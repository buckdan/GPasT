unit ReservationSkiset_Defs;

interface

uses
  Classes,
  SysUtils,
  IdMessage,
  IdAttachment,
  IdText,
  DateUtils,
  xml_unit,
  IcXmlParser,
  ulogfile,
  stdutils,
  dmReservation,
  ReservationType_Defs,
  R2D2,
  uIMAP4,
  DB,
  Variants,
  ReservationResStr,
  DbugIntf,
  ReservationTypeSkiset_Defs;

//****************************************************************************************************************************************************
//****************************************************************************************************************************************************
//
//               ATTENTION : Toutes modification faite ici devra �tre report� dans la caisse (Skiset_DM.pas) !!!
//
//****************************************************************************************************************************************************
//****************************************************************************************************************************************************

// R�cup�ration des param�tres d'acc�s au web service
function GetParamWebService(const Centrale: Integer; var sURL, sCle, sUser : String) : Boolean;

// Gestion appel au web service
function AppelWebService(const sURL, sCle, sUser : String; const Action : TActionWebService) : String;

// R�cup�ration de la liste des offres g�r�es par le site
function GetListeOffresSKISET(const sURL, sCle, sUser : String) : TOffres;
// Gestion des offres
function GestionOffresSKISET(const MaCentrale: TGENTYPEMAIL; const sURL, sCle, sUser : String) : Boolean;

// R�cup�ration de la liste des magasins � traiter
function GetListeMagasins(const MaCentrale: TGENTYPEMAIL) : TListeMagasins;

// R�cup�ration de la liste des r�servations d'un magasin
function GetListeEnTeteReservationsMag(const sURL, sCle, sUser : String) : TReservations;
function GetLignesReservation(aReservation : TReservation) : TLignesReservation;

function GestionReservationsParMag(aMaCentrale: TGenTypeMail; dDate_debut,dDate_end : tdatetime; aListeMagasins : TListeMagasins; aParametrage : TParametrage; modeVerif: boolean = false) : Boolean;
function ReservationAIntegrer(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc) : Boolean;
function GestionAnnulationResa(aReservation : TReservation; aIdResaAAnnuler : Integer) : Boolean;
function GestionMAJResa(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc; aInfoResaBase : TInfosReservation) : Boolean;
function IsCorrespondanceOC(aReservation : TReservation) : Boolean;
function InsertReservation(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc) : Boolean;
function UpdateReservation(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc; aInfoResaBase : TInfosReservation) : Boolean;
procedure TagLineToLinkOfferForResas(aOfferId: String);


// Regarde si la r�servation a d�j� �t� integr�e en base (dans table LOCRESERVATION)
function IsReservationDejaIntegree(const iIdCentrale : Integer; const sNomCentrale, sIdReservation, sRefReservation : String; var InfosResa : TInfosReservation) : Boolean;
// Recherche la date de derni�re mise � jour de la r�servation
function MaxDateUpdate(vReservation : TReservation) : TDateTime;
// Annulation d'une r�servation
function AnnulationReservation(iIdResa : Integer) : Boolean;
// Recherche si une mise � jour de la r�sa a �t� faite sur le web service
function IsMAJWebService(vReservation : TReservation; const iIdResa : Integer; const tDateMAJResa : TDateTime) : Boolean;

// Fonctions de suppression d'une r�servation
function SuppressionReservation(const iIdResa, iIdClient : Integer) : Boolean;
function SuppressionSousLignesReservation(const iIdResa : Integer) : Boolean;
function SuppressionLignesReservation(const iIdResa : Integer) : Boolean;
function SuppressionEnTeteReservation(const iIdResa : Integer) : Boolean;

// Fonctions d'ajout de la r�servation en base
function AjoutClient(const sClientNom, sClientPrenom : String; const iDureeVO : Integer; const tDebutSejourVO, tDureeVODate : TDateTime; vMagasin : TMagasin) : TClient;
function MAJCommentaireClient(const aAdrId : Integer; const tDateDebut, tDateFin : TDateTime; const sCommentaire : String) : Boolean;
function AjoutEnTeteReservation(vReservation : TReservation; const iIdClient, iIdClientPro, iEtat, iPaiement, iMagId : Integer) : Integer;
function MAJEnTeteReservation(const dTotalPrevu : Double) : Boolean;
function AjoutLignesReservation(const iMtaId : Integer; vReservation : TReservation; const iIdResa, iPointure, iTaille, iPoids, iIdClient : Integer; var sCommentaire : String; const vParamLoc : TParamLoc; var dPrixTotal : Double) : Boolean;
function AjoutSousLignesReservation(const vLigneResa : TLigneReservation; const iPrdId, iIdResaLigne, iPointure, iTaille, iPoids : Integer) : Boolean;

function DoInsertReservation(aClientId, aClientAdrId : Integer; aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc) : Boolean;
function InsertClient(const sClientNom, sClientPrenom : String; const iDureeVO : Integer; const tDebutSejourVO, tDureeVODate : TDateTime; vMagasin : TMagasin) : TClient;

var
  // Param�tres pour les appels au web service
  FPRESTA : String;
  FDATE_FROM : TDateTime;
  FDATE_TO : TDateTime;
  FRESA_REF : String;
  FCentrale : TGenTypeMail;   // Variable globale des infos de la centrale de r�servation
  FParametrage : TParametrage;
  FModeVerif: Boolean;

implementation
Uses
  main,
  IdHTTP,
  IdURI,
  IdSSLOpenSSL,
  uJSON,
  Main_Dm,
  Windows;

function GetParamWebService(const Centrale: Integer; var sURL, sCle, sUser : String) : Boolean;
begin
  try
    Result := ReservationTypeSkiset_Defs.GetParamWebService(Dm_Main.Database, Centrale, sURL, sCle, sUser);
  except
    on E:Exception do
      Fmain.trclog('XErreur dans GetParamWebService : '+e.message);
  end;
end;

function AppelWebService(const sURL, sCle, sUser : String; const Action : TActionWebService) : String;
var
  sDestURL : string;
begin
  sDestURL := '';
  Result := '';

  // Construction de l'URL en fonction de l'action demand�e
  case Action of
    awsListeOffres :
      sDestURL := GetURLSkiset(sURL, Action);
    awsListeResaMagasin :
      sDestURL := GetURLSkiset(sURL, Action, FPRESTA, '', FDATE_FROM, FDATE_TO);
    awsListePacksResa :
      sDestURL := GetURLSkiset(sURL, Action, FRESA_REF);
  end;

  if Trim(sDestURL) = '' then
  begin
    Fmain.trclog('TURL vide. Traitement abandonn�.');
    Exit;
  end;

  try
    // Appel au web service
    Result := AppelWebServiceSkiset(sDestURL, sCle, sUser);
  except
    on E : Exception do
    begin
      Fmain.Ferrorconnect := True;
      Fmain.oLogfile.Addtext(Format(RS_ERREUR_CONNEXION_WEBSERVICE_LOG, [E.ClassName, E.Message]));
      Fmain.ShowmessageRS(Format(RS_ERREUR_CONNEXION_WEBSERVICE_DLG, [E.ClassName, E.Message]), RS_TXT_RESCMN_ERREUR);
      Fmain.trclog('T' + RS_ERREUR_CONNEXION_WEBSERVICE_DLG_TRC +': '+E.Message);
      Fmain.trclog('Q-');    // Q : pour ne pas que la fen�tre de diagnostic s'affiche

      Fmain.p_maj_etat('Erreur d''int�gration'+ ' : '+formatdatetime('dd/mm/yyyy hh:nn',vdebut_exec) );
    end;
  end;
end;

function GetListeOffresSKISET(const sURL, sCle, sUser : String) : TOffres;
var
  sListeOffres : String;
  iJsonPos : Integer;
  vJsonOffres : TJsonOffres;
