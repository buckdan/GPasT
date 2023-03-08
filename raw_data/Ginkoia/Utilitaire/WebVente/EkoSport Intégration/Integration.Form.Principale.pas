unit Integration.Form.Principale;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Win.Registry,
  System.UITypes,
  System.StrUtils,
  System.IniFiles,
  System.RegularExpressionsCore,
  System.DateUtils,
  System.Threading,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.Menus,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Comp.UI,
  Integration.Ressources,
  Integration.Methodes,
  Integration.Thread.Lot1,
  Integration.Thread.Lot3,
  uLog;

type
  TFormPrincipale = class(TForm)
    PnlTitre: TPanel;
    LblTitre: TLabel;
    ImgIcone: TImage;
    LblArticles: TLabel;
    ImgArticles: TImage;
    TxtArticles: TEdit;
    BtnArticles: TButton;
    BtnIntegrerLot1: TBitBtn;
    LblLot1: TLabel;
    OdFichier: TOpenDialog;
    PnlLot1: TPanel;
    GpIntegrerLot1: TGridPanel;
    LblProgressionLot1: TLabel;
    PbProgressionLot1: TProgressBar;
    BtnArreterLot1: TBitBtn;
    BvlSeparation: TBevel;
    LblJournal: TLabel;
    GpArticles: TGridPanel;
    PnlArticlesTitre: TPanel;
    PnlArticlesChemin: TPanel;
    BtnParametrer: TBitBtn;
    PcLots: TPageControl;
    TsLot1: TTabSheet;
    TsLot3: TTabSheet;
    LblLot3: TLabel;
    GpClients: TGridPanel;
    PnlClientsTitre: TPanel;
    ImgClients: TImage;
    LblClients: TLabel;
    PnlClientsChemin: TPanel;
    BtnClients: TButton;
    TxtClients: TEdit;
    PnlLot3: TPanel;
    GpIntegerLot3: TGridPanel;
    LblProgressionLot3: TLabel;
    PbProgressionLot3: TProgressBar;
    BtnArreterLot3: TBitBtn;
    BtnIntegrerLot3: TBitBtn;
    TxtJournal: TRichEdit;
    PmJournal: TPopupMenu;
    Copier1: TMenuItem;
    outslectionner1: TMenuItem;
    DlgFindJournal: TFindDialog;
    Rechercher1: TMenuItem;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    TiTraitement: TTrayIcon;
    PmTraitement: TPopupMenu;
    Quitter1: TMenuItem;
    Afficherletraitement1: TMenuItem;
    PnlAutomatique: TPanel;
    ImgAutomatique: TImage;
    LblAutomatique: TLabel;
    LblTraitementFichiers: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Journaliser(
      const AMessage: string;
      const ANiveau: TNiveau = NivTrace;
      const ADossier: string = '';
      const ACodeMagasin: string = '';
      const ATraitement: string = '';
      const ASurcharge: Boolean = False);
    procedure BtnIntegrerLot1Click(Sender: TObject);
    procedure BtnFichiersClick(Sender: TObject);
    procedure DemarrerThreadLot1();
    procedure DemarrerThreadLot1Auto(const AFichier: TFileName);
    procedure FinThreadLot1(Sender: TObject);
    procedure FinThreadLot1Auto(Sender: TObject);
    procedure DemarrerThreadLot3();
    procedure DemarrerThreadLot3Auto(const AFichier: TFileName);
    procedure FinThreadLot3(Sender: TObject);
    procedure FinThreadLot3Auto(Sender: TObject);
    procedure TxtArticlesChange(Sender: TObject);
    procedure BtnArreterLot1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnParametrerClick(Sender: TObject);
    function NettoyageJournaux(): Integer;
    procedure TxtClientsChange(Sender: TObject);
    procedure BtnArreterLot3Click(Sender: TObject);
    procedure BtnIntegrerLot3Click(Sender: TObject);
    procedure PmJournalPopup(Sender: TObject);
    procedure Copier1Click(Sender: TObject);
    procedure outslectionner1Click(Sender: TObject);
    procedure Rechercher1Click(Sender: TObject);
    procedure DlgFindJournalFind(Sender: TObject);
    procedure Afficherletraitement1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TiTraitementClick(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { D�clarations priv�es }
    procedure TraitementAutomatique();
    // Gestion du Drag & Drop
    procedure MessageDropFiles(var AMsg: TWMDropFiles); message WM_DROPFILES;
  public
    { D�clarations publiques }
    sBaseDonnees: string;
    iNiveau     : Integer;
    iDuree      : Integer;
    iDomaine    : Integer;
    iFrequence  : Integer;
    bSauvegarde : Boolean;
    bSauvFichier: Boolean;
  end;

var
  FormPrincipale   : TFormPrincipale;
  ThreadLot1       : TThreadLot1;
  ThreadLot3       : TThreadLot3;
  bInterruptionLot1: Boolean = False;
  bInterruptionLot3: Boolean = False;
  bThreadLot1Auto  : Boolean = False;
  bThreadLot3Auto  : Boolean = False;
  bFinThreadLot1   : Boolean = True;
  bFinThreadLot3   : Boolean = True;
  bEnvoyeCourriel  : Boolean = False;
  // sDossierEnCours   : string = '';
  sCodeMagEnCours: string = '';

implementation

{$R *.dfm}

uses
  Integration.Form.Parametrer,
  Integration.Form.MotPasse;

procedure TFormPrincipale.Journaliser(
  const AMessage: string;
  const ANiveau: TNiveau = NivTrace;
  const ADossier: string = '';
  const ACodeMagasin: string = '';
  const ATraitement: string = '';
  const ASurcharge: Boolean = False);
var
  sRepertoire : string;
  sNomFichier : string;
  sNiveau     : string;
  slFichierLog: TStringList;
begin
  if ((iNiveau = Integer(NivTrace)) and (ANiveau in [NivTrace .. NivErreur]))
    or ((iNiveau = Integer(NivNotice)) and (ANiveau in [NivNotice .. NivErreur]))
    or ((iNiveau = Integer(NivErreur)) and (ANiveau = NivErreur)) or (ANiveau = NivArret) then
  begin
    // R�cup�ration du niveau
    case ANiveau of
      NivTrace:
        sNiveau := 'D�tail';
      NivNotice:
        begin
          TxtJournal.SelAttributes.Color := $0E7F00;
          sNiveau                        := 'Notice';
        end;
      NivErreur:
        begin
          TxtJournal.SelAttributes.Color := $0080FF;
          sNiveau                        := 'Erreur';
        end;
      NivArret:
        begin
          TxtJournal.SelAttributes.Color := $0000FF;
          sNiveau                        := 'Arr�t';
        end;
    end;

    // Ajout le message au Log
    TxtJournal.Lines.Add(Format('%s - [%s] %s', [FormatDateTime('hh:nn:ss.zzz', Now()), sNiveau, AMessage]));
    TxtJournal.SelAttributes.Color := clWindowText;
    TxtJournal.Perform(WM_VSCROLL, SB_BOTTOM, 0);

{$REGION 'Enregistrement dans le fichier de Log'}
    slFichierLog := TStringList.Create();
    try
      sRepertoire := ExtractFilePath(Application.ExeName) + 'Logs\';
      if not(DirectoryExists(sRepertoire)) then
        ForceDirectories(sRepertoire);

      sNomFichier := Format('%sLog_%s-%s.log', [sRepertoire, ChangeFileExt(ExtractFileName(Application.ExeName), ''), FormatDateTime('yyyy-mm-dd', Now())]);

      if FileExists(sNomFichier) then
        slFichierLog.LoadFromFile(sNomFichier);

      slFichierLog.Add(Format('%s - [%s] %s', [FormatDateTime('hh:nn:ss.zzz', Now()), sNiveau, AMessage]));

      slFichierLog.SaveToFile(sNomFichier);
    finally
      slFichierLog.Free();
    end;
{$ENDREGION 'Enregistrement dans le fichier de Log'}
  end;

{$IFNDEF DEBUG}
  // Envoye du log au serveur de Logs
  Log.Doss := ADossier;
  case ANiveau of
    NivTrace:
      Log.Log('', ACodeMagasin, ATraitement, ReplaceStr(AdjustLineBreaks(AMessage), sLineBreak, ''), logTrace, ASurcharge);
    NivNotice:
      Log.Log('', ACodeMagasin, ATraitement, ReplaceStr(AdjustLineBreaks(AMessage), sLineBreak, ''), logNotice, ASurcharge);
    NivErreur:
      Log.Log('', ACodeMagasin, ATraitement, ReplaceStr(AdjustLineBreaks(AMessage), sLineBreak, ''), logError, ASurcharge);
    NivArret:
      Log.Log('', ACodeMagasin, ATraitement, ReplaceStr(AdjustLineBreaks(AMessage), sLineBreak, ''), logCritical, ASurcharge);
  end;
{$ENDIF}
end;

procedure TFormPrincipale.BtnFichiersClick(Sender: TObject);
begin
  case AnsiIndexText(TWinControl(Sender).Name, ['BtnArticles', 'BtnClients']) of
    // Articles
    0:
      begin
        OdFichier.FileName   := ExtractFileName(TxtArticles.Text);
        OdFichier.InitialDir := ExtractFileDir(TxtArticles.Text);
        OdFichier.Title      := RS_OUVRIR_ARTICLES;
        if OdFichier.Execute() then
          TxtArticles.Text := OdFichier.FileName;
      end;
    // Clients
    1:
      begin
        OdFichier.FileName   := ExtractFileName(TxtClients.Text);
        OdFichier.InitialDir := ExtractFileDir(TxtClients.Text);
        OdFichier.Title      := RS_OUVRIR_CLIENTS;
        if OdFichier.Execute() then
          TxtClients.Text := OdFichier.FileName;
      end;
  end;
end;

procedure TFormPrincipale.Afficherletraitement1Click(Sender: TObject);
begin
  ShowWindow(Self.Handle, SW_SHOW);
  WindowState := wsNormal;
  Self.Show();
  SetForegroundWindow(Self.Handle);
end;

procedure TFormPrincipale.BtnArreterLot1Click(Sender: TObject);
begin
  // Demande confirmation
  if MessageDlg(RS_CONF_ARRET, mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    // Arr�te le thread
    if Assigned(ThreadLot1) then
    begin
      bInterruptionLot1 := True;
      ThreadLot1.Terminate();
    end;
  end;
end;

procedure TFormPrincipale.BtnArreterLot3Click(Sender: TObject);
begin
  // Demande confirmation
  if MessageDlg(RS_CONF_ARRET, mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    // Arr�te le thread
    if Assigned(ThreadLot3) then
    begin
      bInterruptionLot3 := True;
      ThreadLot3.Terminate();
    end;
  end;
end;

procedure TFormPrincipale.BtnIntegrerLot1Click(Sender: TObject);
begin
  // Lance le thread
  DemarrerThreadLot1();
end;

procedure TFormPrincipale.BtnIntegrerLot3Click(Sender: TObject);
begin
  // Lance le thread
  DemarrerThreadLot3();
end;

procedure TFormPrincipale.BtnParametrerClick(Sender: TObject);
var
  IniParametres   : TIniFile;
  slDomaines      : TStringList;
  i, iIndexDomaine: Integer;
  bOeuf           : Boolean;
  sDestinataires  : string;
begin
  // V�rifie le mot de passe
  Application.CreateForm(TFormMotPasse, FormMotPasse);
  try
    if FormMotPasse.ShowModal() = mrOk then
    begin
      bOeuf := SameStr(FormMotPasse.TxtMotPasse.Text, ReverseString(MotPasse));
      if not(SameStr(FormMotPasse.TxtMotPasse.Text, MotPasse) or bOeuf) then
      begin
        MessageDlg(RS_ERREUR_MOTPASSE, mtWarning, [mbOk], 0);
        Exit;
      end;
    end
    else
      Exit;
  finally
    FormMotPasse.Free();
  end;

  // Charge les param�tres
  IniParametres := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  Application.CreateForm(TFormParametrer, FormParametrer);
  slDomaines := TStringList.Create();
  try
    // Base de donn�es
    FormParametrer.TxtBaseDonnees.OnChange := nil;
    FormParametrer.TxtBaseDonnees.Text     := sBaseDonnees;
    FormParametrer.TxtBaseDonnees.OnChange := FormParametrer.TxtBaseDonneesChange;

    // Niveau de d�tails
    FormParametrer.CmbNiveau.ItemIndex := iNiveau;

    // Dur�e de conservation
    FormParametrer.SpnDuree.Value := iDuree;

    // Sauvegarde des donn�es
    FormParametrer.ChkSauvegarde.Checked  := bSauvegarde;
    FormParametrer.ChkSauvFichier.Checked := bSauvFichier;

    // Adresse courriel
    FormParametrer.TxtCourrielDestinataires.Text := IniParametres.ReadString('Courriel', 'Destinataires', 'lionel.plais@ginkoia.fr');

    // Domaine d'activit�
    FormParametrer.CmbDomaine.Items.Clear();
    FormParametrer.iDomaine := iDomaine;

    if ListeDomainesActivitees(sBaseDonnees, slDomaines) then
    begin
      iIndexDomaine := -1;
      SetLength(FormParametrer.ListeActId, slDomaines.Count);

      for i := 0 to slDomaines.Count - 1 do
      begin
        FormParametrer.CmbDomaine.Items.Add(slDomaines.ValueFromIndex[i]);
        FormParametrer.ListeActId[i] := StrToInt(slDomaines.Names[i]);
        if StrToInt(slDomaines.Names[i]) = iDomaine then
          iIndexDomaine := i;
      end;
      FormParametrer.CmbDomaine.Enabled   := True;
      FormParametrer.CmbDomaine.ItemIndex := iIndexDomaine;
    end;

    if bOeuf then
    begin
      FormParametrer.LblOeuf.Visible    := True;
      FormParametrer.LblOeuf.Font.Color := clWindowText
    end;

    if FormParametrer.ShowModal() = mrOk then
    begin
      // Enregistre le tous
      sBaseDonnees   := FormParametrer.TxtBaseDonnees.Text;
      iNiveau        := FormParametrer.CmbNiveau.ItemIndex;
      iDuree         := FormParametrer.SpnDuree.Value;
      bSauvegarde    := FormParametrer.ChkSauvegarde.Checked;
      bSauvFichier   := FormParametrer.ChkSauvFichier.Checked;
      sDestinataires := FormParametrer.TxtCourrielDestinataires.Text;

      if FormParametrer.CmbDomaine.ItemIndex > -1 then
        iDomaine := FormParametrer.ListeActId[FormParametrer.CmbDomaine.ItemIndex]
      else
        iDomaine := 0;

      // Sauvegarde dans le fichier INI
      IniParametres.WriteString('G�n�ral', 'BaseDonn�es', sBaseDonnees);
      IniParametres.WriteInteger('G�n�ral', 'Niveau', iNiveau);
      IniParametres.WriteInteger('G�n�ral', 'Dur�e', iDuree);
      IniParametres.WriteBool('G�n�ral', 'Sauvegarde', bSauvegarde);
      IniParametres.WriteBool('G�n�ral', 'SauvFichier', bSauvFichier);
      IniParametres.WriteString('Courriel', 'Destinataires', sDestinataires);
      IniParametres.WriteInteger('Lot1', 'Domaine', iDomaine);
      Journaliser(RS_PARAMETRES_ENREGISTRES);
    end;
  finally
    FreeAndNil(FormParametrer);
    slDomaines.Free();
    IniParametres.Free();
  end;
end;

procedure TFormPrincipale.Copier1Click(Sender: TObject);
begin
  // Copie le texte s�lectionn� dans le presse-papiers
  TxtJournal.CopyToClipboard();
end;

procedure TFormPrincipale.CreateParams(var Params: TCreateParams);
begin
  inherited;

{$IFNDEF DEBUG}
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
{$ENDIF}
end;

procedure TFormPrincipale.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ThreadLot1) then
  begin
    if not(ThreadLot1.Finished) then
    begin
      MessageDlg(RS_ERR_ARRET, mtWarning, [mbOk], 0);
      Action := caNone;
      Exit;
    end
    else
      FreeAndNil(ThreadLot1);
  end;

  if Assigned(ThreadLot3) then
  begin
    if not(ThreadLot3.Finished) then
    begin
      MessageDlg(RS_ERR_ARRET, mtWarning, [mbOk], 0);
      Action := caNone;
      Exit;
    end
    else
      FreeAndNil(ThreadLot3);
  end;

  // Arr�te le Drag & Drop
  DragAcceptFiles(Handle, False);

  Journaliser(RS_ARRET, NivNotice);
end;

procedure TFormPrincipale.FormCreate(Sender: TObject);
const
  REGGINKOIA = '\SOFTWARE\Algol\Ginkoia';
var
  Registre     : TRegistry;
  IniParametres: TIniFile;
  iNbSuppr     : Integer;
  sFrequence   : string;
begin
  // Charge les ic�nes
  ImgIcone.Picture.Icon.Handle := LoadImage(HInstance, 'MAINICON', IMAGE_ICON, 48, 48, LR_DEFAULTCOLOR);
  ImgArticles.Picture.Bitmap.LoadFromResourceName(HInstance, 'PACKAGE_EDITORS');
  ImgClients.Picture.Bitmap.LoadFromResourceName(HInstance, 'PACKAGE_EDITORS');
  BtnIntegrerLot1.Glyph.LoadFromResourceName(HInstance, 'DRAPEAU');
  BtnArreterLot1.Glyph.LoadFromResourceName(HInstance, 'STOP');
  BtnIntegrerLot3.Glyph.LoadFromResourceName(HInstance, 'DRAPEAU');
  BtnArreterLot3.Glyph.LoadFromResourceName(HInstance, 'STOP');
  BtnParametrer.Glyph.LoadFromResourceName(HInstance, 'PARAMETRER');

  // Accepte le Drag & Drop
  DragAcceptFiles(Handle, True);

  // Modifie le titre
  Self.Caption := Format('%s - version %s', [Self.Caption, InfoSurExe(Application.ExeName).FileVersion]);

  // Charge les param�tres
  IniParametres := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    // Base de donn�es
    FindCmdLineSwitch('BASE', sBaseDonnees);

    if sBaseDonnees = '' then
      sBaseDonnees := IniParametres.ReadString('G�n�ral', 'BaseDonn�es', '');

    // Niveau de d�tails
    iNiveau := IniParametres.ReadInteger('G�n�ral', 'Niveau', Integer(NivTrace));

    // Dur�e de conservation
    iDuree := IniParametres.ReadInteger('G�n�ral', 'Dur�e', 60);

    // Sauvegarde des donn�es
    bSauvegarde  := IniParametres.ReadBool('G�n�ral', 'Sauvegarde', True);
    bSauvFichier := IniParametres.ReadBool('G�n�ral', 'SauvFichier', True);

    // Domaine d'activit�
    iDomaine := IniParametres.ReadInteger('Lot1', 'Domaine', 0);
  finally
    IniParametres.Free();
  end;

  // Charge le chemin de la base de donn�es par d�faut s'il n'est pas renseign�
  if sBaseDonnees = '' then
  begin
    Registre := TRegistry.Create(KEY_READ);
    try
      Registre.RootKey := HKEY_LOCAL_MACHINE;
      if Registre.OpenKey(REGGINKOIA, False) then
      begin
        sBaseDonnees := Registre.ReadString('Base0');
        if sBaseDonnees = '' then
          sBaseDonnees := 'C:\Ginkoia\Data\Ginkoia.ib';
      end;
    finally
      Registre.Free();
    end;
  end;

{$REGION 'Param�tre les envoyes au serveur de Logs'}
{$IFNDEF DEBUG}
  // ===== Global pre-resign�
  // App = application   *
  // Inst = instance     ''
  // Host = H�te         *
  // Srv = Serveur       Host
  // Dos = Dossier       -> bas_nompournous le plus frequent dans genbase
  // ===== a l'appele
  // Mdl = Module        -> Vip ou non
  // Ref = R�f�rence     -> Code adherant magasin
  // Key = cl�           -> status
  // Val = valeur        -> mesage
  // ====== facultatif
  // Ovl = overload
  // Freq = fr�quence de validit� : le log doit retimer � date + freq (en seconde)
  // -> property Frequence de la classe
  Log.readIni();

  // R�cup�re la fr�quence d'ex�cution
  iFrequence := 0;
  if FindCmdLineSwitch('FREQUENCE', sFrequence) then
    TryStrToInt(sFrequence, iFrequence);

  Log.Frequence     := iFrequence;
  Log.LogKeepDays   := 31;
  Log.FileLogFormat := [elDate, elDos, elRef, elKey, elValue, elLevel, ElData];
  Log.MaxItems      := 10000;
  Log.Deboublonage  := False;

  case TNiveau(iNiveau) of
    NivTrace:
      Log.FileLogLevel := logNotice;
    NivNotice:
      Log.FileLogLevel := logNotice;
    NivErreur:
      Log.FileLogLevel := logError;
    NivArret:
      Log.FileLogLevel := logCritical;
  end;

  Log.Open();
{$ENDIF}

{$ENDREGION}
  LblProgressionLot1.Caption := RS_PROGRESSION;
  LblProgressionLot3.Caption := RS_PROGRESSION;

  Journaliser(RS_DEMARRAGE, NivNotice);

  // Nettoye les journaux
  iNbSuppr := NettoyageJournaux();
  if iNbSuppr > 1 then
  begin
    Journaliser(Format(RS_NETTOYAGE_JOURNAUX, [iNbSuppr]));
  end
  else if iNbSuppr = 1 then
  begin
    Journaliser(Format(RS_NETTOYAGE_JOURNAL, [iNbSuppr]));
  end;

  // Si on est en mode automatique : juste afficher l'ic�ne de notification
  if FindCmdLineSwitch('AUTOMATIQUE') then
  begin
    ShowWindow(Self.Handle, SW_HIDE);
    TiTraitement.Hint    := Self.Caption;
    TiTraitement.Icon    := Self.Icon;
    TiTraitement.Visible := True;
    TraitementAutomatique();
  end;
end;

procedure TFormPrincipale.FormResize(Sender: TObject);
begin
  // Cache l'ic�ne dans la barre des t�ches si on r�duit la fen�tre est que le
  // programme est en mode automatique
  if (WindowState = wsMinimized) and FindCmdLineSwitch('AUTOMATIQUE') then
  begin
    ShowWindow(Self.Handle, SW_HIDE);
  end;
end;

procedure TFormPrincipale.TxtArticlesChange(Sender: TObject);
begin
  // V�rifie que le fichier existe
  BtnIntegrerLot1.Enabled := (Length(TxtArticles.Text) > 0) and FileExists(TxtArticles.Text);
end;

procedure TFormPrincipale.TxtClientsChange(Sender: TObject);
begin
  // V�rifie que le fichier existe
  BtnIntegrerLot3.Enabled := (Length(TxtClients.Text) > 0) and FileExists(TxtClients.Text);
end;

procedure TFormPrincipale.DemarrerThreadLot1();
var
  sCheminDeplace: TFileName;
  bDeplace      : Boolean;
begin
  // V�rifie qu'il n'y a pas un autre thread de d�marr�
  if Assigned(ThreadLot3) then
  begin
    if not(ThreadLot3.Finished) then
    begin
      MessageDlg(RS_ERREUR_INTEGRATIONENCOUR, mtWarning, [mbOk], 0);
      Exit;
    end
    else
      FreeAndNil(ThreadLot3);
  end;

  if not(Assigned(ThreadLot1)) or ThreadLot1.Finished then
  begin
    BtnIntegrerLot1.Hide();
    BtnArreterLot1.Show();

    // Lib�re l'ancienne instance du thread
    if Assigned(ThreadLot1) then
      FreeAndNil(ThreadLot1);

    // Enregistre le fichier � int�grer
    if bSauvFichier then
    begin
      sCheminDeplace := Format(REP_FORMAT,
        [ExtractFileDir(Application.ExeName), REP_ARTICLES_ENCOURS, FormatDateTime(FORMAT_DATE_HEURE, Now()), ExtractFileName(TxtArticles.Text)]);
      bDeplace := DeplaceFichier(TxtArticles.Text, sCheminDeplace);
    end
    else
    begin
      sCheminDeplace := TxtArticles.Text;
      bDeplace       := True;
    end;

    if bDeplace then
    begin
      Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));

      // Param�tre le thread
      bInterruptionLot1          := False;
      ThreadLot1                 := TThreadLot1.Create(True);
      ThreadLot1.BaseDonnees     := sBaseDonnees;
      ThreadLot1.FichierArticles := sCheminDeplace;
      ThreadLot1.LblProgression  := LblProgressionLot1;
      ThreadLot1.PbProgression   := PbProgressionLot1;
      ThreadLot1.ImgArticles     := ImgArticles;
      ThreadLot1.iActId          := iDomaine;
      ThreadLot1.bSauvegarde     := bSauvegarde;
      ThreadLot1.OnTerminate     := FinThreadLot1;
      ThreadLot1.FreeOnTerminate := False;
      ThreadLot1.Start();
    end;
  end;
