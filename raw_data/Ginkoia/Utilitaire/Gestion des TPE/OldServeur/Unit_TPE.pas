//*****************************************************************************
//$Archive:   P:/Projets/Paquets/ComposantsV8/Unit_TPE.pav  $
//$Revision: 1$
//*****************************************************************************
//$Log:
// 1    Utilitaires1.0         02/03/2012 16:22:52    Christophe HENRAT 
//$
//
//   Rev 1.5   26 Oct 2001 09:03:44   MEREU
//Correction de la proc�dure "TRANSReceive"
//car les code r�ponse de INGENICO ne sont 
//pas les m�mes que CKD
//
//   Rev 1.4   01 Mar 2001 17:19:08   RICHARD
// 
//
//   Rev 1.3   05 Jul 2000 10:00:58   RICHARD
//N�toyage
//
//   Rev 1.2   24 Mar 2000 16:37:54   RICHARD
//Correction drivers OPOS
//
//   Rev 1.1   24 Mar 2000 08:58:46   MEREU
//Suppression des param�tres
//sur la proc�dure "Execute"
//
//   Rev 1.0   23 Mar 2000 16:29:54   MEREU
//Gestion du TPE par les drivers
//Async Pro
//*****************************************************************************

Unit Unit_TPE;

INTERFACE

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OoMisc, AdPort,

  UCst_Tpe,
  Unit_StringUtils ;


Const
       LenLocalReply         = 34;  // Longueur du message en monnaie locale
       LenEuroReply          = 83;  // Longueur du message en monnaie euro
       LocalCode             = 250; // Code de la monnaie locale
       EuroCode              = 978; // Code de la monnaie euro
       vInNbEssai            = 3;   // Nombre de r�-essai avant coupure du dialogue
       vInTimeOut            = 2;   // Nombre de secondes de TimeOut

       TrSucessFull          = -1;
       TrErrorTimeOut        =  0;
       TrErrorNak            =  2;
       TrManual              =  3;
       TrTPEDenied           =  4;

       TPaymentModeChars     : Array [TPaymentMode]   Of Char    = ('0','1','2'); // TPE Standard : "0":Carte ; "2":Ch�que ; "1":Ind�termin�
       TEuroPaymentModeChars : Array [TPaymentMode]   Of Char    = ('1','0','C'); // TPE Euro     : "1":Carte ; "C":Ch�que ; "0":Ind�termin�
       TPaymentStyleValues   : Array [TPaymentDevise] Of Integer = (LocalCode,EuroCode);

