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

UNIT Param_frm;

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
    ExtCtrls,
    RzPanel,
    StdCtrls,
    RzLabel,  Mask,uDefs,
  rxToolEdit, Buttons, RzRadGrp, RzEdit, RzButton, RzRadChk;

TYPE
    TFrm_Param = CLASS(TAlgolStdFrm)
    Lab_DestDir: TRzLabel;
    RepCmb_DestDir: TDirectoryEdit;
    Lab_heure: TRzLabel;
    Lab_ttles: TRzLabel;
    Lab_minutes: TRzLabel;
    Lab_suppinfo: TRzLabel;
    Lab_jours: TRzLabel;
    rze_minutes: TRzEdit;
    rze_jours: TRzEdit;
    GRb_Periodicite: TRzRadioGroup;
    Rzdt_heure: TRzDateTimeEdit;
    Pan_Page: TRzPanel;
    Nbt_Valider: TBitBtn;
    Nbt_Annuler: TBitBtn;
    Gbx_ArretDemarageAuto: TRzGroupBox;
    Bevel1: TBevel;
    Rzdt_Demarrage: TRzDateTimeEdit;
    Rzdt_Arret: TRzDateTimeEdit;
    Chk_Demarrage: TRzCheckBox;
    Chk_Arret: TRzCheckBox;
    Nbt_DemarrageAuto: TBitBtn;
        PROCEDURE Nbt_QuitClick(Sender: TObject);
        PROCEDURE AlgolStdFrmShow(Sender: TObject);
        PROCEDURE AlgolStdFrmCreate(Sender: TObject);
        PROCEDURE AlgolStdFrmCloseQuery(Sender: TObject;
            VAR CanClose: Boolean);
    procedure Nbt_ValiderClick(Sender: TObject);
    procedure rze_minutesKeyPress(Sender: TObject; var Key: Char);
    procedure GRb_PeriodiciteChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
    procedure Chk_DemarrageClick(Sender: TObject);
    procedure Chk_ArretClick(Sender: TObject);
    procedure Nbt_DemarrageAutoClick(Sender: TObject);
    PRIVATE
        UserCanModify, UserVisuMags: Boolean;

        FUNCTION VerifParam : Boolean;
    { Private declarations }
    PROTECTED
    { Protected declarations }
    PUBLIC
    { Public declarations }
    PUBLISHED
    { Published declarations }
    END;


     VAR Frm_Param: TFrm_Param;
IMPLEMENTATION

USES
    GinkoiaResStr,
    DlgStd_Frm, GinKoiaStd;

{$R *.DFM}

PROCEDURE TFrm_Param.AlgolStdFrmCreate(Sender: TObject);
var
  bAllow : Boolean;
BEGIN
  With GCONFIGAPP do
  begin
    RepCmb_DestDir.Text := GCONFIGAPP.DestPath;
    GRb_Periodicite.ItemIndex := Periodicite;
    rzdt_heure.Time   := Heure;
    rze_minutes.Text := IntToStr(Minutes);
    rze_jours.Text   := IntToStr(Jours);

    bAllow := True;
    GRb_PeriodiciteChanging(GRb_Periodicite,Periodicite,bAllow);

    Chk_Demarrage.Checked := bDemarrageAuto;
    Rzdt_Demarrage.Time   := tHeureDemarrage;
    Chk_Arret.Checked     := bArretAuto;
    Rzdt_Arret.Time       := tHeureArret;
  end;

  TRY
      // pour si des fois qu'init longue car ouverture de tables ...etc
      screen.Cursor := crSQLWait;

      // cont�le qui doit avoir le focus en entr�e
      CurCtrl := RepCmb_DestDir;

      Hint := Caption;
      StdGinkoia.AffecteHintEtBmp(self);
      UserVisuMags := StdGinkoia.UserVisuMags;
      UserCanModify := StdGinkoia.UserCanModify('YES_PAR_DEFAUT');
  FINALLY
      screen.Cursor := crDefault;
  END;
END;

procedure TFrm_Param.Nbt_DemarrageAutoClick(Sender: TObject);
begin
  CreerDemarrageAuto();
end;

