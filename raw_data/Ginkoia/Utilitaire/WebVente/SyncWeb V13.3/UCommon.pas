UNIT UCommon;

INTERFACE

USES SysUtils,
  Classes,
  Forms,
  FileCtrl,
  StdCtrls,
  Controls,
  LMDFileGrep,
  LMDFileCtrl,
  uSevenzip
{$IFDEF DEBUG}
  ,
  Dialogs
{$ENDIF}
  ;

PROCEDURE QuickSort(Liste: TStrings);
PROCEDURE LogAction(s: STRING; ANiveau: integer = 0);
PROCEDURE initLogFileName(AMemo: TMemo; AStatusLab: TLabel; ANiveau: integer = 0);
FUNCTION GetLogFile: STRING;
FUNCTION RemChrFromStr(sChr, sStr: STRING): STRING;
PROCEDURE Progress();
PROCEDURE Sablier(b: boolean; sender: TControl);
PROCEDURE PurgeOldLogs(bDelOldLogs: boolean = False; iDelOldLogAge: integer = 60);
FUNCTION StringToFloat(s: STRING): double;
//FUNCTION StringToFloat (s: STRING) : double;
PROCEDURE gTrace(S: STRING);
PROCEDURE DelCurrentLog;
FUNCTION ArrondiMonetaire(x: double): double;
function StrEnleveAccents(const S : String) : string;


// fonction permettant de cr�er un zip d'un fichier
function ZipFile(ASourceFile, AZipName : String) : Boolean;overload;
// Fonction permettant de d�zipper un fichier zip
function UnZipFile(AZipFile, ADestDir : String) : Boolean;
// V�rifie qu'un code-barres est bien en EAN 13
function VerifEAN13(const AEAN: String): Boolean;


VAR
  iNbLog: integer;
  GAPPATH : String;
  GGENTMPPATH : String;
  GGENPATHFACTURE ,
  GGENPATHCDE     ,
  GGENPATHCSV     : String;
  GGENARCHCDE     : String;

IMPLEMENTATION

VAR
  sLogFile: STRING;
  gNiveauToLog: integer;
  mMemo: TMemo;
  lStatus: TLabel;
  bMemo, bStatus: boolean;
  //renseigne un m�mo et un fichier



function StrEnleveAccents(const S : String) : string;
var i:integer;
begin
 Result := S;
 i:=1;
 while i<=length(s) do
  begin
   case s[i] of '�'..'�'     : Result[i]:='A';
                '�'..'�'     : Result[i]:='a';
                '�'..'�'     : Result[i]:='E';
                '�'..'�'     : Result[i]:='e';
                '�'..'�'     : Result[i]:='I';
                '�'..'�'     : Result[i]:='i';
                '�'..'�','�' : Result[i]:='O';
                '�'..'�','�' : Result[i]:='o';
                '�'..'�'     : Result[i]:='U';
                '�'..'�'     : Result[i]:='u';
                '�'          : Result[i]:='S';
                '�'          : Result[i]:='s';
                '�'          : Result[i]:='C';
                '�'          : Result[i]:='c';
                '�'          : Result[i]:='N';
                '�'          : Result[i]:='n';
                '�'          : Result[i]:='D';
                '�','�'      : Result[i]:='Y';
                '�','�'      : Result[i]:='y';
                '�'          : Result[i]:='d';
                '�'          : Result[i]:='z';
                '�'          : Result[i]:='Z';
                '�'    :begin
                         Result[i]:='O';
                         insert('E',Result,i+1);
                         inc(i);
                        end;
                '�'    :begin
                         Result[i]:='o';
                         insert('e',Result,i+1);
                         inc(i);
                        end;
                '�'    :begin
                         Result[i]:='A';
                         insert('E',Result,i+1);
                         inc(i);
                        end;
                '�'    :begin
                         Result[i]:='a';
                         insert('e',Result,i+1);
                         inc(i);
                        end;
                     end;
   inc(i);
   end;
end;

FUNCTION StringToFloat(s: STRING): double;
VAR
  SvgDecSep: Char;
BEGIN
  SvgDecSep := DecimalSeparator;
  TRY
    // On teste avec un .
    DecimalSeparator := '.';
    Result := StrToFloat(S);
  EXCEPT
    TRY
      // On teste avec une ,
      DecimalSeparator := ',';
      Result := StrToFloat(S);
    EXCEPT
      Result := 0;
    END;
  END;
  DecimalSeparator := SvgDecSep;
END;

PROCEDURE Progress();
BEGIN
  mMemo.Lines[mMemo.Lines.Count - 1] := mMemo.Lines[mMemo.Lines.Count - 1] + '.';
  mMemo.Update;
END;

PROCEDURE LogAction(s: STRING; ANiveau: integer = 0);
// Niveau d'activation de log : 0 = Erreurs critiques, 1 = Erreurs normales, 2 = Informations, 3 = Debug
VAR
  F: TextFile;