end;

procedure TFormPrincipale.DemarrerThreadLot1Auto(const AFichier: TFileName);
var
  sCheminDeplace: TFileName;
  bDeplace      : Boolean;
begin
  // V�rifie qu'il n'y a pas un autre thread de d�marr�
  if Assigned(ThreadLot3) then
  begin
    if not(ThreadLot3.Finished) then
    begin
      Exit;
    end
    else
      FreeAndNil(ThreadLot3);
  end;

  if not(Assigned(ThreadLot1)) or ThreadLot1.Finished then
  begin
    BtnIntegrerLot1.Hide();
    BtnArreterLot1.Show();

    // Lib�re l'ancienne instance du thread
    if Assigned(ThreadLot1) then
      FreeAndNil(ThreadLot1);

    sCheminDeplace := Format(REP_FORMAT,
      [ExtractFileDir(Application.ExeName), REP_ARTICLES_ENCOURS, FormatDateTime(FORMAT_DATE_HEURE, Now()), ExtractFileName(AFichier)]);
    bDeplace         := DeplaceFichier(AFichier, sCheminDeplace);
    TxtArticles.Text := AFichier;

    if bDeplace then
    begin
      Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));

      // Param�tre le thread
      bInterruptionLot1          := False;
      ThreadLot1                 := TThreadLot1.Create(True);
      ThreadLot1.BaseDonnees     := sBaseDonnees;
      ThreadLot1.FichierArticles := sCheminDeplace;
      ThreadLot1.LblProgression  := LblProgressionLot1;
      ThreadLot1.PbProgression   := PbProgressionLot1;
      ThreadLot1.ImgArticles     := ImgArticles;
      ThreadLot1.iActId          := iDomaine;
      ThreadLot1.bSauvegarde     := bSauvegarde;
      ThreadLot1.OnTerminate     := FinThreadLot1Auto;
      ThreadLot1.FreeOnTerminate := False;
      ThreadLot1.Start();
    end;
  end;
