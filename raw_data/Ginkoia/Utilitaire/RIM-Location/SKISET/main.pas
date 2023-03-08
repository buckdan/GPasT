unit main ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ReservationResStr, dmReservation, ReservationType_Defs,
  strUtils, ReservationSport2k_Defs, uLOgfile, ReservationSkimium_Defs, ReservationTwinner_Defs,
  ReservationGenerique_Defs, ReservationInterSport_Defs, Main_dm,
  IdMessage, IdAttachment, stdutils, R2D2, StdCtrls, RzLabel, Progbr3d,
  LMDControl, LMDBaseControl, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, ExtCtrls, RzPanel, messagebox_frm, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME, Shellapi, IdAntiFreezeBase, IdAntiFreeze, ImgList, uImap4, DB,
  Ulog,Inifiles,DateUtils, dbugintf; 

type
  TFmain = class(TForm)
    Pan_Fond: TRzPanel;
    Pan_Btn: TRzPanel;
    Gge_A: ProgressBar3D;
    Pan_Text: TRzPanel;
    Memo_Mess: TRzLabel;
    IdAntiFreeze: TIdAntiFreeze;
    Lim_lstimage: TImageList;
    TrayIcon1: TTrayIcon;
    procedure ExecuteTraitementReservation ;
    Procedure ArchivMail(MaCentrale : TGENTYPEMAIL;MaCFG : TCFGMail);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    { D�clarations priv�es }
    procedure FindeSessionWindows(var aMsg : Tmessage); message WM_ENDSESSION ;
  public
    { D�clarations publiques }
  oLogfile : Tlogfile ;
  Fdatabase : string ;
  FAuto : boolean  ; // mode auto = true mode ginkoia = false
  FPostid, Fmagid : integer ;
  FAlgol : boolean ;
  Ferrorconnect : boolean ; // pour distinguer l'erreur de connexion de l'erreur de traitement

  procedure SetDatabase(sDatabase : string) ;
  procedure InitGauge(sMessage : string ;MaxValue : integer) ;
  procedure UpdateGauge ;
  procedure ResetGauge ;

  procedure ShowmessageRS(sMessage, sTitle : string) ;

  end;

const

  //SK7
  CSKI7    = 'RESERVATION SKISET';

var
  Fmain: TFmain;
  itrc:integer; //PDB - niveau de tracing 1,2,3
  cpt_x : integer = 0; //comptage des exceptions

  //TWGS
  cpt_centrale : integer;
  iId_centrale : integer;

  sNom_centrale : string;

  //SK7
  RimIni : TIniFile;
  sdate_begin,sdate_end : string;
  ddate_begin,ddate_end : tdatetime;
  bok_date_begin,bok_date_end : boolean;
  idecal:integer;
  bok_sk7 : boolean;
  FSetting : TFormatSettings;  

  procedure trclog(smsg:string); //PDB

implementation

{$R *.dfm}

procedure trclog(smsg:string); //PDB
var
  i:integer;
  sprem,si:string;
begin
  if itrc>0 then begin
    if length(smsg)>1 then begin

      si:=smsg; //passage du message en variable locale
      sprem:=si[1]; //1er caract�re

      //Si c'est X le message est issu d'une exception
      if sprem='X' then begin
        si:=copy(si,2);
        //Logger normal
        if pos(sNom_centrale,si)>0 //on n'affiche pas le nom de la centrale si d�j� pr�sent dans le message
          then fmain.ologfile.Addtext('> '+si)
          else fmain.ologfile.Addtext('> '+sNom_centrale+' : '+si);

        //Envoyer au monitoring
        //Ulog.Log.Log('RIM','Status','Exception : '+si,loginfo,true,-1,ltLocal);
        Ulog.Log.Log('RIM','Status',si,logError,false,-1,ltLocal);

        senddebug('XXX '+si);

        inc(cpt_x); //on comptabilise les exceptions pour savoir si on affichera le log en fin de traitement
      end

      else begin
        //Message normal, on envoie au log uniquement
        i:=strtointdef(si[1],0);
        if i<=itrc then begin //gestion du niveau de message
          si[1]:='-'; //remplacer le n� de niveau de message avec un -
          //fmain.ologfile.Addtext(si);
          Ulog.Log.Log('RIM','Status',si,logInfo,false,-1,ltLocal);

          senddebug(si);
        end;
      end;

    end;
  end;
end;


procedure TFmain.FindeSessionWindows(var aMsg: TMessage);
var oMsg : Tform ;
begin
  Try
   oMsg := CreateMessageDialog('Le module d''int�gration des r�servations est en cours d''ex�cution',mtWarning,[mbOk]) ;
   oMsg.ShowModal ;
  Finally
    oMsg.Release ;
    oMsg := nil ;
  End;
end;



Procedure TFmain.SetDatabase(sDatabase : string);
var sflog : string ; // nom du fichier log
    bLaunch : boolean ;

    i : integer;