BEGIN
  TRY
    AssignFile(F, sLogFile);
    IF NOT FileExists(sLogFile) THEN
    BEGIN
      Rewrite(F);
      CloseFile(F);
    END;
    IF ANiveau <= gNiveauToLog THEN
    BEGIN
      // Log effectu� dans le fichier
      Inc(iNbLog);

      // Se positionne � la fin du fichier
      Append(F);

      WriteLn(F, FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time) + ' : ' + S);

      CloseFile(F);
    END;

    //complete le m�mo
    IF bMemo THEN
    BEGIN
      mMemo.Lines.Insert(0, FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time) + ' : ' + s);
      mMemo.Update;
    END;

    IF bStatus THEN
    BEGIN
      lStatus.Caption := s;
      lStatus.Update;
    END;

  EXCEPT
    // tantpis, pas de log
  END;
END;

PROCEDURE DelCurrentLog;
VAR
  FileToDel: TLMDFileCtrl;
BEGIN
  FileToDel := TLMDFileCtrl.Create(NIL);
  TRY
    FileToDel.Options := [ffFilesOnly, ffNoActionConfirm];
    FileToDel.FileName := sLogFile;
    IF FileExists(FileToDel.FileName) THEN
    BEGIN
      IF FileToDel.DeleteFiles(FileToDel.FileName) THEN
      BEGIN
        //
      END;
    END;
  FINALLY
    FileToDel.Free;
  END;
END;

PROCEDURE PurgeOldLogs(bDelOldLogs: boolean = False; iDelOldLogAge: integer = 60);
VAR
  LogFiles: TLMDFileGrep;
  FileToDel: TLMDFileCtrl;
  i: integer;
BEGIN
  IF bDelOldLogs THEN
  BEGIN
    LogFiles := TLMDFileGrep.Create(NIL);
    TRY
      FileToDel := TLMDFileCtrl.Create(NIL);
      TRY
        LogFiles.ThreadedSearch := False;
        LogFiles.Dirs := ExtractFilePath(Application.ExeName) + 'Logs';
        LogFiles.FileMasks := '*.*';
        LogFiles.RecurseSubDirs := false;
        LogFiles.ReturnValues := [rvDir, rvFileName];
        LogFiles.ReturnDelimiter := ';';
        LogFiles.CreatedBefore.DateTimeValue := (Now() - iDelOldLogAge);
        LogFiles.LookForDates := [lfCreateBefore];
        LogFiles.Grep;

        FileToDel.Options := [ffFilesOnly, ffNoActionConfirm];
        FOR i := 0 TO LogFiles.Files.Count - 1 DO
        BEGIN
          // R�cup le nom du dossier, sous la forme 'DossierContenant;NomDossierAnnee;'
          FileToDel.FileName := RemChrFromStr(';', LogFiles.Files[i]);
          IF FileToDel.DeleteFiles(FileToDel.FileName) THEN
          BEGIN
            LogAction('Suppression vieux log : ' + FileToDel.FileName, 0);
            // On ne compte pas ce log
            Dec(iNbLog)
          END;
        END;
      FINALLY
        FileToDel.Free;
      END;
    FINALLY
      LogFiles.Free;
    END;
  END;
END;

