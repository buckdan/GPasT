unit MainJAIS_Frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, IniFiles, uDefs, MainJAIS_DM, Buttons,
  ExtCtrls, uTypes, ComCtrls,DateUtils, ParamJAIS_Frm, Menus, DB,
  Grids, DBGrids, rxToolEdit, wwclearbuttongroup, wwradiogroup, wwdblook,
  Wwdbdlg, wwDBLookupComboDlgRv, LMDControl, LMDBaseControl,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton, vgCtrls,
  vgPageControlRv, FileCtrl, RzEdit, RzBtnEdt, wwDialog, wwidlg,
  wwLookupDialogRv, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, dxDBGrid, dxCntner,
  dxDBGridHP;

type
  Tfrm_MainJAIS = class(TForm)
    Ds_fedas: TDataSource;
    MainMenu1: TMainMenu;
    mnuParam: TMenuItem;
    mnuQuitter: TMenuItem;
    pc_Main: TvgPageControlRv;
    Tab_Main: TTabSheet;
    Tab_CfgDb: TTabSheet;
    Pan_Directory: TPanel;
    Gbx_Directory: TGroupBox;
    Lab_Source: TLabel;
    Lab_Destination: TLabel;
    Pan_Middle: TPanel;
    Gbx_CFG: TGroupBox;
    Lab_ArtCollection: TLabel;
    DBLkDlg_ArtCollection: TwwDBLookupComboDlgRv;
    rg_Saison: TwwRadioGroup;
    Pan_right: TPanel;
    Gbx_lstcmd: TGroupBox;
    Pan_lstclient: TPanel;
    Lbx_cmd: TListBox;
    Pan_client: TPanel;
    Pan_Action: TPanel;
    Gbx_Action: TGroupBox;
    Nbt_Execute: TBitBtn;
    Pan_Memoclient: TPanel;
    Gbx_Memo: TGroupBox;
    Pan_Memo: TPanel;
    Lab_Progress: TLabel;
    mmLogs: TMemo;
    ProgressBar1: TProgressBar;
    DBGrid1: TDBGrid;
    Nbt_Connexion: TLMDSpeedButton;
    rzbEdt_source: TRzButtonEdit;
    rzbEdt_Dest: TRzButtonEdit;
    OD_FileDest: TOpenDialog;
    Gbx_Soc: TGroupBox;
    Pan_clientParamSoc: TPanel;
    DBG_Societe: TdxDBGridHP;
    DBG_SocieteSOC_ID: TdxDBGridMaskColumn;
    DBG_SocieteSOC_NOM: TdxDBGridMaskColumn;
    DBG_SocieteEXE_ID: TdxDBGridMaskColumn;
    Ds_Societe: TDataSource;
    LK_ExerCom: TwwLookupDialogRV;
    Lab_DestTxt: TLabel;
    Label1: TLabel;
    Lab_DestTxt1: TLabel;
    Lab_DestTxt2: TLabel;
    DBG_SocieteEXE_NOM: TdxDBGridColumn;
    Nbt_TestZip: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Nbt_ExecuteClick(Sender: TObject);
    procedure mnuParamClick(Sender: TObject);
    procedure mnuQuitterClick(Sender: TObject);
    procedure Nbt_ConnexionClick(Sender: TObject);
    procedure rzbEdt_sourceButtonClick(Sender: TObject);
    procedure rzbEdt_DestButtonClick(Sender: TObject);
    procedure DBG_SocieteEXE_NOMButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure DBG_SocieteDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pc_MainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure Nbt_TestZipClick(Sender: TObject);
  private
    { D�clarations priv�es }
    function CheckParam : Boolean;
    procedure EnableObj(bEnabled : Boolean);
  public
    { D�clarations publiques }
  end;

var
  frm_MainJAIS: Tfrm_MainJAIS;

implementation

{$R *.dfm}

function Tfrm_MainJAIS.CheckParam: Boolean;
begin
  Result := False;
 if not GPARAMDEFAUT.ModuleAccessOK then
 begin
   ShowMessage('vous n''avez pas les droits n�cessaire pour ex�cuter ce module');
   Exit;
 end;

  if rzbEdt_source.Text = '' then
  begin
    ShowMessage('Veuillez s�lectionner un r�pertoire source');
    Exit;
  end;

  if not DirectoryExists(rzbEdt_source.Text) then
  begin
    ShowMessage('Le r�pertoire source n''existe pas');
    Exit;
  end;

  if rzbEdt_Dest.Text = '' then
  begin
    ShowMessage('Veuillez s�lectionner la base de donn�es ginkoia');
    Exit;
  end;