begin

  if paramstr(1) = '/M' then begin
    ologfile.Addtext(RS_RESERVATION_START+' Ginkoia');
    trclog('1'+RS_RESERVATION_START+' Ginkoia');
  end
  else begin
    ologfile.Addtext(RS_RESERVATION_START+' Automatique');
    trclog('1'+RS_RESERVATION_START+' Automatique');
    FAuto := True ;
  end;

   if paramstr(5) = '1' then
      FAlgol := True else FAlgol := False ;

  Fdatabase :=  sDatabase ;
  if dm_main.InitDatabase(Fdatabase, 'ginkoia', 'ginkoia') then
   begin
    Try
      //if paramstr(1) = '/M' then visible := True ;
      Visible := True ; // visible dans tous les cas
      application.ProcessMessages ;

      Try

       //ULOG - initialisation
       dm_main.IbQ_Ulog.SQL.Clear;
       dm_main.IbQ_Ulog.SQL.Add('SELECT BAS_MAGID, BAS_GUID, BAS_SENDER FROM GENBASES');
       dm_main.IbQ_Ulog.SQL.Add(' WHERE BAS_IDENT = (SELECT PAR_STRING FROM GENPARAMBASE WHERE PAR_NOM=''IDGENERATEUR'')');
       trclog('1Pr�paration ULOG');
       dm_main.IbQ_Ulog.Open;
       uLog.Log.readIni;
       uLog.Log.App:='RIM';
       uLog.Log.Mag:=dm_main.IbQ_Ulog.fieldbyname('BAS_MAGID').asstring;
       uLog.Log.Ref:=dm_main.IbQ_Ulog.fieldbyname('BAS_GUID').asstring;
       dm_main.ibc_majcu.Close;
       uLog.Log.Open;
       //uLog.Log.SaveIni('C:\Developpement\Ginkoia\Ulog.ini');

       //Liste des param�tres
       trclog('1Param�tres d''ex�cution');
       for i:= 0 to paramcount do trclog('1Param�tre '+inttostr(i)+' : '+paramstr(i));

       trclog('1Base de donn�es initialis�e');

       trclog('1Appel du traitement des r�servations');
       ExecuteTraitementReservation ;
       trclog('1Retour du traitement des r�servations');
       trclog('1Cl�ture des transactions');
       dm_main.Database.CloseTransactions ;
       trclog('1Cl�ture de la base de donn�es');
       dm_main.Database.close ;
       trclog('1Fin de l''aplication');
      Except
        //PDB
        on e:exception do begin
          trclog('XErreur de traitement : '+e.Message);
        end;
        //
      End;
      trclog('1Envoi du message de fermeture');
      Sendmessage(handle, WM_CLose, 0, 0) ;
    Finally
       oLogfile.Addtext( RS_RESERVATION_END );
       trclog('1Arr�t du tracing');

       //bLaunch := oLogfile.Count > 2 ;
       if cpt_x>0 then bLaunch:=true;

       sFlog := IncludeTrailingPathDelimiter(Extractfilepath(paramstr(0)))+'LOG_RIM\' ;
       ologfile.SaveToFile(sflog);  // passe le chemin d'enregistrement
       if blaunch then
        begin
         sFlog := oLogfile.fichierlog ;
         Shellexecute(handle, 'open', 'Notepad.exe', pchar(sFlog), nil, SW_NORMAL) ;
        end;
    End;
   end else
   begin
      ologfile.Addtext(RS_ERR_RESMAN_DATABASE);
   end;
   oLOgfile.Free ;
   oLOgfile := nil ;
   application.terminate ;
end;




Procedure TFmain.ExecuteTraitementReservation;
var FListCentrale  : TListGENTYPEMAIL;
    i : integer ;
    MaCFG          : TCFGMAIL;
    bAutorisation, bDoreservation, bDotraitement, bResaok : boolean ;
    bAnnulok : boolean ;
    lSearchRecord  : TSearchRec;
    s : string ;

