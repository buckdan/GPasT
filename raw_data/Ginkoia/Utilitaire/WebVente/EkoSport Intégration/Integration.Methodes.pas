unit Integration.Methodes;

interface

uses
  System.Classes,
  System.SysUtils,
  System.IniFiles,
  Winapi.ShellAPI,
  Winapi.Windows,
  Vcl.Forms,
  FireDAC.Comp.Client,
  Integration.Ressources,
  IdBaseComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdSMTP,
  IdMessage,
  IdAttachmentMemory,
  IdSSLOpenSSL,
  uLog;

type
  // Information sur un ex�cutable
  TInfoSurExe = record
    FileDescription: string;
    CompanyName: string;
    FileVersion: string;
    InternalName: string;
    LegalCopyright: string;
    OriginalFileName: string;
    ProductName: string;
    ProductVersion: string;
  end;

  // Liste des domaines d'activit�s d'une base
function ListeDomainesActivitees(const ACheminBase: string; out AListe: TStringList): Boolean;
// V�rifie si une date est bien encod�e au format AAAAMMJJ
function TryIso8601BasicToDate(const AStr: string; out ODate: TDateTime): Boolean;
// Met un fichier � la corbeille
function MettreCorbeille(NomFichier: string): Boolean;
// D�place un fichier
function DeplaceFichier(const ASource, ADestination: string): Boolean;
// Copie un fichier
function CopierFichier(const ASource, ADestination: string): Boolean;
// Efface un r�pertoire
function EffacerRepertoire(const ARepertoire: string): Boolean;
// R�cup�re des informations sur un ex�cutable
function InfoSurExe(AFichier: TFileName): TInfoSurExe;
// V�rifie qu'un code-barres est bien en EAN 13
function VerifEAN13(const AEAN: string): Boolean;
// Envoi le rapport par courriel
function EnvoyerJournalCourriel(const AObjet, AMessage: string; const AAdresses: string = ''; const APrioritaire: Boolean = False): Boolean;
// Crypte une cha�ne
function CryptString(const Value, Key: string): string;
// D�crypte une cha�ne
function DecryptString(const Value, Key: string): string;
// Retourne le nom de l'ordinateur
function NomOrdinateur(): string;

implementation

uses
  Integration.Form.Principale;

// Liste des domaines d'activit�s d'une base
function ListeDomainesActivitees(const ACheminBase: string; out AListe: TStringList): Boolean;
var
  FDConnection    : TFDConnection;
  QueListeDomaines: TFDQuery;
begin
  Result := False;

  FormPrincipale.Journaliser(RS_CONNEXION);
  FDConnection     := TFDConnection.Create(nil);
  QueListeDomaines := TFDQuery.Create(nil);
  try
    // Param�tre la connexion � la base de donn�es
    FDConnection.Params.Clear();
    FDConnection.Params.Add('DriverID=IB');
    FDConnection.Params.Add('User_Name=ginkoia');
    FDConnection.Params.Add('Password=ginkoia');
    FDConnection.Params.Add('Protocol=TCPIP');
    FDConnection.Params.Add('Server=localhost');
    FDConnection.Params.Add('Port=3050');
    FDConnection.Params.Add(Format('Database=%s', [ACheminBase]));

    QueListeDomaines.Connection := FDConnection;
    QueListeDomaines.SQL.Clear();
    QueListeDomaines.SQL.Add('SELECT ACT_ID, ACT_NOM');
    QueListeDomaines.SQL.Add('FROM NKLACTIVITE');
    QueListeDomaines.SQL.Add('  JOIN K ON (K_ID = ACT_ID AND K_ENABLED = 1 AND K_ID != 0);');
    try
      QueListeDomaines.Open();
      FormPrincipale.Journaliser(RS_CHARGEMENT_DOMAINES);

      Result := (QueListeDomaines.RecordCount > 0);

      while not(QueListeDomaines.Eof) do
      begin
        AListe.Add(Format('%d=%s', [QueListeDomaines.FieldByName('ACT_ID').AsInteger, QueListeDomaines.FieldByName('ACT_NOM').AsString]));
        QueListeDomaines.Next();
      end;

    except
      on E: Exception do
      begin
        Result := False;
        FormPrincipale.Journaliser(Format(RS_ERREUR_CONNEXION, [E.ClassName, E.Message]), NivErreur);
      end;
    end;

    FormPrincipale.Journaliser(RS_DECONNEXION);
    QueListeDomaines.Close();
  finally
    QueListeDomaines.Free();
    FDConnection.Free();
  end
end;

// V�rifie si une date est bien encod�e au format AAAAMMJJ
function TryIso8601BasicToDate(const AStr: string; out ODate: TDateTime): Boolean;
var
  Annee, Mois, Jour: Integer;
begin
  Result := (Length(AStr) = 8);

  if not Result then
    Exit;

  Result := TryStrToInt(Copy(AStr, 1, 4), Annee);

  if Annee < 100 then
  begin
    Result := False;
    Exit;
  end;

  if not Result then
    Exit;

  Result := TryStrToInt(Copy(AStr, 5, 2), Mois);

  if not Result then
    Exit;

  Result := TryStrToInt(Copy(AStr, 7, 2), Jour);

  if not Result then
    Exit;

  Result := TryEncodeDate(Annee, Mois, Jour, ODate);