begin
  SetLength(Result, 0);
  try
    try
      // Appel au web service
      sListeOffres := AppelWebService(sURL, sCle, sUser, awsListeOffres);
      if not (sListeOffres = '') then
      begin
        // On transforme le JSON en objet JSON
        iJsonPos := 1;
        SetLength(vJsonOffres, 0);
        TJSON.JSONToDynArray(sListeOffres, iJsonPos, Pointer(vJsonOffres), System.TypeInfo(TJsonOffres));

        // On transforme l'objet JSON en objet m�tier
        Result := TTranspoJson.CopyJSONToOffres(vJsonOffres);
      end;

    finally
      SetLength(vJsonOffres, 0);
    end;

  except
    on E:Exception do
      Fmain.trclog('XErreur dans GetListeOffresSKISET : '+e.message);
  end;
end;

function GestionOffresSKISET(const MaCentrale : TGENTYPEMAIL; const sURL, sCle, sUser : String) : Boolean;
var
  vListeOffres : TOffres;
  Offre : TOffre;
  cpt_offre : Integer;
  sTraceLog : String;
  iOffre : Integer;
begin
  Result := True;

  try
    Fmain.trclog('T');
    Fmain.trclog('T1--Traitement des offres');

    try
      // R�cup�ration des offres via web service
      SetLength(vListeOffres, 0);
      vListeOffres := GetListeOffresSKISET(sURL, sCle, sUser);
      if assigned(vListeOffres) and (Length(vListeOffres) > 0) then
      begin
        Fmain.trclog('T'+ IntToStr(Length(vListeOffres))+' offres disponibles');

        // On regarde le nombre d'offre dans la base
        dm_reservation.Que_LOCCENTRALEOC.Close;
        dm_reservation.Que_LOCCENTRALEOC.ParamCheck := True;
        dm_reservation.Que_LOCCENTRALEOC.ParamByName('PMtyId').AsInteger := MaCentrale.MTY_ID;
        Fmain.trclog('TOuverture des offres avec PMtyId:='+inttostr(MaCentrale.MTY_ID));
        dm_reservation.Que_LOCCENTRALEOC.Open;
        Fmain.trclog('TNbre. d''offres dans la base='+inttostr(dm_reservation.Que_LOCCENTRALEOC.RecordCount));

        if dm_reservation.Que_LOCCENTRALEOC.RecordCount=0 then
        begin
          Fmain.trclog('AAucune OC -> cr�ation initiale');
          bcreation_init_oc := true;
        end;

        // Boucle sur les offres centrales (web service)
        Fmain.trclog('TBoucle sur les offres');
        cpt_offre := 0;

        for Offre in vListeOffres do
        begin
          if ((MaCentrale.MTY_CODE = 'RS7') and (UpperCase(Offre.Centrale) = UpperCase('skiset')))
            or ((MaCentrale.MTY_CODE = 'RGS') and (UpperCase(Offre.Centrale) = UpperCase('gosportmontagne')))
            or ((MaCentrale.MTY_CODE = 'RNS') and (UpperCase(Offre.Centrale) = UpperCase('netski')))
            or ((MaCentrale.MTY_CODE = 'RSKAPI') and (UpperCase(Offre.Centrale) = UpperCase('skimium')))
            or (Offre.Centrale = '') then
          begin
            inc(cpt_offre);

            // V�rification que l'OC existe
            if (dm_reservation.Que_LOCCENTRALEOC.Locate('OCC_IDCENTRALE',Offre.Id,[])) then
            begin
              // OC existante
              // V�rification si le nom est diff�rent
              if Uppercase(dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_NOM').AsString) <> Uppercase(Offre.OffreNom) then
              begin
                // Si diff�rent, on met � jour
                dm_reservation.Que_LOCCENTRALEOC.Edit;
                dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_NOM').AsString := Offre.OffreNom;
                dm_reservation.Que_LOCCENTRALEOC.Post;
                sTraceLog := 'offre modifi�e';
              end
              else
                sTraceLog := 'pas de changement';
            end
            else
            begin
              // OC inexistante donc cr�ation dans la table
              dm_reservation.Que_LOCCENTRALEOC.Append;
              dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_MTYID').AsInteger     := MaCentrale.MTY_ID;
              dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_NOM').AsString        := Offre.OffreNom;
              dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_IDCENTRALE').AsString := IntToStr(Offre.Id);
              dm_reservation.Que_LOCCENTRALEOC.Post;
              sTraceLog :='offre ajout�e';
              main.bcreation_oc := True;
              Result := False;
            end;

            Fmain.trclog('T  n� ' + inttostr(cpt_offre) + ' ' + IntToStr(Offre.Id) + '-' + Offre.OffreNom + '   ->' + sTraceLog);
          end;
        end;

        // Gestion de la correspondance des offres en automatique
        // Uniquement pour bascule Skimium mode mail -> Skimium mode API
        if (MaCentrale.MTY_CODE = 'RSKAPI') and bcreation_init_oc then
        begin
          dm_reservation.MappingOffresSkimium(MaCentrale.MTY_ID);
        end;
      end
      else
      begin
        Fmain.ologfile.Addtext(RS_ERRREUR_RESA_OC);
        Fmain.trclog('TAucune offre retourn�e via l''appel au web service (Offers Packs). Traitement abandonn�.');
      end;

    finally
      Fmain.trclog('TFin traitement des offres');
      Fmain.trclog('T');

      for iOffre := 0 to Pred(Length(vListeOffres)) do
      begin
        FreeAndNil(vListeOffres[iOffre]);
      end;
      SetLength(vListeOffres, 0);
    end;
    
  Except
    on E: Exception do
    begin
      {$IFDEF DEBUG}
      OutputDebugString(pchar('Exception r�servation : '+E.ClassName+':'+E.Message));
      {$ENDIF}
      Fmain.trclog('XException GestionOffresSKISET : '+E.ClassName+':'+E.Message);
    end;
  end;
end;

function GetListeMagasins(const MaCentrale : TGENTYPEMAIL) : TListeMagasins;
var
  vMagasin : TMagasin;
begin
  Fmain.trclog('T');
  Fmain.trclog('T2--R�cup�ration des magasins � traiter dans le module');

  Result := TListeMagasins.Create(True);

  try
    try
      // R�cup�ration de la liste des magasins � traiter
      dm_reservation.Que_IdentMagExist.Close;
      dm_reservation.Que_IdentMagExist.ParamCheck := True;
      dm_reservation.Que_IdentMagExist.ParamByName('PMtyId').AsInteger := MaCentrale.MTY_ID;
      dm_reservation.Que_IdentMagExist.Open;

      if dm_reservation.Que_IdentMagExist.RecordCount > 0 then
      begin
        while not dm_reservation.Que_IdentMagExist.Eof do
        begin
          if ((MaCentrale.MTY_MULTI <> 0) and (dm_reservation.PosID = dm_reservation.Que_IdentMagExist.FieldByName('IDM_POSID').AsInteger))
              or (MaCentrale.MTY_MULTI = 0) then
          begin
            dm_reservation.Que_TmpLoc.Close;
            dm_reservation.Que_TmpLoc.SQL.Clear;
            dm_reservation.Que_TmpLoc.SQL.Add('Select MAG_NOM, MAG_MTAID');
            dm_reservation.Que_TmpLoc.SQL.Add(' FROM GENMAGASIN');
            dm_reservation.Que_TmpLoc.SQL.Add(' WHERE MAG_ID=' + inttostr(dm_reservation.Que_IdentMagExist.FieldByName('IDM_MAGID').asinteger));
            dm_reservation.Que_TmpLoc.ExecSQL;
            Fmain.trclog('T>Magasin : '+dm_reservation.Que_TmpLoc.FieldByName('MAG_NOM').asstring);

            if dm_reservation.Que_IdentMagExist.FieldByName('IDM_PRESTA').AsString = '' then
            begin
              Fmain.trclog('T Aucun identifiant/code adh�rent n''est d�fini pour le magasin '+ dm_reservation.Que_TmpLoc.FieldByName('MAG_NOM').asstring);
            end
            else
            begin
              vMagasin := TMagasin.Create;

              vMagasin.MagId := dm_reservation.Que_IdentMagExist.FieldByName('IDM_MAGID').AsInteger;
              vMagasin.Presta := dm_reservation.Que_IdentMagExist.FieldByName('IDM_PRESTA').AsString;
              vMagasin.CentraleId := dm_reservation.Que_IdentMagExist.FieldByName('IDM_MTYID').AsInteger;
              vMagasin.PosId := dm_reservation.Que_IdentMagExist.FieldByName('IDM_POSID').AsInteger;
              vMagasin.MtaId := dm_reservation.Que_TmpLoc.FieldByName('MAG_MTAID').AsInteger;

              // Param sp�cifique pour LABOUREIX.
              // On force 3 Identifiants magasins pour r�cup�rer toutes les r�sas de ces identifiants sur 1 seul magasin physique.
              // Le forcer dans RIM permet de ne faire aucune modif dans le code de la caisse et de la mobilit� pour l'instant.
              if (MaCentrale.MTY_CODE = 'RSKAPI') and (vMagasin.Presta = '2563') then
                vMagasin.Presta := '2563;2564;2762';

              Result.Add(vMagasin);
            end;
         end;
         dm_reservation.Que_IdentMagExist.next;
        end;
      end
      else
        Fmain.trclog('TPas de r�pertoire � traiter');

      dm_reservation.Que_IdentMagExist.Close;
      Fmain.trclog('T'+inttostr(Result.Count)+' magasin(s) identifi�(s)');

    finally
      Fmain.trclog('TFin traitement des magasins � traiter');
      Fmain.trclog('T');
    end;
  Except
    on E: Exception do
    begin
      {$IFDEF DEBUG}
      OutputDebugString(pchar('Exception r�servation : '+E.ClassName+':'+E.Message));
      {$ENDIF}
      Fmain.trclog('XException GetListeMagasins : '+E.ClassName+':'+E.Message);
    end;
  end;
end;

function GetListeEnTeteReservationsMag(const sURL, sCle, sUser : String) : TReservations;
var
  sListeReservations : String;
  iJsonPos : Integer;
  vJsonResa : TJsonReservations;
begin
  SetLength(Result, 0);
  iJsonPos := 1;

  try
    try
      // Appel au web service
      sListeReservations := AppelWebService(sURL, sCle, sUser, awsListeResaMagasin);
      if not (sListeReservations = '') then
      begin
        // On transforme le JSON en objet JSON
        SetLength(vJsonResa, 0);
        TJSON.JSONToDynArray(sListeReservations, iJsonPos, Pointer(vJsonResa), System.TypeInfo(TJsonReservations));

        // On transforme l'objet JSON en objet m�tier
        Result := TTranspoJson.CopyJSONToReservations(vJsonResa);
      end;

    finally
      SetLength(vJsonResa, 0);
    end;

  except
    on E:Exception do
      Fmain.trclog('XErreur dans GetListeEnTeteReservationsMag : '+e.message);
  end;
end;

function GetLignesReservation(aReservation : TReservation) : TLignesReservation;
var
  sDetailReservation : String;
  vJsonLignes : TJsonLignesReservation;
  iJsonPosLigneResa : Integer;
begin
  SetLength(Result, 0);

  try
    try
      // V�rification des informations contenues dans la r�servation
      if aReservation.DateDebut = 0 then
        Fmain.trclog('EPas de "first_day" sp�cifi� dans la r�servation');
      if aReservation.DateFin = 0 then
        Fmain.trclog('EPas de "last_day" sp�cifi� dans la r�servation');
      if aReservation.NbJours = 0 then
        Fmain.trclog('EPas de "duration" sp�cifi� dans la r�servation"');

      // Appel au web service pour le d�tail de la r�servation
      FRESA_REF := aReservation.Id;
      sDetailReservation := AppelWebService(FParametrage.URL, FParametrage.Cle, FParametrage.User, awsListePacksResa);
      if not (sDetailReservation = '') then
      begin
        // On transforme le JSON en objet JSON
        SetLength(vJsonLignes, 0);
        iJsonPosLigneResa := 1;
        TJSON.JSONToDynArray(sDetailReservation, iJsonPosLigneResa, Pointer(vJsonLignes), System.TypeInfo(TJsonLignesReservation));

        // On transforme l'objet JSON en objet m�tier
        Result := TTranspoJson.CopyJSONToLignesReservation(vJsonLignes);
      end;

    finally
      SetLength(vJsonLignes, 0);
    end;

  except
    on E:Exception do
      Fmain.trclog('XErreur dans GetLignesReservation : '+e.message);
  end;
end;

function IsReservationDejaIntegree(const iIdCentrale : Integer; const sNomCentrale, sIdReservation, sRefReservation: String; var InfosResa : TInfosReservation) : Boolean;
begin
  try
    Result := ReservationTypeSkiset_Defs.IsReservationDejaIntegree(Dm_Main.Database, iIdCentrale, sNomCentrale, sIdReservation, sRefReservation, InfosResa);
  except
    on E:Exception do
      Fmain.trclog('XErreur dans IsReservationDejaIntegree : ' +e.message);
  end;
end;

function MaxDateUpdate(vReservation : TReservation) : TDateTime;
var
  tDateLigne : TDateTime;
  LigneResa : TLigneReservation;
begin
  Result := vReservation.DateMAJ;

  for LigneResa in vReservation.ReservationLignes do
  begin
    tDateLigne := LigneResa.DateMAJ;
    if tDateLigne > Result then
      Result := tDateLigne;
  end;
end;

function AnnulationReservation(iIdResa : Integer) : Boolean;
var
  iEtatResa : Integer;
begin
  Result := False;
  iEtatResa := 0;

  // La r�servation a �t� annul�e
  Fmain.trclog('T>Annulation de la r�servation');

  // Etat de la r�servation (Annul�)
  iEtatResa := dm_reservation.GetEtat(7,0);

  Fmain.trclog('T->Status "Annul�" = ' + IntToStr(iEtatResa));

  if iEtatResa > 0 then
  begin
    Fmain.trclog('T->Mise � jour de l''�tat de r�servation �  = ' + IntToStr(iEtatResa));

    try
      dm_main.StartTransaction;
      dm_reservation.Que_TmpLoc.SQL.Clear;
      dm_reservation.Que_TmpLoc.SQL.Add('UPDATE LOCRESERVATION');
      dm_reservation.Que_TmpLoc.SQL.Add('SET RVS_ETATRESRID = '+ IntToStr(iEtatResa));
      dm_reservation.Que_TmpLoc.SQL.Add('WHERE RVS_ID = ' + IntToStr(iIdResa));
      dm_reservation.Que_TmpLoc.ExecSQL;

      dm_reservation.Que_TmpLoc.Close;
      dm_reservation.Que_TmpLoc.SQL.Clear;
      dm_reservation.Que_TmpLoc.SQL.Add('EXECUTE PROCEDURE PR_UPDATEK(' + IntToStr(iIdResa) + ', 0)');
      dm_reservation.Que_TmpLoc.ExecSQL;
      Dm_Main.Commit;

      Fmain.trclog('RAnnulation r�ussie');
      inc(cpt_r);
      Result := True;
    except
      on e : Exception do
      begin
        Fmain.trclog('XErreur dans AnnulationReservation : ' +e.message);
        Dm_Main.Rollback;
        Result := False;
      end;
    end;
  end
  else
    Fmain.trclog('T   Status d''annulation non renseign� dans la base -> annulation de la resa ignor�e');

  Result := True;
end;

function IsMAJWebService(vReservation : TReservation; const iIdResa : Integer; const tDateMAJResa : TDateTime) : Boolean;
begin
  Result := False;

  // On v�rifie si la r�sa � �t� mise � jour par rapport � la derni�re int�gration
  if tDateMAJResa < MaxDateUpdate(vReservation) then
  begin
    Result := True;    // La r�sa a �t� mise � jour sur le web service
//    Fmain.trclog('T> -> La resa a �t� mise � jour');
  end
  else
  begin
//    Fmain.trclog('T> -> La resa n''a pas �t� mise � jour');
  end;
end;

function SuppressionReservation(const iIdResa, iIdClient : Integer) : Boolean;
begin
  Result := False;
  try
    try
      dm_main.StartTransaction;

      // Appel des fonctions de suppression
      SuppressionSousLignesReservation(iIdResa);
      SuppressionLignesReservation(iIdResa);
      SuppressionEnTeteReservation(iIdResa);

    finally
      Dm_Main.Commit;
      Result := True;
    end;
  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de la suppression de la r�servation : '+e.Message);
      Dm_Main.Rollback;
    end;
  end;
end;

function SuppressionSousLignesReservation(const iIdResa : Integer) : Boolean;
var
  sQuery : String;
begin
  Result := False;
  sQuery := '';

  try
    Fmain.trclog('T> Suppression des sous-lignes');

    // Construction de la requ�te pour r�cup�ration des sous-lignes li�es � la r�servation
    sQuery := 'Select LOCRESERVATIONSOUSLIGNE.RSE_ID'
              + ' FROM LOCRESERVATIONLIGNE'
              + ' JOIN K ON (K_ID=RSL_ID AND K_ENABLED=1)'
              + ' JOIN LOCRESERVATIONSOUSLIGNE'
              + ' JOIN K ON (K_ID=RSE_ID AND K_ENABLED=1)'
              + ' ON (RSE_RSLID=RSL_ID)'
              + ' WHERE RSE_ID<>0 AND RSL_RVSID='
              + IntToStr(iIdResa);

    if (sQuery = '') then
    begin
      Fmain.trclog('T> Erreur de requ�te lors de la suppression des sous-lignes.');
    end
    else
    begin
      // R�cup�ration des sous-lignes li�es � la r�servation
      dm_reservation.Que_TmpLoc.Close;
      dm_reservation.Que_TmpLoc.SQL.Clear;
      dm_reservation.Que_TmpLoc.SQL.Add(sQuery);
      dm_reservation.Que_TmpLoc.ExecSQL;

      //Marquer les records correspondant dans K pour suppression
      while not dm_reservation.Que_TmpLoc.eof do
      begin
        dm_reservation.Que_TmpLoc2.Close;
        dm_reservation.Que_TmpLoc2.SQL.Clear;
        dm_reservation.Que_TmpLoc2.SQL.Add('EXECUTE PROCEDURE PR_UPDATEK(' + IntToStr(dm_reservation.Que_TmpLoc.fieldbyname('RSE_ID').asinteger) + ', 1)');
        dm_reservation.Que_TmpLoc2.ExecSQL;

        dm_reservation.Que_TmpLoc.next;
      end;

      Result := True;
    end;

  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de la suppression des sous-lignes : '+ e.Message);
    end;
  end;
end;

function SuppressionLignesReservation(const iIdResa : Integer) : Boolean;
var
  sQuery : String;
begin
  Result := False;
  sQuery := '';

  try
    Fmain.trclog('T> Suppression des lignes');

    // Construction de la requ�te pour r�cup�ration des lignes li�es � la r�servation
    sQuery := 'Select LOCRESERVATIONLIGNE.RSL_ID'
              + ' FROM LOCRESERVATIONLIGNE'
              + ' JOIN K ON (K_ID=RSL_ID AND K_ENABLED=1)'
              + ' WHERE RSL_ID<>0 AND RSL_RVSID='
              + IntToStr(iIdResa);

    if (sQuery = '') then
    begin
      Fmain.trclog('T> Erreur de requ�te lors de la suppression des lignes.');
    end
    else
    begin
      // R�cup�ration des lignes
      dm_reservation.Que_TmpLoc.Close;
      dm_reservation.Que_TmpLoc.SQL.Clear;
      dm_reservation.Que_TmpLoc.SQL.Add(sQuery);
      dm_reservation.Que_TmpLoc.ExecSQL;

      //Marquer les records correspondant dans K pour suppression
      while not dm_reservation.Que_TmpLoc.eof do
      begin
        dm_reservation.Que_TmpLoc2.Close;
        dm_reservation.Que_TmpLoc2.SQL.Clear;
        dm_reservation.Que_TmpLoc2.SQL.Add('EXECUTE PROCEDURE PR_UPDATEK(' + IntToStr(dm_reservation.Que_TmpLoc.fieldbyname('RSL_ID').asinteger) + ', 1)');
        dm_reservation.Que_TmpLoc2.ExecSQL;

        dm_reservation.Que_TmpLoc.next;
      end;

      Result := True;
    end;
    
  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de la suppression des lignes : '+ e.Message);
    end;
  end;
end;

function SuppressionEnTeteReservation(const iIdResa : Integer) : Boolean;
begin
  Result := False;

  try
    Fmain.trclog('T> Suppression de la r�servation');

    // Mise � jour de K
    dm_reservation.Que_TmpLoc2.Close;
    dm_reservation.Que_TmpLoc2.SQL.Clear;
    dm_reservation.Que_TmpLoc2.SQL.Add('EXECUTE PROCEDURE PR_UPDATEK(' + IntToStr(iIdResa) + ', 1)');
    dm_reservation.Que_TmpLoc2.ExecSQL;

    Result := True;
  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de la suppression de la r�servation : '+ e.Message);
    end;
  end;
end;

function SuppressionClientReservation(const iIdClient : Integer) : Boolean;
begin
  Result := False;

  try
    Fmain.trclog('T> Suppression du client et de son adresse');

    // Recherche du client
    dm_reservation.Que_TmpLoc.Close;
    dm_reservation.Que_TmpLoc.SQL.Clear;
    dm_reservation.Que_TmpLoc.SQL.Add('select clt_adrid from cltclient where clt_id = ' + IntToStr(iIdClient) + ';');
    dm_reservation.Que_TmpLoc.Open;
    if dm_reservation.Que_TmpLoc.Recordcount > 0 then
    begin
      // Mise � jour de K
      dm_reservation.Que_TmpLoc2.Close;
      dm_reservation.Que_TmpLoc2.SQL.Clear;
      dm_reservation.Que_TmpLoc2.SQL.Add('EXECUTE PROCEDURE PR_UPDATEK(' + IntToStr(dm_reservation.Que_TmpLoc.FieldByName('CLT_ADRID').AsInteger) + ', 1)');
      dm_reservation.Que_TmpLoc2.ExecSQL;

      // Mise � jour de K
      dm_reservation.Que_TmpLoc2.Close;
      dm_reservation.Que_TmpLoc2.SQL.Clear;
      dm_reservation.Que_TmpLoc2.SQL.Add('EXECUTE PROCEDURE PR_UPDATEK(' + IntToStr(iIdClient) + ', 1)');
      dm_reservation.Que_TmpLoc2.ExecSQL;

      Result := True;
    end
    else
      Fmain.trclog('T> Pas de client trouv�, on ignore...');

  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de la suppression du client : '+ e.Message);
    end;
  end;
end;

function AjoutClient(const sClientNom, sClientPrenom : String; const iDureeVO : Integer; const tDebutSejourVO, tDureeVODate : TDateTime; vMagasin : TMagasin) : TClient;
var
  iIdPays, iIdVille, iIdAdresse : Integer;
  vClient : TClient;
begin
  Result := TClient.Create;
  iIdAdresse := 0;
  vClient := TClient.Create;

  try
    try
      Fmain.trclog('T> Cr�ation du client ' + sClientNom + ' ' + sClientPrenom);

      // Ajout de l'adresse
      Fmain.trclog('T> Traitement de l''adresse');
      iIdPays := dm_reservation.GetPaysId('', vMagasin.MagId);   // Pas d'infos sur le pays dans la r�sa
      iIdVille := dm_reservation.GetVilleId('', '', iIdPays);  // Pas d'infos sur la ville dans la r�sa
      iIdAdresse := dm_reservation.GetAddresseId(-1, iIdVille);   // Pas d'infos sur l'adresse, on en cr�e une vide

      // Ajout du client avec le lien sur l'adresse
      Fmain.trclog('T> Traitement du client');
      vClient.Nom := UpperCase(sClientNom);
      vClient.Prenom := UpperCase(sClientPrenom);
      vClient.AdresseId := iIdAdresse;
      vClient.MagId := vMagasin.MagId;
      vClient.Civilite := 0;  // Pas d'info sur la civilit� dans la r�sa
      vClient.DureeVO := iDureeVO;      // info de dur�e du voucher pour ne pas afficher le prix sur le bon de loc en caisse
      vClient.DebutSejourVO := tDebutSejourVO;   // info de dur�e du voucher pour ne pas afficher le prix sur le bon de loc en caisse
      vClient.DureeVODate := tDureeVODate;    // Info de date de fin de la r�sa pour ne pas afficher le prix sur le bon de loc en caisse

      vClient.Id := dm_reservation.CreateClient(vClient);

      //Aout du codebarre client
      Fmain.trclog('T> Ajout du codebarre client');
      dm_reservation.InsertCodeBarre(vClient.Id);

      Fmain.trclog('T>LCLT_ID cr��=' + IntToStr(vClient.Id));

    finally
      Result.Assign(vClient);
      FreeAndNil(vClient);
    end;
  except
    on E:Exception do
      Fmain.trclog('XErreur dans AjoutClient : '+e.message);
  end;
end;

function MAJCommentaireClient(const aAdrId : Integer; const tDateDebut, tDateFin : TDateTime; const sCommentaire : String) : Boolean;
var
  sCommentaireClient : String;
begin
  Result := False;
  try
    dm_reservation.Que_GenAdresse.Close;
    dm_reservation.Que_GenAdresse.ParamByName('adrid').AsInteger := aAdrId;
    dm_reservation.Que_GenAdresse.Open;

    if not dm_reservation.Que_GenAdresse.Eof then
    begin
      dm_reservation.Que_GenAdresse.Edit;
      sCommentaireClient := Format('R�serv. du %s au %s' + sLineBreak,
                              [FormatDateTime('dd/mm/yyyy', tDateDebut),
                                FormatDateTime('dd/mm/yyyy', tDateFin)])
                              + sLineBreak + sCommentaire + sLineBreak +
                              dm_reservation.Que_GenAdresse.FieldByName('ADR_COMMENT').AsString;

      dm_reservation.Que_GenAdresse.FieldByName('ADR_COMMENT').AsString := sCommentaireClient;
      dm_reservation.Que_GenAdresse.Post;
      Result := True;
    end;
  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de la mise � jour du client : '+e.Message);
    end;
  end;
end;

function AjoutEnTeteReservation(vReservation : TReservation; const iIdClient, iIdClientPro, iEtat, iPaiement, iMagId : Integer) : Integer;
var
  sChrono : String;
  iIdResa : Integer;

  function GetCommentaireResa(aId, aRef: string): string;
  begin
    Result := 'ID ' + FCentrale.MTY_NOM + ' : ' + aId + CRLF + 'Ref ' + FCentrale.MTY_NOM + ' : ' + aRef;
  end;
begin
  Result := 0;
  iIdResa := -1;
  sChrono := '';

  try
    try
      Fmain.trclog('T-> R�cup�ration du chrono pour la r�servation');
      sChrono := dm_reservation.GetProcChrono;

      Fmain.trclog('T> Ajout de la r�servation chrono=' + sChrono);
      iIdResa := dm_reservation.InsertReservation(
        iIdClient,
        iIdClientPro,
        iEtat,
        iPaiement,
        iMagId,
        '0',
        GetCommentaireResa(vReservation.Id, vReservation.Reference),
        sChrono,
        vReservation.Reference,
        '',
        '',
        vReservation.DateDebut,
        vReservation.DateFin,
        FCentrale.MTY_ID,
        '',
        '',
        vReservation.Id
      );

      Fmain.trclog('T>RVS_ID cr��='+inttostr(iIdResa));

      Fmain.trclog('T  Mise � jour de la date de traitement');
      dm_reservation.Que_Resa.Edit;
      dm_reservation.Que_Resa.fieldbyname('RVS_PAYMENTTIME').AsDateTime := MaxDateUpdate(vReservation);
      dm_reservation.Que_Resa.Post;
      Fmain.trclog('T  Fix�e au '+ datetimetostr(dm_reservation.Que_Resa.fieldbyname('RVS_PAYMENTTIME').AsDateTime));

    finally
      Result := iIdResa;
    end;
  except
    on E:Exception do
      Fmain.trclog('XErreur dans AjoutEnTeteReservation : '+e.message);
  end;
end;

function MAJEnTeteReservation(const dTotalPrevu : Double) : Boolean;
begin
  Result := False;
  try
    dm_reservation.Que_Resa.Edit;
    dm_reservation.Que_Resa.FieldByName('RVS_MONTANTPREV').AsFloat := dTotalPrevu;
    dm_reservation.Que_Resa.Post;
    Result := True;
  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de la mise � jour de la r�servation : '+e.Message);
    end;
  end;
end;

function AjoutLignesReservation(const iMtaId : Integer; vReservation : TReservation; const iIdResa, iPointure, iTaille, iPoids, iIdClient : Integer; var sCommentaire : String; const vParamLoc : TParamLoc; var dPrixTotal : Double) : Boolean;
var
  vLigne : TLigneReservation;
  iIdResaligne, iPrdId : Integer;
  sCommentaireLigne : String;
  iLocType : Integer;
  dPrix : Double;
begin
  // Initialisation
  Result := False;
  sCommentaire := '';
  dPrix := 0;
  dPrixTotal := 0;
  iIdResaligne := -1;

  if not Assigned(vReservation) then
    Exit;

  try
    try
      Fmain.trclog('T  Boucle sur toutes les lignes de la r�servation');
      for vLigne in vReservation.ReservationLignes do
      begin
        if Assigned(vLigne) then
        begin
          // On r�cup�re l'id de l'article correspondant � la r�servation
          iPrdId := dm_reservation.GetPrdId(FCentrale.MTY_ID, vLigne.PackId, 1, iLocType);

          // On r�cup�re le tarif de l'article correspondant au tarif utilis� par le TO
          if (iLocType > -1) and (iPrdId > -1) then
            dPrix := dm_reservation.GetTarifLoc(vParamLoc, iMtaId, vLigne, iPrdId, iLocType, iIdClient);
          dPrixTotal := dPrixTotal + dPrix;   // On calcule le prix total de la r�sa

          // Ajout de l'article
          Fmain.trclog('T    Ajout de l''article');

          iIdResaligne := dm_reservation.InsertResaLigne(
            FCentrale,
            iIdResa,
            vLigne.Id,
            Ord(vLigne.AvecCasque),  // Casque
            0,  //  Multi
            Ord(vLigne.Assurance),  // Garantie
            iPrdId,
            vLigne.Client ,
            '0',  // Remise
            FloatToStr(dPrix),  // Prix
            '',
            vLigne.DateDebut,
            IncDay(vLigne.DateDebut, vLigne.NbJours) - 1,     // Date de fin de la ligne de r�sa
            False,
            '',
            -1,
            vLigne.AmountTTC
          );

          if iIdResaligne > -1 then
          begin
            // Ajout des sous-lignes
            AjoutSousLignesReservation(vLigne, iPrdId, iIdResaligne, iPointure, iTaille, iPoids);
          end;

        
          // Compl�te le commentaire du client (info de chaque personne sur la r�sa)
          sCommentaireLigne := '';
          if vLigne.AvecCasque then
            sCommentaireLigne := 'Casque';

          if vLigne.Assurance then
          begin
            if sCommentaireLigne <> '' then
              sCommentaireLigne := sCommentaireLigne + ' + Garantie'
            else
              sCommentaireLigne := 'Garantie';
          end;

          if sCommentaireLigne <> '' then
            sCommentaire := Format('   %s'#160': %s', [UpperCase(vLigne.Client), sCommentaireLigne]) + sLineBreak + sCommentaire;
        end;
      end;

    finally
      Fmain.trclog('T  Fin d''ajout des lignes de r�servation');
      Result := True;
    end;
  except
    on E:Exception do
      Fmain.trclog('XErreur dans AjoutLignesReservation : '+e.message);
  end;
end;

function AjoutSousLignesReservation(const vLigneResa : TLigneReservation; const iPrdId, iIdResaLigne, iPointure, iTaille, iPoids : Integer) : Boolean;
var
  iLceId : Integer;
begin
  Result := False;
  Fmain.trclog('T  Ajout des sous-lignes');

  if not Assigned(vLigneResa) then
    Exit;

  try
    try
      // On recherche les questions qui doivent �tre pos�es pour cette article
      dm_reservation.Que_LOCTYPERELATION.Close;
      dm_reservation.Que_LOCTYPERELATION.ParamCheck := True;
      dm_reservation.Que_LOCTYPERELATION.ParamByName('PPrdID').AsInteger :=  iPrdId;
      dm_reservation.Que_LOCTYPERELATION.ParamByName('PMtyId').AsInteger := FCentrale.MTY_ID;
      dm_reservation.Que_LOCTYPERELATION.Open;

      while not dm_reservation.Que_LOCTYPERELATION.Eof do
      begin
        iLceId := 0;

        // Pointure
        if dm_reservation.Que_LOCTYPERELATION.FieldByName('LTR_PTR').AsInteger = 1 then
        begin
          iLceId := dm_reservation.GetLocParamElt(iPointure, vLigneResa.Pointure);
//          Fmain.trclog('T - R�ponse "Pointure" : iLceId = ' + IntToStr(iLceId));
          dm_reservation.InsertResaSousLigne(iIdResaligne, dm_reservation.Que_LOCTYPERELATION.fieldbyname('LTR_TCAID').AsInteger, iLceId);
        end;

        // Taille
        if dm_reservation.Que_LOCTYPERELATION.FieldByName('LTR_TAILLE').AsInteger = 1 then
        begin
          iLceId := dm_reservation.GetLocParamElt(iTaille, vLigneResa.Taille);
//          Fmain.trclog('T - R�ponse "Taille" : iLceId = ' + IntToStr(iLceId));
          dm_reservation.InsertResaSousLigne(iIdResaligne, dm_reservation.Que_LOCTYPERELATION.fieldbyname('LTR_TCAID').AsInteger, iLceId);
        end;

        // Poids
        if dm_reservation.Que_LOCTYPERELATION.FieldByName('LTR_POIDS').AsInteger = 1 then
        begin
          iLceId := dm_reservation.GetLocParamElt(iPoids, vLigneResa.Poids);
//          Fmain.trclog('T - R�ponse "Poids" : iLceId = ' + IntToStr(iLceId));
          dm_reservation.InsertResaSousLigne(iIdResaligne, dm_reservation.Que_LOCTYPERELATION.fieldbyname('LTR_TCAID').AsInteger, iLceId);
        end;

        // Insertion d'une ligne sans valeur si pas de question
        if iLceId = 0 then
        begin
//          Fmain.trclog('T - R�ponse sans valeur : iLceId = 0');
          dm_reservation.InsertResaSousLigne(iIdResaligne, dm_reservation.Que_LOCTYPERELATION.fieldbyname('LTR_TCAID').AsInteger, 0);
        end;

        dm_reservation.Que_LOCTYPERELATION.Next;
      end;

    finally
      Fmain.trclog('T  Fin d''ajout des sous-lignes');
      Result := True;
    end;
  except
    on E:Exception do
      Fmain.trclog('XErreur dans AjoutSousLignesReservation : '+e.message);
  end;
end;

function GestionReservationsParMag(aMaCentrale: TGenTypeMail; dDate_debut,dDate_end : tdatetime; aListeMagasins : TListeMagasins; aParametrage : TParametrage; modeVerif: boolean = false) : Boolean;
var
  iMag : Integer;
  vParamLoc : TParamLoc;
  vReservations : TReservations;
  vReservation : TReservation;
  lstRep : TStringList;
  i: Integer;
begin
  Result := False;
  FModeVerif := modeVerif;

  // si on est en mode verif, on prends la date du jour + 120
  if FModeVerif then
  begin
    FDATE_FROM := IncDay(Now(), -1);
    FDATE_TO := IncDay(Now(), 120);;
    Fmain.trclog('T> V�rification de la correspondance des offres centrales / locales sur les 120 jours � venir')
  end
  else
  begin
    FDATE_FROM := dDate_debut;
    FDATE_TO := dDate_end;
  end;

  if not Assigned(FCentrale) then
    FCentrale := TGenTypeMail.Create;
  FCentrale := aMaCentrale;

  if not Assigned(FParametrage) then
    FParametrage := Tparametrage.Create;
  FParametrage.Assign(aParametrage);

  main.cpt_total := 0;
  main.cpt_noMAJ := 0;

  dm_reservation.cpt_trc := 2000;

  try
    try
      Fmain.trclog('T3--Traitement des r�servations');
      if FModeVerif then
        Fmain.trclog('En mode verification des offres');


      for iMag := 0 to Pred(aListeMagasins.Count) do
      begin
        dm_reservation.cpt_trc := dm_reservation.cpt_trc + (iMag*100);
        Fmain.UpdateGauge;

        // si l'ID web magasin est renseign� !
        if aListeMagasins[iMag].Presta <> '' then
        begin
          lstRep := TStringList.Create;
          lstRep.Text := StringReplace(Trim(aListeMagasins[iMag].Presta),';',#13#10,[rfReplaceAll]);

          for i := 0 to lstRep.Count - 1 do
          begin
            FPRESTA := lstRep[i];

            Fmain.trclog('TTraitement des r�servations du magasin Id = ' + IntToStr(aListeMagasins[iMag].MagId));

            // R�cp�ration des param�tres de la location (pour calcul prix r�sa SKISET)
            vParamLoc := dm_reservation.GetLocParamMag(aListeMagasins[iMag].MagId);
            dm_reservation.cpt_trc := dm_reservation.cpt_trc + (iMag*110);

            if Assigned(vParamLoc) then
            begin
              // R�cup�ration des r�servations du magasin
              vReservations := GetListeEnTeteReservationsMag(FParametrage.URL, FParametrage.Cle, FParametrage.User);
              try
                if Assigned(vReservations) and (Length(vReservations) > 0) then
                begin
                  // On boucle sur toutes les r�servations du magasin
                  for vReservation in vReservations do
                  begin
                    main.vDiagnostic.CodeAdherent := FPRESTA;
                    main.vDiagnostic.DateResa := vReservation.DateDebut;
                    main.vDiagnostic.NumResa := vReservation.Id;
                    main.vDiagnostic.Client := vReservation.ClientNom + ' ' + vReservation.ClientPrenom;

                    inc(main.cpt_total);
                    dm_reservation.cpt_trc := dm_reservation.cpt_trc + (iMag*120);

                    if (IntToStr(vReservation.MagId) = FPRESTA) then
                    begin
                      // Traitement de la r�servation uniquement si elle est pour le magasin

                      vReservation.ReservationLignes := GetLignesReservation(vReservation);
                      dm_reservation.cpt_trc := dm_reservation.cpt_trc + (iMag*130);

                      ReservationAIntegrer(vReservation, aListeMagasins[iMag], vParamLoc);
                      dm_reservation.cpt_trc := dm_reservation.cpt_trc + (iMag*140);
                    end
                    else
                      inc(main.cpt_noMAJ);

                    vReservation.Free;
                  end;
                end
                else
                begin
                  Fmain.trclog('TAucune r�servation n''est disponible sur le magasin Id =' + IntToStr(aListeMagasins[iMag].MagId));
                end;

              finally
                SetLength(vReservations, 0);
              end;
            end
            else
            begin
              Fmain.trclog('TAucun param�trage de location disponible sur le magasin Id =' + IntToStr(aListeMagasins[iMag].MagId));
            end;
          end;
        end;
      end;

      if (main.cpt_total = 0) or (main.cpt_noMAJ = main.cpt_total) then
      begin
        // Toutes les r�servations pr�sentent dans la p�riode ont d�j� �t� int�gr�es et n'ont pas eu de mise � jour
        // On sort en Abandon car aucune r�servation n'est disponible pour l'int�gration
        main.vDiagnostic.NumResa := '';
        main.vDiagnostic.DateResa := 0;
        main.vDiagnostic.Client := '';

        Fmain.trclog('AAucune r�servation n''est disponible');
        inc(icptnoresa);
      end;

    finally
      FreeAndNil(FCentrale);
      FreeAndNil(FParametrage);
      FreeAndNil(vParamLoc);
    end;

  except
    on E:Exception do
    begin
      Fmain.trclog('XErreur dans GestionReservationsParMag (trace_id='+inttostr(dm_reservation.cpt_trc)+') : '+e.message);
    end
  end;
end;

function ReservationAIntegrer(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc) : Boolean;
var
  vInfoResaBase : TInfosReservation;
begin
  Result := False;
  vInfoResaBase := Nil;

  // V�rification de la correspondance des OC
  if not IsCorrespondanceOC(aReservation) then
  begin
    if FModeVerif then
      Fmain.trclog('T> Tag des offres qui n''ont pas d''offre locale mais des r�servations � venir')
    else
      Fmain.trclog('T> Erreur de correspondance avec les OC, traitement de la r�servation abandonn�');
  end
  else
  begin
    try
      // en mode v�rification on n'int�gre pas les commandes, on tag seulement les offres � venir qui n'ont pas d'association 
      if not FModeVerif then
      begin
        //On v�rifie si la r�sa existe d�j� en base (= elle a d�j� �t� int�gr�e)
        if IsReservationDejaIntegree(FCentrale.MTY_ID, FCentrale.MTY_NOM, aReservation.Id, aReservation.Reference ,vInfoResaBase) then
        begin
  //        Fmain.trclog('T> La r�servation existe d�j� en base');
          UpdateReservation(aReservation, aMagasin, aParamLoc, vInfoResaBase);
        end
        else
        begin
  //        Fmain.trclog('T> La r�servation n''existe pas en base');
          InsertReservation(aReservation, aMagasin, aParamLoc);
        end;
      end;

      dm_Reservation.CommitSki7;
      Result := True;
    finally
      if Assigned(vInfoResaBase) then
        vInfoResaBase.Free;
    end;
  end;
end;

function InsertReservation(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc) : Boolean;
var
  vClient : TClient;
  vIdGinkoia : Integer;
begin
  Result := False;

  Fmain.trclog('T--Int�gration de la r�servation');

  if not Assigned(aReservation) then
  begin
    Fmain.trclog('TAucune r�servation. Traitement abandonn�.');
    Fmain.trclog('TFin Int�gration de la r�servation');
    Fmain.trclog('T');
    Exit;
  end;

  try
    try
      vIdGinkoia := -1;
      if (aReservation.ClientID <> '') then
      begin
        // Contr�le si le client existe d�j�
        vIdGinkoia := dm_reservation.GetClientImpGin(aReservation.ClientID);
      end;

      if vIdGinkoia > -1 then
      begin
        // R�cup�ration du client
        vClient := dm_reservation.GetClientById(vIdGinkoia);

        // Ajout du voucher sur le client
        dm_reservation.UpdateVoucherClient(vIdGinkoia, aReservation.NbJours, aReservation.DateDebut, aReservation.DateFin);
      end
      else
      begin
        vClient := InsertClient(aReservation.ClientNom, aReservation.ClientPrenom, aReservation.NbJours, aReservation.DateDebut, aReservation.DateFin, aMagasin);
        vIdGinkoia := vClient.Id;
        if (aReservation.ClientID <> '') then
        begin
          // Insert dans Genimport
          dm_reservation.InsertGENIMPORT(vIdGinkoia, -11111401, 5, aReservation.ClientID, FCentrale.MTY_ID);
        end;
      end;

      // Mise � jour des infos de contact du client
      dm_reservation.UpdateContactClient(vClient.AdresseId, aReservation.ClientEmail, aReservation.ClientPhone);

      // Ajout de la liaison entre le client et le TO
      dm_reservation.InsertCLTMEMBREPRO_ENMIEUX(FCentrale.MTY_CLTIDPRO, vClient.Id);


      if Assigned(vClient) then
      begin
        if not DoInsertReservation(vClient.Id, vClient.AdresseId, aReservation, aMagasin, aParamLoc) then
          Fmain.trclog('T   > Erreur d''int�gration de la r�sa : ' + aReservation.Id)
        else
        begin
          Fmain.trclog('RInt�gration r�ussie');
          inc(cpt_r);
          Result := True;
        end;
      end;

    finally
//      Fmain.trclog('TFin Int�gration de la r�servation');
//      Fmain.trclog('T');

      if Assigned(vClient) then
        FreeAndNil(vClient);
    end;
  except
    on E:Exception do
      Fmain.trclog('XErreur dans InsertReservation : '+e.message);
  end;
end;

function InsertClient(const sClientNom, sClientPrenom : String; const iDureeVO : Integer; const tDebutSejourVO, tDureeVODate : TDateTime; vMagasin : TMagasin) : TClient;
begin
  Result := AjoutClient(sClientNom, sClientPrenom, iDureeVO, tDebutSejourVO, tDureeVODate, vMagasin);

//  // Ajout de la liaison entre le client et le TO
//  dm_reservation.InsertCLTMEMBREPRO(FCentrale.MTY_CLTIDPRO, Result.Id);
end;

function DoInsertReservation(aClientId, aClientAdrId : Integer; aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc) : Boolean;
var
  vLigne : TLigneReservation;
  iPrdId : Integer;
  sCheckNomenclature : String;
  iIdResa : Integer;
  sCommentaire : String;
  iTypeLoc : Integer;
  dPrixTotal : Double;
  iEtat : Integer;
begin
  Result := False;
  iPrdId := -1;
  sCheckNomenclature := '';

  try
    // V�rifie si la r�sa est nouvelle ou annul�e
    if not (aReservation.DateAnnulation = 0) and (aReservation.Status = CSTATUS_CANCELLED) then
      iEtat := dm_reservation.GetEtat(7,0)    // Etat Annul�
    else
      iEtat := dm_reservation.GetEtat(1,0);   // Etat Nouvelle


    // Contr�le de la nomenclature pour les articles pr�sent dans la r�servation
    for vLigne in aReservation.ReservationLignes do
    begin
      // On r�cup�re l'id de l'article correspondant � la r�servation
      iPrdId := dm_reservation.GetPrdId(FCentrale.MTY_ID, vLigne.PackId, 1, iTypeLoc);

      // Contr�le de la nomenclature
      Fmain.trclog('T> Contr�le nomenclature avec PrdId=' + inttostr(iPrdId));
      sCheckNomenclature := dm_reservation.CheckNomenclature(iPrdId);
      if sCheckNomenclature <> '' then
      begin
        Fmain.trclog('F' + sCheckNomenclature);   // Erreur de nomenclature
        Result := False;
        Exit;   // On ne continue pas l'int�gration de cette r�servation
      end;
    end;

    Fmain.trclog('T> Nomenclature OK');

    // Ajout de l'en-t�te de la r�servation
    Fmain.trclog('T> Cr�ation de la r�servation "'+ aReservation.Id + '"');
    iIdResa := AjoutEnTeteReservation(aReservation, aClientId, FCentrale.MTY_CLTIDPRO, iEtat, FParametrage.Paiement, aMagasin.MagId);

    if iIdResa > -1 then
    begin
      // Ajout des lignes de r�servations
      Fmain.trclog('T> Cr�ation des lignes de la r�servation "'+ aReservation.Id + '"');
      AjoutLignesReservation(aMagasin.MtaId, aReservation, iIdResa, FParametrage.Pointure, FParametrage.Taille, FParametrage.Poids, FCentrale.MTY_CLTIDPRO, sCommentaire, aParamLoc, dPrixTotal);

      // Mise � jour de l'ent�te avec le montant total pr�vu
      Fmain.trclog('T> Mise � jour du montant pr�vu de la r�servation "'+ aReservation.Id + '"');
      MAJEnTeteReservation(dPrixTotal);

      Fmain.trclog('T Tous les articles ont �t� trait�s');

      // Mise � jour du commentaire sur client
      Fmain.trclog('T> Mise � jour du commentaire sur client');
      MAJCommentaireClient(aClientAdrId, aReservation.DateDebut, aReservation.DateFin, sCommentaire);

      Fmain.trclog('T  >> ETAT FINAL DES PAIEMENTS');
      Fmain.trclog('T  >> - RVS_ACCOMPTE = '+inttostr(dm_reservation.Que_Resa.fieldbyname('RVS_ACCOMPTE').asinteger));
      Fmain.trclog('T  >> - RVS_MONTANTPREV = '+inttostr(dm_reservation.Que_Resa.fieldbyname('RVS_MONTANTPREV').asinteger));
      Fmain.trclog('T  >> - RVS_COMMI = '+inttostr(dm_reservation.Que_Resa.fieldbyname('RVS_COMMI').asinteger));

      Result := True;
    end;

  except
    on e:exception do
    begin
      Fmain.trclog('X> Exception lors de l''ajout de la r�servation : '+e.Message);
    end;
  end;
end;

function UpdateReservation(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc; aInfoResaBase : TInfosReservation) : Boolean;
var
  bAnnulation : Boolean;
begin
  Result := False;
  Fmain.trclog('T--Mise � jour de la r�servation');

  if Assigned(aInfoResaBase) then
  begin
    // Gestion de l'annulation
    bAnnulation := GestionAnnulationResa(aReservation, aInfoResaBase.IdResa);

    if not bAnnulation then
    begin
      // Gestion de mise � jour
      Result := GestionMAJResa(aReservation, aMagasin, aParamLoc, aInfoResaBase);
    end;
  end
  else
    Fmain.trclog('T> La r�servation existe d�j� en base mais pas d''Id r�sa trouv�. Aucune action sur la r�sa n''a �t� faite.');
end;

function GestionAnnulationResa(aReservation : TReservation; aIdResaAAnnuler : Integer) : Boolean;
begin
  Result := False;

  if not (aReservation.DateAnnulation = 0) and (aReservation.Status = CSTATUS_CANCELLED) then
  begin
    AnnulationReservation(aIdResaAAnnuler);
    Result := True;
  end;
end;

function GestionMAJResa(aReservation : TReservation; aMagasin : TMagasin; aParamLoc : TParamLoc; aInfoResaBase : TInfosReservation) : Boolean;
begin
  // Gestion de la mise � jour
  // Pour mettre � jour la r�sa il faut :
  // - que la date de mise � jour du web service soit plus r�cente que la date de mise � jour en base
  // - que la r�sa ne soit pas annul�e
  // - que la r�sa ne soit pas transf�r�e en BL
  Result := False;

  if IsMAJWebService(aReservation, aInfoResaBase.IdResa, aInfoResaBase.DateResa) and (aInfoResaBase.TransfertBL = 0) then
  begin
    Fmain.trclog('T>Mise � jour de la r�servation');

    // Suppression + cr�ation
    SuppressionReservation(aInfoResaBase.IdResa, aInfoResaBase.IdClient);

    // Mise � jour des infos de contact du client
    dm_reservation.UpdateContactClient(aInfoResaBase.CltAdrId, aReservation.ClientEmail, aReservation.ClientPhone);

    if not DoInsertReservation(aInfoResaBase.IdClient, aInfoResaBase.CltAdrId, aReservation, aMagasin, aParamLoc) then
      Fmain.trclog('T   > Erreur d''int�gration de la r�sa : ' + IntToStr(aInfoResaBase.IdResa))
    else
    begin
      Fmain.trclog('RInt�gration r�ussie');
      inc(cpt_r);
      Result := true;
    end;
  end
  else
  begin
    Inc(main.cpt_noMAJ);
//    Fmain.trclog('T   > Toutes les conditions ne sont pas r�unies pour traiter la resa en MAJ');
  end;
end;

function IsCorrespondanceOC(aReservation : TReservation) : Boolean;
var
  vLigne : TLigneReservation;
  sNomOffre : String;
begin
  Result := True;

  Fmain.trclog('T4--V�rification de la correspondance avec les OC');

  try
    try
      for vLigne in aReservation.ReservationLignes do
      begin
        // On v�rifie que le pack de la ligne de r�servation a bien �a correspondance en base
        if not dm_reservation.IsOCParamExist(FCentrale.MTY_ID, vLigne.PackId ,1) then
        begin
          Result := False;

          // On recherche le nom de l'offre en entier pour l'afficher dans la fen�tre de diagnostic
          dm_reservation.Que_LOCCENTRALEOC.Close;
          dm_reservation.Que_LOCCENTRALEOC.ParamCheck := True;
          dm_reservation.Que_LOCCENTRALEOC.ParamByName('PMtyId').AsInteger := FCentrale.MTY_ID;
          dm_reservation.Que_LOCCENTRALEOC.Open;                                                       

          if dm_reservation.Que_LOCCENTRALEOC.RecordCount > 0 then
          begin
            if (dm_reservation.Que_LOCCENTRALEOC.Locate('OCC_IDCENTRALE',vLigne.PackId,[])) then
            begin
              sNomOffre := dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_NOM').asString;
              sNomOffre := StringReplace(sNomOffre, '|', ' - ', [rfIgnoreCase, rfReplaceAll]);

              // si la ligne de l'offre centrale n'a pas de correspondance, on la tag (si pas d�j� tag)
              if (FModeVerif) and (dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_MUSTBELINKED').AsInteger = 0) then
              begin
                TagLineToLinkOfferForResas(dm_reservation.Que_LOCCENTRALEOC.FieldByName('OCC_ID').AsString);
              end;
            end;
          end;

          if not(FModeVerif) then
            Fmain.trclog('FLa relation avec l''OC est manquante : '+ IntToStr(vLigne.PackId) + ' - ' + sNomOffre);
        end
        else
        begin

          // Il y a une correspondance entre l'offre centrale et l'offre magasin
          Fmain.trclog('T  id=' + aReservation.Id + ' du magasin "' + IntToStr(aReservation.MagId) + '" en date du ' + DateTimeToStr(aReservation.DateDebut)
                        + ' -> pack ' + IntToStr(vLigne.PackId) + ' -> OK');
        end;
      end;
    finally
      Fmain.trclog('TFin v�rification de la correspondance avec les OC');
      Fmain.trclog('T');
    end;
  except
    on E:Exception do
      Fmain.trclog('XErreur dans IsCorrespondanceOC : '+e.message);
  end;
end;

procedure TagLineToLinkOfferForResas(aOfferId: String);
begin
  try
    dm_main.StartTransaction;
    dm_reservation.Que_TmpLoc.SQL.Clear;
    dm_reservation.Que_TmpLoc.SQL.Add('UPDATE LOCCENTRALEOC');
    dm_reservation.Que_TmpLoc.SQL.Add('SET OCC_MUSTBELINKED = 1');
    dm_reservation.Que_TmpLoc.SQL.Add('WHERE OCC_ID = ' + aOfferId);
    dm_reservation.Que_TmpLoc.ExecSQL;

    dm_reservation.Que_TmpLoc.Close;
    dm_reservation.Que_TmpLoc.SQL.Clear;
    dm_reservation.Que_TmpLoc.SQL.Add('EXECUTE PROCEDURE PR_UPDATEK(' + aOfferId + ', 0)');
    dm_reservation.Que_TmpLoc.ExecSQL;
    Dm_Main.Commit;

    dm_reservation.Que_TmpLoc.Close;

    Fmain.trclog('Tag d''une offre centrale � associer r�ussie');
  except
    on e : Exception do
    begin
      Fmain.trclog('XErreur dans tag d''une offre centrale : ' +e.message);
      Dm_Main.Rollback;
    end;
  end;

end;


end.
