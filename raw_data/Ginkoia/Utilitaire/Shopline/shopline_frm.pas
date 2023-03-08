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

UNIT shopline_frm;

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
    RzLabel, RzStatus, fcStatusBar, IB_Components, Calend, PSCCalendar,
    PSCCalendarPro, ODCalend, ODPopCal;

TYPE
    TFrm_Shopline = CLASS(TAlgolStdFrm)
        Pan_Page: TRzPanel;
        Nbt_Quit: TLMDSpeedButton;
        Stat_Bar: TfcStatusBar;
        Clk_Status: TRzClockStatus;
        IbC_Min: TIB_Cursor;
        LMDSpeedButton1: TLMDSpeedButton;
        IbC_Ca: TIB_Cursor;
        IbC_Sum: TIB_Cursor;
        od: TODCalendarDialog;
    Tim_h: TTimer;
    RzLabel1: TRzLabel;
    Tim_Top: TTimer;
        PROCEDURE Nbt_QuitClick(Sender: TObject);
        PROCEDURE AlgolStdFrmShow(Sender: TObject);
        PROCEDURE AlgolStdFrmCreate(Sender: TObject);
        PROCEDURE AlgolStdFrmCloseQuery(Sender: TObject;
            VAR CanClose: Boolean);
        PROCEDURE LMDSpeedButton1Click(Sender: TObject);
    procedure Tim_TopTimer(Sender: TObject);
    procedure Tim_hTimer(Sender: TObject);
    PRIVATE
        UserCanModify, UserVisuMags: Boolean;
        PROCEDURE Traitement(ladate: tdatetime; typ: integer);
        PROCEDURE TraitementHeure(jour: tdatetime; hour: word; VAR nbtck: STRING; VAR ca: STRING; VAR nbart: STRING);

    { Private declarations }
    PROTECTED
    { Protected declarations }
    PUBLIC
    { Public declarations }
    PUBLISHED
    { Published declarations }
    END;
VAR frm_shopline: Tfrm_Shopline;
IMPLEMENTATION

USES
    GinkoiaResStr,
    DlgStd_Frm, GinKoiaStd, StdUtils, Main_Dm ;

{$R *.DFM}

PROCEDURE TFrm_Shopline.AlgolStdFrmCreate(Sender: TObject);
BEGIN
    StdGinkoia.LoadIniFileFromDatabase;
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
    tim_top.enabled:=true;
END;

PROCEDURE TFrm_Shopline.Nbt_QuitClick(Sender: TObject);
VAR
    CanClose: Boolean;
BEGIN
//    CanClose := True;
//    AlgolStdFrmCloseQuery(Sender, CanClose);
//    IF CanClose THEN KillAction.Execute;
close;
END;

PROCEDURE TFrm_Shopline.AlgolStdFrmCloseQuery(Sender: TObject;
    VAR CanClose: Boolean);
BEGIN
    { Ici le code de contr�le de sortie. Cette proc�dure n'est pas ex�cut�e directement
      par le composant Page de LMD lorsqu'il tue la forme mais je l'ai associ�e au
      bouton de fermeture qui sert � fermer l'onglet. L'utiliser donc normalement !

      Le code ci-dessous est une proposition standard, le modifier en fonction du
      cas particulier de l'application.
      CtrlCanClose retourne 0 si tout ok
                            1 si onglet courant � son stdTag mis
                            2 si outBar et que une page � son stdTag mis }

    // on recalcule tout
    traitement(date, 1);
    canclose:=true;
    //close;

END;

PROCEDURE TFrm_Shopline.AlgolStdFrmShow(Sender: TObject);
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

PROCEDURE TFrm_Shopline.Traitement(ladate: tdatetime; typ: integer);
VAR Year, Month, Day: Word;
    aa, mm, jj: STRING;
    Fic: tstringlist;
    Hec, Hour, Min, Sec, MSec: Word;
    hh: STRING;
    i: integer;
    heure: tdatetime;
    ca, nbtck, nbart: STRING;
    ch: STRING;

