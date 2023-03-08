unit MigrationReferentiel.Thread.MiseAJour;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Win.ComObj,
  System.Variants,
  System.Types,
  System.StrUtils,
  Winapi.ActiveX,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.IB,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Excel2010,
  MigrationReferentiel.Ressources;

type
  TThreadMiseAJour = class(TCustomMigrationThread)
  strict private
    { D�clarations strictement priv�es }
    // Mise � jour Marques et Fournisseurs
    function MiseAJour(): Boolean;
    // Mise � jour du fichier de nomenclature
    function MiseAJourNkl(): Boolean;
    // Mets � jour la table K
    procedure MiseAJourK(AKID: Integer; ASuppression: Integer = 0);
    // Retourne l'erreur d'une cellule Excel
    function ErreurCellule(const ACell: OleVariant; AhrErreur: HRESULT): string;
  protected
    { D�clarations prot�g�es }
    procedure Execute(); override;
  public
    { D�clarations publiques }
    TypeReferentiel: TTypeReferentiel;
    FichierExcel   : TFileName;
    FichierArticle : TFileName;
    CodesFinauxMaj : Boolean;
    constructor Create(CreateSuspended: Boolean); override;
  end;

implementation

{ TThreadMiseAJour }

constructor TThreadMiseAJour.Create(CreateSuspended: Boolean);
begin
  inherited;

  // Initialise le message d'erreur
  FErreur    := False;
  FMsgErreur := '';

  // Cr�er les composants pour les requ�tes SQL
  FDConnection                        := TFDConnection.Create(nil);
  FDConnection.UpdateOptions.ReadOnly := True;
  FDTransaction                       := TFDTransaction.Create(nil);
  FDTransaction.Connection            := FDConnection;
  FDQuery                             := TFDQuery.Create(nil);
  FDQuery.Connection                  := FDConnection;
  FDQuery.Transaction                 := FDTransaction;
  FDProcStoc                          := TFDStoredProc.Create(nil);
  FDProcStoc.Connection               := FDConnection;
  FDProcStoc.Transaction              := FDTransaction;
  FDProcStoc.StoredProcName           := 'PR_UPDATEK';
end;

procedure TThreadMiseAJour.Execute();
begin
  try
    // Initialise le message d'erreur
    FErreur    := False;
    FMsgErreur := '';

    // V�rifie que Excel est install�
    if not ApplicationInstalled('Excel.Application') then
      raise EExcelManquant.Create(RS_ERREUR_EXCEL);