end;

// Met un fichier � la corbeille
function MettreCorbeille(NomFichier: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  FillChar(fos, SizeOf(fos), 0);

  with fos do
  begin
    wFunc  := FO_DELETE;
    pFrom  := Pchar(NomFichier + #0);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;

  Result := (0 = ShFileOperation(fos));
end;

// D�place un fichier
function DeplaceFichier(const ASource, ADestination: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  FillChar(fos, SizeOf(fos), 0);

  with fos do
  begin
    wFunc  := FO_MOVE;
    pFrom  := Pchar(ASource + #0);
    pTo    := Pchar(ADestination + #0);
    fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_NOCOPYSECURITYATTRIBS;
  end;

  Result := (0 = ShFileOperation(fos));
end;

// Copie un fichier
function CopierFichier(const ASource, ADestination: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  FillChar(fos, SizeOf(fos), 0);

  with fos do
  begin
    wFunc  := FO_COPY;
    pFrom  := Pchar(ASource + #0);
    pTo    := Pchar(ADestination + #0);
    fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_NOCOPYSECURITYATTRIBS;
  end;

  Result := (0 = ShFileOperation(fos));
end;

// Efface un r�pertoire
function EffacerRepertoire(const ARepertoire: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  FillChar(fos, SizeOf(fos), 0);

  with fos do
  begin
    wFunc  := FO_DELETE;
    pFrom  := Pchar(ARepertoire + #0);
    fFlags := FOF_NOCONFIRMATION;
  end;

  Result := (0 = ShFileOperation(fos));
end;

// R�cup�re des informations sur un ex�cutable
function InfoSurExe(AFichier: TFileName): TInfoSurExe;
const
  VersionInfo: array [1 .. 8] of string = ('FileDescription', 'CompanyName', 'FileVersion', 'InternalName', 'LegalCopyRight', 'OriginalFileName', 'ProductName', 'ProductVersion');
var
  Handle  : DWord;
  Info    : Pointer;
  InfoData: Pointer;
  InfoSize: Longint;
  DataLen : UInt;
  LangPtr : Pointer;
  InfoType: string;
  i       : Integer;
begin
  // R�cup�re la taille n�cessaire pour les infos
  InfoSize := GetFileVersionInfoSize(Pchar(AFichier), Handle);

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
      if GetFileVersionInfo(Pchar(AFichier), Handle, InfoSize, Info) then
      begin
        repeat
          // Sp�cifie le type d'information � r�cup�rer
          InfoType := VersionInfo[i];

          if VerQueryValue(Info, '\VarFileInfo\Translation', LangPtr, DataLen) then
            InfoType := Format('\StringFileInfo\%0.4x%0.4x\%s'#0,
              [LoWord(Longint(LangPtr^)), HiWord(Longint(LangPtr^)), InfoType]);

          // Remplit la variable de retour
          if VerQueryValue(Info, @InfoType[1], InfoData, DataLen) then
          begin
            case i of
              1:
                Result.FileDescription := Pchar(InfoData);
              2:
                Result.CompanyName := Pchar(InfoData);
              3:
                Result.FileVersion := Pchar(InfoData);
              4:
                Result.InternalName := Pchar(InfoData);
              5:
                Result.LegalCopyright := Pchar(InfoData);
              6:
                Result.OriginalFileName := Pchar(InfoData);
              7:
                Result.ProductName := Pchar(InfoData);
              8:
                Result.ProductVersion := Pchar(InfoData);
            end;
          end;

          // Incr�mente i
          Inc(i);
        until i >= 8;
      end;
    finally
      // Lib�re la m�moire
      FreeMem(Info, InfoSize);
    end;
  end;
end;

// V�rifie qu'un code-barres est bien en EAN 13
function VerifEAN13(const AEAN: string): Boolean;
var
  i, iValeur, iSommePaires, iSommeImpaires, iSommeTotal, iCle: Integer;
begin
  // V�rifie que le code-barres a bien 13 caract�res
  if Length(AEAN) = 13 then
  begin
    iSommePaires   := 0;
    iSommeImpaires := 0;

    for i := 1 to 12 do
    begin
      if Odd(i) then
      begin
        if TryStrToInt(AEAN[i], iValeur) then
          Inc(iSommeImpaires, iValeur)
        else
        begin
          // Il y a autre chose qu'un chiffre : on arr�te
          Result := False;
          Exit;
        end;
      end
      else
      begin
        if TryStrToInt(AEAN[i], iValeur) then
          Inc(iSommePaires, iValeur)
        else
        begin
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
    else
    begin
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

function EnvoyerJournalCourriel(const AObjet, AMessage: string; const AAdresses: string = ''; const APrioritaire: Boolean = False): Boolean;
var
  IniParametres : TIniFile;
  IdSMTP        : TIdSMTP;
  IdMessage     : TIdMessage;
  IdFichier     : TIdAttachmentMemory;
  msFichier     : TMemoryStream;
  sExpediteur   : string;
  sDestinataires: string;
  sHote         : string;
  sUtilisateur  : string;
  sMotPasse     : string;
  iPort         : Integer;
begin
  Result := True;

  bEnvoyeCourriel := True;

  // Charge les param�tres depuis le fichier INI
  IniParametres := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    sExpediteur := IniParametres.ReadString('Courriel', 'Expediteur', 'dev@ginkoia.fr');

    if AAdresses = '' then
      sDestinataires := IniParametres.ReadString('Courriel', 'Destinataires', 'lionel.plais@ginkoia.fr')
    else
      sDestinataires := AAdresses;

    sHote        := IniParametres.ReadString('Courriel', 'Hote', 'smtp.office365.com');
    sUtilisateur := IniParametres.ReadString('Courriel', 'Utilisateur', 'dev@ginkoia.fr');
    sMotPasse    := DecryptString(IniParametres.ReadString('Courriel', 'MotPasse', CryptString('Toru682674', CLE_CRYPTAGE)), CLE_CRYPTAGE);
    iPort        := IniParametres.ReadInteger('Courriel', 'Port', 587);
  finally
    IniParametres.Free();
  end;

  // Envoie le courriel
  IdSMTP    := TIdSMTP.Create(nil);
  IdMessage := TIdMessage.Create(nil);
  msFichier := TMemoryStream.Create();
  try
    // Exp�diteur
    IdMessage.From.Name    := 'Int�grations DataSolution';
    IdMessage.From.Address := sExpediteur;
    IdMessage.Organization := 'Ginkoia SAS';

    if APrioritaire then
      IdMessage.Priority := mpHighest
    else
      IdMessage.Priority := mpNormal;

    // Destinataires
    IdMessage.Recipients.EMailAddresses := sDestinataires;

    // Objet
    IdMessage.Subject := AObjet;

    // Message
    IdMessage.Body.Clear();
    IdMessage.Body.Add(AMessage);

    // Pi�ce jointe
    FormPrincipale.TxtJournal.Lines.SaveToStream(msFichier);
    msFichier.Position    := 0;
    IdFichier             := TIdAttachmentMemory.Create(IdMessage.MessageParts, msFichier);
    IdFichier.FileName    := Format('Journal_%0:s.rtf', [FormatDateTime('yyyy-mm-dd_hh-nn-ss', Now())]);
    IdFichier.ContentType := 'application/rtf';

    // Param�trage du serveur SMTP
    IdSMTP.IOHandler                                                 := TIdSSLIOHandlerSocketOpenSSL.Create(IdSMTP);
    IdSMTP.UseTLS                                                    := utUseExplicitTLS;
    TIdSSLIOHandlerSocketOpenSSL(IdSMTP.IOHandler).SSLOptions.Method := sslvTLSv1;

    IdSMTP.IOHandler.Destination := Format('%0:s:%1:u', [sHote, iPort]);
    IdSMTP.Host                  := sHote;
    IdSMTP.Port                  := iPort;

    IdSMTP.AuthType := satDefault;
    IdSMTP.Username := sUtilisateur;
    IdSMTP.Password := sMotPasse;

    // Envoie du courriel
    try
      IdSMTP.Connect();

      if IdSMTP.Connected() then
      begin
        if IdSMTP.Authenticate() then
          IdSMTP.Send(IdMessage);
      end;
    except
      on E: Exception do
      begin
        Result := False;
        FormPrincipale.Journaliser(Format(RS_COURRIEL_ERREUR, [E.ClassName, E.Message]), NivErreur);
      end;
    end;
  finally
    IdSMTP.Disconnect();

    msFichier.Free();
    IdFichier.Free();
    IdMessage.Free();
    IdSMTP.Free();

    bEnvoyeCourriel := False;
  end;
end;

// Crypte une cha�ne
function CryptString(const Value, Key: string): string;
var
  i, j      : Integer;
  PassPhrase: string;
begin
  Result     := '';
  PassPhrase := Key;

  j := 1;

  for i := 1 to Length(Value) do
  begin
    Result := Result + IntToHex(Ord(Value[i]) xor Ord(PassPhrase[j]), 2);
    Inc(j);
    if j > Length(PassPhrase) then
      j := 1;
  end;
end;

// D�crypte une cha�ne
function DecryptString(const Value, Key: string): string;
var
  i, j      : Integer;
  PassPhrase: string;
begin
  Result     := '';
  PassPhrase := Key;

  i := 1;
  j := 1;

  repeat
    Result := Result + Chr(StrToInt('$' + Copy(Value, i, 2)) xor Ord(PassPhrase[j]));
    Inc(i, 2);
    Inc(j);
    if j > Length(PassPhrase) then
      j := 1;
  until i > Length(Value);
end;

// Retourne le nom de l'ordinateur
function NomOrdinateur(): string;
var
  lpBuffer: array [0 .. MAX_COMPUTERNAME_LENGTH] of Char;
  nSize   : DWord;
begin
  nSize := Length(lpBuffer);

  if GetComputerName(lpBuffer, nSize) then
    Result := lpBuffer
  else
    Result := '';
end;

end.