begin
  // fonction r�cup�r�e de Ginkoia
  trclog('1Entr�e dans la proc�dure de traitement');

  //PDB
  try
  try
  //

  With Dm_Reservation do
  Begin
    MemD_Rap.Close;
    MemD_Rap.Open;

  // r�pertoire temporaire pour r�cup�rer les fichiers
   GPATHMAILTMP := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'MailImportTmp\';
   trclog('1Cr�ation du r�pertoire temporaire pour r�cup�rer les fichiers');
   ForceDirectories(GPATHMAILTMP);

   trclog('1R�cup�ration de la liste des centrales');
   FListCentrale := dm_reservation.GetListCentrale ;

   cpt_centrale:=FListCentrale.count; //TWGS
   trclog('1Boucle sur les centrales (Nbre.='+inttostr(FListCentrale.count)+')');
      for I := 0 to FlistCentrale.Count-1  do
       begin
          iId_centrale:=FListCentrale.Items[i].MTY_ID; //TWGS
          sNom_centrale:=FListCentrale.Items[i].MTY_NOM;
          trclog('1Centrale "'+FListCentrale.Items[i].MTY_NOM+'" (ID='+inttostr(FListCentrale.Items[i].MTY_ID)+')');
          trclog('1------------------------------------------');
          //Fmain.oLogfile.Addtext('Centrale "'+FListCentrale.Items[i].MTY_NOM+'"');
          dm_reservation.PosID := FPostid;
          case FListCentrale.Items[i].MTY_MULTI of
            // poste r�f�rant uniquement
            0: bAutorisation := (FPostID = GetPostReferantId);
            // magasin uniquement
            1: bAutorisation := IsMagAutorisation(FListCentrale.Items[i].MTY_ID,FMagID, FPostID);
          end;

          //bAutorisation:=true; //SK7 forc�

         if bAutorisation then
          begin
           trclog('1Autorisation OK');

           //SKISET
           if FListCentrale.Items[i].MTY_CODE='RS7' then begin
             trclog('1Traitement SKISET WebService');
             bok_sk7:=true;

             trclog('1Lecture du fichier '+extractFilePath(application.exename)+'RIM.INI');
             //Normallement le fichier INI existe touours car si inexistant il est cr�� au d�marrage de GINKOIA
             s:=extractFilePath(application.exename)+'RIM.INI';
             if fileexists(s) then begin

               RimIni:=TIniFile.Create(s);

               if RimIni.SectionExists('SKISET') then begin

                 sdate_begin:=trim(lowercase(RimIni.ReadString('SKISET','date_begin','')));
                 sdate_end:=trim(lowercase(RimIni.ReadString('SKISET','date_end','')));
                 RimIni.Free;
                 if (sdate_begin<>'') and (sdate_end<>'') then begin

                   GetLocaleFormatSettings(SysLocale.DefaultLCID,FSetting);
                   FSetting.ShortDateFormat := 'YYYY-MM-DD';
                   FSetting.ShortTimeFormat:='HH:NN:SS';
                   FSetting.DateSeparator := '-';
                   FSetting.TimeSeparator:=':';

                   bok_date_begin:=true;
                   bok_date_end:=true;

                   //date_begin
                   if pos('today',sdate_begin)>0 then begin
                     ddate_begin:=now;
                     if pos('today+',sdate_begin)>0 then begin
                       s:=copy(sdate_begin,7);
                       try
                         idecal:=strtoint(s);
                         ddate_begin:=incday(now,idecal);
                       except
                         bok_date_begin:=false;
                       end;
                     end;
                     if pos('today-',sdate_begin)>0 then begin
                       s:=copy(sdate_begin,7);
                       try
                         idecal:=strtoint(s);
                         ddate_begin:=incday(now,-idecal);
                       except
                         bok_date_begin:=false;
                       end;
                     end;
                   end
                   else begin
                     try
                       ddate_begin:=strtodate(sdate_begin,fsetting);
                     except
                       bok_date_begin:=false;
                     end;
                   end;

                   if not bok_date_begin then begin
                     trclog('1La date de d�but de p�riode est incorrecte ('+sdate_begin+'). Traitement abandonn�.');
                     bok_sk7:=false;
                   end;

                   if bok_sk7 then begin

                     //date_end
                     if pos('today',sdate_end)>0 then begin
                       ddate_end:=now;
                       if pos('today+',sdate_end)>0 then begin
                         s:=copy(sdate_end,7);
                         try
                           idecal:=strtoint(s);
                           ddate_end:=incday(now,idecal);
                         except
                           bok_date_end:=false;
                         end;
                       end;
                       if pos('today-',sdate_end)>0 then begin
                         s:=copy(sdate_end,7);
                         try
                           idecal:=strtoint(s);
                           ddate_end:=incday(now,-idecal);
                         except
                           bok_date_end:=false;
                         end;
                       end;
                     end
                     else begin
                       try
                         ddate_end:=strtodate(sdate_end,fsetting);
                       except
                         bok_date_end:=false;
                       end;
                     end;

                     if not bok_date_end then begin
                       trclog('1La date de fin de p�riode est incorrecte ('+sdate_end+'). Traitement abandonn�.');
                       bok_sk7:=false;
                     end;

                     if bok_sk7 then begin
                       if ddate_end<ddate_begin then begin
                         trclog('1La date de fin de p�riode est inf�rieure � la date de d�but. Traitement abandonn�.');
                         bok_sk7:=false;
                       end;
                     end;

                   end;
                 end
                 else begin
                   trclog('1Les dates de d�but et/ou de fin ne sont pas sp�cifi�es. Traitement abandonn�.');
                   bok_sk7:=false;
                 end;

               end
               else begin
                 trclog('1La section SKISET n''existe pas dans le fichier INI. Traitement abandonn�.');
                 bok_sk7:=false;
               end;

             end
             else begin
               trclog('1Fichier RIM.INI absent. Traitement abandonn�.');
               bok_sk7:=false;
             end;

             //Si p�riode valide
             if bok_sk7 then begin
               trclog('1P�riode valide du '+sdate_begin+' au '+sdate_end);
               CreateResaSki7(FListCentrale.Items[i], ddate_begin, ddate_end)
             end;

           end

           else begin
             trclog('1Traitement classique Email');

             MaCFG := dm_reservation.GetMailCFG(FListCentrale.Items[i]);
             trclog('1V�rification des mails de la centrale en cours (n�='+inttostr(AnsiIndexStr(FListCentrale.Items[i].MTY_NOM,[CTWINNER,CINTERSPORT,CSKIMIUM,CSPORT2K,CGENE1,CGENE2,CGENE3,CGOSPORT]))+')');
             // 2- V�rification des mails de la centrale en cours
             // Cxxxxx correspondent � des constantes qui sont l'identique du nom dans la base de donn�es
             // De la table GENTYPEMAIL
             case AnsiIndexStr(FListCentrale.Items[i].MTY_NOM,[CTWINNER,CINTERSPORT,CSKIMIUM,CSPORT2K,CGENE1,CGENE2,CGENE3,CGOSPORT]) of
               0,7: begin
                    trclog('1Twinner,GoSport');
                    bDoReservation := GenerateTwinnerMailList(FListCentrale.Items[i],MaCFG); // Twinner et GoSport
                  end ;
               1: begin
                    trclog('1InterSport');
                    bDoReservation := GenerateISMailList(FListCentrale.Items[i],MaCFG); // Intersport
                  end ;
               2: begin
                   trclog('1Skimium');
                   bDoReservation := GenerateSkmMailList(FListCentrale.Items[i],MaCFG); // Skimium
                  end ;
               3: begin
                    trclog('1Sport2000');
                    bDoReservation := GenerateSport2kMailList(FListCentrale.Items[i],MaCFG); // Sport2000
                  end ;
               4,5,6 : begin
                 trclog('1G�n�rique');
                 bDoReservation := GenerateGENMailList(FListCentrale.Items[i],MaCFG); // Gen1, Gen2,Gen3
               end;
               else
                 trclog('1Aucune centrale ne correspond -> Abandon de la procedure');
                 // 'Aucune centrale trouv�e', 'Erreur'
                 ologfile.Addtext(RS_ERR_RESMAN_NOCENTRALE);
                     // affichage message
                 ShowmessageRS('Aucune centrale trouv�e', 'Erreur');

                 Exit;
             end;   // encase

             // Si il n'y a pas eu de soucis avec la validation des mails de la centrale on passe � la suite
             if bDoReservation then
             begin
               trclog('1Validation des mails ok -> traitement des r�servations de la centrale');
               // 3- Traitement des r�servations de la centrale en cours
               case AnsiIndexStr(FListCentrale.Items[i].MTY_NOM,[CTWINNER,CINTERSPORT,CSKIMIUM,CSPORT2K,CGENE1,CGENE2,CGENE3,CGOSPORT]) of
                 0,7: bDoTraitement := ExecuteTwinnerDoTraitement(FListCentrale.Items[i]); // Twinner-GoSport
                 1: bDoTraitement := True; // Intersport - Sera v�rifi� et trait� en m�me temps que l'int�gration
                 2: bDoTraitement := ExecuteSkmDoTraitement(FListCentrale.Items[i],MaCFG); // Skimium
                 3: bDoTraitement := ExecuteSport2KDoTraitement(FListCentrale.Items[i],MaCFG); // Sport2000
                 4,5,6: bDoTraitement := ExecuteGENDoTraitement(FListCentrale.Items[i],MaCFG); // Gen1, Gen2,Gen3
               end;

               // Si le traitement des r�servations c'est bien pass� alors on va les int�grer
               if bDoTraitement then
               begin
                 trclog('1Traitement des r�servations -> int�gration des r�servations');
                 // 4- Int�gration des R�servations dans la base de donn�es
                 case AnsiIndexStr(FListCentrale.Items[i].MTY_NOM,[CTWINNER,CINTERSPORT,CSKIMIUM,CSPORT2K,CGENE1,CGENE2,CGENE3,CGOSPORT]) of
                   0,2,3,4,5,6,7: bResaOk := CreateResa(FListCentrale.Items[i]); //Twinner, Skimium, Sport2k, Gen1,Gen2, Gen3
                   1: bResaOk := DoCreateReservationIS(FListCentrale.Items[i],MaCFG); // Intersport
                 end;

                 // 5- Traitement des annulations
                 trclog('1Int�gration des annulations');
                 case AnsiIndexStr(FListCentrale.Items[i].MTY_NOM,[CTWINNER,CINTERSPORT,CSKIMIUM,CSPORT2K,CGENE1,CGENE2,CGENE3,CGOSPORT]) of
                   2,3,4,5,6: bAnnulOk := AnnulResa; // Sport2000, Skimium, Gen1, Gen2, Gen3
                   else
                     bAnnulOk := True;
                 end; // case annulation

                 // 6- Archivage des mails
                 // Archivage si l'int�gration et/ou l'annulation des r�servations c'est bien faite et si on a une adresse d'archivage
                 if bResaOk and bAnnulOk and (MaCFG.PBT_ADRARCH <> '') then
                 begin
                    trclog('1Archivage des mails');
                   // traitement des mails � archiver
                    case AnsiIndexStr(FListCentrale.Items[i].MTY_NOM,[CTWINNER,CINTERSPORT,CSKIMIUM,CSPORT2K,CGENE1,CGENE2,CGENE3,CGOSPORT]) of
                      1: ArchiveMailIS(FListCentrale.Items[i],MaCFG); // intersport
                      else begin
                        ArchivMail(FListCentrale.Items[i],MaCFG);
                      end;
                     end ;
                  end; // bresaok...
                 end// bDotraitement
                 else trclog('1Traitement des r�servations s''est mal d�roul�, pas d''int�gration possible');
               end  // bDoreservation

               else begin
               trclog('1La validation des mails a �chou� -> aucun traitement');
                // ' : De nouvelles offres commerciales ont �t� cr��es, veuillez les mettre � jour', 'Informations'
              //  InfoMessHP(ParamsStr(RS_TXT_RESMAN_NEWOFFRE, FListCentrale.Items[i].MTY_NOM),True,0,0,RS_TXT_RESMAN_INFO);
              if fmain.Ferrorconnect = False then
               begin
                // ce n'est pas une erreur de connexition
                s := ParamsStr(RS_TXT_RESMAN_NEWOFFRE, FListCentrale.Items[i].MTY_NOM) ;
                fmain.ologfile.Addtext(s) ;
                    // affichage message
                ShowmessageRS(ParamsStr(RS_TXT_RESMAN_NEWOFFRE, FListCentrale.Items[i].MTY_NOM),RS_TXT_RESMAN_INFO );
               end;
                Exit;
               end // else
           end; // SK7
          end  // if bAutorisation
          else trclog('1Pas d''autorisation -> aucun traitement');
       end; // for

       // 7- Suppression des fichiers du r�pertoire temporaire
       trclog('1Suppression des fichiers du r�pertoire temporaire');
       i := FindFirst(GPATHMAILTMP + '*.*',faAnyFile,lSearchRecord);
       try
         while i = 0  do
         begin
           trclog('1Fichier "'+GPATHMAILTMP + ExtractFileName(lSearchRecord.Name)+'"');
           DeleteFile(GPATHMAILTMP + ExtractFileName(lSearchRecord.Name));
           i := FindNext(lSearchRecord);
         end;
       finally
         FindClose(lSearchRecord);
       end;

       // Affichage du rapport

      //   if Dm_Reservation.MemD_Rap.RecordCount > 0 then
        //          Dm_Reservation.LK_Rap.Execute

       //else
      // begin
         // 'Pas de nouvelle r�servation' , 'Informations'
        // InfoMessHP(RS_TXT_RESMAN_NONEWRESA,True,0,0,RS_TXT_RESMAN_INFO);
        // ologfile.Addtext(RS_TXT_RESMAN_NONEWRESA );
       //  ShowmessageRS(RS_TXT_RESMAN_NONEWRESA ,RS_TXT_RESMAN_INFO);
      // end ;

  end; // fin de with..do

  //pdb
  except
    on e:exception do trclog('XErreur dans la procedure de traitement : '+e.message);
  end;
  finally
    trclog('1Sortie de la proc�dure de traitement');
  end;
  //
