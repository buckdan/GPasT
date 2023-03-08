//------------------------------------------------------------------------------
// Nom de l'unit� :
// R�le           : Page standard d'une application "Page"
// Auteur         :
// Historique     :
// 20/08/2000 - Herv� PULLUARD - v 1.0.0 : Cr�ation
//------------------------------------------------------------------------------

{***************************************************************
   CTRL+TAB pour passer d'un onglet � l'autre.
   Contr�le du changement de page :
       Les formes de chaque page au standard TAlgolstdFrm ont une propri�t� "StdTag"
       qui est utilis� ici.
       Si StdTag de la page courante est >= 0 le changement de page est interdit
       Il nous suffit donc d'agir sur cette propri�t� pour contr�ler...
       Rem : cela ne sert que dans une forme utilis�e comme "page" ailleurs
       StdTag est aussi utilis� de la m�me fa�on pour inhiber les boutons de menus.

       Exception : la MainForm d'un projet page utilise StdTag pour contr�ler
       le nombre de pages Maximum autoris�. Cela n'a aucune incidence puisque
       dans ce contexte la MainForm n'est jamais la forme active
       (au plus bas niveau c'est l'�cran de contr�le qui est actif).

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

   ON NE PEUT PAS NON PLUS QUITTER une application "page" tant qu'il y a encore
   des pages ouvertes hors �cran de contr�le.

   INTERDIRE L'OUVERTURE DE PLUSIEURS OCCURRENCES D'UNE PAGE :
   (seulement pour les TAlgolStdFrm)
   Mettre la propri�t� "OnlyOneInstance" � TRUE

   Num�rotation des pages automatique sur les instances d'un m�me module

   Nota : le syst�me fonctionne sans que les pages aient � d�clarer la MainForm
   dans sa clause Uses. Toutefois il est �vident que cela pourra �tre n�cessaire
   pour d'autres motifs.

   Les Events Key des pages n'interceptent pas les touches syst�me (fl�ches par exemple)

   On peut aussi utiliser le composant WindowList de LMD pour g�rer les pages
   Une fen�tre pour changer (c'est automatique)
   Une fen�tre pour d�truire (en sortie si execute on tue la page s�lect�e)

   **************************************************************************

   ATTENTION :
   *********
    PROCEDURES NON PRISES EN CHARGE par le composant Pages de LMD.
    NE PAS UTILISER

   1. procedure Form Deactivate
   2. procedure Form Activate
   3. procedure Form Close

   *************************************************************************** }

UNIT ParamInit_Frm;

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
    LMDControl,
    LMDBaseControl,
    LMDBaseGraphicButton,
    LMDCustomSpeedButton,
    LMDSpeedButton,
    ExtCtrls,
    RzPanel,
    StdCtrls,
    LMDCustomScrollBox,
    LMDScrollBox,
    LMDCustomButton,
    LMDButton,
    RzLabel,
    RzStatus,
    fcStatusBar,
    Db,
    dxCntner,
    dxTL,
    dxDBCtrl,
    dxDBGrid,
    dxDBGridRv,
    RzPanelRv;

TYPE
    TFrm_ParamInit = CLASS(TAlgolStdFrm)
        Pan_Page: TRzPanel;
        SBtn_Quit: TLMDSpeedButton;
        Lab_Caption: TRzLabel;
        Stat_Bar: TfcStatusBar;
        Clk_Status: TRzClockStatus;
        Tim_Focus: TTimer;
        RzPanelRv1: TRzPanelRv;
        RzPanelRv2: TRzPanelRv;
        Ds_ParamInit: TDataSource;
        Pan_Genre: TRzPanelRv;
        Dbg_Genre: TdxDBGridRv;
        Dbg_GenreGRE_ID: TdxDBGridMaskColumn;
        Dbg_GenreGRE_NOM: TdxDBGridMaskColumn;
        Dbg_GenreGRE_SEXE: TdxDBGridMaskColumn;
        Dbg_GenreGRE_IDREF: TdxDBGridMaskColumn;
        Pan_TCT: TRzPanelRv;
        Dbg_TCT: TdxDBGridRv;
        Dbg_TCTTCT_ID: TdxDBGridMaskColumn;
        Dbg_TCTTCT_NOM: TdxDBGridMaskColumn;
        Dbg_TCTTCT_CODE: TdxDBGridMaskColumn;
        Pan_TVA: TRzPanelRv;
        Dbg_TVA: TdxDBGridRv;
        Dbg_TVATVA_ID: TdxDBGridMaskColumn;
        Dbg_TVATVA_TAUX: TdxDBGridMaskColumn;
        Dbg_TVATVA_CODE: TdxDBGridMaskColumn;
        Pan_Classement: TRzPanelRv;
        Dbg_Cla: TdxDBGridRv;
        Dbg_ClaCLA_ID: TdxDBGridMaskColumn;
        Dbg_ClaCLA_NOM: TdxDBGridMaskColumn;
        Dbg_ClaCLA_TYPE: TdxDBGridMaskColumn;
        Dbg_ClaCLA_NUM: TdxDBGridMaskColumn;
        Pan_Civilite: TRzPanelRv;
        Dbg_Civilite: TdxDBGridRv;
        Dbg_CiviliteCIV_ID: TdxDBGridMaskColumn;
        Dbg_CiviliteCIV_NOM: TdxDBGridMaskColumn;
        Dbg_CiviliteCIV_SEXE: TdxDBGridMaskColumn;
        Pan_ModeR: TRzPanelRv;
        Pan_CdtPaie: TRzPanelRv;
        Pan_CptVente: TRzPanelRv;
        Dbg_ModeR: TdxDBGridRv;
        Dbg_CdtPaie: TdxDBGridRv;
        Dbg_CptVente: TdxDBGridRv;
        Dbg_ModeRMRG_ID: TdxDBGridMaskColumn;
        Dbg_ModeRMRG_LIB: TdxDBGridMaskColumn;
        Dbg_CdtPaieCPA_ID: TdxDBGridMaskColumn;
        Dbg_CdtPaieCPA_NOM: TdxDBGridMaskColumn;
        Dbg_CdtPaieCPA_CODE: TdxDBGridMaskColumn;
        Dbg_CptVenteCVA_ID: TdxDBGridMaskColumn;
        Dbg_CptVenteCVA_TVAID: TdxDBGridMaskColumn;
        Dbg_CptVenteCVA_TCTID: TdxDBGridMaskColumn;
        Dbg_CptVenteTCT_NOM: TdxDBGridMaskColumn;
        Dbg_CptVenteTVA_TAUX: TdxDBGridMaskColumn;
        Dbg_CptVenteCVA_ACHAT: TdxDBGridMaskColumn;
        Dbg_CptVenteCVA_VENTE: TdxDBGridMaskColumn;
        Dbg_CptVenteCVA_EXPORT: TdxDBGridMaskColumn;
        Dbg_CptVenteCVA_RETRO: TdxDBGridMaskColumn;
        Pan_TypeConso: TRzPanelRv;
        Dbg_TypeConso: TdxDBGridRv;
        Dbg_TypeConsoColumn1: TdxDBGridColumn;
        PROCEDURE SBtn_QuitClick(Sender: TObject);
        PROCEDURE AlgolStdFrmShow(Sender: TObject);
        PROCEDURE AlgolStdFrmCreate(Sender: TObject);
        PROCEDURE AlgolStdFrmCloseQuery(Sender: TObject;
            VAR CanClose: Boolean);
        PROCEDURE Tim_FocusTimer(Sender: TObject);
    PRIVATE
    { Private declarations }
    PROTECTED
    { Protected declarations }
    PUBLIC
    { Public declarations }
    PUBLISHED
    { Published declarations }
    END;

VAR
    Frm_ParamInit: TFrm_ParamInit;

//------------------------------------------------------------------------------
// Ressources strings
//------------------------------------------------------------------------------
//ResourceString

IMPLEMENTATION

USES ginkoiastd,
    ginkoiaresstr,
    ParamInit_Dm,
    Main_Frm;
{$R *.DFM}

//------------------------------------------------------------------------------
// Proc�dures et fonctions internes
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Gestionnaires d'�v�nements
//------------------------------------------------------------------------------

PROCEDURE TFrm_ParamInit.AlgolStdFrmCreate(Sender: TObject);
BEGIN
    Lab_caption.caption := Caption;
    Dm_ParamInit := TDm_ParamInit.create(Application);
//  Positionner le contr�le ayant le focus au d�marrage
//    CurCtrl := ;
//    Tim_Focus.Enabled := True;
END;

PROCEDURE TFrm_ParamInit.SBtn_QuitClick(Sender: TObject);
VAR
    CanClose: Boolean;
BEGIN
    CanClose := True;
    AlgolStdFrmCloseQuery(Sender, CanClose);
    IF CanClose THEN KillAction.Execute;
END;

PROCEDURE TFrm_ParamInit.AlgolStdFrmCloseQuery(Sender: TObject;
    VAR CanClose: Boolean);
BEGIN
    { Ici le code de contr�le de sortie. Cette proc�dure n'est pas ex�cut�e
      par le composant Page de LMD lorsqu'il tue la forme mais je l'ai associ�e au
      bouton de fermeture qui sert � fermer l'onglet. L'utiliser donc normalement !

      Le code ci-dessous est une proposition standard, le modifier en fonction du
      cas particulier de l'application.
      CtrlCanClose retourne 0 si tout ok
                            1 si onglet courant � son stdTag mis
                            2 si outBar et que une page � son stdTag mis }

    CanClose := False;
    CASE CtrlCanClose OF
        0: CanClose := True;
        1: INFMESS(ErrPgTab, '');
        2:
            BEGIN
                INFMESS(ErrPgfc, '');
                ActiveFirstTagedFcPage; // active la page fc avec stdTag
            END;
    END;

END;

PROCEDURE TFrm_ParamInit.AlgolStdFrmShow(Sender: TObject);
BEGIN
    Tim_Focus.Enabled := True;
{ Remarque importante :
  Ici ne pas toucher � l'aspect visuel des composants de la forme car cela
  perturbe l'affichage. Le maximized au interne du composant ne se fait plus ... }
END;

PROCEDURE TFrm_ParamInit.Tim_FocusTimer(Sender: TObject);
BEGIN
    Tim_Focus.Enabled := False;
    SetFocus;
    TRY
        IF CurCtrl <> NIL THEN
            CurCtrl.SetFocus;
    EXCEPT
    END;
    CurCtrl := NIL;
    // Raz des panels
    Dbg_Genre.Datasource := NIL;
    Pan_Genre.visible := False;
    Dbg_TCT.Datasource := NIL;
    Pan_TCT.visible := False;
    Dbg_TVA.Datasource := NIL;
    Pan_TVA.visible := False;
    Dbg_Cla.Datasource := NIL;
    Pan_Classement.visible := False;
    Dbg_Civilite.Datasource := NIL;
    Pan_Civilite.visible := False;
    Dbg_ModeR.Datasource := NIL;
    Pan_ModeR.visible := False;
    Dbg_CdtPaie.Datasource := NIL;
    Pan_CdtPaie.visible := False;
    Dbg_CptVente.Datasource := NIL;
    Pan_CptVente.visible := False;
    Pan_TypeConso.visible := False;

    CASE Frm_Main.BtClic OF
        1: BEGIN
                Dm_ParamInit.Genre;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_Genre;
                Dbg_Genre.Datasource := Ds_ParamInit;
                Pan_Genre.Align := alCLient;
                Pan_Genre.visible := True;
            END;
        2: BEGIN
                Dm_ParamInit.TypeComptable;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_TCT;
                Dbg_TCT.Datasource := Ds_ParamInit;
                Pan_TCT.Align := alCLient;
                Pan_TCT.visible := True;
            END;
        3: BEGIN
                Dm_ParamInit.TVA;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_TVA;
                Dbg_TVA.Datasource := Ds_ParamInit;
                Pan_TVA.Align := alCLient;
                Pan_TVA.visible := True;
            END;
        4: BEGIN
                Dm_ParamInit.Classement;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_Classement;
                Dbg_Cla.Datasource := Ds_ParamInit;
                Pan_Classement.Align := alCLient;
                Pan_Classement.visible := True;
            END;
        5: BEGIN
                Dm_ParamInit.Civilite;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_Civilite;
                Dbg_Civilite.Datasource := Ds_ParamInit;
                Pan_Civilite.Align := alCLient;
                Pan_Civilite.visible := True;
            END;
        6: BEGIN
                Dm_ParamInit.ModeReglement;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_ModeR;
                Dbg_ModeR.Datasource := Ds_ParamInit;
                Pan_ModeR.Align := alCLient;
                Pan_ModeR.visible := True;
            END;
        7: BEGIN
                Dm_ParamInit.ConditionPaie;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_CdtPaie;
                Dbg_CdtPaie.Datasource := Ds_ParamInit;
                Pan_CdtPaie.Align := alCLient;
                Pan_CdtPaie.visible := True;
            END;
        8: BEGIN
                Dm_ParamInit.CptVente;
                Ds_ParamInit.DataSet := Dm_ParamInit.Que_CptVente;
                Dbg_CptVente.Datasource := Ds_ParamInit;
                Pan_CptVente.Align := alCLient;
                Pan_CptVente.visible := True;
            END;
        9: BEGIN
                Dm_ParamInit.Conso;
                Ds_ParamInit.DataSet := Dm_ParamInit.Ibq_conso;
                Dbg_TypeConso.Datasource := Ds_ParamInit;
                Pan_TypeConso.Align := alCLient;
                Pan_TypeConso.visible := True;
            END;
        10: Dm_ParamInit.LK_ExeCom.Execute;
    END;

END;

END.