PROCEDURE TFrm_Param.Nbt_QuitClick(Sender: TObject);
VAR
    CanClose: Boolean;
BEGIN
    CanClose := True;
    AlgolStdFrmCloseQuery(Sender, CanClose);
    IF CanClose THEN KillAction.Execute;
END;

PROCEDURE TFrm_Param.AlgolStdFrmCloseQuery(Sender: TObject;
    VAR CanClose: Boolean);
BEGIN
//
END;

PROCEDURE TFrm_Param.AlgolStdFrmShow(Sender: TObject);
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

procedure TFrm_Param.Chk_ArretClick(Sender: TObject);
begin
  Rzdt_Arret.Enabled      := Chk_Arret.Checked;
end;

procedure TFrm_Param.Chk_DemarrageClick(Sender: TObject);
begin
  Rzdt_Demarrage.Enabled  := Chk_Demarrage.Checked;
end;

procedure TFrm_Param.Nbt_ValiderClick(Sender: TObject);
begin
  if VerifParam then
  begin
    // Enregistre la t�che planifi�e
    if Chk_Demarrage.Checked then
    begin
      SupprimeTachePlanifiee();
      CreerTachePlanifiee(Rzdt_Demarrage.Time);
    end
    else
      SupprimeTachePlanifiee();

    With GCONFIGAPP do
    begin
      DestPath         := IncludeTrailingBackslash(RepCmb_DestDir.Text);
      Periodicite      := GRb_Periodicite.ItemIndex;
      Heure            := Rzdt_heure.Time;
      Minutes          := StrToInt(rze_minutes.Text);
      Jours            := StrToInt(rze_jours.Text);
      bDemarrageAuto   := Chk_Demarrage.Checked;
      tHeureDemarrage  := Rzdt_Demarrage.Time;
      bArretAuto       := Chk_Arret.Checked;
      tHeureArret      := Rzdt_Arret.Time;
    end;
    ModalResult := mrOk;
  end;
end;

procedure TFrm_Param.rze_minutesKeyPress(Sender: TObject; var Key: Char);
begin
  VerNumAll(TEdit(Sender),Key,False,False);
end;

function TFrm_Param.VerifParam: Boolean;
begin
  Result := False;

  // v�rification du directory
  if RepCmb_DestDir.Text = '' then
  begin
    InfoMessHP('Veuillez choisir un r�pertoire de destination du fichier d''export',True,0,0,'Erreur');
    RepCmb_DestDir.SetFocus;
    Exit;
  end;

  // V�rification des donn�es de la p�riodicit�
  case GRb_Periodicite.ItemIndex of
    0: begin
      if Rzdt_heure.Text = '' then
      begin
       InfoMessHP('Veuillez saisir l''heure de g�n�ration du fichier d''export',True,0,0,'Erreur');
       Rzdt_heure.SetFocus;
       Exit;
      end;
    end; // 0
    1: begin
      if rze_minutes.Text = '' then
      begin
        InfoMessHP('Veuillez saisir le nombre de minutes entre deux g�n�rations du fichier d''export',True,0,0,'Erreur');
        rze_minutes.SetFocus;
        Exit;
      end
      else begin
        if (StrToInt(rze_Minutes.text) Mod 15) <> 0 then
        begin
          InfoMessHP('Le nombre de minutes doit �tre un multiple de 15' + #13#10 + '(Ex : 15/30/60/90/ etc ...)',True,0,0,'Erreur');
          rze_minutes.SetFocus;
          Exit;
        end;
      end; // else

    end; // 1
  end; // case

  // V�rification de la saisie du nombre de jour
  if rze_jours.Text = '' then
  begin
    InfoMessHP('Veuillez indiquer le nombre de jours pour la suppression',True,0,0,'Erreur');
    rze_jours.SetFocus;
    Exit;
  end;

  Result := True;
end;


procedure TFrm_Param.GRb_PeriodiciteChanging(Sender: TObject; NewIndex: Integer;
  var AllowChange: Boolean);
begin
  Rzdt_heure.Enabled := (NewIndex = 0);
  rze_minutes.Enabled := (NewIndex = 1);

end;

END.