end;

procedure TFormPrincipale.DemarrerThreadLot3();
var
  sCheminDeplace: TFileName;
  bDeplace      : Boolean;
begin
  // V�rifie qu'il n'y a pas un autre thread de d�marr�
  if Assigned(ThreadLot1) then
  begin
    if not(ThreadLot1.Finished) then
    begin
      MessageDlg(RS_ERREUR_INTEGRATIONENCOUR, mtWarning, [mbOk], 0);
      Exit;
    end
    else
      FreeAndNil(ThreadLot1);
  end;

  if not(Assigned(ThreadLot3)) or ThreadLot3.Finished then
  begin
    BtnIntegrerLot3.Hide();
    BtnArreterLot3.Show();

    // Lib�re l'ancienne instance du thread
    if Assigned(ThreadLot3) then
      FreeAndNil(ThreadLot3);

    // Enregistre le fichier � int�grer
    if bSauvFichier then
    begin
      sCheminDeplace := Format(REP_FORMAT,
        [ExtractFileDir(Application.ExeName), REP_CLIENTS_ENCOURS, FormatDateTime(FORMAT_DATE_HEURE, Now()), ExtractFileName(TxtClients.Text)]);
      bDeplace := DeplaceFichier(TxtClients.Text, sCheminDeplace);
    end
    else
    begin
      sCheminDeplace := TxtClients.Text;
      bDeplace       := True;
    end;

    if bDeplace then
    begin
      Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));

      // Param�tre le thread
      bInterruptionLot3          := False;
      ThreadLot3                 := TThreadLot3.Create(True);
      ThreadLot3.BaseDonnees     := sBaseDonnees;
      ThreadLot3.FichierClients  := sCheminDeplace;
      ThreadLot3.LblProgression  := LblProgressionLot3;
      ThreadLot3.PbProgression   := PbProgressionLot3;
      ThreadLot3.ImgClients      := ImgClients;
      ThreadLot3.bSauvegarde     := bSauvegarde;
      ThreadLot3.OnTerminate     := FinThreadLot3;
      ThreadLot3.FreeOnTerminate := False;
      ThreadLot3.Start();
    end;
  end;