end;


procedure TFmain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canclose := false ;
  uLog.Log.Close;  //ULOG
  windowstate := wsMinimized ;
  application.processmessages ;
end;

procedure TFmain.FormCreate(Sender: TObject);
var sId : string ;
begin

    Decimalseparator := '.' ;
    Ferrorconnect := false ;
    Memo_Mess.Caption := RS_VERIF_MAIL ;
    FAuto := false ;
    if oLogfile = nil then
      oLogfile := Tlogfile.Create(False);

    // transforme params en integer 
    sId := Paramstr(3) ;
    Try
     FPostid := StrToInt(sid) ;
    Except
     Fpostid := 0 ;
    End;

    sId := Paramstr(4) ;
    Try
     FMagid := StrToInt(sid) ;
    Except
     FMagid := 0 ;
    End;

    if Paramstr(1) = '/A' then
     begin
       WindowState := wsMinimized ;
     end;

    //PDB
    itrc:=0;
    if paramstr(paramcount)='debug1' then itrc:=1
    else if paramstr(paramcount)='debug2' then itrc:=2
    else if paramstr(paramcount)='debug3' then itrc:=3;
    itrc:=3; //pour le moment on force � 3
    trclog('1Niveau de tracing = '+inttostr(itrc));
    //
end;

Procedure  TFmain.ArchivMail(MaCentrale : TGENTYPEMAIL;MaCFG : TCFGMail);
const
  Retry = 3;
