unit ReservationResStr;

interface

resourcestring
  // Commun
  RS_TXT_RESCMN_ERREUR       = 'Erreur';
  RS_ERR_RESCMN_CFGMAIL      = 'Veuillez configurer la partie e-mail de �0';
  RS_ERR_RESCMN_CNXMAILERROR = '�0 : Erreur lors de la connexion avec le serveur de mail';
  RS_TXT_RESCMN_ANALYSEMAIL  = '�0 : Analyse des mails en cours';

  // DM
  RS_TXT_RESADM_PRIXNET      = 'Prix net : �0';
  RS_TXT_RESADM_PRIXBRUT     = 'Prix Brut : �0';
  RS_TXT_RESADM_REMISEPC     = 'Remise : �0%';
  RS_TXT_RESADM_REMISEEUR    = 'Remise : �0�';
  RS_TXT_RESADM_REMISETTPC   = 'Remise total : �0%';
  RS_TXT_RESADM_RESACOMMENT  = 'R�serv. du �0 au �1 Arrhes : �2�';
  RS_TXT_RESADM_POINTURE     = 'pointure';
  RS_TXT_RESADM_TAILLE       = 'taille';
  RS_TXT_RESADM_POIDS        = 'poids';
  RS_ERR_RESADM_CANCELINTEG  = '�0 : Int�gration interrompue, le param�trage'#13#10 +
                               'des offres commerciales est incomplet...'#13#10 +
                               'R�servation : �1'#13#10 +
                               'Offre : �2';
  RS_TXT_RESADM_RESAINPROGRESS = '�0 : Traitement des r�servations en cours ...';
  RS_TXT_RESADM_PJINPROGRESS = 'Analyse des pi�ces jointes en cours';
  RS_ERR_RESADM_ANNULPROGRESSERROR   = 'Erreur lors du traitement des annulations : ';
  RS_TXT_RESADM_ANNULERROR           = 'Erreur Annulation';
  RS_TXT_RESADM_ANNULINPROGRESS      = 'Traitement des annulations de r�servations en cours';

  // Resa Main
  RS_ERR_RESMAN_NOCENTRALE = 'Aucune centrale trouv�e';
  RS_TXT_RESMAN_NEWOFFRE   = '�0 : De nouvelles offres commerciales ont �t� cr��es, veuillez les mettre � jour';
  RS_TXT_RESMAN_INFO       = 'Informations';
  RS_TXT_RESMAN_NORIGHT    = '�0 : Vous n''avez pas les droits n�cessaire pour traiter les r�servations de cette centrale sur ce poste !';
  RS_TXT_RESMAN_NONEWRESA  = 'Pas de nouvelle r�servation';
  RS_ERR_RESMAN_ERRORPOP3  = 'Erreur POP3';
  RS_TXT_RESMAN_VERIFMAILARCHIV = '�0 : V�rification des mails pour Archivage';
  RS_TXT_RESMAN_ERRORSMTP       = 'Erreur SMTP';
  RS_ERR_RESMAN_MAILTRANSERROR = ' : Erreur lors du transfert d''un mail';
  RS_ERR_RESMAN_DELERROR       = 'Impossible de supprimer un mail';


  // pour module location
  RS_ERR_RESMAN_DATABASE    = 'Erreur connection � la base de donn�es' ;
  RS_RESERVATION_START      = 'Lancement du module en mode' ;    
  RS_RESERVATION_END        = 'Fin d''ex�cution du module' ;


  RS_CONFIG_ISF =   'Veuillez configurer la partie @mail d''intersport'   ;

  RS_NO_CENTRALE = 'Le fichier Pprs.xml est manquant ou vide' ;
  RS_VERIF_MAIL = 'V�rification des courriels de la centrale en cours' ;

  RS_MESSAGE_A_ARCHIVER = ' message � archiver' ;
  RS_MESSAGE_ARCHIVAGE = 'archivage message ' ;
  RS_MESSAGE_NOTDELETED = 'le message n''a pas pu �tre supprim�' ;
  

  RES_DELAI_A_ZERO = 'DELAI DE RETENTION A 0 CENTRALE NON TRAITEE';
  RES_LOG_DEM  = 'D�marrage de la purge' ;
  RES_LOG_FIN  = 'Fin de la purge' ;
  RES_LOG_STOP = 'Traitement interrompu par l''utilisateur' ;
  RES_LOG_ARCHIVE = 'Archiv� : ';
  RES_LOG_NOTDECODE = 'Message non d�cod� : ' ;
  RES_MSG_ARCHIVE = ' messages(s) archiv�(s)' ;
  RES_MSG_ARCHIVER = ' messages(s) � archiver'   ;
  RES_R_TENTATIVE = 'Connexion au compte R�servation tentative ' ;
  RES_R_CONNECTE = 'Connexion au compte R�servation activ�e' ;
  RES_A_TENTATIVE = 'Connexion au compte Archive tentative ' ;
  RES_A_CONNECTE = 'Connexion au compte Archive activ�e' ;
  RES_S_TENTATIVE = 'Connexion au compte Smtp tentative ' ;
  RES_S_CONNECTE = 'Connexion au compte Smtp activ�e' ;
  RES_NOCENTRALE = 'Centrale non trait�e';
  RES_A_MSG      = ' messages dans la boite archive' ;
  RES_MSG        = ' message(s)'  ;
  RES_NORES     = 'Aucune r�servation' ;


  
implementation

end.