Type
       // Classe de gestion du Terminal Point Encaissement ( T.P.E )
       TDtmTPE = Class( TComponent )
       Private
          fApdComPort  : TApdComPort    ;
          fParity      : TParity        ;
          fComNumber   : Word           ;
          fStopbits    : Word           ;
          fDataBits    : Word           ;
          fBaud        : LongInt        ;
          fTrace       : Boolean        ;
          fFichier     : String         ;
          fStationNum  : Integer        ;
          fAmount      : Currency       ;
          fStyle       : TPaymentStyle  ;
          fDevise      : TPaymentDevise ;
          fMode        : TPaymentMode   ;
          fTPEResult   : Integer        ;
          fManualTrans : Boolean        ;

          fEnqReceive  : Boolean        ;
          fRepReceive  : Boolean        ;
          fEotReceive  : Boolean        ;

          Procedure InitApdComponent;

          Function  TPEAskTransaction   : String;
          Function  EndTransactionByTPE : Boolean;
          Function  ENQReceive          : Boolean;
          Function  TRANSReceive        : Boolean;
          Function  EOTReceive          : Boolean;
          Procedure EnvoiChaine    ( vStString : String );
          Function  CalculCheckSum ( vStString : String ) : Integer;
          Function  AttenteReponse ( vStString : String ) : Integer;

          Procedure SetStyle     ( aValue : TPaymentStyle  );
          Procedure SetDevise    ( aValue : TPaymentDevise );
       Public
            Constructor Create( aOwner : TComponent ); OverRide;
            Destructor  Destroy;                       OverRide;

            Function    TPEConnecte : Boolean;

            Procedure   Execute;
       Published
            // Com
            Property DataBits   : Word          Read fDatabits   Write fDataBits   Default adpoDefDatabits;
            Property Parity     : TParity       Read fParity     Write fParity     Default adpoDefParity;
            Property ComNumber  : Word          Read fComNumber  Write fComNumber  Default adpoDefComNumber;
            Property StopBits   : Word          Read fStopbits   Write fStopbits   Default adpoDefStopbits;
            Property BaudRate   : LongInt       Read fBaud       Write fBaud       Default adpoDefBaudRt;

            // Fonctionnel
            Property StationNum  : Integer        Read fStationNum  Write fStationNum  Default 0;
	          Property Amount      : Currency       Read fAmount      Write fAmount;                       // Montant de la transaction
            Property Mode        : TPaymentMode   Read fMode        Write fMode        Default pmCheck;  // Mode de paiement : Carte ou Ch�que
	          Property Style       : TPaymentStyle  Read fStyle       Write SetStyle     Default psLocal;  // psLocal : Ancien TPE ( Francs uniquement ) , psEuro : TPE compatible Euro ( Euro / Francs )
            Property Devise      : TPaymentDevise Read fDevise      Write SetDevise    Default pmFrancs; // pour le TPE Euro : Le montant est exprim� en francs ou euro
            Property ManualTrans : Boolean        Read fManualTrans Write fManualTrans Default False;    // Passer en transaction manuelle

            // Trace sur fichier !!!
            Property Trace      : Boolean Read fTrace      Write fTrace     Default False;
            Property Fichier    : String  Read fFichier    Write fFichier;

            Property TPEResult  : Integer       Read fTPEResult;
       End;


IMPLEMENTATION


//============================================================================
// Nom      : GetTPEEuroPaymentMode
// Objet    : Retrouver le mode de paiement suivant aCar
// Cr�ation : 23/03/00 ( F.M )
// Entr�e   :
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function GetTPEEuroPaymentMode( aChar : Char ) : TPaymentMode;
Var vIn : TPaymentMode;
Begin
    Result := High( TPaymentMode );
    For vIn := Low( TPaymentMode ) To High( TPaymentMode ) Do
      If aChar = TEuroPaymentModeChars[ vIn ] Then
      Begin
          Result := vIn;
          Break;
      End;
End;
//============================================================================
// Nom      : GetTPEPaymentMode
// Objet    : Retrouver le mode de paiement suivant aCar
// Cr�ation : 23/03/00 ( F.M )
// Entr�e   :
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function GetTPEPaymentMode( aChar : Char ) : TPaymentMode;
Var vIn : TPaymentMode ;
Begin
    Result := high(TPaymentMode);
    For vIn := Low( TPaymentMode ) To High( TPaymentMode ) Do
      If aChar = TPaymentModeChars[ vIn ] Then
      Begin
          Result := vIn;
          Break;
      End;
End;




//============================================================================
// Nom      : InitApdComponent
// Objet    : Initialiser les propri�t�s du composant  RS232
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Procedure TDtmTPE.InitApdComponent;
Begin
    fApdComPort.ComNumber := fComNumber;
    fApdComPort.Baud      := fBaud;
    fApdComPort.Parity    := fParity;
    fApdComPort.DataBits  := fDatabits;
    fApdComPort.StopBits  := fStopbits;
    fApdComPort.TraceName := fFichier;
    If fTrace Then fApdComPort.Tracing := tlOn
              Else fApdComPort.Tracing := tlOff;
End;
//============================================================================
// Nom      : Create
// Objet    : Constructor de l'objet
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Constructor TDtmTPE.Create( aOwner : TComponent );
Begin
    Inherited Create( aOwner );

    fParity      := pEven    ;
    fComNumber   := adpoDefComNumber ;
    fStopbits    := 1  ;
    fDatabits    := 7  ;
    fBaud        := 1200    ;
    fTrace       := False            ;
    fFichier     := 'C:\TRACETPE.TXT';
    fStationNum  := 0                ;
    fAmount      := 0                ;
    fStyle       := psLocal          ;
    fDevise      := pmFrancs         ;
    fMode        := pmCheck          ;
    fTPEResult   := TrSucessFull     ;
    fManualTrans := False            ;

    fApdComPort          := TApdComPort.Create( NIL );
    fApdComPort.AutoOpen := False;
    InitApdComponent;
