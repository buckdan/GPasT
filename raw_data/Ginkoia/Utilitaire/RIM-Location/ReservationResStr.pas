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
  RS_ERR_RESADM_ANNULCLIENTERROR     = 'Erreur lors du traitement des annulations clients : ';
  RS_TXT_RESADM_ANNULERROR           = 'Erreur Annulation';
  RS_TXT_RESADM_ANNULINPROGRESS      = 'Traitement des annulations de r�servations en cours';
  RS_ERR_RESADM_CREATERESA          = 'Erreur lors de la cr�ation de la r�servation "%s", celle-ci passera � la prochaine int�gration.'#13#10'%s'#160': %s.';

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

  //Pour les OC
  RS_TXT_RESMAN_OC    = 'Traitement des OC';
  RS_TXT_RESMAN_OCx   = 'OC n�';
  RS_ERR_RESMAN_OCx   = 'Erreur de traitement : l''XML pout cet article ne contient pas d''�l�ments.'#13#10
                        + 'Ou ne contient pas les 2 �l�ments requis : nom et id_article.'#13#10#13#10
                        + 'Il a �t� ignor�.'#13#10;

  // pour module location
  RS_ERR_RESMAN_DATABASE    = 'Erreur connection � la base de donn�es' ;
  RS_RESERVATION_START      = 'Lancement du module en mode' ;
  RS_RESERVATION_END        = 'Fin d''ex�cution du module' ;


  RS_CONFIG_ISF =   'Veuillez configurer la partie @mail d''intersport'   ;

  RS_NO_CENTRALE = 'Le fichier Pprs.xml est manquant ou vide' ;
  RS_VERIF_MAIL = 'V�rification des courriels de la centrale en cours' ;
  
  RS_ERREUR_CONNEXION_LOG = '%s'#160': Erreur lors de la connexion au service de messagerie. Essai %u sur %u.'#13#10
                          + 'Le service de messagerie semble momentan�ment indisponible. '
                          + 'Veuillez r�essayer ult�rieurement'#133#13#10
                          + '%s'#160': %s';
  RS_ERREUR_CONNEXION_DLG = '%s'#13#10
                          + 'Le service de messagerie semble momentan�ment indisponible.'#13#10
                          + 'Veuillez r�essayer ult�rieurement'#133#13#10#13#10
                          + '%s'#160': %s';
  RS_CONNEXION_OK_LOG     = '%s'#160': Connexion au service de messagerie r�ussie.';

implementation

end.