{$REGION 'Param�trage de la connexion'}
    Progression(RS_MSG_PARAM_CONNECT, 0);
    Journaliser(Format(RS_MSG_PARAM_CONNECT_PARAMS, [Serveur, Port, BaseDonnees, Utilisateur, MotPasse]));

    if (Serveur = '') or (BaseDonnees = '') then
      raise EBaseDonnees.Create(RS_ERREUR_BASEDONNEES);

    FDConnection.Params.Clear();
    FDConnection.Params.Values['DriverID']  := 'IB';
    FDConnection.Params.Values['Protocol']  := 'TCPIP';
    FDConnection.Params.Values['User_Name'] := Utilisateur;
    FDConnection.Params.Values['Password']  := MotPasse;
    FDConnection.Params.Values['Server']    := Serveur;
    FDConnection.Params.Values['Port']      := IntToStr(Port);
    FDConnection.Params.Values['Database']  := BaseDonnees;

    FDQuery.Connection        := FDConnection;
    FDQuery.FetchOptions.Mode := fmAll;
{$ENDREGION 'Param�trage de la connexion'}
    // En fonction du type de mise � jour � effectuer
    case TypeReferentiel of
      trMarques, trFournisseurs:
        begin
          FDConnection.UpdateOptions.ReadOnly := False;
          FDQuery.UpdateOptions.ReadOnly      := False;
          if not(MiseAJour()) and not(Terminated) then
            raise EErreurFichierExcel.Create(RS_ERREUR_FICHIER_EXCEL);
        end;
      trNomenclature:
        begin
          FDConnection.UpdateOptions.ReadOnly := True;
          FDQuery.UpdateOptions.ReadOnly      := True;
          if not(MiseAJourNkl()) and not(Terminated) then
            raise EErreurFichierExcel.Create(RS_ERREUR_FICHIER_EXCEL);
        end;
    end;

    if Terminated then
      Exit;
  except
    on E: Exception do
    begin
      FErreur    := True;
      FMsgErreur := Format('%s'#160': %s'#13#10#13#10'%s', [E.ClassName, E.Message, FMsgErreur]);
      case TypeReferentiel of
        trMarques, trFournisseurs:
          Journaliser(RS_ERREUR_MAJ + sLineBreak + FMsgErreur, NivArret);
        trNomenclature:
          Journaliser(RS_ERREUR_MAJ_NKL + sLineBreak + FMsgErreur, NivArret);
      end;
    end;
  end;
end;

// Mise � jour Marques et Fournisseurs
function TThreadMiseAJour.MiseAJour(): Boolean;
var
  XLSXApplication      : OleVariant; // ExcelApplication;
  XLSXFichier          : OleVariant; // ExcelWorkbook;
  XLSXFeuille          : OleVariant; // ExcelWorksheet;
  XSLXCellule          : OleVariant; // ExcelRange;
  hrErreur             : HRESULT;
  sCellule             : string;
  sLigne               : string;
  iNbLignes, i         : Integer;
  Correspondances      : TCorrespondances;
  Correspondance       : TCorrespondance;
  CodeValeurBase       : TCodeValeur;
  CodeValeurReferentiel: TCodeValeur;
  sChampId             : string;
  sChampCode           : string;
  sChampNom            : string;
begin
  Result := False;

  try
    // Initialise les objets
    Correspondances       := TCorrespondances.Create();
    CodeValeurBase        := TCodeValeur.Create();
    CodeValeurReferentiel := TCodeValeur.Create();

{$REGION 'R�cup�re les correspondances'}
    try
      // Ouvre Excel
      CoInitialize(nil);
      XLSXApplication         := CreateOleObject('Excel.Application');
      XLSXApplication.Visible := False;

      if Terminated then
        Exit;

      // Ouvre le fichier
      XLSXFichier := XLSXApplication.Workbooks.Open(FichierExcel);

      XLSXFeuille := XLSXFichier.WorkSheets['Correspondances'];

      // V�rifie que le tableau est le bon
      sCellule    := 'C1';
      XSLXCellule := XLSXFeuille.Range[sCellule];
      sLigne      := XSLXCellule.Value;
      if not(AnsiSameText(sLigne, 'Destination')) then
      begin
        FMsgErreur := RS_ERREUR_MANQUE_DESTINATION;
        Exit;
      end;

      // R�cup�re le nombre de lignes du tableau
      iNbLignes := XLSXFeuille.UsedRange.Rows.Count - 1;

      Progression(RS_MSG_RECUP_CORRESP, 0, iNbLignes);
      Journaliser(Format(RS_MSG_RECUP_CORRESP_NOM, [FichierExcel]));

      for i := 1 to iNbLignes do
      begin
        Progression(Format(RS_MSG_RECUP_CORRESP_NB, [i, iNbLignes]), i);

        sCellule    := Format('A%u', [i + 1]);
        XSLXCellule := XLSXFeuille.Range[sCellule];
        if not(VarIsError(XSLXCellule.Value, hrErreur)) then
          CodeValeurBase.Valeur := XSLXCellule.Value
        else
        begin
          Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
            NivErreur);
          Inc(FNbErreurs);
          Continue;
        end;
        sCellule    := Format('B%u', [i + 1]);
        XSLXCellule := XLSXFeuille.Range[sCellule];
        if not(VarIsError(XSLXCellule.Value, hrErreur)) then
          CodeValeurBase.Code := XSLXCellule.Value
        else
        begin
          Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
            NivErreur);
          Inc(FNbErreurs);
          Continue;
        end;
        sCellule    := Format('C%u', [i + 1]);
        XSLXCellule := XLSXFeuille.Range[sCellule];
        if not(VarIsError(XSLXCellule.Value, hrErreur)) then
          CodeValeurReferentiel.Valeur := XSLXCellule.Value
        else
        begin
          Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
            NivErreur);
          Inc(FNbErreurs);
          Continue;
        end;
        sCellule    := Format('D%u', [i + 1]);
        XSLXCellule := XLSXFeuille.Range[sCellule];
        if not(VarIsError(XSLXCellule.Value, hrErreur)) then
          CodeValeurReferentiel.Code := XSLXCellule.Value
        else
        begin
          Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
            NivErreur);
          Inc(FNbErreurs);
          Continue;
        end;

        Correspondance := TCorrespondance.Create(CodeValeurBase, CodeValeurReferentiel);
        Correspondances.Add(Correspondance);

        if Terminated then
          Exit;
      end;
    finally
      XLSXFichier.Close(False);
      XSLXCellule     := Unassigned;
      XLSXFeuille     := Unassigned;
      XLSXFichier     := Unassigned;
      XLSXApplication := Unassigned;
      CoUnInitialize();
    end;
{$ENDREGION 'R�cup�re les correspondances'}
{$REGION 'Met � jour la base de donn�es'}
    try
      Progression(RS_MSG_MAJ_BDD, 0, Correspondances.Count);
      Journaliser(RS_MSG_MAJ_BDD);

      try
        FDTransaction.StartTransaction();

        if FDQuery.Active then
          FDQuery.Close();

        // Charge la requ�te pour les mises � jour
        case TypeReferentiel of
          trMarques:
            begin
              FDQuery.SQL.Clear();
              FDQuery.SQL.Add('SELECT MRK_ID, MRK_CODE, MRK_NOM');
              FDQuery.SQL.Add('FROM   ARTMARQUE');
              FDQuery.SQL.Add('  JOIN K ON (K_ID = MRK_ID AND K_ENABLED = 1 AND K_ID != 0)');
              FDQuery.SQL.Add('WHERE  MRK_CODE = :MRK_CODE');
              FDQuery.SQL.Add('  AND  MRK_NOM  = :MRK_NOM;');
              sChampId   := 'MRK_ID';
              sChampCode := 'MRK_CODE';
              sChampNom  := 'MRK_NOM';
            end;
          trFournisseurs:
            begin
              FDQuery.SQL.Add('SELECT FOU_ID, FOU_CODE, FOU_NOM');
              FDQuery.SQL.Add('FROM   ARTFOURN');
              FDQuery.SQL.Add('  JOIN K ON (K_ID = FOU_ID AND K_ENABLED = 1 AND FOU_ID != 0)');
              FDQuery.SQL.Add('WHERE  FOU_CODE = :FOU_CODE');
              FDQuery.SQL.Add('  AND  FOU_NOM  = :FOU_NOM;');
              sChampId   := 'FOU_ID';
              sChampCode := 'FOU_CODE';
              sChampNom  := 'FOU_NOM';
            end;
        end;

        if Terminated then
          Exit;

        // Parcours les correspondances du ficheir Excel
        i := 0;
        for Correspondance in Correspondances do
        begin
          Inc(i);
          Progression(Format(RS_MSG_MAJ_BDD_NB, [i, Correspondances.Count]), i);

          // Si des informations ont �t� saisies par l'utilisateur et que �a modifie les valeurs existantes
          if ((Correspondance.Fichier.Code <> '') or (Correspondance.Fichier.Valeur <> '')) and
            not(AnsiSameStr(Correspondance.Fichier.Code, Correspondance.BaseDonnees.Code) and
              AnsiSameStr(Correspondance.Fichier.Valeur, Correspondance.BaseDonnees.Valeur)) then
          begin
            try
              // Recherche l'�l�ment dans la base de donn�es
              FDQuery.ParamByName(sChampCode).AsString := Correspondance.BaseDonnees.Code;
              FDQuery.ParamByName(sChampNom).AsString  := Correspondance.BaseDonnees.Valeur;
              FDQuery.Open();
              FDQuery.Last();

              // Met � jour l'�l�ment trouv� (m�me s'il y en a plusieurs)
              while not(FDQuery.Bof) do
              begin
                FDQuery.Edit();
                FDQuery.FieldByName(sChampCode).AsString := Correspondance.Fichier.Code;
                FDQuery.FieldByName(sChampNom).AsString  := Correspondance.Fichier.Valeur;
                FDQuery.Post();

                MiseAJourK(FDQuery.FieldByName(sChampId).AsInteger);

                FDQuery.Prior();
              end;
            finally
              FDQuery.Close();
            end;
          end;

          if Terminated then
            Exit;
        end;

        FDTransaction.Commit();
        Result := True;
      except
        FDTransaction.Rollback();
      end;
    finally
      // Si le thread a �t� arr�t� : annuler la transaction
      if Self.Terminated then
        FDTransaction.Rollback();
    end;
{$ENDREGION 'Met � jour la base de donn�es'}
  finally
    FreeAndNil(CodeValeurBase);
    FreeAndNil(CodeValeurReferentiel);
    FreeAndNil(Correspondances);
  end;