end;

procedure TFormPrincipale.DemarrerThreadLot3Auto(const AFichier: TFileName);
var
  sCheminDeplace: TFileName;
  bDeplace      : Boolean;
begin
  // V�rifie qu'il n'y a pas un autre thread de d�marr�
  if Assigned(ThreadLot1) then
  begin
    if not(ThreadLot1.Finished) then
    begin
      Exit;
    end
    else
      FreeAndNil(ThreadLot1);
  end;

  if not(Assigned(ThreadLot3)) or ThreadLot3.Finished then
  begin
    BtnIntegrerLot3.Hide();
    BtnArreterLot3.Show();

    // Lib�re l'ancienne instance du thread
    if Assigned(ThreadLot3) then
      FreeAndNil(ThreadLot3);

    sCheminDeplace := Format(REP_FORMAT,
      [ExtractFileDir(Application.ExeName),
       REP_ARTICLES_ENCOURS,
       FormatDateTime(FORMAT_DATE_HEURE, Now()),
       ExtractFileName(AFichier)]);

    bDeplace := DeplaceFichier(AFichier, sCheminDeplace);

    if bDeplace then
    begin
      Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));

      // Param�tre le thread
      bInterruptionLot3          := False;
      ThreadLot3                 := TThreadLot3.Create(True);
      ThreadLot3.BaseDonnees     := sBaseDonnees;
      ThreadLot3.FichierClients  := sCheminDeplace;
      ThreadLot3.LblProgression  := LblProgressionLot3;
      ThreadLot3.PbProgression   := PbProgressionLot3;
      ThreadLot3.ImgClients      := ImgClients;
      ThreadLot3.bSauvegarde     := bSauvegarde;
      ThreadLot3.OnTerminate     := FinThreadLot3;
      ThreadLot3.FreeOnTerminate := False;
      ThreadLot1.Start();
    end;
  end;