End;
//============================================================================
// Nom      : Destroy
// Objet    : Destructor de l'objet
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Destructor TDtmTPE.Destroy;
Begin
    fApdComPort.Free;

    Inherited Destroy;
End;
//============================================================================
// Nom      : SetStyle
// Objet    : Contr�le de la propri�t� " Style "
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Procedure TDtmTPE.SetStyle( aValue : TPaymentStyle );
Begin
    If aValue <> fStyle Then
    Begin
        fStyle := aValue;
        If ( fStyle = psLocal ) And ( fDevise = pmEuro ) Then
          fDevise := pmFrancs;
    End;
End;
//============================================================================
// Nom      : SetDevise
// Objet    : Contr�le de la propri�t� " Devise "
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Procedure TDtmTPE.SetDevise( aValue : TPaymentDevise );
Begin
    If aValue <> fDevise Then
    Begin
        If ( fStyle = psEuro ) Or ( (fStyle = psLocal) And (aValue = pmFrancs) ) Then
          fDevise := aValue;
    End;
End;
//============================================================================
// Nom      : CalculCheckSum
// Objet    : Calculer la CheckSum d'une chaine de caract�re � envoyer
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   : Result : La CheckSum
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function TDtmTPE.CalculCheckSum( vStString : String ) : Integer;
Var i : Integer;
Begin
    Result := 0;
    For i := 1 To Length( vStString ) Do
      Result := Result XOR ( Ord( vStString[ i ] ) );
End;
//============================================================================
// Nom      : TPEAskTransaction
// Objet    : Transaction � envoyer au TPE
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   : Result : la chaine � envoyer
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function TDtmTPE.TPEAskTransaction : String;
Var vInCheckSum : Integer;
Begin
    Result := '';
    Case fStyle Of
       // TPE Standard
       psLocal : Result := FillString(IntToStr(fStationNum)       ,'0' ,TaRightJustify,2) +
                           FillString(IntToStr(Trunc(fAmount*100)),'0' ,TaRightJustify,8) +
                           TPaymentModeChars[fMode]                                       +
                           cEtx;
       // TPE Compatible Euro
       psEuro  : Result := FillString(IntToStr(fStationNum)       ,'0' ,TaRightJustify,2) +
                           FillString(IntToStr(Trunc(fAmount*100)),'0' ,TaRightJustify,8) +
                           '1'                                                            +
                           TEuroPaymentModeChars[fMode]                                   +
                           '0'                                                            +
                           IntToStr( TPaymentStyleValues[ fDevise ] )                     +
                           StringOfChar(' ',10)                                           +
                           cEtx;
    End;
    vInCheckSum := CalculCheckSum( Result );
    Result      := cStx + Result + Chr(vInCheckSum);
End;
//============================================================================
// Nom      : EnvoiChaine;
// Objet    : Envoyer une chaine de caract�re sur le port COM
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   : vStString : Chaine � envoyer
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Procedure TDtmTPE.EnvoiChaine( vStString : String );
Begin
    // Vider les buffers
    fApdComPort.FlushInBuffer;
    fApdComPort.FlushOutBuffer;

    // Envoi de la chaine
    fApdComPort.Output := vStString;
