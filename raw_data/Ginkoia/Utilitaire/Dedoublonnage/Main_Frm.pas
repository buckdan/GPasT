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
    AlgolStdFrm,
    Calend,
    // Ici unit�s corresponadant � la scrollBox
    LMDCustomScrollBox,
    LMDScrollBox, LMDCustomHint, LMDCustomShapeHint, LMDShapeHint, Wwintl,
    vgStndrt, LMDCustomComponent, LMDContainerComponent, LMDBaseDialog,
    LMDAboutDlg, ActnList, RxCalc, dxBar, RzStatus, fcStatusBar,
    // Digits,
  ExtCtrls, RzPanel, RzPanelRv, StdCtrls, RzLabel, FormFill, RzBorder,
  LMDControl, LMDBaseControl, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, cxClasses, dxSkinsCore, dxSkinsdxBarPainter, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSilver, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue;
    // *****************************************

TYPE
    TFrm_Main = CLASS(TAlgolStdFrm)
        Bm_Main: TdxBarManager;
        Dxb_Quit: TdxBarButton;
        Calc_Main: TRxCalculator;
        ActLst_Main: TActionList;
        TimeSto_Main: TDateTimeStorage;
        IPLang_Main: TwwIntl;
        Hint_Main: TLMDShapeHint;
        Calend_Main: TCalend;
        Stat_Bar: TfcStatusBar;
        Clk_Status: TRzClockStatus;
//        Digits1: TDigits;
    RzPanelRv1: TRzPanelRv;
    Dxb_Mark: TdxBarButton;
    RzLabel1: TRzLabel;
    DCFormFill1: TDCFormFill;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDSpeedButton2: TLMDSpeedButton;
    Dxb_Outils: TdxBarSubItem;
    dxb_Fourn: TdxBarButton;
    RzBorder1: TRzBorder;
    AboutDlg_Main: TLMDAboutDlg;
        PROCEDURE AlgolStdFrmCreate(Sender: TObject);
        PROCEDURE AlgolStdFrmShow(Sender: TObject);
        PROCEDURE Dxb_QuitClick(Sender: TObject);
        PROCEDURE AlgolStdFrmCloseQuery(Sender: TObject;
            VAR CanClose: Boolean);
        PROCEDURE AlgolStdFrmKeyDown(Sender: TObject; VAR Key: Word;
            Shift: TShiftState);
    procedure Dxb_MarkClick(Sender: TObject);
    procedure dxb_FournClick(Sender: TObject);
    PRIVATE
    { Private declarations }
        ouvert: Boolean;
        kit: Boolean;
    PROTECTED
    { Protected declarations }
    PUBLIC
    { Public declarations }
    PUBLISHED
    { Published declarations }
    END;

VAR
    Frm_Main: TFrm_Main;

IMPLEMENTATION

USES ConstStd, Main_Dm, stdUtils, Marques_Frm,
  RegroupFourn_frm;

{$R *.DFM}

TYPE
    TmyCustomdxBarControl = CLASS(TCustomdxBarControl);

//******************* TFrm_Main.AlgolMainFrmCreate *************************

PROCEDURE TFrm_Main.AlgolStdFrmCreate(Sender: TObject);
BEGIN
    ouvert := False;
END;

//******************* TFrm_Main.AlgolStdFrmCloseQuery *************************
// Contr�le de sortie de la Forme ...

PROCEDURE TFrm_Main.AlgolStdFrmCloseQuery(Sender: TObject;
    VAR CanClose: Boolean);
BEGIN
    CanClose := NOT Ouvert;
    IF NOT Canclose THEN
        Abort
END;

//******************* TFrm_Main.AlgolMainFrmShow *************************

PROCEDURE TFrm_Main.AlgolStdFrmShow(Sender: TObject);
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
        IF StdConst.Tip_Main.ShowAtStartup THEN ExecTip;
    END;
END;

//--------------------------------------------------------------------------------
// Boutons du Menu
//--------------------------------------------------------------------------------

//******************* TFrm_Main.Dxb_QuitClick *************************
// Bouton Quitter

PROCEDURE TFrm_Main.Dxb_QuitClick(Sender: TObject);
BEGIN
    Close;
END;

PROCEDURE TFrm_Main.AlgolStdFrmKeyDown(Sender: TObject; VAR Key: Word;
    Shift: TShiftState);
BEGIN
    IF (key = VK_ESCAPE) THEN Kit := True;
END;

procedure TFrm_Main.Dxb_MarkClick(Sender: TObject);
begin
     DedoubMarques;
end;

procedure TFrm_Main.dxb_FournClick(Sender: TObject);
begin
     DedoubFourn;
end;

END.

