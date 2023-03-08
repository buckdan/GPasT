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

   NE PAS OUBLIER qu'il existe aussi une propri�t� STDSTR qui peut servir...

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
   EVENTS STANDARDS NON EXECUTES par les Pages du composant dockpage de LMD.
   DONC A NE PAS UTILISER ou � des fins personnelles et qui donc doivent explicitement
   �tre appel�es

   1. Form Deactivate
   2. Form Activate
   3. Form Close
   4. Form KeyDown
   *************************************************************************** }

UNIT moule_frm;

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
    RzLabel, RzStatus, fcStatusBar, Db, Grids, DBGrids, IBODataset;

TYPE
    TFrm_Moule = CLASS(TAlgolStdFrm)
        Pan_Page: TRzPanel;
        PROCEDURE Nbt_QuitClick(Sender: TObject);
        PROCEDURE AlgolStdFrmShow(Sender: TObject);
        PROCEDURE AlgolStdFrmCreate(Sender: TObject);
    procedure AlgolStdFrmCloseQuery(Sender: TObject; var CanClose: Boolean);
    PRIVATE
        UserCanModify, UserVisuMags: Boolean;
    { Private declarations }
    PROTECTED
    { Protected declarations }
    PUBLIC
    { Public declarations }
    PUBLISHED
    { Published declarations }
    END;


     VAR Frm_moule: Tfrm_moule;
IMPLEMENTATION

USES
    GinkoiaResStr,
    DlgStd_Frm, GinKoiaStd;

{$R *.DFM}



procedure TFrm_Moule.AlgolStdFrmCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // Appel� par Nbt_QuitClick
end;

PROCEDURE TFrm_Moule.AlgolStdFrmCreate(Sender: TObject);
BEGIN

    TRY
        screen.Cursor := crSQLWait;
        // pour si des fois qu'init longue car ouverture de tables ...etc

        //CurCtrl := xxx;
        // cont�le qui doit avoir le focus en entr�e

        Hint := Caption;
        StdGinkoia.AffecteHintEtBmp(self);
        UserVisuMags := StdGinkoia.UserVisuMags;
        UserCanModify := StdGinkoia.UserCanModify('YES_PAR_DEFAUT');


    FINALLY
        screen.Cursor := crDefault;
    END;
END;

PROCEDURE TFrm_Moule.Nbt_QuitClick(Sender: TObject);
VAR
    CanClose: Boolean;
BEGIN
    CanClose := True;
    AlgolStdFrmCloseQuery(Sender, CanClose);
    IF CanClose THEN KillAction.Execute;
END;

PROCEDURE TFrm_Moule.AlgolStdFrmShow(Sender: TObject);
BEGIN

{ Important :
  Ici ne pas toucher � l'aspect visuel des composants visuels de la forme car cela
  perturbe l'affichage -> Le maximized interne et n�cessaire de la page dock�e ne se
  fait fait plus ...

  Ici � la cr�ation de la forme et jusqu'au 1er show la propri�t� INit de la forme
  est toujours � False ! C'est apr�s le "DoSwow" qu'elle est automatiquement mise �
  True ... Donc le 2�me entr�e ici INit est th�oriquement � False.
  Cette propri�t� est visible et g�rable dans l'inspecteur d'objets.
  A noter que si la propri�t� InitTrueOnShow est mise � False ce qui est dit
  pr�c�demment n'est plus de rigueur...
}

    IF Init THEN
    BEGIN
        { Ne passe donc pas ici lors de la cr�ation !}

        {
        A mettre imp�rativement si bouton de convertor
        Nbt_Convert.ControlConvertor;
        }

        { Attention ici faut peut �tre cha�ner sur
          un traitement sp�cifique si on veut g�rer
          les cas de "surConnection"
        UserVisuMags := StdGinkoia.UserVisuMags;
        UserCanModify := StdGinkoia.UserCanModify('xxx');
        }

    END;

END;

END.