End;
//============================================================================
// Nom      : AttenteReponse
// Objet    : On envoie une chaine de caract�re au TPE et on se met en attente
//            d'une r�ponse ack, nak ou timeout
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   : vStString  : Chaine � transmettre
// Sortie   : Result     : TrErrorTimeOut => Erreur de TimeOut
//                         TrSucessFull      => Ack Re�u
//                         TrErrorNak     => Nack Re�u
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function TDtmTPE.AttenteReponse( vStString : String ) : Integer;
Var vInTentative : Integer;
Begin
    Result       := TrErrorTimeOut;
    vInTentative := 1;
    // Envoi de vStString et mise en attente de ACK ou NAK
    EnvoiChaine( vStString );
    While ( vInTentative <= vInNbEssai ) And ( Result = TrErrorTimeOut ) Do
    Begin
        Result := fApdComPort.WaitForMultiString(cAck + '^' + cNak,Secs2Ticks(vInTimeOut),True,False,'^');
        Inc( vInTentative );
    End;
    Result := TrErrorTimeOut * Byte( Result = 0 ) +  // Erreur de TimeOut
              TrSucessFull   * Byte( Result = 1 ) +  // Ack re�u => c'est bon
              TrErrorNak     * Byte( Result = 2 ) ;  // Nak re�u => pas bon
End;
//============================================================================
// Nom      : TPEConnecte
// Objet    : Indique si le TPE est connect� au poste
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   : " Result := True " TPE Connect�
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function TDtmTPE.TPEConnecte : Boolean;
Begin
    // Initialiser les propri�t�s du composant " fApdComPort "
    InitApdComponent;
    // Ouvrir le port s�rie
    fApdComPort.Open := True;

    // Demande pour �mettre ( Envoi de ENQ ) et attente de r�ponse  => Le TPE est-il pr�sent ?
    Result := AttenteReponse( cEnq ) = TrSucessFull;
    // On envoie une fin d'�mission m�me en cas d'erreur
    EnvoiChaine( cEot );

    // Fermer le port s�rie
    fApdComPort.Open := False;
End;
//============================================================================
// Nom      : ENQReceive
// Objet    : on attend le ENQ sur la fin de transaction du TPE
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   : " Result := True " ENQ re�u sur la Fin de transaction
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function TDtmTPE.ENQReceive : Boolean;
Begin
    If  ( Not fEnqReceive  )
    And ( Not fManualTrans ) Then
    Begin
        fEnqReceive := fApdComPort.WaitForString( cEnq , Secs2Ticks(vInTimeOut),True,False);
        If fEnqReceive Then
          EnvoiChaine( cAck );
    End;
    Result := fEnqReceive;
End;
//============================================================================
// Nom      : EOTReceive
// Objet    : on attend le EOT sur la fin de transaction du TPE
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   : " Result := True " EOT re�u sur la Fin de transaction
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function TDtmTPE.EOTReceive : Boolean;
Begin
    If  ( Not fEotReceive  )
    And ( fEnqReceive      )
    And ( fRepReceive      )
    And ( Not fManualTrans )  Then
      fEotReceive := fApdComPort.WaitForString( cEot , Secs2Ticks(vInTimeOut),True,False);

    Result := fEotReceive;
End;
//============================================================================
// Nom      : TRANSReceive
// Objet    : on attend le message 'STX.....ETX' sur la fin de transaction du TPE
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   : " Result := True " Message re�u sur la Fin de transaction
//----------------------------------------------------------------------------
// 26/10/2001 ( F.MEREU ) : Il faut savoir que CKD en code r�ponse n'utilise
//                          que 0 et 7 alors que INGENICO utilise un code allant
//                          de 0 � 7.
//                          Code r�ponse Ok pour CKD      : 0
//                          Code r�ponse Ok pour INGENICO : 0 , 1 , 2 , 3
//----------------------------------------------------------------------------
Function TDtmTPE.TRANSReceive : Boolean;
Var c , CRC                : Char;
    vSt                    : String;
    ET                     : EventTimer;
    vBoEtxReceive , vBoFin : Boolean;
