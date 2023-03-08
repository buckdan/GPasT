unit uDefs;

interface

uses Windows, Messages, SysUtils, Classes, Controls, StdCtrls, DateUtils,
  WinSvc, Contnrs, Forms, ShellAPI, Registry, TlHelp32, Dialogs;

type
  TConfig = Record
    DestPath : String;
    Periodicite : Integer;
    Heure : TTime;
    Minutes : Integer;
    Jours : Integer;
    dPrevAction : TDateTime;
    dNextAction : TDateTime;
    bDemarrageAuto: Boolean;
    tHeureDemarrage: TTime;
    bArretAuto: Boolean;
    tHeureArret: TTime;
    sUtilisateur: String;
    sMotPasse: String;
  End;

  TExportFile = class(TObject)
    public
      sCodePDV   : String;
      sDateJour  : String[8];
      iNTranche  : integer;
      iNbTickets : Integer;
      fCA        : Currency;
      iNbVendeur : Integer;
  end;

  TPeriodeTranche = record
    dDateDebut : TDateTime;
    dDateFin   : TDateTime;
  end;

//  TTranche = Array [1..96] of TExportFile;

  TTrancheObList = class (TObjectList)
  private
    procedure SetItem (Index : integer; Value : TExportFile);
    function  GetItem (Index : Integer) : TExportFile;
  public
    function Add(AObject : TExportFile) : integer;
    procedure Insert(Index : integer; AObject : TExportFile);
    property Items[Index : Integer] : TExportFile read GetItem Write SetItem; default;
  end;
  
  // Information sur un ex�cutable
  TInfoSurExe = record
    FileDescription, CompanyName, FileVersion, InternalName, LegalCopyright,
    OriginalFileName, ProductName, ProductVersion: String;
  end;

var
  GAPPPATH : String;
  GINIFILE : String;
  GCONFIGAPP : TConfig;
  GTESTMODE  : Boolean = False;

  procedure VerNumAll(Edit: TEdit;
    var Key: Char; Moins: Boolean = True; Virgul: Boolean = False);
  Function CalculTranche(dDate : TDateTime) : Integer;
  function CalculPeriode(dDate : TDate;iTranche : integer) : TPeriodeTranche;
//  function SetTbTrancheToFile(tbTranche : TTranche;dDateDebut,dDateFin : TDateTime;bDelete : Boolean = True) : Boolean;
  function SetTbTrancheListToFile(tbTranche : TTrancheObList;dDateDebut,dDateFin : TDateTime;bDelete : Boolean = True) : Boolean;

  // fonction qui permet de calculer la prochaine date d'action du timer dans le cas d'un traitement par interval
  function CalculNextDate(dDate : TDateTime) : TDateTime;

  // Procedure d'attente de l'arriv� du service IB
  procedure Attente_IB;

  // R�cup�re des informations sur un ex�cutable
  function InfoSurExe(Fichier: String): TInfoSurExe;

  // Cr�er la t�che journali�re
  function CreerTachePlanifiee(AHeureDebut: TTime): Boolean;

  // Supprimer la t�che journali�re
  function SupprimeTachePlanifiee(): Boolean;

  // Cr�er le d�marrage auto
  function CreerDemarrageAuto(): Boolean;

  // Tue un processus via son nom
  function KillProcess(const AProcessName: String): Boolean;

  // V�rifie si l'OS est Windows Vista ou sup�rieur
  function IsWindowsVista(): Boolean;

  // V�rifie si l'OS est Windows 2003
  function IsWindows2003(): Boolean;

implementation

uses Main_frm, Main_Dm;

