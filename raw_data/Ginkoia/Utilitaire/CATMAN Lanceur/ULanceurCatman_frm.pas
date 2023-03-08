UNIT ULanceurCatman_frm;

INTERFACE

USES
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  //d�but uses
  Inifiles,
  DateUtils,
  ShellApi,
  //fin uses
  Dialogs,
  StdCtrls,
  ExtCtrls,
  IdMessage,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP;

CONST
  // D�finition d'un type de message personnalis�
  WM_CATMAN = 7112;
  WM_PROMIXTRAYICON = WM_USER + 20;
  CM_PROMIX_TRACKON = 1;

TYPE
  TFrm_LanceurCatman = CLASS(TForm)
    lab_AnalysesCatman: TLabel;
    btn_ArretAnalyses: TButton;
    Tim_Demarrage: TTimer;
    Pan_EtatAnalyses: TPanel;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    chk_NoMail: TCheckBox;
    Tim_SurveillanceAnalyses: TTimer;
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE WM_MESSAGE(VAR msg: TMessage); MESSAGE WM_CATMAN;
    PROCEDURE btn_ArretAnalysesClick(Sender: TObject);
    PROCEDURE Tim_DemarrageTimer(Sender: TObject);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE ArreterAnalyses();
    PROCEDURE Tim_SurveillanceAnalysesTimer(Sender: TObject);
    PROCEDURE Tray_LaunchDblClick(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
  PRIVATE
    { D�clarations priv�es }
    iMsgAnalyses: integer;
    iNotification: Integer; //fr�quence d'�mission d'un message signalant notre activit� au lanceur en millisecondes
    timeOutAnalyses: Integer; //d�lai avant de consid�rer que AnalysesCatMan.exe doit �tre terminated
    sCheminExeAnalyses: STRING;
    wsListeEmailIncidents: WideString;
    ProcessAnalysesInfo: TProcessInformation;
    dLastNotificationTime: TdateTime;
    PROCEDURE initSmtp;
    PROCEDURE signalerIncident(msg: STRING);
    PROCEDURE WMPROMIXTRAYICON(VAR msg: TMessage); MESSAGE WM_PROMIXTRAYICON;
    //PIdAnalyses: cardinal;
  PUBLIC
    { D�clarations publiques }
    i: extended;
  END;

VAR
  Frm_LanceurCatman: TFrm_LanceurCatman;
  Nid: TNotifyIconData;

IMPLEMENTATION

{$R *.dfm}

{ TForm1 }

PROCEDURE TFrm_LanceurCatman.ArreterAnalyses;
VAR
  handleWindow: Thandle;
  iSleep: integer;
BEGIN
  //arreter la surveillance des messages provenant d'analysesCatman
  Tim_SurveillanceAnalyses.Enabled := false;
  //envoyer un message d'arr�t � AnalysesCatman.exe
  TRY
    handleWindow := 0;
    iSleep := 0;
    handleWindow := FindWindow('TFrm_AnalysesCatman', NIL);
    IF handleWindow <> 0 THEN
      PostMessage(handleWindow, WM_CATMAN, 0, -1); // 0 pour signaler arret complet
    //attendre le signal de l'arr�t provenant d'AnalysesCatman ou l'expiration du d�lai
    WHILE ((iMsgAnalyses <> 0) AND (iSleep < timeOutAnalyses)) DO
    BEGIN
      //rendre la main au system
      Application.ProcessMessages;
      sleep(200);
      iSleep := iSleep + 200;
    END;
    //si timeout tuer l'appli
    IF iMsgAnalyses <> 0 THEN
    BEGIN
      TerminateProcess(ProcessAnalysesInfo.hProcess, 0);
      Pan_EtatAnalyses.Color := clRed;
    END;
  EXCEPT ON Stan: Exception DO
    BEGIN
      closeHandle(handleWindow);
      signalerIncident('Etape : Arret du lanceur -> Arret d''activit� de LanceurCatman.exe :' + Stan.Message);
    END;
  END;
END;

PROCEDURE TFrm_LanceurCatman.btn_ArretAnalysesClick(Sender: TObject);
BEGIN
  screen.cursor := crHourGlass;
  btn_ArretAnalyses.enabled := false;
  //d�sactiver les bouton
  IF (btn_ArretAnalyses.tag = 1) THEN //�tat d�marr�, passer en arr�t
  BEGIN
    btn_ArretAnalyses.caption := 'D�marrer Analyses';
    btn_ArretAnalyses.tag := 0;
    ArreterAnalyses;
  END
  ELSE
  BEGIN
    btn_ArretAnalyses.caption := 'Arr�ter Analyses';
    btn_ArretAnalyses.tag := 1;
    Tim_Demarrage.Enabled := true;
  END;
  btn_ArretAnalyses.enabled := true;
  screen.cursor := crDefault;
END;

PROCEDURE TFrm_LanceurCatman.FormClose(Sender: TObject;
  VAR Action: TCloseAction);
BEGIN
  btn_ArretAnalyses.enabled := false;
  screen.cursor := crHourGlass;
  ArreterAnalyses;
  signalerIncident('Etape : Arret du lanceur -> Arret d''activit� de LanceurCatman.exe ');
  screen.cursor := crDefault;
END;

PROCEDURE TFrm_LanceurCatman.FormCreate(Sender: TObject);
VAR
  ini: TInifile;
BEGIN
  i := 0;
  iNotification := 0;
  dLastNotificationTime := now;
  WITH nid DO
  BEGIN
    cbSize := sizeof(nid);
    wnd := handle;
    uID := 1;
    uCallbackMessage := WM_PROMIXTRAYICON;
    hIcon := ExtractIcon(Application.Handle, Pchar(Application.exename), 0);
    szTip := 'Lanceur Catman';
    uFlags := nif_message OR nif_Icon OR nif_tip;
  END;
  Shell_NotifyIcon(NIM_ADD, @nid);
  ShowWindow(Application.handle, SW_HIDE);
  //lecture des diff�rentes valeur stock�es et renseignement des variables correspondantes
  ini := TInifile.create(ChangeFileExt(Application.exename, '.ini'));
  iNotification := ini.readInteger('ANALYSES', 'NOTIFICATION', 0); //la fr�quence � laquelle AnalysesCatman envoi un message
  timeOutAnalyses := ini.readInteger('ANALYSES', 'TIMEOUT', 0); //le temps maximum d'attente de la fin de l'exe d'analyses
  sCheminExeAnalyses := ini.ReadString('ANALYSES', 'CHEMIN', ''); //le chemin vers AnalysesCatman.exe
  wsListeEmailIncidents := ini.readString('EXE', 'EMAIL_INCIDENTS', 'bruno.nicolafrancesco@ginkoia.fr'); //le nombre max de traitements simultan�s
  initSmtp;
END;

PROCEDURE TFrm_LanceurCatman.FormDestroy(Sender: TObject);
BEGIN
  Shell_NotifyIcon(NIM_DELETE, @nid);
END;

PROCEDURE TFrm_LanceurCatman.FormShow(Sender: TObject);
BEGIN
  Tim_Demarrage.Enabled := true;
END;

PROCEDURE TFrm_LanceurCatman.Tim_DemarrageTimer(Sender: TObject);
VAR
  StartInfo: TStartupInfo;
BEGIN
  Tim_Demarrage.Enabled := false;
  TRY
    { Mise � z�ro de la structure StartInfo }
    FillChar(StartInfo, SizeOf(StartInfo), #0);
    { Seule la taille est renseign�e, toutes les autres options }
    { laiss�es � z�ro prendront les valeurs par d�faut }
    StartInfo.cb := SizeOf(StartInfo);
    //cr�er le processus d'analysesCatman
    IF sCheminExeAnalyses <> '' THEN
    BEGIN
      IF NOT CreateProcess(NIL, Pchar(sCheminExeAnalyses), NIL, NIL, False,
        0, NIL, NIL, StartInfo, ProcessAnalysesInfo) THEN
      BEGIN
        TRY
          TerminateProcess(ProcessAnalysesInfo.hProcess, 0);
        FINALLY
          //Signaler le probl�me
          signalerIncident('Etape : Cr�ation du processus AnalysesCatman impossible ');
        END;
      END
      ELSE //d�marrer la surveillance de la bonne r�ception des message d'analysesCatman
      BEGIN
        btn_ArretAnalyses.caption := 'Arr�ter Analyses';
        btn_ArretAnalyses.tag := 1;
        Pan_EtatAnalyses.Color := clGreen;
        Tim_SurveillanceAnalyses.Interval := iNotification;
        Tim_SurveillanceAnalyses.Enabled := true;
        signalerIncident('Etape : D�marrage du lanceur -> Lanceur d�marr� et Analyses Catman lanc�');
      END;
    END;
  FINALLY
    //
  END;
END;

PROCEDURE TFrm_LanceurCatman.Tim_SurveillanceAnalysesTimer(Sender: TObject);
BEGIN
  //V�rifier si le dernier message a �t� re�u a temps
  //si la diff�rence entre l'heure actuelle et celle du dernier message est sup�rieur � la fr�quence d'envoi des messages
  //on signale l'anomalie par e-mail
  IF (MilliSecondsBetween(now, dLastNotificationTime) > 5 * iNotification) THEN
  BEGIN
    Pan_EtatAnalyses.Color := clRed;
    btn_ArretAnalyses.caption := 'D�marrer Analyses';
    btn_ArretAnalyses.tag := 0;
    Tim_SurveillanceAnalyses.Enabled := false;
    signalerIncident('Etape : Surveillance des messages : AnalysesCatman ne signale plus son activit�');
    //tenter de relancer
    TRY
      ArreterAnalyses;
    FINALLY
      btn_ArretAnalysesClick(NIL);
    END;
  END;
END;

PROCEDURE TFrm_LanceurCatman.Tray_LaunchDblClick(Sender: TObject);
BEGIN
  show;
  FormStyle := FsStayOnTop;
  Application.processmessages;
  FormStyle := FsNormal;
END;

PROCEDURE TFrm_LanceurCatman.WMPROMIXTRAYICON(VAR msg: TMessage);
VAR
  pt: TPoint;
BEGIN
  CASE msg.lparam OF
    Wm_RButtonDown:
      BEGIN
        GetCursorPos(pt);
        SetForegroundWindow(handle);
        Popupmenu.Popup(pt.x, pt.y);
      END;
    Wm_LButtonDblClk: Visible := True;
    Wm_LButtonDown: ;
    Wm_MouseMove: ;
  END;
END;

PROCEDURE TFrm_LanceurCatman.WM_MESSAGE(VAR msg: TMessage);
BEGIN
  iMsgAnalyses := msg.LParam;
  CASE iMsgAnalyses OF
    0:
      BEGIN
        Pan_EtatAnalyses.Color := clRed;
        btn_ArretAnalyses.caption := 'D�marrer Analyses';
        btn_ArretAnalyses.tag := 0;
        signalerIncident('Etape : Message envoy� au lanceur -> Arret d''activit� d''AnalysesCatman ');
        Tim_SurveillanceAnalyses.enabled := false;
      END;
    1:
      BEGIN
        Pan_EtatAnalyses.Color := clGreen;
        //mettre � jour l'heure du dernier message re�u :
        dLastNotificationTime := now;
      END;
  END;
END;

PROCEDURE TFrm_LanceurCatman.initSmtp;
BEGIN
  WITH IdSMTP DO
  BEGIN
    Host := 'smtp.fr.oleane.com';
    //param�trage de test
    Port := 25;
    //IdSMTP.Port := 587;
    AuthType := atDefault;
    Username := 'catman@algodefi.fr.fto';
    Password := 'HAkDjKZS';
  END;
END;

PROCEDURE TFrm_LanceurCatman.signalerIncident(msg: STRING);
BEGIN
  IF NOT chk_NoMail.Checked THEN
  BEGIN
    //signale par e-mail que le programme � rencontr� un probl�me
    IdMessage.Clear;
    IdMessage.Body.Clear;
    IdMessage.From.Text := 'Catman@Ginkoia.fr';
    //IdMessage.CCList.EMailAddresses := ; // Syst�matiquement une copie � l'adresse mail originale
    IdMessage.Recipients.EMailAddresses := wsListeEmailIncidents;
    IdMessage.Subject := 'Notification Incident LanceurCatman.exe';
    IdMessage.Body.Text := DateTimeToStr(now) + ' LanceurCatman.exe a rencontr� un probl�me lors de son execution. ' + #13#10 + 'Description : ' + #13#10 + msg;
    TRY
      IF NOT idsmtp.connected THEN
        IdSMTP.Connect();
      IdSMTP.Send(IdMessage);
    EXCEPT
      EXIT;
    END;
    IdSMTP.Disconnect();
  END;
END;

END.

