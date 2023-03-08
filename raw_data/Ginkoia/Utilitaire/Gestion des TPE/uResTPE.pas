unit uResTPE;

interface

ResourceString
  TXT_ComOuvert  = 'Ouvert';     // 1
  TXT_ComInconnu = 'Inconnu';    // -1
  TXT_ComFerme   = 'Ferm�';      // 0

  ParitePaire   = 'Paire';
  PariteImpaire = 'Impaire';
  PariteAucune  = 'Aucune';
  PariteMarque  = 'Marque';
  PariteEspace  = 'Espace';

  TXT_Erreur = 'Erreur';

  ERR_COM_ErreurNoCom  = 'Erreur de N� de port COM';
  ERR_COM_Vitesse      = 'Erreur de vitesse du Port COM';
  ERR_COM_BitDonnee    = 'Erreur du bit de donn�es du port COM';
  ERR_COM_Parite       = 'Erreur de la parit� du port COM';
  ERR_COM_BitArret     = 'Erreur du bit d''arr�t du port COM';
  ERR_COM_OuvertureCom = 'Erreur ouverture du port COM';

  ERR_NumeroPortInvalide = 'Num�ro de port COM invalide !';

  ERR_ChaineVide         = 'Veuillez Saisir une chaine de recherche pour l''auto d�tection';

  TXT_Trans_TestPresence = 'Test pr�sence TPE';
  TXT_Trans_Debit        = 'D�bit :  %s';
  TXT_Trans_Credit       = 'Cr�dit :  %s';
  TXT_Trans_Annulation   = 'Annulation :  %s';
  TXT_Trans_Duplicata    = 'Duplicata :  %s';
  TXT_Trans_Cheq         = 'Ch�que :  %s';

  ERR_Trans_Param_Invalide         = 'Param�tre invalide';        // 1
  ERR_Trans_Param_NoCaisseInvalide = 'N� de caisse invalide';     // 2
  ERR_Trans_Param_MntInvalide      = 'Montant invalide';          // 3

  ERR_Trans_PortCOM = 'Erreur ouverture port COM';

  ERR_Trans_TPE_TimeOut = 'D�lai d�pass�';                        // 1

implementation

end.