end;

// Mise � jour du fichier de nomenclature
function TThreadMiseAJour.MiseAJourNkl(): Boolean;
var
  XLSXApplication           : OleVariant; // ExcelApplication;
  XLSXFichier               : OleVariant; // ExcelWorkbook;
  XLSXFeuille               : OleVariant; // ExcelWorksheet;
  XSLXCellule               : OleVariant; // ExcelRange;
  hrErreur                  : HRESULT;
  sCellule                  : string;
  sValeur                   : string;
  iNbLignes                 : Integer;
  Correspondances           : TCorrespondancesNkl;
  Correspondance            : TCorrespondanceNkl;
  CodeValeurBase            : TCodeValeurNkl;
  CodeValeurReferentiel     : TCodeValeurNkl;
  ValeursCSV                : TCodesValeurs;
  slFichier                 : TStringList;
  sdaLigne                  : TStringDynArray;
  sLigne                    : string;
  i, iIndexCode, iIndexArtID: Integer;
  iArtId                    : Integer;
  j                         : Integer;
begin
  Result := False;
  try
    // Initialise les objets
    Correspondances       := TCorrespondancesNkl.Create();
    ValeursCSV            := TCodesValeurs.Create();
    CodeValeurBase        := TCodeValeurNkl.Create();
    CodeValeurReferentiel := TCodeValeurNkl.Create();

