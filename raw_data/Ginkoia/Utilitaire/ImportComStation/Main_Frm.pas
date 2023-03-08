{***************************************************************
 *
 * Unit Name: Main_Frm
 * Purpose  :
 * Author   :
 * History  :
 *
 ****************************************************************}

//*********************************************************************************
//*                                                                               *
//*  Unit Description : Forme principale standard                                 *
//*                                                                               *
//*  Author/Developer : Herv�                                                     *
//*                                                                               *
//*  Copyright (c) Algol                                                          *
//*  All Rights reserved.                                                         *
//*                                                                               *
//*  20/08/2000 22:19:51                                                          *
//*                                                                               *
//*  Mod�le de forme principale standard                                          *
//*                                                                               *
//*                                                                               *
//*                                                                               *
//*********************************************************************************

{***************************************************************
 Remarques :

   IMPORTANT
   *********
   LE DM_MAIN est d�clar� dans le projet mais laiss� dans la partie "Non cr�e"
   en automatique du projet.
   Apr�s cr�ation de la base, il suffit de le basculer de l'autre c�t� depuis
   la boite des options de projet
   NOTA : aucune forme ne d�clare le DM_Main qui est donc � rajouter dans la clause
   Uses des formes pour lesquelles c'est n�cessaire...

   NE PAS HERITER DE CE MODELE car probl�mes � cause des composants Syst�me
   COPIER : Cr�e une copie
   UTILISER : Travaille sur les originaux mais attention toute modif
   est r�percut�e dans les autres programmes qui "utilisent"

   Nota : En cas de non n�cessit� de la ScrollBox dans la fiche de base, supprimer
   le composant et les 2 lignes des unit�s correspondantes en fin de la clause Uses ...

   ATTENTION : lorsque "StdTag" de la forme est >= 0 les "boutons de menu"
       dont le tag est >= 0 sont inhib�s.
       Nota :
           1. StdTag par defaut = -1 c'est pourquoi je consid�re une valeur >= 0
           2. Par d�faut tout nouveau bouton menu pos� est inhib� car son Tag = 0.
              (Les boutons de menu des projets "mod�les" ont tous leur tag mis
              � = -1 sauf quitter. Ils restent ainsi toujours actifs 'aide, tip ...etc.
           3. Cette solution nous permet de continuer � utiliser des valeurs absolues
              significatives pour les Tags et donc d'effectuer nos tests sur celle-ci.
              Cela nous �vite aussi de m�moriser des valeurs de Tags pour les restituer
              en fin de traitement. Il suffit de d'inverser le signe du Tag momentan�ment
              pour obtenir le r�sultat souhait�

   ****************************************************************************
   ATTENTION : FICHIER D'AIDE
   1. Par d�faut le fichier d'aide est d�connect� dans l'�v�nement Create de StsConst
      Il est mis � vide pour �viter les erreurs tant que le fichier d'aide nest pas
      g�n�r�. Lorsque celui-ci existe, il suffit de supprimer ou de mettre en commentaire
      cette ligne.
   2. Le fichier d'aide par d�faut de l'application est "nom du projet".HLP et doit se
      trouver dans le sous r�pertoire Help du r�pertoire de l'application
   ****************************************************************}

UNIT Main_Frm;

INTERFACE

USES
    Windows,
    Messages,
    SysUtils,
    Classes,
    Graphics,
    Controls,
    Forms,
    Dialogs,
    AlgolStdFrm, ehsHelpRouter, ehsBase, ehsWhatsThis, Calend,
  LMDCustomHint, LMDCustomShapeHint, LMDShapeHint, Wwintl, vgStndrt,
  LMDCustomComponent, LMDContainerComponent, LMDBaseDialog, LMDAboutDlg,
  ActnList, RxCalc, dxBar, dxfTimer, LMDControl, LMDBaseControl,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton, ExtCtrls,
  RzPanel, RzPanelRv, RzStatus, fcStatusBar, Db, ADODB, ADBExport;

TYPE
    TFrm_Main = CLASS ( TAlgolStdFrm )
        Bm_Main: TdxBarManager;
        Dxb_Quit: TdxBarButton;
        Dxb_calc: TdxBarButton;
        Dxb_Calend: TdxBarButton;
        Dxb_Help: TdxBarButton;
        Dxb_About: TdxBarButton;
        Dxb_Apropos: TdxBarSubItem;
        Dxb_Tip: TdxBarButton;
        Calc_Main: TRxCalculator;
        ActLst_Main: TActionList;
        AboutDlg_Main: TLMDAboutDlg;
        TimeSto_Main: TDateTimeStorage;
        IPLang_Main: TwwIntl;
        Hint_Main: TLMDShapeHint;
        Calend_Main: TCalend;
        WIS_Main: TWhatsThis;
        HRout_Main: THelpRouter;
        Dxb_IndexHelp: TdxBarButton;
    Stat_Bar: TfcStatusBar;
    Clk_Status: TRzClockStatus;
    RzPanelRv1: TRzPanelRv;
    SBtn_ImpCs: TLMDSpeedButton;
    Chr_Tim: TdxfTimer;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DBExport1: TDBExport;
    DataSource1: TDataSource;
    SBtn_Kit: TLMDSpeedButton;
        PROCEDURE AlgolStdFrmCreate ( Sender: TObject ) ;
        PROCEDURE AlgolStdFrmShow ( Sender: TObject ) ;
        PROCEDURE Dxb_QuitClick ( Sender: TObject ) ;
        PROCEDURE Dxb_HelpClick ( Sender: TObject ) ;
        PROCEDURE Dxb_calcClick ( Sender: TObject ) ;
        PROCEDURE Dxb_CalendClick ( Sender: TObject ) ;
        PROCEDURE Dxb_AboutClick ( Sender: TObject ) ;
        PROCEDURE Dxb_TipClick ( Sender: TObject ) ;
        PROCEDURE WIS_MainHelp ( Sender, HelpItem: TObject; IsMenu: Boolean;
            HContext: THelpContext; X, Y: Integer; VAR CallHelp: Boolean ) ;
        PROCEDURE Dxb_IndexHelpClick ( Sender: TObject ) ;
        PROCEDURE Bm_MainClickItem ( Sender: TdxBarManager;
            ClickedItem: TdxBarItem ) ;
        PROCEDURE AlgolStdFrmCloseQuery ( Sender: TObject;
            VAR CanClose: Boolean ) ;
    procedure SBtn_ImpCSClick(Sender: TObject);
    procedure AlgolStdFrmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SBtn_KitClick(Sender: TObject);
    Private
    { Private declarations }

    procedure GenereTxt;
    Protected
    { Protected declarations }
    Public
    { Public declarations }
       KeyKit : Boolean;
       Function Kit: Boolean;
    Published
    { Published declarations }
    END;

VAR
    Frm_Main: TFrm_Main;

IMPLEMENTATION

USES
//ConstStd,
GinkoiaStd, GinkoiaResStr, Cst_Dm;

{$R *.DFM}

TYPE
    TmyCustomdxBarControl = CLASS ( TCustomdxBarControl ) ;

//--------------------------------------------------------------------------------
//Auto G�n�r�es
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//Syst�me FORM
//--------------------------------------------------------------------------------

//******************* TFrm_Main.AlgolMainFrmCreate *************************

PROCEDURE TFrm_Main.AlgolStdFrmCreate ( Sender: TObject ) ;
BEGIN
    KeyKit := False;
END;

//******************* TFrm_Main.AlgolStdFrmCloseQuery *************************
// Contr�le de sortie de la Forme ...

PROCEDURE TFrm_Main.AlgolStdFrmCloseQuery ( Sender: TObject;
    VAR CanClose: Boolean ) ;
BEGIN
    Canclose := sbtn_Kit.Enabled;
    If CanClose THEN
    Begin
        Canclose := StdTag < 0;
        IF NOT Canclose THEN
        BEGIN
            INFMESS ( ErrItemMenu, '' ) ;
            Abort;
        END;
    End;
END;

//******************* TFrm_Main.AlgolMainFrmShow *************************

PROCEDURE TFrm_Main.AlgolStdFrmShow ( Sender: TObject ) ;
BEGIN
{  Maximized mis ici pour prendre en compte corrextement les "anchors"
   CanMaximize � False pour shunter la dimension DesignTime et que la form soit
   toujours minimized ou maximized
   Nota : dsSie=zeable pour la Form car sinon recouvre la TaskBar
   Dans ce contexte c'est Bill qui prend tout en charge }

    IF NOT Init THEN
    BEGIN
        windowState := wsMaximized;
        canMaximize := False;
//        IF StdConst.Tip_Main.ShowAtStartup THEN ExecTip;
    END;
END;

//--------------------------------------------------------------------------------
// Boutons du Menu
//--------------------------------------------------------------------------------

//******************* TFrm_Main.Bm_MainClickItem *************************
// Contr�le de la disponibilit� des boutons des menus ...

PROCEDURE TFrm_Main.Bm_MainClickItem ( Sender: TdxBarManager;
    ClickedItem: TdxBarItem ) ;
VAR
    Cancel: Boolean;
BEGIN
    // StdTag de la forme sert
    // de t�moin pour autoriser l'acc�s aux boutons de menus
    // si stdTag >= 0 le boutons de menus dont le Tag est >= 0 sont inhib�s

    Cancel := False;
    IF ( ClickedItem IS TdxBarButton ) THEN
        IF clickedItem.Tag >= 0 THEN
            Cancel := StdTag >= 0;

    IF cancel THEN
    BEGIN
        INFMESS ( ErrItemMenu, '' ) ;
        Abort;
    END;

END;

//******************* TFrm_Main.Dxb_QuitClick *************************
// Bouton Quitter

PROCEDURE TFrm_Main.Dxb_QuitClick ( Sender: TObject ) ;
BEGIN
    Close;
END;

//--------------------------------------------------------------------------------
//Gestion de l'aide
//--------------------------------------------------------------------------------

//******************* TFrm_Main.WhatsThis1Help *************************
// Activation de l'aide pour ExpressBar

PROCEDURE TFrm_Main.WIS_MainHelp ( Sender, HelpItem: TObject;
    IsMenu: Boolean; HContext: THelpContext; X, Y: Integer;
    VAR CallHelp: Boolean ) ;
VAR
    ABarItem: TdxBarItemControl;
    P: TPoint;
BEGIN
    IF application.Helpfile = '' THEN
        CallHelp := False
    ELSE
    BEGIN
        IF HelpItem IS TCustomdxBarControl THEN
        BEGIN
            WITH TmyCustomdxBarControl ( HelpItem ) DO
            BEGIN
                P.x := x;
                p.y := y;
                ABarItem := ItemAtPos ( ScreenToClient ( P ) ) ;
                IF NOT ( ( ABarItem = NIL ) OR ( ABarItem IS TdxBarSubItemControl ) ) THEN
                    HContext := ABarItem.Item.HelpContext;
                Application.HelpCommand ( HELP_CONTEXTPOPUP, HContext ) ;
                CallHelp := False;
            END;
        END;
    END;

END;

//******************* TFrm_Main.Dxb_HelpClick *************************

PROCEDURE TFrm_Main.Dxb_HelpClick ( Sender: TObject ) ;
BEGIN
    Wis_main.ContextHelp;
END;

//******************* TFrm_Main.Dxb_IndexHelpClick *************************
// Chaine sur l'indes de l'aide (didacticiel)

PROCEDURE TFrm_Main.Dxb_IndexHelpClick ( Sender: TObject ) ;
BEGIN
    IF application.Helpfile = '' THEN Exit;
    HRout_main.HelpContent;
END;

//--------------------------------------------------------------------------------
//Outils accessoires
//--------------------------------------------------------------------------------

//******************* TFrm_Main.Dxb_calcClick *************************
// Calculatrice

PROCEDURE TFrm_Main.Dxb_calcClick ( Sender: TObject ) ;
BEGIN
    ExecCalc;
END;

//******************* TFrm_Main.Dxb_TipClick *************************
// Bouton Tip du menu

PROCEDURE TFrm_Main.Dxb_TipClick ( Sender: TObject ) ;
BEGIN
    ExecTip;
END;

//******************* TFrm_Main.Dxb_AboutClick *************************
// Boite About

PROCEDURE TFrm_Main.Dxb_AboutClick ( Sender: TObject ) ;
BEGIN
    AboutDlg_Main.Execute;
END;

//******************* TFrm_Main.Dxb_CalendClick *************************
// Calendrier

PROCEDURE TFrm_Main.Dxb_CalendClick ( Sender: TObject ) ;
BEGIN
    Calend_Main.execute;
END;

procedure TFrm_Main.SBtn_ImpCSClick(Sender: TObject);
begin
     Sbtn_ImpCs.Enabled := False;
     Sbtn_Kit.Enabled := False;
     Refresh;

     GenereTxt ;

     If Dm_Cst.DoImport Then
        showmessage('L''import termin�, aucun rapport g�n�r�...   ');

     Sbtn_ImpCs.Enabled := True;
     Sbtn_Kit.Enabled := True;
end;

Function TFrm_Main.Kit: Boolean;
Begin
  Result := KeyKit;
  KeyKit := False;
End;

procedure TFrm_Main.AlgolStdFrmKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     keyKit := ( key = VK_ESCAPE );
end;

procedure TFrm_Main.GenereTxt ;
Var
  CheminCS : String ;
begin
  CheminCS := UpperCase ( StdGinkoia.iniCtrl.readString ( 'CSTATION', 'PATH', '' ) ) ;
  IF ADOConnection1.ConnectionString = '' THEN
      ADOConnection1.ConnectionString := Format('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;Persist Security Info=False',[StdGinkoia.iniCtrl.readString ( 'CSTATION', 'PATHACCESS', '' )]) ;
  AdoTable1.TableName := 'T_Famille' ;
  DbExport1.FileName := CheminCS+'\'+'T_Famille.txt' ;
  AdoTable1.Open ;
  DbExport1.execute ;
  AdoTable1.First;
  TRY
      AdoTable1.Close ;
  EXCEPT
  END;

  AdoTable1.TableName := 'T_Fournisseur' ;
  DbExport1.FileName := CheminCS+'\'+'T_Fournisseur.txt' ;
  AdoTable1.Open ;
  DbExport1.execute ;
  AdoTable1.First;
  TRY
      AdoTable1.Close ;
  EXCEPT
  END;

  AdoTable1.TableName := 'T_Marque' ;
  DbExport1.FileName := CheminCS+'\'+'T_Marque.txt' ;
  AdoTable1.Open ;
  DbExport1.execute ;
  AdoTable1.First;
  TRY
      AdoTable1.Close ;
  EXCEPT
  END;

  AdoTable1.TableName := 'T_R�f�rencement' ;
  DbExport1.FileName := CheminCS+'\'+'T_R�f�rencement.txt' ;
  AdoTable1.Open ;
  DbExport1.execute ;
  AdoTable1.First;
  TRY
      AdoTable1.Close ;
  EXCEPT
  END;

  AdoTable1.TableName := 'T_Sous_famille' ;
  DbExport1.FileName := CheminCS+'\'+'T_Sous_famille.txt' ;
  AdoTable1.Open ;
  DbExport1.execute ;
  AdoTable1.First;
  TRY
      AdoTable1.Close ;
  EXCEPT
  END;

  AdoTable1.TableName := 'T_Tarification' ;
  DbExport1.FileName := CheminCS+'\'+'T_Tarification.txt' ;
  AdoTable1.Open ;
  DbExport1.execute ;
  AdoTable1.First;
  TRY
      AdoTable1.Close ;
  EXCEPT
  END;

  AdoTable1.TableName := 'T_Nature' ;
  DbExport1.FileName := CheminCS+'\'+'T_Nature.txt' ;
  AdoTable1.Open ;
  DbExport1.execute ;
  AdoTable1.First;
  TRY
      AdoTable1.Close ;
  EXCEPT
  END;

end;

procedure TFrm_Main.SBtn_KitClick(Sender: TObject);
begin
     Close;
end;

END.

