unit SymmetricDS.Commun.DataModule.Traitements;

interface

uses
  Winapi.Windows,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Classes,
  System.RegularExpressionsCore,
  System.Win.Registry,
  System.StrUtils,
  System.IOUtils,
  System.Variants,
  Data.DB,
  {$IF DECLARED(FireMonkeyVersion)}
  FMX.Forms,
  {$ELSE}
  VCL.Forms,
  {$ENDIF}
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.IB,
  FireDAC.Phys.IBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util,
  FireDAC.Comp.Script,
  SymmetricDS.Commun,
  SymmetricDS.Commun.XML.InstallationServeur,
  cHash;

type
  TInfosReplication = record
    NomBase             : string;
    ServeurReplication  : string;
  end;
  TDataModuleTraitements = class(TDataModule)
    FdcConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QueListeBases: TFDQuery;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    QueNomClient: TFDQuery;
    ScriptGrants: TFDScript;
    QueScript: TFDQuery;
    StrProcSym: TFDStoredProc;
    QueProcExists: TFDQuery;
    TransSymmDS: TFDTransaction;
    TabSymDS: TFDTable;
    QueURLReplic: TFDQuery;
    procedure ScriptGrantsError(ASender: TObject;
      const AInitiator: IFDStanObject; var AException: Exception);
  private
    { D�clarations priv�es }
    FJournaliser: TJournaliser;
  public
    { D�clarations publiques }
    property Journaliser: TJournaliser read FJournaliser write FJournaliser;
    // Installation de SymmetricDS
    function InstallationSymmetricDS(const ARepertoire: string = 'C:\SymmetricDS-Pro';
      const AURLServeur: string = 'https://localhost:31417/'): Boolean;
    // Installation de dossiers
    function InstallationDossier(const ABaseDonnees: TFileName;
      const ARepertoireSymmDS, ANomDossier, AAdresseURL: string; const AListeBases: TStringList): Boolean;
    // Installation de client
    function InstallationClient(const ABaseDonnees: TFileName = ''; 
      const ARepertoireSymmDS: string = 'C:\SymmetricDS-Pro'): Boolean;
    // Nom du client
    function NomClient(const ABaseDonnees: TFileName): string;
    // Nom de la base de donn�es et serveur de r�plication
    function InfosReplication(const ABaseDonnees: TFileName): TInfosReplication;
    // Liste des bases de la base de donn�es
    function ListeBases(const ABaseDonnees: TFileName;
      out AListeBases: TStringList): Boolean;
  end;

var
  DataModuleTraitements: TDataModuleTraitements;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModuleTraitements }

// Installation de SymmetricDS
function TDataModuleTraitements.InstallationSymmetricDS(const ARepertoire: string = 'C:\SymmetricDS-Pro';
  const AURLServeur: string = 'https://localhost:31417/'): Boolean;
const
  REGJAVA             = '\Software\JavaSoft\Java Runtime Environment';
  REGEXP_VERSION      = '(\d+)\.(\d+)';
  REGEXP_RECUP_CHEMIN = '^"(.+)"|^(\S+)';
var
  Registre          : TRegistry;
  reExpression      : TPerlRegEx;
  ResInstallateur   : TResourceStream;
  sVersionJava      : string;
  sProgInstall      : TFileName;
  sFichParams       : TFileName;
  sCheminInterBase  : TFileName;
  sFichierConf      : TFileName;
  iMajeur, iMineur  : Integer;
  XMLServeurFile    : IXMLAutomatedInstallationType;
  XMLFile           : TextFile;
  slConfFile        : TStringList;
  iIndex            : Integer;