end;

procedure TFormPrincipale.DlgFindJournalFind(Sender: TObject);
var
  Options  : TSearchTypes;
  iPosition: Integer;
begin
  Options := [];

  if frMatchCase in DlgFindJournal.Options then
    Options := Options + [stMatchCase];

  if frWholeWord in DlgFindJournal.Options then
    Options := Options + [stWholeWord];

  // Trouve le texte recherch�
  iPosition := TxtJournal.FindText(DlgFindJournal.FindText, TxtJournal.SelStart + TxtJournal.SelLength, TxtJournal.Lines.Text.Length, Options);

  if iPosition > -1 then
  begin
    TxtJournal.SelStart  := iPosition;
    TxtJournal.SelLength := Length(DlgFindJournal.FindText);
    TxtJournal.SetFocus();
  end
  else
    MessageDlg(RS_RECHERCHE_TERMINEE, mtInformation, [mbOk], 0)
end;

procedure TFormPrincipale.FinThreadLot1(Sender: TObject);
var
  sNomFichier   : string;
  sCheminDeplace: TFileName;
begin
  // Replace les boutons d'int�gration
  BtnIntegrerLot1.Show();
  BtnArreterLot1.Hide();

  if bInterruptionLot1 then
  begin
    Journaliser(RS_ABANDONNEE, NivErreur);
    LblProgressionLot1.Caption := RS_ABANDONNEE;
  end;

  // D�place le fichier en fonction du r�sultat de l'int�gration
  if bSauvFichier then
  begin
    sNomFichier := ExtractFileName(TThreadLot1(Sender).FichierArticles);

    case TThreadLot1(Sender).Integre of
      True:
        begin
          // Sauvegarde le fichier dans les succ�s
          sCheminDeplace := Format(REP_FORMAT,
            [ExtractFileDir(Application.ExeName),
             REP_ARTICLES_SUCCES,
             FormatDateTime(FORMAT_DATE_HEURE, Now()),
             sNomFichier]);

          if DeplaceFichier(TThreadLot1(Sender).FichierArticles, sCheminDeplace) then
          begin
            EffacerRepertoire(ExtractFilePath(TThreadLot1(Sender).FichierArticles));
            Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
          end;
        end;
      False:
        begin
          // Sauvegarde le fichier dans les erreurs
          sCheminDeplace := Format(REP_FORMAT,
            [ExtractFileDir(Application.ExeName),
             REP_ARTICLES_ERREURS,
             FormatDateTime(FORMAT_DATE_HEURE, Now()),
             sNomFichier]);

          if DeplaceFichier(TThreadLot1(Sender).FichierArticles, sCheminDeplace) then
          begin
            EffacerRepertoire(ExtractFilePath(TThreadLot1(Sender).FichierArticles));
            Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
          end;
        end;
    end;
  end;