BEGIN
    ShowMessHPAvi ( 'Traitement en cours',true,0,0,'' ) ;
    createdir('c:\shopline\');
    createdir('c:\shopline\caisse\');

    IF typ = 1 THEN
        hec := 22 //traitement demand� pour une date
    ELSE
        DecodeTime(now, Hec, Min, Sec, MSec);

    DecodeDate(ladate, Year, Month, Day);
    aa := conv(year - 2000, 2);
    mm := conv(month, 2);
    jj := conv(day, 2);
    fic := tstringlist.create;
    TRY
        fic.LoadFromFile('c:\shopline\caisse\' + aa + mm + jj + '.txt');
    EXCEPT
    END;
    fic.clear;
    //Traitement pour la journ�e en cours de toutes les heures non trait�es
    ibc_min.close;
    ibc_min.parambyname('magid').asinteger := stdginkoia.magasinid;
    ibc_min.parambyname('thedate').asdatetime := ladate;
    ibc_min.open;
    IF ibc_min.fieldbyname('tke_date').asDateTime<>0 THEN
    BEGIN
        // Il faut rattraper le retard
        DecodeTime(ibc_min.fieldbyname('tke_date').asDateTime, Hour, Min, Sec, MSec);
        WHILE hour < hec DO
        BEGIN
            TraitementHeure(ladate, hour, nbtck, ca, nbart);
            hh := conv(hour, 2);
            ch := ' 001 | ' + jj + '/' + mm + '/' + aa +
                ' | ' + hh +
                ' | ' + nbtck +
                ' | ' + ca +
                ' | ' + nbart +
                ' |      0 |';
            fic.add(ch);
            hour := hour + 1;
        END;
        fic.SaveToFile('c:\shopline\caisse\' + aa + mm + jj + '.txt');
    END;

    fic.free;
    ShowCloseHP;
END;

PROCEDURE TFrm_Shopline.TraitementHeure(jour: tdatetime; hour: word; VAR nbtck: STRING; VAR ca: STRING; VAR nbart: STRING);
VAR heure: tdatetime;
    i: integer;
BEGIN

    ibc_ca.close;
    ibc_ca.parambyname('magid').asinteger := stdginkoia.magasinid;
    heure := EncodeTime(Hour, 0, 0, 0);
    ibc_ca.parambyname('d1').asdatetime := jour + heure;
    heure := EncodeTime(Hour, 59, 59, 0);
    ibc_ca.parambyname('d2').asdatetime := jour + heure;
    ibc_ca.open;

    ca := floattostr(roundrv(ibc_ca.fieldbyname('ca').asfloat, 2));
    nbart := floattostr(roundrv(ibc_ca.fieldbyname('nbart').asfloat, 0));

    ibc_sum.close;
    ibc_sum.parambyname('magid').asinteger := stdginkoia.magasinid;
    heure := EncodeTime(Hour, 0, 0, 0);
    ibc_sum.parambyname('d1').asdatetime := jour + heure;
    heure := EncodeTime(Hour, 59, 59, 0);
    ibc_sum.parambyname('d2').asdatetime := jour + heure;
    ibc_sum.open;

    nbtck := ibc_sum.fieldbyname('nbtck').asstring;

    nbtck := Alignleft(nbtck, ' ', 6);
    nbart := Alignleft(nbart, ' ', 6);
    ca := Alignleft(Ca, ' ', 10);
    i := pos('.', ca);
    IF i <> 0 THEN
    BEGIN
        delete(ca, i, 1);
        insert(',', ca, i);
    END;
END;

PROCEDURE TFrm_Shopline.LMDSpeedButton1Click(Sender: TObject);
BEGIN
    tim_h.enabled:=false;
    IF od.Execute THEN traitement(od.startdate, 1);
    tim_h.enabled:=true;
END;

procedure TFrm_Shopline.Tim_TopTimer(Sender: TObject);
begin
  tim_top.enabled:=false;
  traitement(date, 1);
  tim_h.enabled:=true;
end;

procedure TFrm_Shopline.Tim_hTimer(Sender: TObject);
begin
    traitement(date, 1);
end;

END.