begin
  sProgInstall  := IncludeTrailingPathDelimiter(ARepertoire) + 'symmetric-pro-3.6.10-setup.jar';
  sFichParams   := ChangeFileExt(sProgInstall, '.xml');

  {$REGION 'V�rifie si Java 1.5 ou sup�rieur est install�'}
  Journaliser('V�rifie si Java 1.5 ou sup�rieur est install�.');
  Registre      := TRegistry.Create(KEY_READ);
  reExpression  := TPerlRegEx.Create();
  try
    Registre.RootKey  := HKEY_LOCAL_MACHINE;
    if Registre.OpenKey(REGJAVA, False) then
    begin
      sVersionJava := Registre.ReadString('CurrentVersion');
      reExpression.RegEx        := REGEXP_VERSION;
      reExpression.Subject      := sVersionJava;

      if reExpression.Match() then
      begin
        Journaliser(Format('Version %s d�tect�e.', [reExpression.Groups[0]]));
        iMajeur := StrToInt(reExpression.Groups[1]);
        iMineur := StrToInt(reExpression.Groups[2]);
        if iMajeur < 1 then
        begin
          // Java est vraiment obsol�te
          Journaliser('Java est vraiment obsol�te.', NivErreur);
          Journaliser('T�l�chargez la derni�re version � l�adresse'#160': https://www.java.com/fr/download/');
          Result := False;
          Exit;
        end
        else if (iMajeur = 1)
          and (iMineur < 5) then
        begin
          // Java est obsol�te
          Journaliser('Java est obsol�te.', NivErreur);
          Journaliser('T�l�chargez la derni�re version � l�adresse'#160': https://www.java.com/fr/download/');
          Result := False;
          Exit;
        end;
      end
      else begin
        // Java n'est pas install�
        Journaliser('Java n�est pas install�.', NivErreur);
        Journaliser('T�l�chargez la derni�re version � l�adresse'#160': https://www.java.com/fr/download/');
        Result := False;
        Exit;
      end;
    end
    else begin
      // Java n'est pas install�
      Journaliser('Java n�est pas install�.', NivErreur);
      Journaliser('T�l�chargez la derni�re version � l�adresse'#160': https://www.java.com/fr/download/');
      Result := False;
      Exit;
    end;
  finally
    reExpression.Free();
    Registre.Free();
  end;
  {$ENDREGION 'V�rifie si Java 1.5 ou sup�rieur est install�'}

  {$REGION 'V�rification du r�pertoire d�installation'}
  Journaliser('V�rification du r�pertoire d�installation.');
  if not(DirectoryExists(ARepertoire)) then
  begin
    // Cr�ation du r�pertoire d'installation
    Journaliser('Cr�ation du r�pertoire d�installation.');
    if not(ForceDirectories(ARepertoire)) then
    begin
      // Le r�pertoire d'installation ne peux pas �tre cr��
      Journaliser('Le r�pertoire d�installation ne peux pas �tre cr��.', NivErreur);
      Result := False;
      Exit;
    end;
  end;
  {$ENDREGION 'V�rification du r�pertoire d�installation'}

  {$REGION 'Extraction du programme d�installation'}
  Journaliser('Extraction du programme d�installation.');
  try
    ResInstallateur := TResourceStream.Create(HInstance, 'SymmetricDS', RT_RCDATA);
    try
      ResInstallateur.SaveToFile(sProgInstall);
      Journaliser('Programme d�installation extrait.');
    finally
      ResInstallateur.Free();
    end;
    ResInstallateur := TResourceStream.Create(HInstance, 'XMLServeur', RT_RCDATA);
    try
      ResInstallateur.SaveToFile(sFichParams);
      Journaliser('Param�trage d�installation extrait.');
    finally
      ResInstallateur.Free();
    end;
  except
    on e: Exception do
    begin
      // Impossible d'extraire les ressources
      Journaliser('Impossible d�extraire les ressources.', NivErreur);
      Result := False;
      Exit;
    end;
  end;
  {$ENDREGION 'Extraction du programme d�installation'}

  {$REGION 'Modification des param�tres d�installation automatique'}
  Journaliser('Modification des param�tres d�installation automatique.');

  // Chargement du fichier XML
  XMLServeurFile := LoadAutomatedInstallation(sFichParams);

  // Modification du r�pertoire d'installation
  XMLServeurFile.ComizforgeizpackpanelstargetTargetPanel.Installpath := ARepertoire;

  // Enregistrement du fichier XML modifi�
  AssignFile(XMLFile, sFichParams);
  try
    Rewrite(XMLFile);
    Write(XMLFile, XMLServeurFile.XML);
  finally
    CloseFile(XMLFile);
  end;
  {$ENDREGION 'Modification des param�tres d�installation automatique'}

  {$REGION 'Lancement du programme d�installation en mode automatique'}
  Journaliser('Lancement du programme d�installation en mode automatique.');
  if ExecuterAdministrateur('javaw', Format('-jar %s %s', [sProgInstall, sFichParams]), ARepertoire) then
    Journaliser('Programme d�installation termin�.')
  else begin
    Journaliser('Erreur lors de l�ex�cution du programme d�installation.', NivErreur);
    Result := False;
    Exit;
  end;

  // V�rification du service SymmetricDS
  Journaliser('V�rification du service SymmetricDS.');
  if ServiceExiste() then
  begin
    Journaliser('Le service SymmetricDS a bien �t� install�.');
  end
  else begin
    Journaliser('Erreur lors de la v�rification du service SymmetricDS.', NivErreur);
    Result := False;
    Exit;
  end;
  {$ENDREGION 'Lancement du programme d�installation en mode automatique'}

  {$REGION 'Mise � la corbeille des fichiers d�installation'}
  Journaliser('Mise � la corbeille des fichiers d�installation.');
  if not(MettreCorbeille(sProgInstall) and MettreCorbeille(sFichParams)) then
  begin
    Journaliser('Erreur lors de la suppression des fichiers d�installation.', NivErreur);
  end;
  {$ENDREGION 'Mise � la corbeille des fichiers d�installation'}

  {$REGION 'R�cup�ration du chemin d�InterBase'}
  Journaliser('R�cup�ration du chemin d�InterBase.');
  reExpression      := TPerlRegEx.Create();
  try
    try
      sCheminInterBase          := InfoSurService('IBS_gds_db').BinaryPathName;
      reExpression.RegEx        := REGEXP_RECUP_CHEMIN;
      reExpression.Subject      := sCheminInterBase;

      if reExpression.Match() then
        sCheminInterBase := reExpression.Groups[1] + reExpression.Groups[2];

      sCheminInterBase   := ExtractFilePath(sCheminInterBase);
    except
      on E: Exception do
      begin
        Journaliser(Format('Erreur lors de la r�cup�ration du chemin d�InterBase.' + sLineBreak + '%s - %s',
          [E.ClassName, E.Message]), NivErreur);
        Result := False;
        Exit;
      end;
    end;
  finally
    reExpression.Free();
  end;
  {$ENDREGION 'R�cup�ration du chemin d�InterBase'}

  {$REGION 'Installation des UDF de SymmetricDS'}
  Journaliser('Installation des UDF de SymmetricDS.');
  if CopierFichier(Format('%s\databases\interbase\sym_udf.dll', [ExcludeTrailingPathDelimiter(ARepertoire)]),
    Format('%s\..\UDF\sym_udf.dll', [ExcludeTrailingPathDelimiter(sCheminInterBase)])) then
  begin
    Journaliser('Installation des UDF de SymmetricDS termin�e.');
  end
  else begin
    Journaliser('Erreur lors de l�installation des UDF de SymmetricDS.', NivErreur);
    Result := False;
    Exit;
  end;
  {$ENDREGION 'Installation des UDF de SymmetricDS'}

  {$REGION 'Installation de InterClient'}
  Journaliser('Installation de InterClient.');
  if CopierFichier(Format('%s\..\SDK\lib\interclient.jar', [ExcludeTrailingPathDelimiter(sCheminInterBase)]),
    Format('%s\lib\interclient.jar', [ExcludeTrailingPathDelimiter(ARepertoire)])) then
  begin
    Journaliser('Installation de InterClient termin�e.');
  end
  else begin
    Journaliser('Erreur lors de l�installation de InterClient.', NivErreur);
    Result := False;
    Exit;
  end;
  {$ENDREGION 'Installation de InterClient'}

(*
  {$REGION 'Configuration de Java pour SymmetricDS'}
  Journaliser('Configuration de Java pour SymmetricDS.');
  slConfFile        := TStringList.Create();
  try
    sFichierConf                  := Format('%s\conf\sym_service.conf', [ExcludeTrailingPathDelimiter(ARepertoire)]);
    slConfFile.NameValueSeparator := '=';
    slConfFile.LoadFromFile(sFichierConf);

    // Passe en mode serveur
    iIndex := slConfFile.IndexOfName('#wrapper.java.additional.12');
    if iIndex > -1 then
      slConfFile[iIndex]  := 'wrapper.java.additional.12=-server'
    else
      slConfFile.Values['wrapper.java.additional.12'] := '-server';

    // Change les tailles pour la RAM allou�e
    slConfFile.Values['wrapper.java.initmemory']      := '2048';
    slConfFile.Values['wrapper.java.maxmemory']       := '2048';

    slConfFile.SaveToFile(sFichierConf);
  finally
    slConfFile.Free();
  end;
  {$ENDREGION 'Configuration de Java pour SymmetricDS'}
*)

  {$IFDEF DEBUG}
  {$REGION 'Configuration de SymmetricDS 3.6.10 pour InterBase'}
  Journaliser('Configuration de SymmetricDS 3.6.10 pour InterBase.');
  slConfFile        := TStringList.Create();
  try
    sFichierConf                  := Format('%s\conf\symmetric.properties', [ExcludeTrailingPathDelimiter(ARepertoire)]);
    slConfFile.NameValueSeparator := '=';

    // Change l'"initial load"
    slConfFile.Values['initial.load.concat.csv.in.sql.enabled'] := 'true';

    slConfFile.SaveToFile(sFichierConf);
  finally
    slConfFile.Free();
  end;
  {$ENDREGION 'Configuration de SymmetricDS 3.6.10 pour InterBase'}
  {$ENDIF}

  {$REGION 'D�marrage du service SymmetricDS'}
  Journaliser('D�marrage du service SymmetricDS.');
  try
    if ExecuterAdministrateur('NET', 'START SymmetricDS', '', False) then
      Journaliser('Service SymmetricDS d�marr�.')
    else begin
      Journaliser('Erreur lors du d�marrage du service SymmetricDS.', NivErreur);
      Result := False;
      Exit;
    end;
  except
    on E: Exception do
    begin
      Journaliser(Format('Erreur lors du d�marrage du service SymmetricDS.' + sLineBreak + '%s'#160': %s',
        [E.ClassName, E.Message]), NivErreur);
      Result := False;
      Exit;
    end;
  end;
  {$ENDREGION 'D�marrage du service SymmetricDS'}

  Result := True;
end;

// Installation des dossiers
function TDataModuleTraitements.InstallationDossier(const ABaseDonnees: TFileName;
  const ARepertoireSymmDS, ANomDossier, AAdresseURL: string; const AListeBases: TStringList): Boolean;
const
  USERID    = 'ginkoia';
  FIRSTNAME = 'Ginkoia';
  LASTNAME  = FIRSTNAME;
  EMAIL     = 'ginkoia@ginkoia.fr';
  PASSWORD  = 'ch@mon1x';
var
  sNomDossier           : string;
  sAdresseURL           : string;
  sFichierConf          : TFileName;
  slConfFile            : TStringList;
  slListeTables         : TStringList;
  ResScripts            : TResourceStream;
  FicSymGrants          : TFileName;
  FicSymProcedures      : TFileName;
  i, j                  : Integer;
  bNoeudCorrecte        : Boolean;
begin
  Result := False;

  // V�rifie que le nom de dossier ne comporte pas d'espaces
  for i := 1 to Length(ANomDossier) do
  begin
    if not(ANomDossier[i] in ['0'..'9', 'A'..'Z', 'a'..'z', '-', '_']) then
    begin
      Journaliser(Format('Le nom du dossier "%s" n�est pas correct.', [ANomDossier]), NivErreur);
      Result := False;
      Exit;
    end;
  end;

  sNomDossier := LowerCase(ANomDossier);
  sAdresseURL := AAdresseURL;  
  if sAdresseURL[High(sAdresseURL)] = '/' then
    SetLength(sAdresseURL, Length(sAdresseURL) - 1);  

  {$REGION 'Cr�ation du fichier de propri�t�s'}
  Journaliser(Format('Cr�ation du fichier de propri�t�s pour le dossier "%s".', [sNomDossier]));
  sFichierConf      := Format('%s\engines\%s.properties',
    [ExcludeTrailingPathDelimiter(ARepertoireSymmDS), sNomDossier]);
  slConfFile        := TStringList.Create();
  try
    slConfFile.NameValueSeparator             := '=';
    slConfFile.Values['engine.name']          := sNomDossier;
    slConfFile.Values['db.driver']            := 'interbase.interclient.Driver';
    slConfFile.Values['db.url']               := 'jdbc:interbase://localhost:3050/' + ReplaceStr(ABaseDonnees, '\', '/');
    slConfFile.Values['db.user']              := 'sysdba';
    slConfFile.Values['db.password']          := 'masterkey';
    slConfFile.Values['db.validation.query']  := 'SELECT CAST(1 AS INTEGER) FROM RDB$DATABASE';
    slConfFile.Values['sync.url']             := Format('%s/sync/%s', [ExcludeTrailingPathDelimiter(sAdresseURL), sNomDossier]);
    slConfFile.Add('registration.url='); 
    slConfFile.Values['group.id']             := Format('dossier-%s', [sNomDossier]);
    slConfFile.Values['external.id']          := sNomDossier;
    slConfFile.SaveToFile(sFichierConf);
  finally
    slConfFile.Free();
  end;
  {$ENDREGION 'Cr�ation du fichier de propri�t�s'}

  {$REGION 'Cr�ation des tables pour SymmetricDS'}
  Journaliser('Cr�ation des tables pour SymmetricDS.');
  if not(Executer(Format('%s\bin\symadmin.bat', [ExcludeTrailingPathDelimiter(ARepertoireSymmDS)]),
    Format('--engine %s create-sym-tables', [sNomDossier]), ARepertoireSymmDS, True)) then
  begin
    Journaliser('Erreur lors de la cr�ation des tables pour SymmetricDS.');
    Result := False;
    Exit;
  end;
  {$ENDREGION 'Cr�ation des tables pour SymmetricDS'}

  slListeTables         := TStringList.Create();
  try
    {$REGION 'Connexion � la base de donn�es'}
    Journaliser('Connexion � la base de donn�es');
    FdcConnection.Params.Clear();
    FdcConnection.Params.Add('DriverID=IB');
    FdcConnection.Params.Add('User_Name=sysdba');
    FdcConnection.Params.Add('Password=masterkey');
    FdcConnection.Params.Add(Format('Database=%s', [ABaseDonnees]));
    FdcConnection.Open();
    {$ENDREGION 'Connexion � la base de donn�es'}

    {$REGION 'Cr�ation de l�utilisateur Ginkoia'}
    Journaliser('Cr�ation de l�utilisateur Ginkoia.');
    FdcConnection.Transaction.StartTransaction();
    try
      try
        // V�rifie si l'utilisateur existe d�j�
        QueScript.SQL.Clear();
        QueScript.SQL.Add('SELECT COUNT(*) AS USEREXISTE');
        QueScript.SQL.Add('FROM   SYM_CONSOLE_USER');
        QueScript.SQL.Add('WHERE  USER_ID = :USERID;');
        QueScript.ParamByName('USERID').AsString          := USERID;
        QueScript.Open();
        if QueScript.FieldByName('USEREXISTE').AsInteger = 0 then
        begin
          QueScript.Close();

          // Cr�er la requ�te d'insertion
          QueScript.SQL.Clear();
          QueScript.SQL.Add('INSERT INTO SYM_CONSOLE_USER (USER_ID, FIRST_NAME, LAST_NAME, EMAIL, HASHED_PASSWORD, AUTH_METH,');
          QueScript.SQL.Add('                              USER_ROLE, CREATE_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)');
          QueScript.SQL.Add('VALUES (:USERID, :FIRSTNAME, :LASTNAME, :EMAIL, :HASHEDPASSWORD, ''INTERNAL'', ''ADMIN'', CURRENT_TIMESTAMP,');
          QueScript.SQL.Add('        ''ginkoia'', CURRENT_TIMESTAMP);');
          QueScript.ParamByName('USERID').AsString          := USERID;
          QueScript.ParamByName('FIRSTNAME').AsString       := FIRSTNAME;
          QueScript.ParamByName('LASTNAME').AsString        := LASTNAME;
          QueScript.ParamByName('EMAIL').AsString           := EMAIL;
          QueScript.ParamByName('HASHEDPASSWORD').AsString  := SHA1DigestToHexA(CalcSHA1(PASSWORD));
          try
            QueScript.ExecSQL();
          finally
            QueScript.Close();
          end;
        end
        else begin
          QueScript.Close();
          Journaliser('L�utilisateur Ginkoia existe d�j�.');
        end;
      except
        on E: Exception do
        begin
          Journaliser(Format('Erreur lors de la cr�ation de l�utilisateur Ginkoia.'#13#10'%s'#160': %s', [E.ClassName, E.Message]), NivErreur);
          Result := False;
          FdcConnection.Transaction.Rollback();
          Exit;
        end;
      end;
    finally
      if FdcConnection.Transaction.Active then
      begin
        FdcConnection.Transaction.Commit();
        Journaliser('Cr�ation de l�utilisateur Ginkoia termin�e.');
      end;
    end;
    {$ENDREGION 'Cr�ation de l�utilisateur Ginkoia'}

    {$REGION 'Extraction des scripts SQL'}
    Journaliser('Extraction des scripts SQL.');
    try
      FicSymGrants          := IncludeTrailingPathDelimiter(TPath.GetTempPath()) + 'SymGrants.sql';
      FicSymProcedures      := IncludeTrailingPathDelimiter(TPath.GetTempPath()) + 'SymProcedures.sql';

      ResScripts        := TResourceStream.Create(HInstance, 'sym_grants', RT_RCDATA);
      try
        ResScripts.SaveToFile(FicSymGrants);
        Journaliser(Format('"%s" extrait dans "%s".', ['sym_grants', FicSymGrants]));
      finally
        ResScripts.Free();
      end;

      ResScripts        := TResourceStream.Create(HInstance, 'sym_procedures', RT_RCDATA);
      try
        ResScripts.SaveToFile(FicSymProcedures);
        Journaliser(Format('"%s" extrait dans "%s".', ['sym_procedures', FicSymProcedures]));
      finally
        ResScripts.Free();
      end;

      ResScripts        := TResourceStream.Create(HInstance, 'sym_tables', RT_RCDATA);
      try
        slListeTables.LoadFromStream(ResScripts);
      finally
        ResScripts.Free();
      end;
    except
      on E: Exception do
      begin
        // Impossible d'extraire la ressource
        Journaliser(Format('Impossible d�extraire les ressources.'#13#10'%s'#160': %s', [E.ClassName, E.Message]), NivErreur);
        Result := False;
        Exit;
      end;
    end;
    {$ENDREGION 'Extraction des scripts SQL'}

    {$REGION 'Cr�ation des droits et des proc�dures stock�es'}
    Journaliser('Cr�ation des droits et des proc�dures stock�es.');
    ScriptGrants.SQLScripts.Clear();
    ScriptGrants.Arguments.Clear();
    ScriptGrants.Arguments.Add(sNomDossier);

    with ScriptGrants.SQLScripts.Add do
    begin
      Name  := 'root';
      SQL.Add('@SymGrants');
      SQL.Add('@SymProcedures');
    end;

    with ScriptGrants.SQLScripts.Add do
    begin
      Name      := 'SymGrants';
      SQL.LoadFromFile(FicSymGrants);
      SQL.Text  := ReplaceStr(SQL.Text, '&1', sNomDossier);
    end;

    with ScriptGrants.SQLScripts.Add do
    begin
      Name      := 'SymProcedures';
      SQL.LoadFromFile(FicSymProcedures);
      SQL.Text  := ReplaceStr(SQL.Text, '&1', sNomDossier);

      try
        QueProcExists.Open();

        if QueProcExists.FieldByName('PROCEXISTS').AsInteger > 0 then
        begin
          SQL.Text  := ReplaceText(SQL.Text, 'CREATE PROCEDURE', 'ALTER PROCEDURE');
        end;
      finally
        QueProcExists.Close();
      end;
    end;

    FdcConnection.StartTransaction();
    try
      if ScriptGrants.ValidateAll() then
      begin
        if ScriptGrants.ExecuteAll() then
          Journaliser('Scripts SQL ex�cut�s.')
        else begin
          Journaliser('Erreur lors de l�ex�cution des scripts SQL.', NivErreur);
          Result := False;
          Exit;
        end;
      end
      else begin
        Journaliser('Erreur lors de la validation des scripts SQL.', NivErreur);
        Result := False;
        Exit;
      end;
    finally
      if ScriptGrants.TotalErrors > 0 then
        FdcConnection.Rollback()
      else
        FdcConnection.Commit();
    end;
    {$ENDREGION 'Cr�ation des droits et des proc�dures stock�es'}

    {$REGION 'Cr�ation des d�clencheurs'}
    Journaliser('Cr�ation des d�clencheurs.');
    FdcConnection.Transaction.StartTransaction();
    try
      try
        StrProcSym.StoredProcName := 'POPULATE_SYM_TRIGGER';
        StrProcSym.Prepare();
        for i := 0 to slListeTables.Count - 1 do
        begin
          StrProcSym.ParamByName('NOMTABLE').AsString  := slListeTables[i];
          try
            StrProcSym.ExecProc();
          finally
            StrProcSym.Close();
          end;
        end;

        QueScript.SQL.Clear();
        QueScript.SQL.Add('UPDATE  SYM_TRIGGER');
        QueScript.SQL.Add('SET     SYNC_KEY_NAMES = ''K_ID''');
        QueScript.SQL.Add('WHERE   SOURCE_TABLE_NAME = ''K'';');
        try
          QueScript.ExecSQL();
        finally
          QueScript.Close();
        end;

        QueScript.SQL.Clear();
        QueScript.SQL.Add('UPDATE  SYM_TRIGGER');
        QueScript.SQL.Add('SET     SYNC_KEY_NAMES = ''CLG_ID2''');
        QueScript.SQL.Add('WHERE   SOURCE_TABLE_NAME = ''TARCLGFOURN_TMP'';');
        try
          QueScript.ExecSQL();
        finally
          QueScript.Close();
        end;

        QueScript.SQL.Clear();
        QueScript.SQL.Add('UPDATE  SYM_TRIGGER');
        QueScript.SQL.Add('SET     SYNC_KEY_NAMES = ''PVT_ID2''');
        QueScript.SQL.Add('WHERE   SOURCE_TABLE_NAME = ''TARPRIXVENTE_TMP'';');
        try
          QueScript.ExecSQL();
        finally
          QueScript.Close();
        end;

        QueScript.SQL.Clear();
        QueScript.SQL.Add('UPDATE  SYM_TRIGGER ST');
        QueScript.SQL.Add('SET     ST.SYNC_KEY_NAMES = (');
        QueScript.SQL.Add('  SELECT  F_LEFT(KTB_DATA, 6)');
        QueScript.SQL.Add('  FROM    KTB');
        QueScript.SQL.Add('  WHERE   KTB_NAME = ST.SOURCE_TABLE_NAME)');
        QueScript.SQL.Add('WHERE   ST.SYNC_KEY_NAMES IS NULL;');
        try
          QueScript.ExecSQL();
        finally
          QueScript.Close();
        end;
      except
        on E: Exception do
        begin
          Journaliser(Format('Erreur lors de la cr�ation des d�clencheurs.'#13#10'%s'#160': %s', [E.ClassName, E.Message]), NivErreur);
          Result := False;
          FdcConnection.Transaction.Rollback();
          Exit;
        end;
      end;
    finally
      if FdcConnection.Transaction.Active then
      begin
        FdcConnection.Transaction.Commit();
        Journaliser('Cr�ation des d�clencheurs termin�e.');
      end;
    end;
    {$ENDREGION 'Cr�ation des d�clencheurs'}

    {$REGION 'Cr�ation des n�uds de groupes'}
    Journaliser('Cr�ation des n�uds de groupes.');
    FdcConnection.Transaction.StartTransaction();
    try
      try
        TabSymDS.Open('SYM_NODE_GROUP');
        try
          if not(TabSymDS.Locate('NODE_GROUP_ID', Format('dossier-%s', [sNomDossier]), [loCaseInsensitive])) then
          begin
            TabSymDS.Insert();
            TabSymDS.FieldByName('NODE_GROUP_ID').AsString  := Format('dossier-%s',[sNomDossier]);
            TabSymDS.FieldByName('DESCRIPTION').AsString    := Format('Groupe du dossier %s', [UpperCase(sNomDossier)]);
            TabSymDS.Post();
          end
          else begin
            TabSymDS.Edit();            
            TabSymDS.FieldByName('DESCRIPTION').AsString    := Format('Groupe du dossier %s', [UpperCase(sNomDossier)]);
            TabSymDS.Post();
          end;

          if not(TabSymDS.Locate('NODE_GROUP_ID', Format('mags-%s', [sNomDossier]), [loCaseInsensitive])) then
          begin
            TabSymDS.Insert();
            TabSymDS.FieldByName('NODE_GROUP_ID').AsString  := Format('mags-%s',[sNomDossier]);
            TabSymDS.FieldByName('DESCRIPTION').AsString    := Format('Groupe des magasins rattach�s au dossier %s', [UpperCase(sNomDossier)]);
            TabSymDS.Post();
          end
          else begin
            TabSymDS.Edit();            
            TabSymDS.FieldByName('DESCRIPTION').AsString    := Format('Groupe des magasins rattach�s au dossier %s', [UpperCase(sNomDossier)]);
            TabSymDS.Post();
          end;
        finally
          TabSymDS.Close();
        end;

        TabSymDS.Open('SYM_NODE_GROUP_LINK');
        try
          if not(TabSymDS.Locate('SOURCE_NODE_GROUP_ID;TARGET_NODE_GROUP_ID', 
            VarArrayOf([Format('mags-%s', [sNomDossier]), Format('dossier-%s', [sNomDossier])]), [loCaseInsensitive])) then
          begin
            TabSymDS.Insert();
            TabSymDS.FieldByName('SOURCE_NODE_GROUP_ID').AsString   := Format('mags-%s',[sNomDossier]);
            TabSymDS.FieldByName('TARGET_NODE_GROUP_ID').AsString   := Format('dossier-%s',[sNomDossier]);
            TabSymDS.FieldByName('DATA_EVENT_ACTION').AsString      := 'P';
            TabSymDS.FieldByName('SYNC_CONFIG_ENABLED').AsInteger   := 1;
            TabSymDS.FieldByName('CREATE_TIME').AsDateTime          := Now();
            TabSymDS.FieldByName('LAST_UPDATE_BY').AsString         := 'Ginkoia';
            TabSymDS.FieldByName('LAST_UPDATE_TIME').AsDateTime     := Now();
            TabSymDS.Post();
          end;      
          
          if not(TabSymDS.Locate('SOURCE_NODE_GROUP_ID;TARGET_NODE_GROUP_ID', 
            VarArrayOf([Format('dossier-%s', [sNomDossier]), Format('mags-%s', [sNomDossier])]), [loCaseInsensitive])) then
          begin
            TabSymDS.Insert();
            TabSymDS.FieldByName('SOURCE_NODE_GROUP_ID').AsString   := Format('dossier-%s',[sNomDossier]);
            TabSymDS.FieldByName('TARGET_NODE_GROUP_ID').AsString   := Format('mags-%s',[sNomDossier]);
            TabSymDS.FieldByName('DATA_EVENT_ACTION').AsString      := 'W';          
            TabSymDS.FieldByName('SYNC_CONFIG_ENABLED').AsInteger   := 1;
            TabSymDS.FieldByName('CREATE_TIME').AsDateTime          := Now();    
            TabSymDS.FieldByName('LAST_UPDATE_BY').AsString         := 'Ginkoia';
            TabSymDS.FieldByName('LAST_UPDATE_TIME').AsDateTime     := Now();
            TabSymDS.Post();
          end;     
        finally
          TabSymDS.Close();
        end;
      except
        on E: Exception do
        begin
          Journaliser(Format('Erreur lors de la cr�ation des n�uds de groupes.'#13#10'%s'#160': %s', [E.ClassName, E.Message]), NivErreur);
          Result := False;
          FdcConnection.Transaction.Rollback();
          Exit;
        end;
      end;
    finally
      if FdcConnection.Transaction.Active then
      begin
        FdcConnection.Transaction.Commit();
        Journaliser('Cr�ation des n�uds de groupes termin�e.');
      end;
    end;
    {$ENDREGION 'Cr�ation des n�uds de groupes'}

    {$REGION 'Cr�ation des routeurs'}      
    Journaliser('Cr�ation des routeurs.');
    FdcConnection.Transaction.StartTransaction();
    try
      try
        TabSymDS.Open('SYM_ROUTER');     
        try 
          if not(TabSymDS.Locate('ROUTER_ID', Format('mags-%0:s_2_dossier-%0:s', [sNomDossier]), [loCaseInsensitive])) then
          begin
            TabSymDS.Insert();
            TabSymDS.FieldByName('ROUTER_ID').AsString                  := Format('mags-%0:s_2_dossier-%0:s', [sNomDossier]);
            TabSymDS.FieldByName('SOURCE_NODE_GROUP_ID').AsString       := Format('mags-%s', [sNomDossier]);
            TabSymDS.FieldByName('TARGET_NODE_GROUP_ID').AsString       := Format('dossier-%s', [sNomDossier]);    
            TabSymDS.FieldByName('ROUTER_TYPE').AsString                := 'default';
            TabSymDS.FieldByName('SYNC_ON_UPDATE').AsInteger            := 1;
            TabSymDS.FieldByName('SYNC_ON_INSERT').AsInteger            := 1;
            TabSymDS.FieldByName('SYNC_ON_DELETE').AsInteger            := 1;         
            TabSymDS.FieldByName('USE_SOURCE_CATALOG_SCHEMA').AsInteger := 1;
            TabSymDS.FieldByName('CREATE_TIME').AsDateTime              := Now();  
            TabSymDS.FieldByName('LAST_UPDATE_BY').AsString             := 'Ginkoia';
            TabSymDS.FieldByName('LAST_UPDATE_TIME').AsDateTime         := Now();
            TabSymDS.Post();
          end; 
            
          if not(TabSymDS.Locate('ROUTER_ID', Format('dossier-%0:s_2_mags-%0:s', [sNomDossier]), [loCaseInsensitive])) then
          begin
            TabSymDS.Insert();
            TabSymDS.FieldByName('ROUTER_ID').AsString                  := Format('dossier-%0:s_2_mags-%0:s', [sNomDossier]);
            TabSymDS.FieldByName('SOURCE_NODE_GROUP_ID').AsString       := Format('dossier-%s', [sNomDossier]);
            TabSymDS.FieldByName('TARGET_NODE_GROUP_ID').AsString       := Format('mags-%s', [sNomDossier]);   
            TabSymDS.FieldByName('ROUTER_TYPE').AsString                := 'default';
            TabSymDS.FieldByName('SYNC_ON_UPDATE').AsInteger            := 1;
            TabSymDS.FieldByName('SYNC_ON_INSERT').AsInteger            := 1;
            TabSymDS.FieldByName('SYNC_ON_DELETE').AsInteger            := 1;         
            TabSymDS.FieldByName('USE_SOURCE_CATALOG_SCHEMA').AsInteger := 1;
            TabSymDS.FieldByName('CREATE_TIME').AsDateTime              := Now();    
            TabSymDS.FieldByName('LAST_UPDATE_BY').AsString             := 'Ginkoia';
            TabSymDS.FieldByName('LAST_UPDATE_TIME').AsDateTime         := Now();
            TabSymDS.Post();
          end;
        finally
          TabSymDS.Close();
        end;
        
      except
        on E: Exception do
        begin
          Journaliser(Format('Erreur lors de la cr�ation des routeurs.'#13#10'%s'#160': %s', [E.ClassName, E.Message]), NivErreur);
          Result := False;
          FdcConnection.Transaction.Rollback();
          Exit;
        end;
      end;
    finally
      if FdcConnection.Transaction.Active then
      begin
        FdcConnection.Transaction.Commit();
        Journaliser('Cr�ation des routeurs termin�e.');
      end;
    end;    
    {$ENDREGION 'Cr�ation des routeurs'}

    {$REGION 'Liaison des d�clencheurs avec les routeurs'}
    Journaliser('Liaison des d�clencheurs avec les routeurs.');
    FdcConnection.Transaction.StartTransaction();
    try
      try
        StrProcSym.StoredProcName := 'POPULATE_SYM_TRIGGER_ROUTER_DEFAULT';
        StrProcSym.Prepare();
        for i := 0 to slListeTables.Count - 1 do
        begin
          StrProcSym.ParamByName('NOMTABLE').AsString   := slListeTables[i];
          StrProcSym.ParamByName('ROUTERID1').AsString  := Format('dossier-%0:s_2_mags-%0:s', [sNomDossier]);
          StrProcSym.ParamByName('ROUTERID2').AsString  := Format('mags-%0:s_2_dossier-%0:s', [sNomDossier]);
          try
            StrProcSym.ExecProc();
          finally
            StrProcSym.Close();
          end;
        end;
      except
        on E: Exception do
        begin
          Journaliser(Format('Erreur lors de la liaison des d�clencheurs avec les routeurs.'#13#10'%s'#160': %s',
            [E.ClassName, E.Message]), NivErreur);
          Result := False;
          FdcConnection.Transaction.Rollback();
          Exit;
        end;
      end;
    finally
      if FdcConnection.Transaction.Active then
      begin
        FdcConnection.Transaction.Commit();
        Journaliser('Liaison des d�clencheurs avec les routeurs termin�e.');
      end;
    end;
    {$ENDREGION 'Liaison des d�clencheurs avec les routeurs'}
  finally
    slListeTables.Free();
    FdcConnection.Close();
  end;

  {$REGION 'Cr�ation des n�uds des magasins pour la r�plication'}
  Journaliser('Cr�ation des n�uds des magasins pour la r�plication.');
  for i := 0 to AListeBases.Count - 1 do
  begin
    // V�rifie que le nom de dossier ne comporte pas d'espaces
    bNoeudCorrecte := True;
    for j := 1 to Length(ANomDossier) do
    begin
      if not(AListeBases[i][j] in ['0'..'9', 'A'..'Z', 'a'..'z', '-', '_']) then
      begin
        Journaliser(Format('Le nom du n�uds "%s" n�est pas correct. Il ne sera pas pris en compte.', [AListeBases[i]]), NivErreur);
        bNoeudCorrecte := False;
        Break;
      end;
    end;

    if bNoeudCorrecte then
    begin
      if not(Executer(Format('%s\bin\symadmin.bat', [ExcludeTrailingPathDelimiter(ARepertoireSymmDS)]),
        Format('--engine %0:s open-registration mags-%0:s %1:s', [sNomDossier, LowerCase(AListeBases[i])]), ARepertoireSymmDS, True)) then
      begin
        Journaliser('Erreur lors de la cr�ation des n�uds des magasins pour la r�plication.');
        Result := False;
        Exit;
      end
      else begin
        Journaliser(Format('N�ud pour le magasin "%s" cr��.', [LowerCase(AListeBases[i])]));
      end;
    end;
  end;
  {$ENDREGION 'Cr�ation des n�uds des magasins pour la r�plication'}

  Result := True;
end;

// Installation de client
function TDataModuleTraitements.InstallationClient(const ABaseDonnees: TFileName = ''; 
  const ARepertoireSymmDS: string = 'C:\SymmetricDS-Pro'): Boolean;
const
  REGGINKOIA    = '\SOFTWARE\Algol\Ginkoia';
var
  sBaseDonnees  : TFileName; 
  Registre      : TRegistry;
  sNomClient    : string;
  InfoClient    : TInfosReplication;   
  sFichierConf  : TFileName; 
  slConfFile    : TStringList;
begin  
  Result := False;
  
  {$REGION 'R�cup�ration du chemin de la base de donn�es'}
  if ABaseDonnees = '' then
  begin                                                    
    // Si la base de donn�es n'est pas sp�cifi�e : la r�cup�rer depuis la base de registre
    Journaliser('R�cup�ration du chemin de la base de donn�es.');
    Registre := TRegistry.Create(KEY_READ);
    try
      Registre.RootKey  := HKEY_LOCAL_MACHINE;
      if Registre.OpenKey(REGGINKOIA, False) then
      begin
        sBaseDonnees := Registre.ReadString('Base0');
        if sBaseDonnees = '' then
          sBaseDonnees := 'C:\Ginkoia\Data\Ginkoia.ib';
      end;
    finally
      Registre.Free();
    end;  
  end
  else begin
    sBaseDonnees := ABaseDonnees;
  end;                                         
  Journaliser(Format('Base de donn�es -> %s', [sBaseDonnees]));  
  {$ENDREGION 'R�cup�ration du chemin de la base de donn�es'}

  {$REGION 'R�cup�re les informations de r�plication'}
  Journaliser('R�cup�re les informations de r�plication.');
  sNomClient  := NomClient(sBaseDonnees);
  InfoClient  := InfosReplication(sBaseDonnees);
  Journaliser(Format(' - Nom du client'#160': %s', [sNomClient]));  
  Journaliser(Format(' - Nom de la base'#160': %s', [InfoClient.NomBase]));    
  Journaliser(Format(' - Nom du serveur de r�plication'#160': %s', [InfoClient.ServeurReplication]));  
  {$ENDREGION 'R�cup�re les informations de r�plication'}
  
  {$REGION 'Cr�ation du fichier de propri�t�s'}
  Journaliser(Format('Cr�ation du fichier de propri�t�s pour la base "%s".', [InfoClient.NomBase]));
  sFichierConf      := Format('%s\engines\%s.properties',
    [ExcludeTrailingPathDelimiter(ARepertoireSymmDS), LowerCase(InfoClient.NomBase)]);
  slConfFile        := TStringList.Create();
  try
    slConfFile.NameValueSeparator             := '=';
    slConfFile.Values['engine.name']          := LowerCase(InfoClient.NomBase);
    slConfFile.Values['registration.url']     := Format('https://%s:31417/sync/%s', [InfoClient.ServeurReplication, LowerCase(sNomClient)]);
    slConfFile.Values['sync.url']             := Format('https://localhost:31417/sync/%s', [LowerCase(InfoClient.NomBase)]);    
    slConfFile.Values['db.driver']            := 'interbase.interclient.Driver';
    slConfFile.Values['db.url']               := 'jdbc:interbase://localhost:3050/' + ReplaceStr(sBaseDonnees, '\', '/');
    slConfFile.Values['db.user']              := 'sysdba';
    slConfFile.Values['db.password']          := 'masterkey';
    slConfFile.Values['db.validation.query']  := 'SELECT CAST(1 AS INTEGER) FROM RDB$DATABASE';    
    slConfFile.Values['group.id']             := Format('mags-%s', [LowerCase(sNomClient)]);  
    slConfFile.Values['external.id']          := LowerCase(InfoClient.NomBase);
    slConfFile.SaveToFile(sFichierConf);
  finally
    slConfFile.Free();
  end;
  {$ENDREGION 'Cr�ation du fichier de propri�t�s'}

  {$REGION 'Arr�t du service SymmetricDS'}
  Journaliser('Arr�t du service SymmetricDS.');
  try
    if ExecuterAdministrateur('NET', 'STOP SymmetricDS', '', False) then
      Journaliser('Service SymmetricDS arr�t�.')
    else begin
      Journaliser('Erreur lors de l�arr�t du service SymmetricDS.', NivErreur);
      Result := False;
      Exit;
    end;
  except
    on E: Exception do
    begin
      Journaliser(Format('Erreur lors de l�arr�t du service SymmetricDS.' + sLineBreak + '%s'#160': %s',
        [E.ClassName, E.Message]), NivErreur);
      Result := False;
      Exit;
    end;
  end;
  {$ENDREGION 'D�marrage du service SymmetricDS'}

  {$REGION 'Red�marrage du service SymmetricDS'}
  Journaliser('Red�marrage du service SymmetricDS.');
  try
    if ExecuterAdministrateur('NET', 'START SymmetricDS', '', False) then
      Journaliser('Service SymmetricDS d�marr�.')
    else begin
      Journaliser('Erreur lors du red�marrage du service SymmetricDS.', NivErreur);
      Result := False;
      Exit;
    end;
  except
    on E: Exception do
    begin
      Journaliser(Format('Erreur lors du red�marrage du service SymmetricDS.' + sLineBreak + '%s'#160': %s',
        [E.ClassName, E.Message]), NivErreur);
      Result := False;
      Exit;
    end;
  end;
  {$ENDREGION 'D�marrage du service SymmetricDS'}

  Result := True;
end;

// Nom de la base de donn�es
function TDataModuleTraitements.NomClient(const ABaseDonnees: TFileName): string;
begin
  try
    // Param�tre la connexion � la base de donn�es
    FdcConnection.Params.Clear();
    FdcConnection.Params.Add('DriverID=IB');
    FdcConnection.Params.Add('User_Name=ginkoia');
    FdcConnection.Params.Add('Password=ginkoia');
    FdcConnection.Params.Add(Format('Database=%s', [ABaseDonnees]));

    QueNomClient.Open();

    if not(QueNomClient.IsEmpty) then
      Result := QueNomClient.FieldByName('BAS_NOMPOURNOUS').AsString
    else
      Result := '';

  finally
    FdcConnection.Close();
  end;
end; 

// Nom de la base de donn�es et serveur de r�plication
function TDataModuleTraitements.InfosReplication(const ABaseDonnees: TFileName): TInfosReplication;
const
  REGEXP_URL = 'http://([^:|/]+)*'; 
var
  reExpression      : TPerlRegEx;
begin
  try
    // Param�tre la connexion � la base de donn�es
    FdcConnection.Params.Clear();
    FdcConnection.Params.Add('DriverID=IB');
    FdcConnection.Params.Add('User_Name=ginkoia');
    FdcConnection.Params.Add('Password=ginkoia');
    FdcConnection.Params.Add(Format('Database=%s', [ABaseDonnees]));

    QueURLReplic.Open();

    if not(QueURLReplic.IsEmpty) then
    begin
      Result.NomBase              := QueURLReplic.FieldByName('BAS_NOM').AsString;
      Result.ServeurReplication   := QueURLReplic.FieldByName('REP_URLDISTANT').AsString; 
          
      // R�cup�re le nom du serveur dans l'URL
      reExpression  := TPerlRegEx.Create();
      try       
        reExpression.RegEx        := REGEXP_URL;
        reExpression.Subject      := Result.ServeurReplication;
        
        if reExpression.Match() then
          Result.ServeurReplication   := reExpression.Groups[1]; 
      finally
        reExpression.Free();
      end;
    end
    else begin
      Result.NomBase              := '';  
      Result.ServeurReplication   := '';
    end;

  finally
    FdcConnection.Close();
  end;
end;

procedure TDataModuleTraitements.ScriptGrantsError(ASender: TObject;
  const AInitiator: IFDStanObject; var AException: Exception);
begin
  Journaliser(Format('Erreur lors de l�ex�cution d�un script'#160': %s - %s',
    [AException.ClassName, AException.Message]), NivErreur);
end;

// Liste des bases de la base de donn�es
function TDataModuleTraitements.ListeBases(const ABaseDonnees: TFileName;
  out AListeBases: TStringList): Boolean;
begin
  try
    // Param�tre la connexion � la base de donn�es
    FdcConnection.Params.Clear();
    FdcConnection.Params.Add('DriverID=IB');
    FdcConnection.Params.Add('User_Name=ginkoia');
    FdcConnection.Params.Add('Password=ginkoia');
    FdcConnection.Params.Add(Format('Database=%s', [ABaseDonnees]));

    QueListeBases.Open();

    AListeBases.Clear();

    while not(QueListeBases.Eof) do
    begin
      AListeBases.Add(QueListeBases.FieldByName('BAS_SENDER').AsString);
      QueListeBases.Next();
    end;

    Result := not(QueListeBases.IsEmpty);
  finally
    FdcConnection.Close();
  end;
end;

end.
