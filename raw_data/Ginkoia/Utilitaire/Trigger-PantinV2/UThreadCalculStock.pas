unit UThreadCalculStock;

interface

uses
  Classes, SysUtils, Windows, DateUtils, DB, IBCustomDataSet, IBQuery, IBDatabase, IBStoredProc,
  StdCtrls, StrUtils, ResStr;

type
  TThreadCalculStock = class(TThread)
  strict private
    { D�clarations priv�es }
    IBDB_BaseClient: TIBDatabase;
    IBT_BaseClient: TIBTransaction;
    IBQue_GENTRIGGER: TIBQuery;
    IBQue_VER13: TIBQuery;
    IBStProc_ProcStock: TIBStoredProc;
    iGenTrigger: ShortInt;
    hDebut, hFin: TDateTime;
    // R�cup�re l'�tat de GENTRIGGER et le place � 1
    function EtatGenTrigger(): ShortInt;
    // V�rifie que l'on est en version 13 ou sup�rieure
    function EtatVer13(): Boolean;
    // Ex�cute la proc�dure stock�e de pr�traitement
    procedure ExecutePretraitement();
    // Ex�cute la proc�dure de d�clencheur diff�r�e
    procedure ExecuteTriggerDiffere();
  protected
    procedure Execute(); override;
  public
    { D�clarations publiques }
    Id:               Integer;
    Nom:              String;
    Chemin:           String;
    TempsMoyen:       Integer;
    TempsTraitement:  Integer;
    DerniereDate:     TDateTime;
    Erreur:           Boolean;
    ErreurMessage:    String;
    Annuler:          Boolean;
    LblTraites:       TLabel;
  end;

implementation

{ TThreadCalculStock }

// R�cup�re l'�tat de GENTRIGGER et le place � 1
function TThreadCalculStock.EtatGenTrigger(): ShortInt;
begin
  // Connecte le Query
  IBQue_GENTRIGGER := TIBQuery.Create(nil);
  try
    IBQue_GENTRIGGER.Database := IBDB_BaseClient;

    // V�rifie si GENTRIGGER est � 1
    IBQue_GENTRIGGER.SQL.Clear();
    IBQue_GENTRIGGER.SQL.Add('SELECT GEN_ID(GENTRIGGER, 0) GENTRIGGER');
    IBQue_GENTRIGGER.SQL.Add('FROM RDB$DATABASE');
    IBQue_GENTRIGGER.Open();

    Result := IBQue_GENTRIGGER.FieldByName('GENTRIGGER').AsInteger;

    // Si GENTRIGGER est � 0 : on le met � 1
    if Result = 0 then
    begin
      IBQue_GENTRIGGER.Close();
      IBQue_GENTRIGGER.SQL.Clear();
      IBQue_GENTRIGGER.SQL.Add('SET GENERATOR GENTRIGGER TO 1');
      IBQue_GENTRIGGER.ExecSQL();
    end;
  finally
    IBQue_GENTRIGGER.Free();
  end;
end;

// V�rifie que l'on est en version 13 ou sup�rieure
function TThreadCalculStock.EtatVer13(): Boolean;
var
  sVersion: String;
  iVersion: Integer;
begin
  // Connecte le Query
  Result := False;
  IBQue_VER13 := TIBQuery.Create(nil);
  try
    IBQue_VER13.Database := IBDB_BaseClient;

    // V�rifie la version
    IBQue_VER13.SQL.Clear();
    IBQue_VER13.SQL.Add('SELECT VER_VERSION');
    IBQue_VER13.SQL.Add('FROM   GENVERSION');
    IBQue_VER13.SQL.Add('ORDER  BY VER_DATE DESC ROWS 1');
    IBQue_VER13.Open();

    if IBQue_VER13.RecordCount > 0 then
    begin
      sVersion := IBQue_VER13.FieldByName('VER_VERSION').AsString;
      if TryStrToInt(LeftStr(sVersion, Pos('.', sVersion) - 1), iVersion) then
        Result := iVersion >= 13;
    end;
  finally
    IBQue_VER13.Free();
  end;
end;

// Ex�cute la proc�dure stock�e de pr�traitement
procedure TThreadCalculStock.ExecutePretraitement();
begin
  // Connecte la proc�dure stock�e
  IBStProc_ProcStock := TIBStoredProc.Create(nil);
  try
    LblTraites.Caption                := RS_INFO_PRETRAITEMENT;
    IBStProc_ProcStock.Database       := IBDB_BaseClient;
    IBStProc_ProcStock.StoredProcName := 'EAI_TRIGGER_PRETRAITE';
    IBStProc_ProcStock.ExecProc();
  finally
    IBStProc_ProcStock.Free();
  end;
end;

// Ex�cute la proc�dure de d�clencheur diff�r�e
procedure TThreadCalculStock.ExecuteTriggerDiffere();
const
  PAS = 10;
var
  iNbTraites, iNbPaquets: Integer;
