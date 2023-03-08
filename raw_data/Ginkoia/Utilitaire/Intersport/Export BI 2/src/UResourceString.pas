unit UResourceString;

interface

// Pour selectList_Frm.pas
resourceString
  rs_ErreurLectureFichierIni = 'Erreur de lecture du fichier INI';
  rs_ExceptionRequeteDossier = 'Exception lors du requetage des dossiers : %s - %s';
  rs_ExceptionRequeteMagasin = 'Exception lors du requetage des magasins : %s - %s';
  rs_ExceptionSelectionDossier = 'Exception lors de la selection des dossiers : %s - %s';
  rs_ExceptionSelectionMagasin = 'Exception lors de la selection des magasins : %s - %s';

// pour Traitement.pas
resourceString
  // libelle d'exception
  rs_ExceptionBase = 'Exception : %s - %s';
  rs_ExceptionDossier = 'Dossier : "%s - %s" Exception : %s - %s';
  rs_ExceptionMagasin = 'Dossier : "%s - %s" Magasin : "%s - %s" Exception : %s - %s';
  rs_ExceptionReadIni = 'Erreur de lecture du fichier INI';
  rs_ExceptionConnectFTP = 'Erreur de connexion au FTP';
  rs_ExceptionBoucleRecalcul = 'Pas de retour de "eai_trigger_differe"';
  rs_ExceptionJetonOK = 'Echec de l''obtention du Jeton : Ok';
  rs_ExceptionJetonOQP = 'Echec de l''obtention du Jeton : Occup�';
  rs_ExceptionJetonCNX = 'Echec de l''obtention du Jeton : Erreur de connexion � la base';
  rs_ExceptionJetonPRM = 'Echec de l''obtention du Jeton : Erreur de param�trage';
  rs_ExceptionJetonHTTP = 'Echec de l''obtention du Jeton : Erreur de connexion';
  rs_ExceptionJetonINTERNAL = 'Echec de l''obtention du Jeton : Erreur interne';
  rs_ExceptionJetonABORTED = 'Echec de l''obtention du Jeton : Annul�';
  rs_ExceptionJetonNEVER = 'Echec de l''obtention du Jeton : jamais demand�';
  rs_ExceptionJetonOTHER = 'Echec de l''obtention du Jeton : autre erreur (%d)...';
  rs_ExceptionRecalcule = 'Erreur lors du recalcule des stock';
  rs_ExceptionReInsert = 'Erreur lors de la reinsertion des lignes manquantes';
  rs_ExceptionCorrectionDate = 'Erreur lors de la correction a date du dossier';
  rs_ExceptionActivationMag = 'Erreur lors de l''activation du magasin';
  rs_ExceptionInitMagasin = 'Erreur lors de l''initialisation du magasin';
  rs_ExceptionExport = 'Autre erreur lors de l''export (%d)';
  rs_ExceptionFtpSend = 'Erreur d''acc�s FTP';
  rs_ExceptionValidation = 'Erreur a la validation des lignes';
  // libelle decalage
  rs_LibDecalage = '  -> ';
  // libelle pas d'erreur
  rs_NoErreur = 'OK';
  rs_HasErreur = 'KO';
  // libelle d'erreur
  rs_AlreadyError = 'Erreur pre-existante : %s';
  rs_ErreurGetSuivi = 'Erreur de t�l�chargement du fichier de suivi';
  rs_ErreurDateGlobale = 'Date globale du fichier de suivi (%s) interdit l''export';
  rs_ErreurDossierInactif = 'Dossier non activ�';
  rs_ErreurUnableToConnect = 'Impossible de se connecter � la base';
  rs_ErreurPasDeDossier = 'Pas de dossier present en base';
  rs_ErreurPasDeMagasin = 'Pas de magasin present dans ce dossier';
  rs_ErreurMagasinInactif = 'Magasin non activ�';
  rs_ErreurNoCodeAdh = 'Code adh�rent non renseign�';
  rs_ErreurInitTodo = 'Initialisation pr�vue, pas d�export de delta';
  rs_ErreurDateMagasin = 'Date incorect dans le fichier de suivi';
  rs_ErreurDateMagasinDetail = '(dates : fichier = %s; BDD = %s)';
  rs_ErreurExportDone = 'Export termin�';
  rs_ErreurExportOK = ' lignes export�es';
  rs_ErreurNoData = 'Pas de donn�e � exporter';
  rs_ErreurNoFileToSend = 'Pas de fichier a envoyer';
  rs_ErreurAlreadyInit = 'Magasin d�j� initialis�';
  // caption de suivit
  rs_CaptionGetListe = 'Recup�ration de la liste des dossiers/magasins';
  rs_CaptionGestionSuivi = 'Gestion du fichier de suivi';
  rs_CaptionDossier = 'Traitement du dossier "%s - %s"';
  rs_CaptionMagasin = 'Traitement du magasin "%s - %s" du dossier "%s - %s"';
  // Step
  rs_StepJeton = 'Prise du jeton';
  rs_StepRecalcule = 'Recalcule';
  rs_StepReInsert = 'Correction : Reinsertion des lignes manquante';
  rs_StepCorrectionDate = 'Correction : Correction a date';
  rs_StepActivationMagasin = 'Activation du magasin';
  rs_StepInitMagasin = 'Initialisation du magasin';
  rs_StepAskDoExport = 'Export du magasin ?';
  rs_StepExportMagasin = 'Exportation';
  rs_StepSendFileFTP = 'Envoi du fichier sur le serveur FTP';
  rs_StepValideMagasin = 'Validation de l''export';
  rs_StepGetDateLastMvt = 'R�cup�ration de la date de dernier mouvement';
  rs_StepGetCAPeriode = 'R�cup�ration du CA sur la p�riode';
  rs_StepWriteRapport = 'Ecriture du rapport';
  rs_StepFreeJeton = 'Liberation du jeton';
  // message de trace
  rs_TraceStartThread = 'Demarage du thread';
  rs_TraceGestionSuiviDate = 'Date de validation : %s';
  rs_TraceSeparateur = '==============================';
  rs_TraceGestionBase = 'Gestion des fonctions de bases';
  rs_TraceGestionExport = 'Gestion des Export';
  rs_TraceGestionInit = 'Gestion des Initialisation';
  rs_TraceEndOfThread = 'Fin du thread...';
  // information de traitement
  rs_InfoListeVide = 'La listes des dossiers/magasins vide -> remplissage';
  // element du fichier
  rs_EnteteFile = 'Serveur;Code groupe;Nom groupe;Code adh�rent;Nom adh�rent;Nb lignes export�es;Date du dernier mouvement;CA sur les %d derniers jours;Traitement OK ?;Message';

implementation

end.