//  if Not FileExists(fe_dirDest.Text) then
//  begin
//    ShowMessage('Impossible de trouver la base de donn�es ginkoia, veuillez v�rifier la configuration');
//    Exit;
//  end;

  if GPARAMDEFAUT.TVA_ID = 0 then
  begin
    ShowMessage('vous devez s�lectionner une TVA dans les param�trages');
    Exit;
  end;

  if GPARAMDEFAUT.FOU_ID = 0 then
  begin
    ShowMessage('Vous devez s�lectionner un founisseur dans les param�trages');
    Exit;
  end;
  
//  if DBLkDlg_Nomenclature.Text = '' then
//  begin
//    Showmessage('Veuillez s�lectionner une nomenclature par d�faut');
//    Exit;
//  end;

  With DM_MainJais do
  begin
//    Que_ListFournisseur.FieldByName('FOU_ID').AsInteger
    if GetCDTPaiement(GPARAMDEFAUT.FOU_ID,0) = 0 then
    begin
      if Que_ListFournisseur.Locate('FOU_ID',GPARAMDEFAUT.FOU_ID,[loCaseInsensitive]) then
        ShowMessage('Les conditions g�n�rales du fournisseur ' + Que_ListFournisseur.FieldByName('FOU_NOM').AsString +
                    ' sont incompl�tes' + #13#10 + 'Veuillez les configurer dans Ginkoia');
      Exit;
    end;
  end;

  if GPARAMDEFAUT.Collection and (DBLkDlg_ArtCollection.Text = '') then
  begin
    ShowMessage('Vous devez s�lectionner une collection');
    Exit;
  end;

  if rg_Saison.ItemIndex = -1 then
  begin
    ShowMessage('Veuillez s�lectionner une saison');
    Exit;
  end;                                          

  Result := True;
end;

procedure Tfrm_MainJAIS.DBG_SocieteDblClick(Sender: TObject);
begin
  DBG_SocieteEXE_NOMButtonClick(self,0);
end;

procedure Tfrm_MainJAIS.DBG_SocieteEXE_NOMButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
var
  GenParam : TGenParam;
begin
  With DM_MainJAIS do
  begin
    if LK_ExerCom.Execute then
    begin
      With cdsSociete do
      try
        DisableControls;
        Edit;
        FieldByName('EXE_ID').AsInteger := Que_ListExerciceCommercial.FieldByName('EXE_ID').AsInteger;
        FieldByName('EXE_NOM').AsString := Que_ListExerciceCommercial.FieldByName('EXE_NOM').AsString;
        Post;

        // Sauvegarde du param�trage soci�t�
        With GenParam do
        begin
          PRM_TYPE   := 11;
          PRM_MAGID  := 0;
          PRM_POS    := 0;
          PRM_FLOAT  := 0;
          PRM_CODE   := 4;
          PRM_STRING := 'lire PRM_INTEGER=EXC_ID par SOCID';
          PRM_INFO   := 'Exercice Commercial';
          PRM_MAGID := FieldByName('SOC_ID').AsInteger;
          PRM_INTEGER := FieldByName('EXE_ID').AsInteger;

          SetGenParamByMagID(GenParam);
        end;
      finally
        EnableControls;
      end; // with cds
    end;
  end;
end;

procedure Tfrm_MainJAIS.EnableObj(bEnabled: Boolean);
begin
  mnuParam.Enabled   := bEnabled;
  mnuQuitter.Enabled := bEnabled;
  DBLkDlg_ArtCollection.Enabled := bEnabled;
  rg_Saison.Enabled := bEnabled;
  Nbt_Execute.Enabled := bEnabled;

  DBG_Societe.Enabled := bEnabled;
end;

procedure Tfrm_MainJAIS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With TIniFile.Create(GAPPPATH + GINIFILE) do
  try
    WriteString('DIRECTORY','SOURCE',rzbEdt_source.Text);
    WriteString('DIRECTORY','DEST',rzbEdt_Dest.Text);
  finally
    Free;
  end;

  DM_MainJais.Free;
end;

procedure Tfrm_MainJAIS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // emp�che la fermeture du logiciel si il est en cours de travail.
  CanClose := not BINPROGRESS;
end;

procedure Tfrm_MainJAIS.FormCreate(Sender: TObject);
begin
  BCONNECTED := False;
  pc_Main.ActivePageIndex := 0;

  Caption := 'ImportJAIS V' + CVERSION;

  // Initialisation des r�pertoires
  GAPPPATH        := ExtractFilePath(Application.ExeName);
  GINIFILE        := ExtractFileName(ChangeFileExt(Application.ExeName,'.ini'));
  GPATHFILETMP    := GAPPPATH + 'TmpFile\';
  GPATHDATA       := GAPPPATH + 'Data\';
  GPATHDATASTRUCT := GPATHDATA + 'tablestruct\';
  GFILEHFTOXML    := GAPPPATH + 'Outils\hyperfile2xml\hyperfile2xml.exe';
  GFILEFEDAS      := GPATHDATA + 'FedasIntersport.csv';
  GPATHARCHIVEZIP := GAPPPATH + 'Archives\ZIP\';
  GPATHARCHIVEJA  := GAPPPATH + 'Archives\JA\';

  if not DirectoryExists(GPATHFILETMP) then
    ForceDirectories(GPATHFILETMP);

  if not DirectoryExists(GPATHARCHIVEZIP) then
    ForceDirectories(GPATHARCHIVEZIP);

  if not DirectoryExists(GPATHARCHIVEJA) then
    ForceDirectories(GPATHARCHIVEJA);

  With TIniFile.Create(GAPPPATH + GINIFILE) do
  try
    rzbEdt_source.Text := ReadString('DIRECTORY','SOURCE','C:\Program Files\JA');
    rzbEdt_Dest.Text   := ReadString('DIRECTORY','DEST','');
  finally
    free;
  end;     

  DM_MainJais := TDM_MainJAIS.Create(self);

  if rzbEdt_Dest.Text <> '' then
  begin
     if DM_MainJais.OpenDataBase(rzbEdt_Dest.Text) then
       BCONNECTED := True;
  end;

  EnableObj(BCONNECTED);

end;

procedure Tfrm_MainJAIS.mnuParamClick(Sender: TObject);
begin
  if rzbEdt_Dest.Text <> '' then
  begin
    if GPARAMDEFAUT.ModuleAccessOK then
    begin
      with Tfrm_ParamJAIS.Create(Self) do
      try
        ShowModal;
      finally
        Release;
      end;
    end
    else
      ShowMessage('vous n''avez pas les droits n�cessaire pour ex�cuter ce module');
  end
  else
    ShowMessage('Vous ne pouvez pas param�trer le logiciel car il n''y a aucune base de donn�es s�lectionn�e');
end;

procedure Tfrm_MainJAIS.mnuQuitterClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_MainJAIS.Nbt_ConnexionClick(Sender: TObject);
begin
  Nbt_Connexion.Enabled := False;
  Screen.Cursor := crHourGlass;
  try
    if rzbEdt_Dest.Text <> '' then
    begin
      BCONNECTED := DM_MainJAIS.OpenDataBase(rzbEdt_Dest.Text);
      if BCONNECTED then
        ShowMessage('Connexion r�ussie � la base de donn�es');
    end
    else begin
      ShowMessage('Veuillez saisir un chemin pour la base de donn�es');
    end;
  finally
    EnableObj(BCONNECTED);
    Nbt_Connexion.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure Tfrm_MainJAIS.Nbt_ExecuteClick(Sender: TObject);
var
  TableList : TListTableHF;
  dDateDebut : TDateTime;
  dDateFin : TDateTime;                     
  iTemps : integer;
  sText : String;
begin
  With DM_MainJais do
  try
    EnableObj(False);
    BINPROGRESS := True;

    mmLogs.Clear;
    if VerifDBMAG then
    begin
      // V�rification que les param�tres sont corrects
      if CheckParam then
      begin
        dDateDebut := now;

        GPATHSOURCE := IncludeTrailingBackslash(AnsiDequotedStr(rzbEdt_source.Text,'"'));
        GFILEDEST   := AnsiDequotedStr(rzbEdt_Dest.Text,'"');

        AddToMemo(mmLogs,'--- D�but du Traitement des donn�es ---');
        //Ouverture de la base de donn�es Ginkoia
        AddToMemo(mmLogs,'1- Ouverture de la base de donn�es');
        if OpenDataBase(GFILEDEST) then
        begin
          // 2- R�cup�ration de la liste des tables � traiter
          AddToMemo(mmLogs,'2- R�cup�ration de la liste des tables � traiter');
          TableList := GetTableList;

          //  R�cup�ration du type GT Taille
          TableList.IdTypeGT := GetTailleTypeGT('REFERENCEMENT INTERSPORT',0);

          // Param�trage de la liste et valeur par d�faut
          TableList.Lab := Lab_Progress;
          TableList.Memo := mmLogs;
          TableList.Progress := ProgressBar1;
          TableList.lstCommande := Lbx_cmd;

          // Fournisseur instersport
          TableList.IdFournIntersport := GPARAMDEFAUT.FOU_ID;

          if DBLkDlg_ArtCollection.Text = '' then
            TableList.IdCOLID := 0
          else begin
            if Que_ListArtCollection.Locate('COL_NOM',DBLkDlg_ArtCollection.Text,[loCaseInsensitive]) then
              TableList.IdCOLID := Que_ListArtCollection.FieldByName('COL_ID').AsInteger;
          end;

          TableList.iSaison := rg_Saison.ItemIndex;

          // Ouverture du fichier FEDAS
          AddToMemo(mmLogs,' -> Ouverture du fichier FEDAS');
          if LoadFedasData(TableList) then
          begin
            // 3- Convertion des tables
            AddToMemo(mmLogs,'3- Convertion des tables');
            if ConvertTbHF(TableList) then
            begin
              AddToMemo(mmLogs,'4- V�rification de la structure');
              // 4- V�rification de la structure et que les champs attendus existent
              if CheckFieldList(TableList) then
              begin
                // Copie des donn�es du r�poertoire des JA vers le r�pertoire Archives/JA
                // + Cr�ation d'un raccourci sur le bureau dans un r�pertoire Archives JA
                // Seulement si le r�pertoire des JA n'existe pas encore
                CopyFileAndCreateLink(TableList);

                // 5- transfert/cr�ation, dans la base de donn�es, des articles
                AddToMemo(mmLogs,'5- Traitement des donn�es');
                if DoTraitement(TableList) then
                begin
                  // sauvegarde des fichiers commandes de cette importation
                  AddToMemo(mmLogs,'6- Archivage des JA');
                  ArchiveJA(TableList);
                end;
              end;
              Lab_Progress.Caption := 'Traitement termin�';
              AddToMemo(mmLogs,'--- Fin du Traitement des donn�es ---');
            end; // if
          end;
        end; // if

        dDateFin := Now;
        iTemps := SecondsBetween(dDateDebut,dDateFin);
        sText := FormatFloat('00',iTemps Div 3600);
        iTemps := iTemps Mod 3600;
        sText := sText + FormatFloat(':00',iTemps Div 60) + FormatFloat(':00',iTemps Mod 60);
        AddToMemo(mmLogs,'Temps de traitement : ' + sText);
  //        AddToMemo(mmLogs,'----------------------------------');
  //        AddToMemo(mmLogs,'Nombre de fournisseurs trait�s : ' + IntToStr(TableList.iCptFournisseur));
  //        AddToMemo(mmLogs,'Nombre de marques trait�es : ' + IntToStr(TableList.iCptMarque));
  //        AddToMemo(mmLogs,'Nombre d''articles trait�s : ' + IntToStr(TableList.iCptArticle));
  //        AddToMemo(mmLogs,'Nombre de couleurs trait�es : ' + IntToStr(TableList.iCptCouleur));
  //        AddToMemo(mmLogs,'Nombre de tailles trait�s : ' + IntToStr(TableList.iCptTaille));
  //        AddToMemo(mmLogs,'----------------------------------');
      end; // if
    end
    else begin
      ShowMessage('Ce magasin n''est pas le magasin autoris� � faire les int�grations de commande');
    end;
  Except on E:Exception do
    begin
      Lab_Progress.Caption := 'Erreur lors du traitement des donn�es';
      AddToMemo(mmLogs,'----------------------------------');
      AddToMemo(mmLogs,'-----         ERREUR         -----');
      AddToMemo(mmLogs,'----------------------------------');
      AddToMemo(mmLogs,E.Message);
      AddToMemo(mmLogs,'----------------------------------');
      ShowMessage(E.Message);
    end;
  end; // with

  EnableObj(True);
  BINPROGRESS := False;

  if Assigned(TableList) then
    TableList.Free;
end;

procedure Tfrm_MainJAIS.Nbt_TestZipClick(Sender: TObject);
var
  Table : TListTableHF;
begin

   GPATHSOURCE := IncludeTrailingBackslash(AnsiDequotedStr(rzbEdt_source.Text,'"'));
   GFILEDEST   := AnsiDequotedStr(rzbEdt_Dest.Text,'"');

  Table := GetTableList;
  With Table do
  begin
    Lab := Lab_Progress;
    Memo := mmLogs;
    Progress := ProgressBar1;
    lstCommande := Lbx_cmd;
  end;

  ConvertTbHF(Table);
  DM_MainJAIS.CheckFieldList(Table);
  DM_MainJAIS.ArchiveJA(Table);

  CopyFileAndCreateLink(Table);
end;

procedure Tfrm_MainJAIS.pc_MainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := not BINPROGRESS;
end;

procedure Tfrm_MainJAIS.rzbEdt_DestButtonClick(Sender: TObject);
begin
  if OD_FileDest.Execute then
    rzbEdt_Dest.Text := OD_FileDest.FileName;
end;

procedure Tfrm_MainJAIS.rzbEdt_sourceButtonClick(Sender: TObject);
var
 HelpCtx : integer;
 sDir : String;
 sCaption ,
 sRoot : String;
begin
  if Trim(rzbEdt_source.Text) <> '' then
    sDir := rzbEdt_source.Text
  else
    sDir := 'c:\';
  sRoot := '';
  sCaption := 'S�lection du r�pertoire des JA';
  if SelectDirectory(sCaption,sRoot,sDir,[sdNewUI]) then
    rzbEdt_source.Text := sDir;
end;

end.
