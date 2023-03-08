unit ReservationResStr;

interface

resourcestring
  // Commun
  RS_TXT_RESCMN_ERREUR       = 'Erreur';
  RS_ERR_RESCMN_CFGMAIL      = 'Veuillez configurer la partie e-mail de �0';
  RS_ERR_RESCMN_CFGMAIL_TRC  = 'La partie e-mail de "�0" n''est pas configur�e.';
  RS_ERR_RESCMN_CNXMAILERROR = '�0 : Erreur lors de la connexion avec le serveur de mail';
  RS_TXT_RESCMN_ANALYSEMAIL  = '�0 : Analyse des mails en cours';
  RS_ERR_RESCMN_SAVEMAIL_TRC  = '"�0" : Erreur de traitement de mail : ';

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
  RS_TXT_RESADM_GARANTIE     = 'Garantie';
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

  RS_TXT_COMENTRESA_PAIEMENT = 'Paiement : �0%';
  RS_TXT_COMENTRESA_OPTIONS = 'Options : �0';
  RS_TXT_COMENTRESA_DRIVE = 'Drive';
  RS_TXT_COMENTRESA_GARANTIEVOL = 'Garantie vol casse';
  RS_TXT_COMENTRESA_SECOURS = 'Secours rapatriement';

  RS_TXT_COMENTLINE_AGE = 'Age : �0';
  RS_TXT_COMENTLINE_LEVEL = 'Niveau du skieur : �0';


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
  RS_RESERVATION_CAPTION_MODE_VERIF     = 'Verification des r�servations � venir' ;


  RS_CONFIG_ISF =   'Veuillez configurer la partie @mail d''Intersport'   ;
  RS_ERR_RESCMN_CFGMAILISF_TRC  = 'La partie e-mail d''Intersport n''est pas configur�e.';

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
  RS_ERREUR_CONNEXION_DLG_TRC = 'Le service de messagerie est indisponible';
  RS_CONNEXION_OK_LOG     = '%s'#160': Connexion au service de messagerie r�ussie.';

  // SKISET
  RS_ERREUR_CFGWEBSERVICE = 'Veuillez configurer la partie web service de �0';
  RS_ERREUR_CFGWEBSERVICE_TRC  = 'La partie web service de "�0" n''est pas configur�e.';
  RS_ERREUR_CONNEXION_WEBSERVICE_LOG = 'Erreur lors de la connexion au web service.'#13#10
                                     + 'Le web service est indisponible.'#13#10
                                     + '%s'#160': %s';
  RS_ERREUR_CONNEXION_WEBSERVICE_DLG = 'Le web service est indisponible.'#13#10
                                     + '%s'#160': %s';
  RS_ERREUR_CONNEXION_WEBSERVICE_DLG_TRC = 'Le web service est indisponible.';
  RS_ERRREUR_RESA_OC = 'Erreur de traitement : Aucune offre retourn�e par le web service.';


implementation

end.