end;

procedure TFormPrincipale.FinThreadLot1Auto(Sender: TObject);
var
  sNomFichier   : string;
  sCheminDeplace: TFileName;
begin
  // Replace les boutons d'int�gration
  BtnIntegrerLot1.Show();
  BtnArreterLot1.Hide();

  if bInterruptionLot1 then
  begin
    Journaliser(RS_ABANDONNEE, NivErreur);
    LblProgressionLot1.Caption := RS_ABANDONNEE;
  end;

  // D�place le fichier en fonction du r�sultat de l'int�gration
  sNomFichier := ExtractFileName(TThreadLot1(Sender).FichierArticles);

  case TThreadLot1(Sender).Integre of
    True:
      begin
        // Sauvegarde le fichier dans les succ�s
        sCheminDeplace := Format(REP_FORMAT,
          [ExtractFileDir(Application.ExeName),
           REP_ARTICLES_SUCCES,
           FormatDateTime(FORMAT_DATE_HEURE, Now()),
           sNomFichier]);

        if DeplaceFichier(TThreadLot1(Sender).FichierArticles, sCheminDeplace) then
        begin
          EffacerRepertoire(ExtractFilePath(TThreadLot1(Sender).FichierArticles));
          Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
        end;
      end;
    False:
      begin
        // Sauvegarde le fichier dans les erreurs
        sCheminDeplace := Format(REP_FORMAT,
          [ExtractFileDir(Application.ExeName),
           REP_ARTICLES_ERREURS,
           FormatDateTime(FORMAT_DATE_HEURE, Now()),
           sNomFichier]);

        if DeplaceFichier(TThreadLot1(Sender).FichierArticles, sCheminDeplace) then
        begin
          EffacerRepertoire(ExtractFilePath(TThreadLot1(Sender).FichierArticles));
          Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
        end;
      end;
  end;

  bFinThreadLot1 := TThreadLot1(Sender).Integre;
  // sDossierEnCours := TThreadLot1(Sender).Dossier;
  sCodeMagEnCours := TThreadLot1(Sender).CodeMagasin;

  bThreadLot1Auto := False;
end;

procedure TFormPrincipale.FinThreadLot3(Sender: TObject);
var
  sNomFichier   : string;
  sCheminDeplace: TFileName;
