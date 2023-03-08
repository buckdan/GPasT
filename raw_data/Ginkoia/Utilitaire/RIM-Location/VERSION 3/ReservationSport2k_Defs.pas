unit ReservationSport2k_Defs;

interface
  uses Classes, SysUtils, IdMessage, IdAttachment,  IdText,
       DateUtils, xml_unit, IcXmlParser,ulogfile, stdutils,
       dmReservation, ReservationType_Defs, R2D2, uImap4, ReservationResStr, dbugintf;

const
  CSPORT2K  = 'RESERVATION SPORT 2000';
  CS2KWORDDETECT = 'RESERVATION GINKOIA';

  // R�cup�re les mails pour savoir s'il vont �tre trait� ou non.
  function GenerateSport2kMailList(MaCentrale : TGENTYPEMAIL;MaCfg : TCFGMAIL) : Boolean;
    // V�rifie que les mails sont bien valide.
  procedure CheckSport2KMail(MaCentrale : TGENTYPEMAIL; MaCfg : TCFGMAIL);
  // Fonction principale de traitement des mails
  function ExecuteSport2KDoTraitement(MaCentrale : TGENTYPEMAIL;MaCfg : TCFGMAIL) : Boolean;


implementation

uses
  Main;

function GenerateSport2kMailList(MaCentrale : TGENTYPEMAIL;MaCfg : TCFGMAIL) : Boolean;
const
  Retry = 3;
var
  Count : integer ; // pour tester les essais
  i, iNbMess, j , k: integer;
  sIdMag,sIdResa : String;
  sFileName : String;
  IMAP4 : IMAP4Class;
  lstRep : TStringList;