PROCEDURE initLogFileName(AMemo: TMemo; AStatusLab: TLabel; ANiveau: integer = 0);
// Objet de la proc�dure : initialiser les logs
// Chemin du log, m�mo de compte rendu (si non, mettre nil), Label de compte rendu (si non, mettre nil)
// Niveau d'activation de log : 0 = Erreurs critiques, 1 = Erreurs normales, 2 = Informations, 3 = Debug
BEGIN
  iNbLog := 0;

  IF AMemo <> NIL THEN
  BEGIN
    mMemo := AMemo;
    mMemo.clear;
    bMemo := True;
  END
  ELSE
    bMemo := False;

  IF AStatusLab <> NIL THEN
  BEGIN
    lStatus := AStatusLab;
    lStatus.Caption := 'Bienvenue dans ' + Application.Name;
    bStatus := True;
  END
  ELSE
    bStatus := False;

  // On active le log pour ce niveau et ceux plus importants
  gNiveauToLog := ANiveau;

  ForceDirectories(ExtractFilePath(Application.ExeName) + 'Logs\');
  sLogFile := ExtractFilePath(Application.ExeName) + 'Logs\' + FormatDateTime('yyyy_mm_dd', Date) + '_' + ChangeFileExt(ExtractFileName(Application.ExeName), '.log');
END;

FUNCTION GetLogFile: STRING;

BEGIN
  result := sLogFile
END;

FUNCTION RemChrFromStr(sChr, sStr: STRING): STRING;
BEGIN

  WHILE Pos(sChr, sStr) > 0 DO
  BEGIN
    delete(sStr, Pos(sChr, sStr), Length(sChr));
  END;

  result := sStr
END;

PROCEDURE QuickSort(Liste: TStrings);
// FC : Proc�dure trouv�e sur le Web, ne pas crier sur la facon de d�clarer, merci...
  PROCEDURE RappelQuickSort(Liste: TStrings; Premier, Dernier: Integer);

    {Objectif : Proc�dure triant la liste de type TStrings re�u en param�tre.
                Le trillage se fera avec le tri (Quick Sort).}

  VAR
    PremierTemp, DernierTemp: Integer;
    Milieu: STRING;

  BEGIN
    PremierTemp := Premier;
    DernierTemp := Dernier;
    Milieu := Liste.Strings[(Dernier + Premier) DIV 2];

    REPEAT
      WHILE Liste.Strings[PremierTemp] < Milieu DO Inc(PremierTemp);
      WHILE Liste.Strings[DernierTemp] > Milieu DO Dec(DernierTemp);

      IF PremierTemp <= DernierTemp THEN
      BEGIN
        Liste.ExChange(PremierTemp, DernierTemp);
        Inc(PremierTemp);
        Dec(DernierTemp);
      END;

    UNTIL PremierTemp > DernierTemp;

    IF DernierTemp > Premier THEN RappelQuickSort(Liste,
        Premier, DernierTemp);
    IF PremierTemp < Dernier THEN RappelQuickSort(Liste,
        PremierTemp, Dernier);
  END;

BEGIN
  IF Liste.Count > 0 THEN RappelQuickSort(Liste, 0, Liste.Count - 1);
END;

PROCEDURE sablier(b: boolean; sender: TControl);
BEGIN
  IF B THEN
  BEGIN
    screen.cursor := crHourGlass;
    // on d�sactive la fenetre
    sender.Enabled := false;
  END
  ELSE
  BEGIN
    screen.cursor := crDefault;
    sender.Enabled := True;
  END;
END;

PROCEDURE gTrace(S: STRING);
BEGIN
{$IFDEF DEBUG}
  Showmessage(S);
{$ENDIF}

END;

FUNCTION ArrondiMonetaire(X: double): double;
BEGIN
  TRY
    Result := Round(X * 100) / 100;
  EXCEPT
    ON E: Exception DO
    BEGIN
      Result := 0;
    END;
  END;

END;

function ZipFile(ASourceFile, AZipName : String) : Boolean;
var
  Arch : I7zOutArchive;
begin
  Result := False;
  try
    Arch := CreateOutArchive(CLSID_CFormatZip);
    Arch.AddFile(ASourceFile,ExtractFileName(ASourceFile));
    Arch.SaveToFile(AZipName);
    Arch := nil;
    Result := True;
  Except on E:Exception do
    raise Exception.Create('ZipFile -> ' + E.Message);
  end;
end;

function UnZipFile(AZipFile, ADestDir : String) : Boolean;
var
  Arch : I7zInArchive;
begin
  Result := False;
  try
    Arch := CreateInArchive(CLSID_CFormatZip);
    Arch.OpenFile(AZipFile);
    Arch.ExtractTo(ExtractFilePath(ADestDir));
    Result := True;
  Except on E:Exception do
    raise Exception.Create('UnZipFile -> ' + E.Message);
  end;
end;

// V�rifie qu'un code-barres est bien en EAN 13
function VerifEAN13(const AEAN: String): Boolean;
var
  i, iValeur, iSommePaires, iSommeImpaires, iSommeTotal, iCle: Integer;
begin
  // V�rifie que le code-barres a bien 13 caract�res
  if Length(AEAN) = 13 then
  begin
    iSommePaires    := 0;
    iSommeImpaires  := 0;
    for i := 1 to 12 do
    begin
      if Odd(i) then
      begin
        if TryStrToInt(AEAN[i], iValeur) then
          Inc(iSommeImpaires, iValeur)
        else begin
          // Il y a autre chose qu'un chiffre : on arr�te
          Result := False;
          Exit;
        end;
      end
      else begin
        if TryStrToInt(AEAN[i], iValeur) then
          Inc(iSommePaires, iValeur)
        else begin
          // Il y a autre chose qu'un chiffre : on arr�te
          Result := False;
          Exit;
        end;
      end;
    end;

    // Calcul le total
    iSommeTotal := iSommeImpaires + iSommePaires * 3;

    // V�rifie que le dernier chiffre est Ok
    if TryStrToInt(AEAN[13], iValeur) then
    begin
      if (iSommeTotal mod 10) = 0 then
        iCle := 0
      else
        iCle := 10 - (iSommeTotal mod 10);
      Result := (iValeur = iCle);
    end
    else begin
      // Il y a autre chose qu'un chiffre : on arr�te
      Result := False;
      Exit;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

END.