begin
  // Replace les boutons d'int�gration
  BtnIntegrerLot3.Show();
  BtnArreterLot3.Hide();

  if bInterruptionLot3 then
  begin
    Journaliser(RS_ABANDONNEE, NivErreur);
    LblProgressionLot3.Caption := RS_ABANDONNEE;
  end;

  // D�place le fichier en fonction du r�sultat de l'int�gration
  if bSauvFichier then
  begin
    sNomFichier := ExtractFileName(TThreadLot3(Sender).FichierClients);

    case TThreadLot3(Sender).Integre of
      True:
        begin
          // Sauvegarde le fichier dans les succ�s
          sCheminDeplace := Format(REP_FORMAT,
            [ExtractFileDir(Application.ExeName),
             REP_ARTICLES_SUCCES,
             FormatDateTime(FORMAT_DATE_HEURE, Now()),
             sNomFichier]);

          if DeplaceFichier(TThreadLot3(Sender).FichierClients, sCheminDeplace) then
          begin
            EffacerRepertoire(ExtractFilePath(TThreadLot3(Sender).FichierClients));
            Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
          end;
        end;
      False:
        begin
          // Sauvegarde le fichier dans les erreurs
          sCheminDeplace := Format(REP_FORMAT,
            [ExtractFileDir(Application.ExeName),
             REP_ARTICLES_ERREURS,
             FormatDateTime(FORMAT_DATE_HEURE, Now()),
             sNomFichier]);

          if DeplaceFichier(TThreadLot3(Sender).FichierClients, sCheminDeplace) then
          begin
            EffacerRepertoire(ExtractFilePath(TThreadLot3(Sender).FichierClients));
            Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
          end;
        end;
    end;
  end;
end;

procedure TFormPrincipale.FinThreadLot3Auto(Sender: TObject);
var
  sNomFichier   : string;
  sCheminDeplace: TFileName;
begin
  // Replace les boutons d'int�gration
  BtnIntegrerLot3.Show();
  BtnArreterLot3.Hide();

  if bInterruptionLot3 then
  begin
    Journaliser(RS_ABANDONNEE, NivErreur);
    LblProgressionLot3.Caption := RS_ABANDONNEE;
  end;

  // D�place le fichier en fonction du r�sultat de l'int�gration
  sNomFichier := ExtractFileName(TThreadLot3(Sender).FichierClients);

  case TThreadLot3(Sender).Integre of
    True:
      begin
        // Sauvegarde le fichier dans les succ�s
        sCheminDeplace := Format(REP_FORMAT,
          [ExtractFileDir(Application.ExeName),
           REP_ARTICLES_SUCCES,
           FormatDateTime(FORMAT_DATE_HEURE, Now()),
           sNomFichier]);

        if DeplaceFichier(TThreadLot3(Sender).FichierClients, sCheminDeplace) then
        begin
          EffacerRepertoire(ExtractFilePath(TThreadLot3(Sender).FichierClients));
          Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
        end;
      end;
    False:
      begin
        // Sauvegarde le fichier dans les erreurs
        sCheminDeplace := Format(REP_FORMAT,
          [ExtractFileDir(Application.ExeName),
           REP_ARTICLES_ERREURS,
           FormatDateTime(FORMAT_DATE_HEURE, Now()),
           sNomFichier]);

        if DeplaceFichier(TThreadLot3(Sender).FichierClients, sCheminDeplace) then
        begin
          EffacerRepertoire(ExtractFilePath(TThreadLot3(Sender).FichierClients));
          Journaliser(Format(RS_VIDANGE, [sCheminDeplace]));
        end;
      end;
  end;

  bThreadLot3Auto := False;
end;

function TFormPrincipale.NettoyageJournaux(): Integer;
const
  REGEX_DATE_LOG = 'Log_\w+-(\d{4})-(\d{2})-(\d{2})\.log';
var
  reExpression        : TPerlRegEx;
  srDossier           : TSearchRec;
  sRepertoire         : string;
  iAnnee, iMois, iJour: Integer;
  dtDateFic           : TDate;
begin
  // R�cup�re le r�pertoire des logs
  sRepertoire := ExtractFilePath(Application.ExeName) + 'Logs\';

  Result := 0;

  // Recherche tout les fichiers de logs
  if (FindFirst(sRepertoire + 'Log_*-????-??-??.log', faAnyFile, srDossier) = 0) then
  begin
    repeat
      reExpression := TPerlRegEx.Create();
      try
        reExpression.RegEx   := REGEX_DATE_LOG;
        reExpression.Options := [preCaseLess];
        reExpression.Subject := srDossier.Name;

        if reExpression.Match() then
        begin
          iAnnee    := StrToInt(reExpression.Groups[1]);
          iMois     := StrToInt(reExpression.Groups[2]);
          iJour     := StrToInt(reExpression.Groups[3]);
          dtDateFic := EncodeDate(iAnnee, iMois, iJour);
          if (DaysBetween(Now(), dtDateFic) > iDuree) then
          begin
            if MettreCorbeille(sRepertoire + srDossier.Name) then
              Inc(Result);
          end;
        end;
      finally
        reExpression.Free();
      end;
    until (FindNext(srDossier) <> 0);
  end;
end;

procedure TFormPrincipale.outslectionner1Click(Sender: TObject);
begin
  // S�lectionne tout le texte
  TxtJournal.SelectAll();
end;

procedure TFormPrincipale.PmJournalPopup(Sender: TObject);
begin
  Copier1.Enabled := (TxtJournal.SelLength > 0);
end;

procedure TFormPrincipale.Quitter1Click(Sender: TObject);
begin
  Self.Close();
end;

procedure TFormPrincipale.Rechercher1Click(Sender: TObject);
begin
  DlgFindJournal.Execute(Self.Handle);
end;

procedure TFormPrincipale.TiTraitementClick(Sender: TObject);
begin
  if WindowState <> wsMinimized then
    WindowState := wsMinimized;
end;

procedure TFormPrincipale.TraitementAutomatique();
var
  sDossier      : string;
  sMessage      : string;
  sDestinataires: string;
  Fichiers      : array of TSearchRec;
  FichierRech   : TSearchRec;
  iNbFichiers   : Integer;
  i, j          : Integer;
begin
  // Affiche le Label
  ImgAutomatique.Picture.Icon.Handle := LoadImage(0, IDI_INFORMATION, IMAGE_ICON, 32, 32, LR_SHARED);
  PnlAutomatique.Show();

  // R�cup�re le dossier � traiter
  if FindCmdLineSwitch('DOSSIER', sDossier) then
  begin
    // Lancement du traitement automatique
    Journaliser(Format(RS_AUTOMATIQUE, [sDossier, sBaseDonnees]), NivNotice);

    // V�rifie que le dossier existe
    if DirectoryExists(sDossier) then
    begin
      sDossier := IncludeTrailingPathDelimiter(sDossier);

      iNbFichiers := 0;