Begin
    If  ( Not fRepReceive  )
    And ( fEnqReceive      )
    And ( Not fManualTrans )  Then
    Begin
        vSt           := '';
        vBoFin        := False;
        vBoEtxReceive := False;

        // on attend : STX........ETX + CRC
        NewTimer( ET , Secs2Ticks(vInTimeOut) );
        Repeat
             fApdComPort.ProcessCommunications;
             If fApdComPort.CharReady Then
             Begin
                 c   := fApdComPort.GetChar;
                 vSt := vSt + c;
                 if Not vBoEtxReceive Then
                   vBoEtxReceive := c = cEtx;
             End;
             
             If Length(vSt) > 0 Then
               vBoFin := ( vBoEtxReceive ) And ( vSt[Length(vSt)] <> cEtx );

             Application.ProcessMessages;
        Until ( vBoFin ) Or ( TimerExpired(ET) ) Or ( fManualTrans );

        If vBoFin Then
        Begin
            CRC := vSt[Length(vSt)];
            Delete( vSt , Length(vSt) , 1 ); // Virer la CheckSum
            Delete( vSt , 1           , 1 ); // Virer le STX
            // Quel est la r�ponse du TPE ?
            If Not( vSt[3] In ['0','1','2','3'] ) Then
              fTPEResult := TrTPEDenied;
            // l'utilisateur peut changer de mode de r�glement
            Case fStyle Of
               psLocal : Mode := GetTPEPaymentMode     ( vSt[12] );
               psEuro  : Mode := GetTPEEuroPaymentMode ( vSt[12] );
            End;
            // l'utilisateur peut changer de montant
            Amount := StrToInt( Copy( vSt, 4, 6)  ) +
                      StrToInt( Copy( vSt, 10, 2) ) / 100 ;
            // R�sultat des courses ...
            fRepReceive := CRC = Chr( CalculCheckSum( vSt ) );
            If fRepReceive Then EnvoiChaine( cAck )
                           Else EnvoiChaine( cNak );
        End;
    End;
    Result := fRepReceive;
End;
//============================================================================
// Nom      : EndTransactionByTPE
// Objet    : on attend la fin de transaction du TPE
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   :
// Sortie   : " Result := True " Fin de transaction
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Function TDtmTPE.EndTransactionByTPE : Boolean;
Begin
    Result := ENQReceive And TRANSReceive And EOTReceive;
End;
//============================================================================
// Nom      : Execute
// Objet    : Envoyer la transaction au TPE ( Appel�e par le Front Office )
// Cr�ation : 22/03/00 ( F.M )
// Entr�e   : aAmount  : Montant de la transaction
//            aMode    : Mode de paiement : Carte ou Ch�que
//            aStyle   : psLocal : Ancien TPE ( Francs uniquement ) , psEuro : TPE compatible Euro ( Euro / Francs )
//            aDevise  : pour le TPE Euro : Le montant est exprim� en francs ou euro
// Sortie   :
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
Procedure TDtmTPE.Execute;  // pour le TPE Euro : Le montant est exprim� en francs ou euro
Begin
    fManualTrans := False;  // Autoriser � �tre chang�e qu'au cours d'une transaction
    fEnqReceive  := False;
    fRepReceive  := False;
    fEotReceive  := False;

    // Initialiser les propri�t�s du composant " fApdComPort "
    InitApdComponent;

    // Ouvrir le port s�rie
    fApdComPort.Open := True;

    // Demande pour �mettre ( Envoi de ENQ ) et attente de r�ponse
    fTPEResult := AttenteReponse( cEnq );
    // Envoi de la transaction au TPE ( STX ... + Montant ) et attente de r�ponse
    If fTPEResult = TrSucessFull Then
      fTPEResult := AttenteReponse( TPEAskTransaction );
    // Envoi de EOT si ACK ou NAK mais pas si TimeOut
    If fTPEResult <> TrErrorTimeOut Then
      EnvoiChaine( cEot );

    // Attente de traitement du TPE et de sa r�ponse r�ponse
    // On est oblig� de faire des boucles sans fin ou arr�t manuel
    // car on ne sait pas combien de temps le TPE va mettre pour r�pondre !!!
    If fTPEResult = TrSucessFull Then
    Begin
        While ( Not fManualTrans ) And ( Not EndTransactionByTPE ) Do
          Application.ProcessMessages;

        If fManualTrans Then
          fTPEResult := TrManual;
    End;

    // Fermer le port s�rie
    fApdComPort.Open := False;
End;






End.