procedure VerNumAll(Edit: TEdit;var Key: Char; Moins: Boolean = True; Virgul: Boolean = False);
var i, j: integer;
begin
  if Key in [',', '.'] then
    Key := DecimalSeparator;
  if not (Key in ['0'..'9', DecimalSeparator, '-', #8]) or ((Key = '-') and not (Moins))
    or ((Key = DecimalSeparator) and not (Virgul)) then
  begin
    Key := #0;
  end;
  if (Key = DecimalSeparator) and (Virgul) then
    if Pos(DecimalSeparator, Edit.Text) > 0 then
      Key := #0;
  if (Key = DecimalSeparator) and (Virgul) then
    if length(Edit.Text) < 1 then
    begin
      Edit.Text := '0' + DecimalSeparator;
      Edit.SelStart := 2;
      Key := #0;
    end;
  if (Key = DecimalSeparator) and (Virgul) then
    if (copy(Edit.Text, 1, 1) = '-') and (Length(Edit.Text) = 1) then
    begin
      Edit.Text := '-0' + DecimalSeparator;
      Edit.SelStart := 3;
      Key := #0;
    end;
  if (Key = '-') and (Moins) then
  begin
    i := Edit.SelStart;
    j := Edit.SelLength;
    if Length(Edit.Text) > 1 then
    begin
      if Edit.Text[1] = '-' then
      begin
        Edit.Text := Copy(Edit.Text, 2, Length(Edit.Text) - 1);
        if i = 0 then
          Dec(j);
      end
      else
        Edit.Text := '-' + Edit.Text;
    end
    else
      if Edit.Text = '-' then
        Edit.Text := ''
      else
        Edit.Text := '-' + Edit.Text;
    if Edit.Text <> '' then
      if Edit.Text[1] = '-' then
        i := i + 1
      else
        i := i - 1;
    Edit.Selstart := i;
    Edit.SelLength := j;
    Key := #0;
  end;
end;

Function CalculTranche(dDate : TDateTime) : Integer;
var
  wHr,wMn,wSec,wMls : Word;
begin
  DecodeTime(dDate,wHr,wMn,wSec,wMls);
  Result := ((wHr * 3600 + wMn * 60 + wSec) Div (15 * 60)) + 1;
end;

function CalculPeriode(dDate : TDate;iTranche : integer) : TPeriodeTranche;
var
  iCalcul,iReste : Integer;
  wHr,wMn,wSec : Word;
  dDateTemp : TDateTime;
begin
  iCalcul := iTranche * 15 * 60;
  wHr := iCalcul Div 3600;
  iReste := iCalcul Mod 3600;
  wMn := iReste Div 60;
  wSec := iReste Mod 60;
  if wHr = 24 then
  begin
    dDate := dDate + 1;
    wHr := 0;
  end;
  dDateTemp         := EncodeDateTime(YearOf(dDate),MonthOf(dDate),DayOf(dDate),wHr,wMn,wSec,0);
  Result.dDateFin   := IncSecond(dDateTemp,-1);
  Result.dDateDebut := IncMinute(dDateTemp,-15);
end;

function SetTbTrancheListToFile(tbTranche : TTrancheObList;dDateDebut,dDateFin : TDateTime;bDelete : Boolean = True) : Boolean;
var
  i : integer;
  dDateSupp : TDate;
  LstFile : TStringList;
  LstLigne : TStringList;
  sTemp : String;
  dDateEnCours : TDateTime;
  iTrancheEnCours : Integer;
begin
  Result := False;
  
  dDateSupp := dDateDebut - GCONFIGAPP.Jours;

  // Chargement du fichier existant
  LstFile := TStringList.Create;
  LstLigne := TStringList.Create;
  try
    ForceDirectories(GCONFIGAPP.DestPath);
    if FileExists(GCONFIGAPP.DestPath + 'BoCaisse.txt') then
      LstFile.LoadFromFile(GCONFIGAPP.DestPath + 'BoCaisse.txt');

    // Suppression des lignes dont la date est inf�rieure � dDateSupp
    if bDelete then
      for i := (LstFile.Count - 1) DownTo 0 do
      begin
        lstLigne.Text := lstFile[i];
        // transforme les ; en caract�res CR-LF afin de pouvoir rechercher la date en index 1
        LstLigne.Text := StringReplace(LstLigne.Text,';',#13#10,[rfReplaceAll]);
        if StrToInt(lstLigne[1]) < StrToInt(FormatDateTime('YYYYMMDD',dDateSupp)) then
          lstFile.Delete(i);
      end; // for

    // ajout des nouvelles lignes
    for i := 0 to tbTranche.Count - 1 do
    begin
      sTemp := '';
      if tbTranche[iTrancheEnCours].sDateJour <> '' then
      begin
        sTemp := sTemp + tbTranche[i].sCodePDV  + ';';
        sTemp := sTemp + tbTranche[i].sDateJour + ';';
        sTemp := sTemp + FormatFloat('00',tbTranche[i].iNTranche) + ';';
        sTemp := sTemp + IntToStr(tbTranche[i].iNbTickets) + ';';
        sTemp := sTemp + FormatFloat('0.00',tbTranche[i].fCA) + ';';
        sTemp := sTemp + IntToStr(tbTranche[i].iNbVendeur);
        LstFile.Add(sTemp);
      end; // if
      Application.ProcessMessages;
    end;

    {dDateEnCours := dDateDebut;

    while dDateEnCours <= dDateFin do
    begin

      iTrancheEnCours := CalculTranche(dDateEnCours);

      sTemp := '';
      if tbTranche[iTrancheEnCours].sDateJour <> '' then
      begin
        sTemp := sTemp + tbTranche[iTrancheEnCours].sCodePDV  + ';';
        sTemp := sTemp + tbTranche[iTrancheEnCours].sDateJour + ';';
        sTemp := sTemp + FormatFloat('00',tbTranche[iTrancheEnCours].iNTranche) + ';';
        sTemp := sTemp + IntToStr(tbTranche[iTrancheEnCours].iNbTickets) + ';';
        sTemp := sTemp + FormatFloat('0.00',tbTranche[iTrancheEnCours].fCA) + ';';
        sTemp := sTemp + IntToStr(tbTranche[iTrancheEnCours].iNbVendeur);
        LstFile.Add(sTemp);
      end; // if

      dDateEnCours := IncMinute(dDateEnCours,15);
    end; // while }

    // sauvegarde du fichier
    lstFile.SaveToFile(GCONFIGAPP.DestPath + 'BoCaisse.txt');
  finally
    LstFile.Free;
    LstLigne.Free;
  end;

  Result := True;
end;

function CalculNextDate(dDate : TDateTime) : TDateTime;
begin
  Result := dDate;
  repeat
    Result := IncMinute(Result,GCONFIGAPP.Minutes);
  until Result > Now;
end;


procedure Attente_IB;
VAR
{
  hSCManager: SC_HANDLE;
  hService: SC_HANDLE;
  Statut: TServiceStatus;
  tempMini: DWORD;
  CheckPoint: DWORD;
  LastError: DWORD;
  NbBcl: Integer;
}
  i: Integer;
BEGIN
  for i := 1 to 100 do
  begin
    Sleep(10);
    Application.ProcessMessages();
  end;

{
  hSCManager := OpenSCManager(NIL, NIL, SC_MANAGER_CONNECT);
  hService := OpenService(hSCManager, 'InterBaseGuardian', SERVICE_QUERY_STATUS);

  if hService = 0 then
  begin
    LastError := GetLastError();
    if LastError = ERROR_SERVICE_DOES_NOT_EXIST then
      hService := OpenService(hSCManager, 'IBG_gds_db', SERVICE_QUERY_STATUS);
  end;

  IF hService <> 0 THEN
  BEGIN // Service trouv�
    QueryServiceStatus(hService, Statut);
    CheckPoint := 0;
    NbBcl := 0;
    WHILE (statut.dwCurrentState <> SERVICE_RUNNING) OR
      (CheckPoint <> Statut.dwCheckPoint) DO
    BEGIN
      CheckPoint := Statut.dwCheckPoint;
      tempMini := Statut.dwWaitHint + 1000;
      Sleep(tempMini);
      QueryServiceStatus(hService, Statut);
      Inc(nbBcl);
      IF NbBcl > 900 THEN BREAK;
    END;
    IF NbBcl < 900 THEN
    BEGIN
      CloseServiceHandle(hService);
      hService := OpenService(hSCManager, 'InterBaseServer', SERVICE_QUERY_STATUS);

      if hService = 0 then
      begin
        LastError := GetLastError();
        if LastError = ERROR_SERVICE_DOES_NOT_EXIST then
          hService := OpenService(hSCManager, 'IBS_gds_db', SERVICE_QUERY_STATUS);
      end;

      IF hService <> 0 THEN
      BEGIN // Service trouv�
        QueryServiceStatus(hService, Statut);
        CheckPoint := 0;
        NbBcl := 0;
        WHILE (statut.dwCurrentState <> SERVICE_RUNNING) OR
          (CheckPoint <> Statut.dwCheckPoint) DO
        BEGIN
          CheckPoint := Statut.dwCheckPoint;
          tempMini := Statut.dwWaitHint + 1000;
          Sleep(tempMini);
          QueryServiceStatus(hService, Statut);
          Inc(nbBcl);
          IF NbBcl > 900 THEN BREAK;
        END;
      END;
    END;
  END;
  CloseServiceHandle(hService);
  CloseServiceHandle(hSCManager);
}
END;

// R�cup�re des informations sur un ex�cutable
function InfoSurExe(Fichier: String): TInfoSurExe;
const
  VersionInfo: array [1..8] of String =
    ('FileDescription', 'CompanyName', 'FileVersion',
    'InternalName', 'LegalCopyRight', 'OriginalFileName',
    'ProductName', 'ProductVersion');
var
  Handle:   DWord;
  Info:     Pointer;
  InfoData: Pointer;
  InfoSize: Longint;
  DataLen:  UInt;
  LangPtr:  Pointer;
  InfoType: String;
  i:        Integer;
begin
  // R�cup�re la taille n�cessaire pour les infos
  InfoSize := GetFileVersionInfoSize(Pchar(Fichier), Handle);

  // Initialise la variable de retour
  with Result do
  begin
    FileDescription  := '';
    CompanyName      := '';
    FileVersion      := '';
    InternalName     := '';
    LegalCopyright   := '';
    OriginalFileName := '';
    ProductName      := '';
    ProductVersion   := '';
  end;
  i := 1;

  // Si il y a des informations de version
  if InfoSize > 0 then
  begin
    // R�serve la m�moire
    GetMem(Info, InfoSize);

    try
      // Si les infos peuvent �tre r�cup�r�es
      if GetFileVersionInfo(Pchar(Fichier), Handle, InfoSize, Info) then
        repeat
          // Sp�cifie le type d'information � r�cup�rer
          InfoType := VersionInfo[i];

          if VerQueryValue(Info, '\VarFileInfo\Translation',
            LangPtr, DataLen) then
            InfoType := Format('\StringFileInfo\%0.4x%0.4x\%s'#0,
              [LoWord(Longint(LangPtr^)), HiWord(Longint(LangPtr^)),
              InfoType]);

            // Remplit la variable de retour
          if VerQueryValue(Info, @InfoType[1], InfoData, DataLen) then
            case i of
              1:
                Result.FileDescription  := StrPas(InfoData);
              2:
                Result.CompanyName      := StrPas(InfoData);
              3:
                Result.FileVersion      := StrPas(InfoData);
              4:
                Result.InternalName     := StrPas(InfoData);
              5:
                Result.LegalCopyright   := StrPas(InfoData);
              6:
                Result.OriginalFileName := StrPas(InfoData);
              7:
                Result.ProductName      := StrPas(InfoData);
              8:
                Result.ProductVersion   := StrPas(InfoData);
            end;

          // Incr�mente i
          Inc(i);
        until i >= 8;
    finally
      // Lib�re la m�moire
      FreeMem(Info, InfoSize);
    end;
  end;
end;

// Cr�er la t�che journali�re
function CreerTachePlanifiee(AHeureDebut: TTime): Boolean;
const
  CS_TACHE_CREER      = '/CREATE /TN %s /TR %s /SC DAILY /ST %s';
  CS_TACHE_CREER_XP   = '/CREATE /TN %s /TR %s /SC "Toutes les semaines" /D LUN,MAR,MER,JEU,VEN,SAM,DIM /ST %s /RU "%s" /RP "%s"';
  CS_TACHE_CREER_2003 = '/CREATE /TN %s /TR %s /SC DAILY /ST %s /RU "%s" /RP "%s"';
var
  // Information pour l'ex�cution du programme
  InfoExecution : TShellExecuteInfo;
  StartupInfo   : TStartupInfo;
  ProcessInfo   : TProcessInformation;
  // Drapeau pour la fin du programme
  bFini         : Boolean;
  // Code de retour du programme
  iCodeRetour   : LongWord;
  // Param�tres du programme
  sParametres   : String;
  // Informations pour l'utilisateur courant
  tUtilisateur  : Array[0..255] Of Char;
  sUtilisateur  : String;
  sMotPasse     : String;
  Taille        : Cardinal;
begin
  Result := False;   
  EnregistrerLog('D�but de la cr�ation de la t�che planifi�e');

  // Pr�paration du lancement du programme
  // -> http://msdn.microsoft.com/library/bb762154
  FillChar(InfoExecution, SizeOf(InfoExecution), #0);
  InfoExecution.cbSize        := SizeOf(InfoExecution);
  InfoExecution.Wnd           := Application.Handle;
  InfoExecution.fMask         := SEE_MASK_NOCLOSEPROCESS;
  InfoExecution.lpVerb        := 'OPEN';
  InfoExecution.lpFile        := 'SCHTASKS.EXE';
  
  if IsWindowsVista() then
  begin
    sParametres               := Format(CS_TACHE_CREER,
      [AnsiQuotedStr(InfoSurExe(Application.ExeName).ProductName, '"'),
        AnsiQuotedStr(Application.ExeName, '"'),
        FormatDateTime('hh:nn:ss', AHeureDebut)]);
  end
  else if IsWindows2003() then
  begin
    sParametres               := Format(CS_TACHE_CREER_2003,
      [AnsiQuotedStr(InfoSurExe(Application.ExeName).ProductName, '"'),
        AnsiQuotedStr(Application.ExeName, '"'),
        FormatDateTime('hh:nn:ss', AHeureDebut),
        GCONFIGAPP.sUtilisateur,
        GCONFIGAPP.sMotPasse]);
  end
  else
  begin
    sParametres               := Format(CS_TACHE_CREER_XP,
      [AnsiQuotedStr(InfoSurExe(Application.ExeName).ProductName, '"'),
        AnsiQuotedStr(Application.ExeName, '"'),
        FormatDateTime('hh:nn:ss', AHeureDebut),
        GCONFIGAPP.sUtilisateur,
        GCONFIGAPP.sMotPasse]);
  end;

  if FindCmdLineSwitch('VERBEUX') then
    MessageDlg(sParametres, mtInformation, [mbOk], 0);

  InfoExecution.lpParameters  := PChar(sParametres);
  InfoExecution.nShow         := SW_HIDE;

  // Lancement du programme
  if ShellExecuteEx(@InfoExecution) then
  begin
    bFini := False;
    Application.ProcessMessages();

    // Attente de la fin du programme
    // -> http://msdn.microsoft.com/library/ms687032
    repeat
      Application.ProcessMessages();
    until WaitForSingleObject(ProcessInfo.hThread, 200) <> WAIT_TIMEOUT;

    // R�cup�re le code de retour
    // -> http://msdn.microsoft.com/library/ms683189
    GetExitCodeProcess(ProcessInfo.hProcess, iCodeRetour);

    Result := iCodeRetour = 0;
  end;

  EnregistrerLog('Fin de la cr�ation de la t�che planifi�e');
end;

// Supprimer la t�che journali�re
function SupprimeTachePlanifiee(): Boolean;
const
  CS_TACHE_SUPPRIMER  = '/DELETE /TN %s /F';
var
  // Information pour l'ex�cution du programme
  InfoExecution: TShellExecuteInfo;     
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  // Drapeau pour la fin du programme
  bFini: Boolean;
  // Code de retour du programme
  iCodeRetour: LongWord;
  // Param�tres du programme
  sParametres: String;
begin
  Result := False;
  EnregistrerLog('D�but de la suppression de la t�che planifi�e');

  // Pr�paration du lancement du programme
  // -> http://msdn.microsoft.com/library/bb762154
  FillChar(InfoExecution, SizeOf(InfoExecution), #0);
  InfoExecution.cbSize        := SizeOf(InfoExecution);
  InfoExecution.Wnd           := Application.Handle;
  InfoExecution.fMask         := SEE_MASK_NOCLOSEPROCESS;
  InfoExecution.lpVerb        := 'OPEN';
  InfoExecution.lpFile        := 'SCHTASKS.EXE';
  sParametres                 := Format(CS_TACHE_SUPPRIMER,
    [AnsiQuotedStr(InfoSurExe(Application.ExeName).ProductName, '"')]);
  InfoExecution.lpParameters  := PChar(sParametres);
  InfoExecution.nShow         := SW_HIDE;
   
  if FindCmdLineSwitch('VERBEUX') then
    MessageDlg(sParametres, mtInformation, [mbOk], 0);

  // Lancement du programme
  if ShellExecuteEx(@InfoExecution) then
  begin
    bFini := False;
    Application.ProcessMessages();

    // Attente de la fin du programme
    // -> http://msdn.microsoft.com/library/ms687032
    repeat
      Application.ProcessMessages();
    until WaitForSingleObject(InfoExecution.hProcess, 200) <> WAIT_TIMEOUT;

    // R�cup�re le code de retour
    // -> http://msdn.microsoft.com/library/ms683189
    GetExitCodeProcess(InfoExecution.hProcess, iCodeRetour);

    Result := iCodeRetour = 0;
  end;

  EnregistrerLog('Fin de la suppression de la t�che planifi�e');
end;

// Cr�er le d�marrage auto
function CreerDemarrageAuto(): Boolean;
var
  // Base de registre
  Registre: TRegistry;
begin
  EnregistrerLog('D�but de la cr�ation du d�marrage automatique');

  Result := False;
  Registre := TRegistry.Create();
  try
    Registre.RootKey := HKEY_LOCAL_MACHINE;
    if Registre.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', False) then
    begin
      Registre.WriteString(InfoSurExe(Application.ExeName).ProductName, Application.ExeName);
      Result := True;
    end;
  finally
    Registre.Free();
  end;

  EnregistrerLog('Fin de la cr�ation du d�marrage automatique');
end;

// Tue un processus via son nom
function KillProcess(const AProcessName: String): Boolean;
var
  ProcessEntry32: TProcessEntry32;
  HSnapShot:      THandle;
  HProcess:       THandle;
begin
  Result := False;
 
  HSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if HSnapShot = 0 then
    Exit;
 
  ProcessEntry32.dwSize := SizeOf(ProcessEntry32);
  if Process32First(HSnapShot, ProcessEntry32) then
  repeat
    if CompareText(ProcessEntry32.szExeFile, AProcessName) = 0 then
    begin
      HProcess := OpenProcess(PROCESS_TERMINATE, False, ProcessEntry32.th32ProcessID);
      if HProcess <> 0 then
      begin
        Result := TerminateProcess(HProcess, 0);
        CloseHandle(HProcess);
      end;
      Break;
    end;
  until not Process32Next(HSnapShot, ProcessEntry32);
 
  CloseHandle(HSnapshot);
end;

// V�rifie si l'OS est Windows Vista ou sup�rieur
function IsWindowsVista(): Boolean;
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);
  Result := VerInfo.dwMajorVersion >= 6;
end;

// V�rifie si l'OS est Windows 2003
function IsWindows2003(): Boolean;
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);
  Result := (VerInfo.dwMajorVersion = 5) and (Win32MinorVersion >= 2);
end;

{ TTrancheObList }

function TTrancheObList.Add(AObject: TExportFile): integer;
begin
  Result := inherited Add(AObject);
end;

function TTrancheObList.GetItem(Index: Integer): TExportFile;
begin
  Result := TExportFile(inherited GetItem(Index));
end;

procedure TTrancheObList.Insert(Index: integer; AObject: TExportFile);
begin
  inherited Insert(index, AObject);
end;

procedure TTrancheObList.SetItem(Index: integer; Value: TExportFile);
begin
  inherited SetItem(Index,Value);
end;

end.