{$REGION 'R�cup�re les correspondances'}
    try
      // Ouvre Excel
      CoInitialize(nil);
      XLSXApplication         := CreateOleObject('Excel.Application');
      XLSXApplication.Visible := False;

      if Terminated then
        Exit;

      // Ouvre le fichier
      XLSXFichier := XLSXApplication.Workbooks.Open(FichierExcel);

      XLSXFeuille := XLSXFichier.WorkSheets['Correspondances'];

      // R�cup�re le nombre de lignes du tableau
      iNbLignes := XLSXFeuille.UsedRange.Rows.Count - 1;

      // V�rifie que le tableau est le bon
      sCellule    := 'H1';
      XSLXCellule := XLSXFeuille.Range[sCellule];
      sLigne      := XSLXCellule.Value;

      if not(AnsiSameText(sLigne, 'Destination')) then
      begin
        FMsgErreur := RS_ERREUR_MANQUE_DESTINATION;
        Exit;
      end;

      Progression(RS_MSG_RECUP_CORRESP, 0, iNbLignes);
      Journaliser(Format(RS_MSG_RECUP_CORRESP_NOM, [FichierExcel]));

      try
        for i := 1 to iNbLignes do
        begin
          Progression(Format(RS_MSG_RECUP_CORRESP_NB, [i, iNbLignes]), i);

          sCellule    := Format('A%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            CodeValeurBase.CodeFinal := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sCellule    := Format('B%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            CodeValeurBase.Univers := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sCellule    := Format('C%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            CodeValeurBase.Secteur := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sCellule    := Format('D%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            CodeValeurBase.Rayon := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sCellule    := Format('E%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            CodeValeurBase.Famille := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sCellule    := Format('F%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            CodeValeurBase.SousFamille := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sCellule    := Format('G%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            CodeValeurReferentiel.CodeFinal := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sCellule    := Format('H%u', [i + 1]);
          XSLXCellule := XLSXFeuille.Range[sCellule];
          if not(VarIsError(XSLXCellule.Value, hrErreur)) then
            sValeur := XSLXCellule.Value
          else
          begin
            Journaliser(Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule, ErreurCellule(XSLXCellule, hrErreur)]),
              NivErreur);
            Inc(FNbErreurs);
            Continue;
          end;
          sdaLigne := SplitString(sValeur, '|');

          if Length(sdaLigne) >= 5 then
          begin
            CodeValeurReferentiel.Univers     := sdaLigne[0];
            CodeValeurReferentiel.Secteur     := sdaLigne[1];
            CodeValeurReferentiel.Rayon       := sdaLigne[2];
            CodeValeurReferentiel.Famille     := sdaLigne[3];
            CodeValeurReferentiel.SousFamille := sdaLigne[4];
          end
          else
          begin
            CodeValeurReferentiel.Univers     := '';
            CodeValeurReferentiel.Secteur     := '';
            CodeValeurReferentiel.Rayon       := '';
            CodeValeurReferentiel.Famille     := '';
            CodeValeurReferentiel.SousFamille := '';
          end;

          // Si l'utilisateur � renseign� cette ligne dans le fichier Excel
          if CodeValeurReferentiel.CodeFinal <> '' then
          begin
            Correspondance := TCorrespondanceNkl.Create(CodeValeurBase, CodeValeurReferentiel);
            Correspondances.Add(Correspondance);
          end;

          if Terminated then
            Exit;
        end;
      except
        on E: Exception do
        begin
          FMsgErreur := Format(RS_ERREUR_LECT_FICHIER_EXCEL, [sCellule]);
          Exit;
        end;
      end;
    finally
      XLSXFichier.Close(False);
      XSLXCellule     := Unassigned;
      XLSXFeuille     := Unassigned;
      XLSXFichier     := Unassigned;
      XLSXApplication := Unassigned;
      CoUnInitialize();
    end;
{$ENDREGION 'R�cup�re les correspondances'}
{$REGION 'Met � jour les articles du fichier CSV'}
    Progression(RS_MSG_MAJ_FIC, 0);
    Journaliser(Format(RS_MSG_MAJ_FIC_NOM, [FichierArticle]));

    if FDQuery.Active then
      FDQuery.Close();

    FDQuery.SQL.Clear();
    FDQuery.SQL.Add('SELECT DISTINCT UNI_CODE, UNI_NOM, SEC_CODE, SEC_NOM, RAY_CODE, RAY_NOM, FAM_CODE, FAM_NOM,');
    FDQuery.SQL.Add('       SSF_CODE, SSF_NOM, SSF_CODEFINAL');
    FDQuery.SQL.Add('FROM   ARTARTICLE');
    FDQuery.SQL.Add('  JOIN ARTRELATIONAXE ON (ARX_ARTID = ART_ID)');
    FDQuery.SQL.Add('  JOIN K KARX         ON (KARX.K_ID = ARX_ID AND KARX.K_ENABLED = 1)');
    FDQuery.SQL.Add('  JOIN NKLSSFAMILLE   ON (SSF_ID = ARX_SSFID)');
    FDQuery.SQL.Add('  JOIN K KSSF         ON (KSSF.K_ID = SSF_ID AND KSSF.K_ENABLED = 1 AND KSSF.K_ID != 0)');
    FDQuery.SQL.Add('  JOIN NKLFAMILLE     ON (FAM_ID = SSF_FAMID)');
    FDQuery.SQL.Add('  JOIN K KFAM         ON (KFAM.K_ID = FAM_ID AND KFAM.K_ENABLED = 1 AND KFAM.K_ID != 0)');
    FDQuery.SQL.Add('  JOIN NKLRAYON       ON (RAY_ID = FAM_RAYID)');
    FDQuery.SQL.Add('  JOIN K KRAY         ON (KRAY.K_ID = RAY_ID AND KRAY.K_ENABLED = 1 AND KRAY.K_ID != 0)');
    FDQuery.SQL.Add('  JOIN NKLSECTEUR     ON (SEC_ID = RAY_SECID)');
    FDQuery.SQL.Add('  JOIN K KSEC         ON (KSEC.K_ID = SEC_ID AND KSEC.K_ENABLED = 1 AND KSEC.K_ID != 0)');
    FDQuery.SQL.Add('  JOIN NKLUNIVERS     ON (UNI_ID = SEC_UNIID)');
    FDQuery.SQL.Add('  JOIN K KUNI         ON (KUNI.K_ID = UNI_ID AND KUNI.K_ENABLED = 1 AND KUNI.K_ID != 0)');
    FDQuery.SQL.Add('  JOIN NKLACTIVITE    ON (ACT_ID = UNI_ACTID AND ACT_ID = ART_ACTID)');
    FDQuery.SQL.Add('  JOIN K KACT         ON (KACT.K_ID = ACT_ID AND KACT.K_ENABLED = 1 AND KACT.K_ID != 0)');
    FDQuery.SQL.Add('WHERE ART_ID = :ARTID;');

    try
      // Charge le fichier � lire
      slFichier := TStringList.Create();
      slFichier.LoadFromFile(FichierArticle);

      if Terminated then
        Exit;

      // Lit la premi�re ligne
      sdaLigne := SplitString(slFichier[0], ';');

      iIndexCode  := -1;
      iIndexArtID := -1;
      for i       := 0 to Length(sdaLigne) - 1 do
      begin
        if AnsiSameText(sdaLigne[i], 'CODEFEDAS') then
          iIndexCode := i;
        if AnsiSameText(sdaLigne[i], 'CODE') then
          iIndexArtID := i;
      end;

      if Terminated then
        Exit;

      if (iIndexCode > -1) and (iIndexArtID > -1) then
      begin
        Progression(RS_MSG_MAJ_FIC, 0, slFichier.Count);

        // Lit le fichier ligne par ligne
        for i := 1 to slFichier.Count - 1 do
        begin
          Progression(Format(RS_MSG_MAJ_FIC_NB, [i, slFichier.Count]), i);

          sdaLigne := SplitString(slFichier[i], ';');

          if TryStrToInt(sdaLigne[iIndexArtID], iArtId) then
          begin
            // R�cup�re la nomenclature actuelle du mod�le
            FDQuery.ParamByName('ARTID').AsInteger := iArtId;
            try
              FDQuery.Open();

              CodeValeurBase.CodeFinal   := FDQuery.FieldByName('SSF_CODEFINAL').AsString;
              CodeValeurBase.Univers     := FDQuery.FieldByName('UNI_NOM').AsString;
              CodeValeurBase.Secteur     := FDQuery.FieldByName('SEC_NOM').AsString;
              CodeValeurBase.Rayon       := FDQuery.FieldByName('RAY_NOM').AsString;
              CodeValeurBase.Famille     := FDQuery.FieldByName('FAM_NOM').AsString;
              CodeValeurBase.SousFamille := FDQuery.FieldByName('SSF_NOM').AsString;

              // Recherche dans les correspondances extraites du fichier Excel la nouvelle nomenclature
              if Correspondances.FindBaseDonnees(CodeValeurBase, Correspondance) then
              begin
                // Met � jour le fichier avec le nouveau code
                if CodesFinauxMaj then
                  sdaLigne[iIndexCode] := AnsiUpperCase(Correspondance.Fichier.CodeFinal)
                else
                  sdaLigne[iIndexCode] := Correspondance.Fichier.CodeFinal;

                sLigne   := '';
                for j    := 0 to Length(sdaLigne) - 1 do
                  sLigne := sLigne + sdaLigne[j] + ';';

                sLigne := AnsiLeftStr(sLigne, Length(sLigne) - 1);

                slFichier[i] := sLigne;
              end;

              if Terminated then
                Exit;
            finally
              FDQuery.Close();
            end;
          end;
        end;

        // Enregistre le fichier
        slFichier.SaveToFile(FichierArticle);
      end
      else
      begin
        FMsgErreur := RS_ERREUR_MANQUE_CODE;
        Result     := False;
        Exit;
      end;
    finally
      // Ferme le fichier
      FreeAndNil(slFichier);
    end;
{$ENDREGION 'Met � jour les articles du fichier CSV'}
    Result := True;
  finally
    FreeAndNil(CodeValeurBase);
    FreeAndNil(CodeValeurReferentiel);
    FreeAndNil(Correspondances);
    FreeAndNil(ValeursCSV);
  end;
end;

procedure TThreadMiseAJour.MiseAJourK(AKID: Integer; ASuppression: Integer = 0);
begin
  try
    if FDProcStoc.Active then
      FDProcStoc.Close();

    if not(FDProcStoc.Prepared) then
      FDProcStoc.Prepare();

    FDProcStoc.ParamByName('K_ID').AsInteger       := AKID;
    FDProcStoc.ParamByName('SUPRESSION').AsInteger := ASuppression;

    FDProcStoc.ExecProc();
  finally
    FDProcStoc.Close();
  end;
end;

function TThreadMiseAJour.ErreurCellule(const ACell: OleVariant; AhrErreur: HRESULT): string;
const
  ErrorBase = HRESULT($800A0000);
var
  i: Integer;
begin
  Result := ACell.Text;

  for i := 1 to Length(Result) do
  begin
    if Result[i] <> '#' then
      Exit;
  end;

  if AhrErreur = ErrorBase or xlErrDiv0 then
    Result := '#DIV/0!'
  else if AhrErreur = ErrorBase or xlErrNA then
    Result := '#N/A'
  else if AhrErreur = ErrorBase or xlErrName then
    Result := '#NAME?'
  else if AhrErreur = ErrorBase or xlErrNull then
    Result := '#NULL!'
  else if AhrErreur = ErrorBase or xlErrNum then
    Result := '#NUM!'
  else if AhrErreur = ErrorBase or xlErrRef then
    Result := '#REF!'
  else if AhrErreur = ErrorBase or xlErrValue then
    Result := '#VALUE!'
  else
    Result := 'erreur inconnue';
end;

end.
