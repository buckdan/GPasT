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

unit IntegMail_frm;

interface

uses
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
    RzLabel, RzStatus, fcStatusBar, Db, Grids, DBGrids, IBODataset, dxBar,
    wwDialog, wwidlg, wwLookupDialogRv, dxmdaset, dxSkinsCore,
  dxSkinsdxBarPainter, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSilver,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxClasses;

type
    TFrm_IntegMail = class(TAlgolStdFrm)
        Pan_Page: TRzPanel;
        dxBarManager1: TdxBarManager;
        Param: TdxBarSubItem;
        Quitter: TdxBarButton;
        Integ: TdxBarButton;
        Referant: TdxBarButton;
        Ident: TdxBarButton;
        RzLabel1: TRzLabel;
        LMDSpeedButton1: TLMDSpeedButton;
        ParamG: TdxBarButton;
        Que_PR: TIBOQuery;
        Que_PRPRM_ID: TIntegerField;
        Que_PRPRM_STRING: TStringField;
        Que_PRPRM_POS: TIntegerField;
        Que_PRPRM_CODE: TIntegerField;
        Que_Pos: TIBOQuery;
        Que_PosPOS_ID: TIntegerField;
        Que_PosPOS_NOM: TStringField;
        LK_Pos: TwwLookupDialogRV;
        Que_PRPRM_TYPE: TIntegerField;
            Export: TdxBarButton;
        Que_Export: TIBOQuery;
        Mois: TdxMemData;
        Moisdeb: TDateField;
        Moisfin: TDateField;
        MoisLib: TStringField;
        LK_Mois: TwwLookupDialogRV;
        Que_Mag: TIBOQuery;
        LK_Mag: TwwLookupDialogRV;
        Que_MagMAG_ID: TIntegerField;
        Que_MagMAG_ENSEIGNE: TStringField;
        Mfinal: TdxMemData;
        Que_mail: TIBOQuery;
        Que_mailPRM_STRING: TStringField;
    Que_Adr: TIBOQuery;
    Que_AdrMAG_ENSEIGNE: TStringField;
    Que_AdrADR1: TStringField;
    Que_AdrADR2: TStringField;
    Que_AdrADR3: TStringField;
    Que_AdrVIL_CP: TStringField;
    Que_AdrVIL_NOM: TStringField;
    Que_AdrADR_TEL: TStringField;
    Que_AdrADR_FAX: TStringField;
        procedure Nbt_QuitClick(Sender: TObject);
        procedure AlgolStdFrmShow(Sender: TObject);
        procedure AlgolStdFrmCreate(Sender: TObject);
        procedure QuitterClick(Sender: TObject);
        procedure ParamGClick(Sender: TObject);
        procedure IdentClick(Sender: TObject);
        procedure ReferantClick(Sender: TObject);
        procedure GenerikAfterCancel(DataSet: TDataSet);
        procedure GenerikAfterPost(DataSet: TDataSet);
        procedure GenerikNewRecord(DataSet: TDataSet);
        procedure GenerikUpdateRecord(DataSet: TDataSet;
            UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
        procedure IntegClick(Sender: TObject);
        procedure ExportClick(Sender: TObject);
        procedure GenerikBeforeDelete(DataSet: TDataSet);
    private
        UserCanModify, UserVisuMags: Boolean;
        function PosteReferant: boolean;
        { Private declarations }
    protected
        { Protected declarations }
    public
        { Public declarations }
    published
        { Published declarations }
    end;


var Frm_IntegMail: TFrm_IntegMail;
implementation

uses
    GinkoiaResStr,
    DlgStd_Frm, GinKoiaStd, EspritparamCde_frm, mail_frm, Main_Dm,
    IntegEsprit_Frm, ComObj, RapMail_Frm;

{$R *.DFM}



procedure TFrm_IntegMail.AlgolStdFrmCreate(Sender: TObject);
begin

    try
        screen.Cursor := crSQLWait;
        // pour si des fois qu'init longue car ouverture de tables ...etc

        //CurCtrl := xxx;
        // cont�le qui doit avoir le focus en entr�e

        Hint := Caption;
        StdGinkoia.AffecteHintEtBmp(self);
        UserVisuMags := StdGinkoia.UserVisuMags;
        UserCanModify := StdGinkoia.UserCanModify('YES_PAR_DEFAUT');
        stdginkoia.LoadIniFileFromDatabase;



    finally
        screen.Cursor := crDefault;
    end;
end;

procedure TFrm_IntegMail.Nbt_QuitClick(Sender: TObject);
var
    CanClose: Boolean;
begin
end;

procedure TFrm_IntegMail.AlgolStdFrmShow(Sender: TObject);
begin

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

    if Init then
    begin
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

    end;

end;

procedure TFrm_IntegMail.QuitterClick(Sender: TObject);
begin
    Application.terminate;
end;

procedure TFrm_IntegMail.ParamGClick(Sender: TObject);
begin
    if PosteReferant then ExecuteEspritparamCde;
end;

procedure TFrm_IntegMail.IdentClick(Sender: TObject);
begin
    if PosteReferant then ExecuteFrm_mail(2);
end;

procedure TFrm_IntegMail.ReferantClick(Sender: TObject);
begin
    que_pr.open;
    if que_pr.eof then
    begin
        if not StdGinKoia.OuiNon('', 'Attention, confirmez vous que le poste r�f�rant' + #10 + #13 +
            'pour l''int�gration des commandes sera dans le magasin' + #10 + #13 +
            'o� vous vous trouvez?' + #10 + #13 + 'CETTE VALIDATION EST DEFINITIVE !', False)
            then
        begin
            que_pr.close;
            Exit;
        end;

        que_pr.insert;
        Que_PRPRM_STRING.asstring := stdginkoia.prefixbase;
        Que_PRPRM_CODE.asinteger := 10009;
        Que_PRPRM_TYPE.asinteger := 12;
    end
    else
    begin
        if Que_PRPRM_STRING.asstring <> stdginkoia.prefixbase then
        begin
            infmess('Fonction impossible, ce poste n'' est ' + #10 + #13 + ' pas autoris� � int�grer les commandes...', '');
            que_pr.close;
            EXIT;
        end
        else
            que_pr.edit;
    end;
    infmess('Attention, le poste que vous allez s�lectionner doit' + #10 + #13 + 'avoir un obligatoirement acces Internet.', '');

    que_pos.close;
    que_pos.parambyname('magid').asinteger := stdginkoia.magasinid;
    que_pos.open;
    que_pos.locate('pos_id', Que_PRPRM_POS.asinteger, []);
    if lk_pos.execute then
    begin
        Que_PRPRM_POS.asinteger := Que_PosPOS_ID.asinteger;
        que_pr.post
    end
    else
        que_pr.cancel;

    que_pr.close;

end;

function TFrm_IntegMail.PosteReferant: boolean;
begin
    que_pr.open;
    if que_pr.eof then
    begin
        infmess('Fonction impossible, ce poste n'' est ' + #10 + #13 + ' pas autoris� � g�rer les commandes Esprit...', '');
        que_pr.close;
        result := false;
        EXIT;
    end;
    if (Que_PRPRM_POS.asinteger <> stdginkoia.posteid) or
        (Que_PRPRM_STRING.asstring <> stdginkoia.prefixbase)
        then
    begin
        infmess('Fonction impossible, ce poste n'' est ' + #10 + #13 + ' pas autoris� � g�rer les commandes Esprit...', '');
        que_pr.close;
        result := false;
        EXIT;
    end;
    result := true;
end;

procedure TFrm_IntegMail.GenerikAfterCancel(DataSet: TDataSet);
begin
    Dm_Main.IBOCancelCache(DataSet as TIBOQuery);
end;

procedure TFrm_IntegMail.GenerikAfterPost(DataSet: TDataSet);
begin
    Dm_Main.IBOUpDateCache(DataSet as TIBOQuery);
end;

procedure TFrm_IntegMail.GenerikBeforeDelete(DataSet: TDataSet);
begin
    { A achever ...
        IF StdGinkoia.ID_EXISTE('KEYID', que_QueryKEY_ID.asInteger, []) THEN
        BEGIN
            StdGinKoia.DelayMess(ErrNoDeleteIntChk, 3);
            ABORT;
        END;
    }
end;

procedure TFrm_IntegMail.GenerikNewRecord(DataSet: TDataSet);
begin
    if not Dm_Main.IBOMajPkKey((DataSet as TIBODataSet),
        (DataSet as TIBODataSet).KeyLinks.IndexNames[0]) then Abort;
end;

procedure TFrm_IntegMail.GenerikUpdateRecord(DataSet: TDataSet;
    UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
    Dm_Main.IBOUpdateRecord((DataSet as TIBODataSet).KeyRelation,
        (DataSet as TIBODataSet), UpdateKind, UpdateAction);
end;


procedure TFrm_IntegMail.IntegClick(Sender: TObject);
begin
    if PosteReferant then
    begin
        //Frm_IntegMail.enabled := false;
        ExecuteIntegEsprit;
        //Frm_IntegMail.enabled := true;
    end;
end;

procedure TFrm_IntegMail.ExportClick(Sender: TObject);
var debut: tdatetime;
    Year, Month, Day: Word;
    i: integer;
    my_ole_application, OleWorkBook: Variant;
    ts: TStrings;

begin

    que_mail.open;
    if (que_mail.eof) or (Que_mailPRM_STRING.asstring = '') then
    begin
        infmess('Le param�trage est incomplet (adresse @mail destinataire)...', '');
        EXIT;
    end;

    if not OuiNonHP('Export automatiques donn�es du mois pr�c�dent?', true, true, 0, 0, 'Esprit') then EXIT;

    que_mag.open;
    if que_mag.recordcount > 1 then
    begin
        if not lk_mag.execute then EXIT;
    end;
    que_adr.close;
    que_adr.parambyname('magid').asinteger:=Que_MagMAG_ID.asinteger;
    que_adr.open;

    mois.open;
    debut := IncMonth(now, -13);

    for i := 1 to 13 do
    begin

        mois.insert;
        mois.fieldbyname('lib').asstring := uppercase(FormatDateTime('mmmm yyyy', debut));

        DecodeDate(Debut, Year, Month, Day);
        mois.fieldbyname('deb').asdatetime := EncodeDate(Year, Month, 1);

        debut := IncMonth(debut, 1);
        DecodeDate(Debut, Year, Month, Day);
        mois.fieldbyname('fin').asdatetime := EncodeDate(Year, Month, 1);
        mois.post;

    end;

    if not lk_mois.execute then Exit;

    try
        ShowMessHPAvi('Traitement en cours', true, 0, 0);
        que_export.close;
        que_export.parambyname('deb').asdatetime := Moisdeb.asdatetime;
        que_export.parambyname('fin').asdatetime := Moisfin.asdatetime;
        que_export.parambyname('magid').asinteger := Que_MagMAG_ID.asinteger;
        que_export.open;


        mfinal.close;
        mfinal.LoadFromDataSet(que_export);
        mfinal.DelimiterChar := ';';
        mfinal.SaveToTextFile(ExtractFilePath(Application.ExeName) + 'exports\' + MoisLib.asstring + '.csv');
        ShowCloseHP;
    except
        ShowCloseHP;
        infmess('Traitement interrompu...', '');
        EXIT;
    end;
    if OuiNonHP('Traitement termin�, souhaitez vous consulter' + #10 + #13 + 'les r�sultats avant de les envoyer?', true, false, 0, 0) then
    begin
        my_ole_application := CreateOleObject('Excel.Application');
        my_ole_application.Visible := True;
        OleWorkBook := my_ole_application.Workbooks.open(ExtractFilePath(Application.ExeName) + 'exports\' + MoisLib.asstring + '.csv');
    end;


    if OuiNonHP('Envoi par @mail des r�sultats de ' + MoisLib.asstring + '?', false, false, 0, 0) then
    begin
        ts := TStringList.Create;
        ts.add(Que_AdrMAG_ENSEIGNE.asstring);
        ts.add(que_AdrADR1.asstring);
        ts.add(Que_AdrADR2.asstring);
        ts.add(Que_AdrADR3.asstring);
        ts.add(Que_AdrVIL_CP.asstring+' '+Que_AdrVIL_nom.asstring);
        ts.add('Tel : '+ Que_AdrADR_TEL.asstring);
        ts.add('Fax : '+ Que_AdrADR_FAX.asstring);


        ExecuteRapMailex('bruno.nicolafrancesco@ginkoia.fr', Que_mailPRM_STRING.asstring, 'R�sultats mensuels : ' + MoisLib.asstring, ExtractFilePath(Application.ExeName) + 'exports\' + MoisLib.asstring + '.csv',ts.text);
        ts.free;
    end;

end;

end.