begin
  // Connecte le Query
  IBQue_GENTRIGGER := TIBQuery.Create(nil);
  try
    IBQue_GENTRIGGER.Database := IBDB_BaseClient;

    if EtatVer13() then
    begin
      iNbTraites := 0;
      iNbPaquets := 0;

      // Compte le nombre de paquets � traiter
      if IBQue_GENTRIGGER.Active then
        IBQue_GENTRIGGER.Close();

      IBQue_GENTRIGGER.SQL.Clear();
      IBQue_GENTRIGGER.SQL.Add('SELECT COUNT(*) AS NBPAQUETS');
      IBQue_GENTRIGGER.SQL.Add('FROM   GENTRIGGERDIFF');
      IBQue_GENTRIGGER.Open();

      if IBQue_GENTRIGGER.RecordCount > 0 then
        iNbPaquets := IBQue_GENTRIGGER.FieldByName('NBPAQUETS').AsInteger;

      // Ex�cute la proc�dure stock�e
      IBQue_GENTRIGGER.Close();
      IBQue_GENTRIGGER.SQL.Clear();
      IBQue_GENTRIGGER.SQL.Add('SELECT RETOUR');
      IBQue_GENTRIGGER.SQL.Add('FROM   EAI_TRIGGER_DIFFERE(:PAS)');
      IBQue_GENTRIGGER.ParamCheck := True;
      IBQue_GENTRIGGER.ParamByName('PAS').AsInteger := PAS;

      repeat
        LblTraites.Caption := Format(RS_INFO_TRIGGERDIFF, [iNbTraites, iNbPaquets]);

        IBQue_GENTRIGGER.Close();
        IBQue_GENTRIGGER.Open();

        Inc(iNbTraites, PAS);
      until (IBQue_GENTRIGGER.FieldByName('RETOUR').AsInteger = 0) or Self.Terminated;
    end
    else begin
      // Ex�cute la proc�dure stock�e
      IBQue_GENTRIGGER.Close();
      IBQue_GENTRIGGER.SQL.Clear();
      IBQue_GENTRIGGER.SQL.Add('SELECT RETOUR');
      IBQue_GENTRIGGER.SQL.Add('FROM   BN_TRIGGERDIFFERE');
      LblTraites.Caption := RS_INFO_TRAITEMENT;

      repeat
        IBQue_GENTRIGGER.Close();
        IBQue_GENTRIGGER.Open();

        Inc(iNbTraites, PAS);
      until (IBQue_GENTRIGGER.FieldByName('RETOUR').AsInteger = 0) or Self.Terminated;
    end;
  finally
    IBQue_GENTRIGGER.Free();
  end;
end;

procedure TThreadCalculStock.Execute();
begin
  // R�cup�re l'heure courante
  hDebut := Now();
  Erreur := False;

  // Connecte la base de donn�es
  IBDB_BaseClient := TIBDatabase.Create(nil);
  IBT_BaseClient  := TIBTransaction.Create(nil);
  try
    try
      IBDB_BaseClient.DatabaseName        := Chemin;
      IBDB_BaseClient.Params.Clear();
      IBDB_BaseClient.Params.Values['user_name'] := 'sysdba';
      IBDB_BaseClient.Params.Values['password']  := 'masterkey';
      IBDB_BaseClient.LoginPrompt         := False;
      IBDB_BaseClient.DefaultTransaction  := IBT_BaseClient;

      IBT_BaseClient.DefaultDatabase      := IBDB_BaseClient;

      IBDB_BaseClient.Open();

      // V�rifie l'�tat de GENTRIGGER
      iGenTrigger := EtatGenTrigger();

      // V�rifie si on est en version 13 ou sup�rieure
      if EtatVer13() then
      begin
        // Ex�cute EAI_TRIGGER_PRETRAITE
        ExecutePretraitement();
      end;

      // Ex�cute BN_TRIGGERDIFFERE
      ExecuteTriggerDiffere();

      // Remet GENTRIGGER � 0 s'il l'�tait au d�but
      if iGenTrigger = 0 then
      begin
        // Connecte le Query
        IBQue_GENTRIGGER := TIBQuery.Create(nil);
        try
          IBQue_GENTRIGGER.Database := IBDB_BaseClient;

          IBQue_GENTRIGGER.SQL.Clear();
          IBQue_GENTRIGGER.SQL.Add('SET GENERATOR GENTRIGGER TO 0');
          IBQue_GENTRIGGER.ExecSQL();
        finally
          IBQue_GENTRIGGER.Free();
        end;
      end;

      // Si il faut valider
      if not(Annuler) then
      begin
        LblTraites.Caption := RS_INFO_VALIDATION;

        // Validation de la transaction
        IBT_BaseClient.Commit();

        // R�cup�re l'heure de fin
        hFin := Now();

        // Calcul du nombre de secondes pass�es
        TempsTraitement := SecondsBetween(hDebut, hFin);

        // Calcul du temps moyen
        if TempsMoyen <> 0 then
          TempsMoyen := (TempsMoyen + TempsTraitement) div 2
        else
          TempsMoyen := TempsTraitement;

        // Enregistre la date d'ex�cution
        DerniereDate := Now();
      end
      else begin
        // Si l'annulation a �t� demand�e
        IBT_BaseClient.Rollback();
      end;
    except
      on E: Exception do
      begin
        Erreur        := True;
        ErreurMessage := Format('%s : %s', [E.ClassName, E.Message]);
        OutputDebugString(PChar(ErreurMessage));

        // Annule la transaction
        IBT_BaseClient.Rollback();
      end;
    end;
  finally
    LblTraites.Caption := RS_INFO_ETAT;
    IBDB_BaseClient.Free();
    IBT_BaseClient.Free();
  end;
end;

end.