var
  Count : integer ; // pour tester les essais
  iNbMess, i, j : Integer;
  IdSMTP : TSmtpClient ;
  lstRep, lstMailBox : TStringList;
  s : string ;
  IMAP4 : IMAP4Class;
begin
  // On sort quand on est en algol
  if FAlgol then begin
    main.trclog('1Mode Algol -> par d''archivage');
    Exit;
  end;

  try //PDB

  IMAP4 := IMAP4Class.Create(MaCfg.PBT_SERVEUR,MaCfg.PBT_ADRPRINC,MaCfg.PBT_PASSW,MaCfg.PBT_PORT,True);
  IMAP4.PGStatus3D := Fmain.Gge_A;
  lstRep := TStringList.Create;
  lstMailBox := TStringList.Create;
  With Dm_Reservation do
  Try
    //raise Exception.Create('Erreur volontaire dans archivage');
    {$REGION 'Tentative de connexion'}
    Count := 0;
    Repeat
      try
        Inc(Count) ;
        IMAP4.Connect;
        //Plus utile car email identique  Fmain.oLogfile.Addtext(Format(RS_CONNEXION_OK_LOG, [MaCentrale.MTY_NOM]));
        break ;
      Except on E:Exception do
        begin
          if Count = Retry then
          begin
            Fmain.Ferrorconnect := True ;
            Fmain.oLogfile.Addtext(Format(RS_ERREUR_CONNEXION_LOG, [MaCentrale.MTY_NOM, Count, Retry, E.ClassName, E.Message]));
            Fmain.ShowmessageRS(Format(RS_ERREUR_CONNEXION_DLG, [MaCentrale.MTY_NOM, E.ClassName, E.Message]), 'Erreur');
            Exit;
          end
          else begin
            Sleep(Dm_Reservation.DelaisEssais);
          end;
        end;
      end;
    Until Retry=Count;
    {$ENDREGION}

   lstMailBox := IMAP4.MailboxList;
   With Que_IdentMagExist do
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
            lstRep.Text := StringReplace(Trim(FieldByName('IDM_PRESTA').AsString),';',#13#10,[rfReplaceAll]);
            for i := 0 to lstRep.Count - 1 do
            begin
              Fmain.InitGauge(Format('%s %d sur %d : Code %d/%d'#13#10'Analyse des mails pour archivage',[MaCentrale.MTY_NOM,RecNo,Recordcount,i + 1, lstRep.Count]),100);
              // Positionnement dans le r�pertoire (On passe � la suite s'il n'existe pas
              if not IMAP4.SelectMailBox('Reservation/' + Trim(lstRep[i])) then
                Continue;

              // R�cup�ration des mails du r�pertoire
              IMAP4.LoadAllMailBoxMsg;

              Fmain.InitGauge(Format('%s %d sur %d : Code %d/%d'#13#10'Archivage des mails en cours',[MaCentrale.MTY_NOM,RecNo,Recordcount, i+1, lstRep.Count]),100);
              for j := 0 to IMAP4.MsgList.Count - 1 do
              begin
                // recherche si le mail est � traiter
                if MemD_Mail.Locate('MailSubject;MailDate',VarArrayOf([IMAP4.MsgList[j].Subject,IMAP4.MsgList[j].Date]),[loCaseInsensitive]) then
                begin
                  // Doit on archiver le mail ?
                  if MemD_Mail.FieldByName('bArchive').AsBoolean then
                  begin
                    if lstMailBox.IndexOf('Archive/' + Trim(lstRep[i])) = -1 then
                    begin
                      IMAP4.CreateMailBox('Archive/' + Trim(lstRep[i]));
                      lstMailBox.Add('Archive/' + Trim(lstRep[i]));
                    end;

                    IMAP4.MoveMsg(j + 1,'Archive/' + Trim(lstRep[i]));
                  end;
                end;

                Fmain.Gge_A.Progress := (j + 1) * 100 DIV (IMAP4.MsgList.Count);
                FMain.Refresh;
              end; // for j
              IMAP4.ValidMoveMsg;
            end; // for i
          end; // if
         Next;
       end; // while
     end; // if
   end; // With

  //PDB
  except
    on e:exception do main.trclog('XErreur dans la procedure ArchivMail : '+e.message);
  end;
  Finally
    lstMailBox.Free;
    lstRep.Free;
    IMAP4.Free;
  End;



//  Account := TAccount.Create(MaCfg.PBT_ADRPRINC,MaCfg.PBT_PASSW,'');
//  With Account do
//   begin
//     Port := MaCfg.PBT_PORT ;
//     Host := MaCfg.PBT_SERVEUR
//   end;
//
//  IdPop := Tpop3Client.Create(Account, True); // connection True = avec SSL
//
//  SMTPAccount := TAccount.Create(MaCfg.PBT_ADRPRINC,MaCfg.PBT_PASSW,'');
//  With SMTPAccount do
//   begin
//     Port := MaCfg.PBT_PORTSMTP ;
//     Host := MaCFG.PBT_SMTP ;
//   end;
//
//  IdSMTP := TSmtpClient.Create(SMTPAccount);
//  Count := 0 ;
//  Repeat
//    Try
//     inc(Count) ;
//     IdSMTP.Connect ;
//     Break ;
//    Except on E:Exception do
//     begin
//     if Count=Retry then
//        begin
//        // ' : Erreur lors de la connexion avec le serveur de mail', 'Erreur POP3'
//       // InfoMessHP(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM) + #13#10 + E.Message,True,0,0,RS_ERR_RESMAN_ERRORPOP3);
//        ologfile.Addtext(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM)+' '+E.Message);
//        Fmain.ShowmessageRS(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM) + #13#10 + E.Message,RS_ERR_RESMAN_ERRORPOP3 );
//        Exit;
//        end;
//     end;
//    End;
//  Until Retry=Count ;
//
//  
//  IdMess := TIdMessage.Create(Dm_Reservation);
//  lst := TStringList.Create;
//
//
//
//
//  With Dm_Reservation do
//  try
//    With IdPop do
//    begin
//      PrepareUserPass ;// connection SSL en mode user pass
//      Count := 0 ;
//      Repeat
//      try
//        Inc(Count) ;
//        if Connected = False then
//           Connect;
//        break ;
//      Except on E:Exception do
//        begin
//         if Count=Retry then
//          begin
//          // ' : Erreur lors de la connexion avec le serveur de mail', 'Erreur POP3'
//         // InfoMessHP(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM) + #13#10 + E.Message,True,0,0,RS_ERR_RESMAN_ERRORPOP3);
//          ologfile.Addtext(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM)+' '+E.Message);
//          ShowmessageRS(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM) + #13#10 + E.Message,RS_ERR_RESMAN_ERRORPOP3 );
//          Exit;
//          end;
//        end;
//      end; // with idpop
//      Until  Retry=Count  ;
//    end;  // with
//
//    iNbMess := Idpop.CheckMessages;
//    // ' : V�rification des mails pour Archivage'
//    //InitGaugeMessHP (ParamsStr(RS_TXT_RESMAN_VERIFMAILARCHIV,MaCentrale.MTY_NOM), iNbMess + 1, true, 0, 0, '', false) ;
//
//    InitGauge(ParamsStr(RS_TXT_RESMAN_VERIFMAILARCHIV,MaCentrale.MTY_NOM),  iNbMess+1);
//    for i := iNbMess downto 1  do
//    begin
//       UpdateGauge ;
//      // r�cup�ration du header du mail (plus rapide pour un traitement en surface)
//      IdPop.Pop3.RetrieveHeader(i,IdMess);
//      // Est ce que le mail se trouve dans la liste des mails � traiter
//      if MemD_Mail.Locate('MailSubject',IdMess.Subject,[])  then
//      begin
//        // doit on archiver le mail ?
//        if MemD_Mail.FieldByName('bArchive').AsBoolean then
//        begin
//          With IdSMTP do
//          begin
//            Count := 0 ;
//            Repeat
//              Try
//                 Inc(Count) ;
//                 if Connected = false then
//                   Connect;
//                 break ;
//              Except on E:Exception do
//                begin
//                 if Retry=Count then
//                  begin
//                   // ' : Erreur lors de la connexion avec le serveur de mail', 'Erreur SMTP'
//                   // InfoMessHP(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM) + #13#10 + E.Message,True,0,0,RS_TXT_RESMAN_ERRORSMTP);
//                   ologfile.Addtext(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM)+' '+E.message);
//                      ShowmessageRS(ParamsStr(RS_ERR_RESCMN_CNXMAILERROR, MaCentrale.MTY_NOM) + #13#10 + E.Message, RS_TXT_RESMAN_ERRORSMTP);
//
//                   Exit;
//                  end;
//                end;
//              end;
//            Until Retry=Count ;
//           end;
//
//           // R�cup�ration du mail en entier
//           // Gestion de Twinner sp�cifique
//           if MaCentrale.MTY_CODE = 'RTW' then
//           begin
//            {$REGION '<---- cliquez sur le + et lire avant de modifier le code ci dessous'}
//            // La sauvegarde du fichier sur le disc dur + le traitement ne doivent pas �tre modifi�s
//            // car les mails transmis par twinner ont des soucis de format qui sont corrig�s
//            // Par l'utilisation de la sauvegarde tempporaire + nettoyage du mail.
//            {$ENDREGION}
//            IdMess.NoEncode := True;
//            IdMess.NoDecode := True;
//            IdPop.Pop3.Retrieve(i,IdMess);
//
//            IdMess.SaveToFile(GPATHMAILTMP + 'ArchTmp.txt');
//
//            lst.LoadFromFile(GPATHMAILTMP + 'ArchTmp.txt');
//            lst.Text := StringReplace(lst.Text,#13#13#10,#13#10,[rfReplaceAll]);
//            lst.SaveToFile(GPATHMAILTMP + 'ArchTmpb.txt');
//
//            IdMess.NoEncode := False;
//            IdMess.NoDecode := False;
//            IdMess.LoadFromFile(GPATHMAILTMP + 'ArchTmpb.txt');
//           end else
//            IdPop.Pop3.Retrieve(i,IdMess);
//            Count := 0 ;
//            Repeat
//            try
//              // changement de l'adresse de l'envoyeyr et du destinataire
//              Inc(Count) ;
//              idMess.Sender.Address := idSmtp.Smtp.Username ;
//              IdMess.Recipients.EMailAddresses := MaCFG.PBT_ADRARCH;
//              IdMess.From.Address :=   idSmtp.Smtp.Username ;
//              // transfert du mail- en mode algol non
//              if FAlgol = false then
//                IdSMTP.Send(IdMess);
//              Break ;
//            Except on E:Exception do
//              begin
//                if Retry = Count then
//                begin
//                // ' : Erreur lors du transfert d''un mail', 'Erreur SMTP'
//                //InfoMessHP(ParamsStr(RS_ERR_RESMAN_MAILTRANSERROR,MaCentrale.MTY_NOM) + #13#10 + E.Message,True,0,0,RS_TXT_RESMAN_ERRORSMTP);
//                ologfile.Addtext(ParamsStr(RS_ERR_RESMAN_MAILTRANSERROR,MaCentrale.MTY_NOM)+' '+E.Message) ;
//                ShowmessageRS(ParamsStr(RS_ERR_RESMAN_MAILTRANSERROR,MaCentrale.MTY_NOM)+#13#10 + E.Message,RS_TXT_RESMAN_ERRORSMTP );
//                 Exit;
//                end;
//              end;
//            end;
//            Until Retry = Count;
//             // Si l'envoi se passe bien alors on va supprimer le mail dans la boite reservation.xxx@ginkoia.fr
//             // en mode algol on ne supprime pas le message
//             if FAlgol = False then
//              begin
//                if not IdPop.Pop3.Delete(i) then
//                begin
//                  // 'Impossible de supprimer un mail', 'Erreur Pop3'
//                  //InfoMessHP(RS_ERR_RESMAN_DELERROR,True,0,0,RS_ERR_RESMAN_ERRORPOP3);
//                  ologfile.Addtext(RS_ERR_RESMAN_DELERROR+' '+idMess.Subject);
//                  ShowmessageRS(RS_ERR_RESMAN_DELERROR,RS_ERR_RESMAN_ERRORPOP3);
//                   Exit;
//                end;
//              end;
//          end; // with
//        end;
//      end;
//      // resert de la gauge
//      ResetGauge ;
//  finally
//    IdPop.Free;
//    IdMess.Free;
//    IdSMTP.Free;
//    lst.free;
//    IdPop := nil ;
//    IdMess := nil ;
//    IdSmtp := nil ;
//    lst := nil ;
//  end;
end;


// kes fonction de gestion de la barre de progression et des messages ne sont
// ex�cut�es qu'en mode manuel

procedure TFmain.UpdateGauge;
begin
//  if Fauto = True then exit ;
  Gge_A.Progress := Gge_A.Progress+1 ;
  application.processmessages ;
end;

Procedure TFmain.InitGauge(sMessage : string ;MaxValue: Integer);
begin
//    if Fauto = True then exit ;
    Memo_Mess.caption := sMessage ;
    Memo_Mess.Update ;
    Gge_A.MaxValue := MaxValue;
    Gge_A.Progress := 0 ;
    Gge_A.Update ;
    Application.ProcessMessages;
end;

procedure TFmain.ResetGauge;
begin
  //  if Fauto = True then exit ;
    Gge_A.Progress := 0 ;
    Gge_A.MaxValue := 0 ;
    Gge_A.Update ;
end;


procedure TFmain.ShowmessageRS(sMessage, sTitle: string);
var bNeedToDisplay : boolean;
begin
 //if Fauto = True then exit ;

 Try
   bNeedtoDisplay := visible ;
   if visible then Hide ;
   Application.CreateForm(TFmessagebox, Fmessagebox);
   Fmessagebox.Caption := sTitle ;
   Fmessagebox.Memo_Mess.Caption := sMessage ;
   Fmessagebox.ShowModal ;
 Finally
   if bNeedToDisplay then Show;
   Fmessagebox.Release ;
   Fmessagebox := nil ;
 End;
   
end;

end.