{$REGION 'Int�gration des articles'}
      // Parcours le dossier
      if FindFirst(sDossier + 'eko_article_*.csv', faAnyFile, FichierRech) = 0 then
      begin
        repeat
          Inc(iNbFichiers);
          SetLength(Fichiers, iNbFichiers);
          Fichiers[Pred(iNbFichiers)] := FichierRech;
        until FindNext(FichierRech) <> 0;
      end;

      // Tri les fichiers dans l'ordre des dates
      for i := 1 to Pred(iNbFichiers) do
      begin
        FichierRech := Fichiers[i];

        j := Pred(i);

        while (Fichiers[j].TimeStamp > FichierRech.TimeStamp) and (j >= 1) do
        begin
          Fichiers[Succ(j)] := Fichiers[j];
          Dec(j);
        end;
        Fichiers[Succ(j)] := FichierRech;
      end;

      // Traite les fichiers
      TTask.Run(
          procedure()
        var
          i: Integer;
          slFichiersErreur: TStringList;
        begin
          try
            slFichiersErreur := TStringList.Create();
            for i := 0 to Pred(iNbFichiers) do
            begin
              Journaliser(Format(RS_TRAITEMENT_FICHIER, [Succ(i), iNbFichiers]), NivNotice);
              LblTraitementFichiers.Caption := Format(RS_TRAITEMENT_FICHIER, [Succ(i), iNbFichiers]);
              bThreadLot1Auto := True;
              DemarrerThreadLot1Auto(sDossier + Fichiers[i].Name);

              repeat
                Sleep(1000);
              until not(bThreadLot1Auto);

              if bInterruptionLot1 then
              begin
                slFichiersErreur.Add(Fichiers[i].Name);
                Break;
              end;

              if not(bFinThreadLot1) then
                slFichiersErreur.Add(Fichiers[i].Name);
            end;

            // Si l'envoie de courriels est demand�e
            if FindCmdLineSwitch('COURRIEL', sDestinataires) then
            begin
              // En fonction du r�sultat de l'int�gration des articles
              if slFichiersErreur.Count = 0 then
              begin
                if iNbFichiers > 1 then
                  sMessage := Format(RS_COURRIEL_ENTETE_SUCCES, [Format(RS_COURRIEL_FICHIERS, [iNbFichiers])])
                else
                  sMessage := Format(RS_COURRIEL_ENTETE_SUCCES, [Format(RS_COURRIEL_FICHIER, [iNbFichiers])]);

                sMessage := sMessage + Format(RS_COURRIEL_PIED, [Self.Caption]);
                EnvoyerJournalCourriel(Format(RS_COURRIEL_OBJET_SUCCES, [NomOrdinateur()]), sMessage, sDestinataires);
              end
              else
              begin
                if not(FindCmdLineSwitch('VALIDER_ERREURS')) then
                begin
                  sMessage := Format(RS_COURRIEL_ENTETE_ERREUR, [slFichiersErreur.Text]) + Format(RS_COURRIEL_PIED, [Self.Caption]);
                  EnvoyerJournalCourriel(Format(RS_COURRIEL_OBJET_ERREUR, [NomOrdinateur()]), sMessage, sDestinataires, True);
                end
                else
                begin
                  sMessage := Format(RS_COURRIEL_ENTETE_AVERTISSEMENT, [slFichiersErreur.Text]) + Format(RS_COURRIEL_PIED, [Self.Caption]);
                  EnvoyerJournalCourriel(Format(RS_COURRIEL_OBJET_AVERTISSEMENT, [NomOrdinateur()]), sMessage, sDestinataires, True);
                end;
              end;
            end;
          finally
            slFichiersErreur.Free();
            TThread.Synchronize(nil,
                procedure()
              begin
                // Ferme le programme
                Close();
                Application.Terminate();
              end);
          end;
        end);
{$ENDREGION 'Int�gration des articles'}
{$REGION 'Int�gration des clients'}
      { TODO -oLP -cCode : Si le client a besoin d'int�grer automatiquement les clients.
        D�commenter cette partie. }
      {
        // Parcours le dossier
        if FindFirst(sDossier + 'eko_clients_*.csv', faAnyFile, FichierRech) = 0 then
        begin
        repeat
        Inc(iNbFichiers);
        SetLength(Fichiers, iNbFichiers);
        Fichiers[Pred(iNbFichiers)] := FichierRech;
        until FindNext(FichierRech) <> 0;
        end;

        // Tri les fichiers dans l'ordre des dates
        for i := 1 to Pred(iNbFichiers) do
        begin
        FichierRech := Fichiers[i];

        j := Pred(i);

        while (Fichiers[j].TimeStamp > FichierRech.TimeStamp)
        and (j >= 1) do
        begin
        Fichiers[Succ(j)] := Fichiers[j];
        Dec(j);
        end;
        Fichiers[Succ(j)] := FichierRech;
        end;

        // Traite les fichiers
        for i := 0 to Pred(iNbFichiers) do
        begin
        bThreadLot3Auto := True;
        DemarrerThreadLot3Auto(sDossier + Fichiers[i].Name);

        repeat
        Application.ProcessMessages();
        Sleep(1000);
        until not(bThreadLot3Auto);
        end;
      }
{$ENDREGION 'Int�gration des clients'}
    end
    else
    begin
      // Le r�pertoire n'existe pas
      Journaliser(RS_ERREUR_DOSSIER, NivArret);

      // Ferme le programme
      Self.Close();
      Application.Terminate();
    end;
  end;
end;

procedure TFormPrincipale.MessageDropFiles(var AMsg: TWMDropFiles);
var
  iLenght : Integer;
  FileName: PChar;
begin
  // Gestion du Drag & Drop
  try
    iLenght  := DragQueryFile(AMsg.Drop, 0, nil, 0);
    FileName := StrAlloc(Succ(iLenght));
    DragQueryFile(AMsg.Drop, 0, FileName, Succ(iLenght));

    case PcLots.ActivePageIndex of
      // Onglet Articles
      0:
        TxtArticles.Text := FileName;
      // Onglet Clients
      1:
        TxtClients.Text := FileName;
    end;
  finally
    StrDispose(FileName);
    AMsg.Result := 0;
    inherited;
  end;
end;

end.