begin
  //PDB
  try
  try

  Result := False;
  Dm_Reservation.MemD_Mail.Close;
  Dm_Reservation.MemD_Mail.Open;

  if MaCfg.PBT_ADRPRINC = '' then
  begin
    Fmain.ologfile.Addtext('Veuillez configurer la partie @mail de Sport2000');
    //InfoMessHP('Veuillez configurer la partie @mail de Sport2000',True,0,0,'Erreur');
      Fmain.showmessagers('Veuillez configurer la partie @mail de Sport2000','Erreur');
      Fmain.trclog('T'+ParamsStr(RS_ERR_RESCMN_CFGMAIL_TRC,MaCentrale.MTY_NOM));
      Fmain.trclog('Q-');

      Fmain.p_maj_etat('Erreur d''int�gration'+ ' : '+formatdatetime('dd/mm/yyyy hh:nn',vdebut_exec) );

    Exit;
  end;

  IMAP4 := IMAP4Class.Create(Macfg.PBT_SERVEUR,Macfg.PBT_ADRPRINC,Macfg.PBT_PASSW,Macfg.PBT_PORT,True);
  IMAP4.PGStatus3D := Fmain.Gge_A;
  lstRep := TStringList.Create;
  //Try //PDB

    {$REGION 'Tentative de connexion}
    Count := 0;
    Repeat
      try
        Inc(Count) ;
        IMAP4.Connect;
        //Fmain.oLogfile.Addtext(Format(RS_CONNEXION_OK_LOG, [MaCentrale.MTY_NOM]));
        break ;
      Except on E:Exception do
        begin
          if Count = Retry then
          begin
            Fmain.Ferrorconnect := True ;
            Fmain.oLogfile.Addtext(Format(RS_ERREUR_CONNEXION_LOG, [MaCentrale.MTY_NOM, Count, Retry, E.ClassName, E.Message]));
            Fmain.ShowmessageRS(Format(RS_ERREUR_CONNEXION_DLG, [MaCentrale.MTY_NOM, E.ClassName, E.Message]), 'Erreur');
            Fmain.trclog('T'+RS_ERREUR_CONNEXION_DLG_TRC+': '+E.Message);
            Fmain.trclog('Q-');

            Fmain.p_maj_etat('Erreur d''int�gration'+ ' : '+formatdatetime('dd/mm/yyyy hh:nn',vdebut_exec) );

            Exit;
          end
          else begin
            Sleep(Dm_Reservation.DelaisEssais);
          end;
        end;
      end;
    Until Retry=Count;
    {$ENDREGION}

    // R�cup�raiotn de la liste des magasins � traiter
    Fmain.trclog('T**R�cup�ration de la liste des magasins � traiter');
    With dm_reservation.Que_IdentMagExist do
    begin
      Close;
      ParamCheck := True;
      ParamByName('PMtyId').AsInteger := MaCfg.PBT_MTYID;
      Open;

      if (Recordcount > 0) then
      begin
        while not EOF do
        begin
          if ((MaCentrale.MTY_MULTI <> 0) and (dm_reservation.POSID = FieldByName('IDM_POSID').AsInteger)) Or
             (MaCentrale.MTY_MULTI = 0) then
          begin

            dm_reservation.Que_TmpLoc.Close;
            dm_reservation.Que_TmpLoc.SQL.Clear;
            dm_reservation.Que_TmpLoc.SQL.Add('Select MAG_NOM');
            dm_reservation.Que_TmpLoc.SQL.Add(' FROM GENMAGASIN');
            dm_reservation.Que_TmpLoc.SQL.Add(' WHERE MAG_ID='+inttostr(FieldByName('IDM_MAGID').asinteger));
            dm_reservation.Que_TmpLoc.ExecSQL;
            Fmain.trclog('T*Magasin : '+dm_reservation.Que_TmpLoc.FieldByName('MAG_NOM').asstring);

            lstRep.Text := StringReplace(Trim(FieldByName('IDM_PRESTA').AsString),';',#13#10,[rfReplaceAll]);

            if lstRep.Count=0 then begin

              //Uniquement mentionner ce cas dans le tracing, et pas dans le diagnostic
              Fmain.trclog('TAucun identifiant/code adh�rent n''est d�fini pour le magasin '+dm_reservation.Que_TmpLoc.FieldByName('MAG_NOM').asstring);

            end;

            for i := 0 to lstRep.Count - 1 do
            begin
              Fmain.InitGauge(Format('%s %d sur %d : Code %d/%d'#13#10'R�cup�ration des mails',[MaCentrale.MTY_NOM,RecNo,Recordcount,i + 1, lstRep.Count]),100);
              Fmain.trclog('T'+Format('%s %d sur %d : Code %d/%d'#13#10'R�cup�ration des mails',[MaCentrale.MTY_NOM,RecNo,Recordcount,i + 1, lstRep.Count]));
              main.scodeadh:= Trim(lstRep[i]);
              // Positionnement dans le r�pertoire (On passe � la suite s'il n'existe pas
              if not IMAP4.SelectMailBox('Reservation/' + Trim(lstRep[i])) then
              begin
                scodeadh := Trim(lstRep[i]);
                Fmain.trclog('GPas de correspondance du code adh�rent '+Trim(lstRep[i])+' - Pas de bo�te mail "Reservation/' + Trim(lstRep[i])+'"');
                main.berreur_codeadh := true;
                Continue;
              end;

              // R�cup�ration des mails du r�pertoire
              IMAP4.LoadAllMailBoxMsg;

              Fmain.InitGauge(Format('%s %d sur %d : Code %d/%d'#13#10'Sauvegarde des mails',[MaCentrale.MTY_NOM,RecNo,Recordcount, i+1, lstRep.Count]),100);
              Fmain.trclog('T'+Format('%s %d sur %d : Code %d/%d'#13#10'Sauvegarde des mails',[MaCentrale.MTY_NOM,RecNo,Recordcount, i+1, lstRep.Count]));
              for j := 0 to IMAP4.MsgList.Count - 1 do
              begin
                // On r�cup�re un maximum d'information du mail + r�cup�ration de la pi�ce jointe
                With Dm_Reservation,MemD_Mail do
                begin
                  // d�coupe le sujet pour r�cup�rer l'id magasin et le num�ro de r�servation
                  With TStringList.Create do
                  try
                    Text    := StringReplace(Trim(IMAP4.MsgList[j].Subject),' ',#13#10,[rfReplaceAll]);
                    // Apr�s stringreplace on a dans la stringlist
                    // 0- Reservation
                    // 1- GINKOIA
                    // 2- L'id Magasin
                    // 3- NUMERO
                    // 4- L'id Reservation
                    sIdMag  := Strings[2];
                    sIdResa := Strings[4];
                  finally
                    Free;
                  end; // try

                  // On va stocker les informations temporairement dans un TdxMemData pour la suite du traitement
                  //sFilename := IdMess.MessageParts.Items[j].FileName ;
                  //sFilename := GPATHMAILTMP + sFilename ;
                  if R2D2.DecodeMessage(IMAP4.MsgList[j], GPATHMAILTMP, 0, sFileName) = True then
                  Begin
                    Append;
                    FieldByName('MailId').AsInteger        := j + 1;
                    FieldByName('MailSubject').AsString    := IMAP4.MsgList[j].Subject;
                    FieldByName('MailAttachName').AsString := sFileName;
                    FieldByName('MailIdMag').AsString      := sIdMag;
                    FieldByName('MailIdResa').AsString     := sIdResa;
                    FieldByName('MailDate').AsDateTime     := IMAP4.MsgList[j].Date;
                    FieldByName('bTraiter').AsBoolean      := False;
                    FieldByName('bArchive').AsBoolean      := False ;
                    if Fmain.Falgol = False then
                      FieldByName('bArchive').AsBoolean      :=  True; // on archive dans tous les cas   //(Abs(DaysBetween(Now,GetDateFromK(sIdResa))) >= MaCfg.PBT_ARCHIVAGE);
                    FieldByName('bAnnulation').AsBoolean   := False;
                    FieldByName('bVoucher').AsBoolean      := False;

                    FieldByName('scodeadh').AsString := main.scodeadh;

                    Try
                      Post;
                      // Sauvegarde de la pi�ce jointe;  sauveagrd� par R2D2;
                      //TIdAttachment(IdMess.MessageParts.Items[j]).SaveToFile(GPATHMAILTMP + sFileName);
                    Except on E:Exception do
                      begin
                      // A voir selon
                      //PDB
                      Fmain.trclog('X'+ParamsStr(RS_ERR_RESCMN_SAVEMAIL_TRC,MaCentrale.MTY_NOM)+e.message);
                      end;
                    End; // try
                  end; // if R2D2 ;
                end; // with


                Fmain.Gge_A.Progress := (j + 1) * 100 DIV (IMAP4.MsgList.Count);
                FMain.Refresh;
              end; // for j
            end; // for i

          end;
          Next;
        end;
      end
      else begin
        Fmain.trclog('TPas de r�pertoire � traiter');
        exit; // pas de r�pertoire � traiter
      end;
    end;
    Result := True;

  //PDB
  except
    on e:exception do Fmain.trclog('XErreur dans GenerateSport2kMailList : '+e.message);
  end;
  Finally
    Fmain.ResetGauge ;
    IMAP4.Free;
    LstRep.Free;
  End;
end;

procedure CheckSport2KMail(MaCentrale : TGENTYPEMAIL; MaCfg : TCFGMAIL);
var
  lst : TStringList;
  MonXml : TmonXML;
  nReservationXml : TIcXMLElement;
  bAnnulation : Boolean;
  bVoucher    : Boolean;
  iPosition   : Integer;
  sIdResa     : String;
begin
  lst := TStringList.Create;
  MonXml := TmonXML.Create;
  With Dm_Reservation do
  try
  try
    With MemD_Mail do
    begin
      First;
      while not EOF do
      begin
        lst.LoadFromFile(GPATHMAILTMP + FieldByName('MailAttachName').AsString);
        // On v�rifie que le fichier poss�de au moins une des balises attendu
        if Pos('</fiche>',lst.text) > 1 then
        begin
          try
            // On charge le fichier pour v�rifi� si c'est une annulation
            //PDB
            try
              MonXml.loadfromstring(lst.text);
            Except
              //on E:Exception do Fmain.trclog('FErreur XML : '+e.message);
            end;

            nReservationXml := MonXml.find('/fiche/reservation');
            // si c'est une annulation on ne traitera pas le fichier
            bAnnulation := (MonXml.ValueTag(nReservationXml,'annulation') = 'O');
            bVoucher    := (MonXml.ValueTag(nReservationXml,'voucher') = 'O');

            // On met � jour le Dxmemdata.
            Edit;

            (* PDB - ANCIEN
            if bAnnulation then
            begin
              // Si c'est une annulation
              // est ce que la reservation existe encore ?
              if Dm_Reservation.IsReservationExist(FieldByName('MailIdResa').AsString) then
              begin
                FieldByName('bTraiter').AsBoolean    := Not bAnnulation;
                FieldByName('bAnnulation').AsBoolean := bAnnulation;
              end;
            end else
            begin
              // On v�rifie que la r�servation n'a pas d�j� �t� trait�
              //if not Dm_Reservation.IsReservationExist(FieldByName('MailIdResa').AsString) then
              //PDB...en tenant compte de la Centrale
              if not Dm_Reservation.IsReservationExistMulti(FieldByName('MailIdResa').AsString ,-1, MaCentrale.MTY_ID) then
              begin
                FieldByName('bTraiter').AsBoolean    := True;
              end;
            end;
            *)


            if bAnnulation then
            begin
              FieldByName('bAnnulation').AsBoolean := true;
              // Si c'est une annulation, est ce que la reservation existe encore ?
              if Dm_Reservation.IsReservationExist(FieldByName('MailIdResa').AsString)
              then begin
                senddebug('+++Annulation + r�sa existe -> annulation normale');
                FieldByName('bTraiter').AsBoolean    := true
              end
              else begin
                senddebug('+++Annulation d''une r�sa inexistante');
                FieldByName('bTraiter').AsBoolean    := false;
              end;
            end else
            begin
              FieldByName('bAnnulation').AsBoolean := false;
              // On v�rifie que la r�servation n'a pas d�j� �t� trait�
              //if not Dm_Reservation.IsReservationExist(FieldByName('MailIdResa').AsString)
              //PDB...en tenant compte de la Centrale
              if not Dm_Reservation.IsReservationExistMulti(FieldByName('MailIdResa').AsString,-1,MaCentrale.MTY_ID)
                then begin
                  senddebug('+++Cr�ation normale d''une r�sa');
                  FieldByName('bTraiter').AsBoolean    := True;
                end
                else begin
                  senddebug('+++R�sa d�j� existante');
                  FieldByName('bTraiter').AsBoolean    := False;
                end;
            end;


            FieldByName('bVoucher').AsBoolean    := bVoucher;
            Post;

            if bAnnulation and dm_reservation.ReservationInMemory(MemD_Mail, FieldByName('MailIdResa').AsString) then
            begin
              Edit;
              FieldByName('bTraiter').AsBoolean    := False;
              FieldByName('bArchive').AsBoolean    := False;
              FieldByName('bAnnulation').AsBoolean := True;
              Post;
            end;
         Except on E:Exception do
            begin
              Edit;
              FieldByName('bTraiter').AsBoolean    := False;
              Post;
              Fmain.trclog('XErreur dans CheckSport2KMail-1 : '+e.message);
            end;
          end;
        end;
        Next;
      end; // while
    end; // with
  //PDB
  except
    on e:exception do Fmain.trclog('XErreur dans CheckSport2KMail-2 : '+e.message);
  end;
  finally
    lst.Free;
    MonXml.Free;
    lst := nil ;
    MonXml := nil ;
  end; // with / try
end;

function ExecuteSport2KDoTraitement(MaCentrale : TGENTYPEMAIL;MaCfg : TCFGMAIL) : Boolean;
begin
  // V�rification que les mails sont bien valide
  CheckSport2KMail(MaCentrale, MaCfg);

  // V�rification de la partie OC des mails
  Result := Dm_Reservation.CheckOC(MaCentrale);
end;

end.
