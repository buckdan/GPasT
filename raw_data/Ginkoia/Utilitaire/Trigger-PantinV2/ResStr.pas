unit ResStr;

interface

resourcestring
  RS_ERR_MOT_PASSE          = 'Le mot de passe saisi est incorrect.';
  RS_ERR_NB_RECALC_MAX      = 'Le nombre de recalculs simultan�s est atteind.';
  RS_ERR_CALCUL_EN_COURS    = 'Le calcul de cette base est d�j� en cours d''ex�cution.';
  RS_ERR_CALCUL_INACTIF     = 'Le calcul de cette base ne peut �tre arr�t� car il n''est pas actif.';
  RS_ERR_ENR_DATE_TRAIT     = 'Erreur lors de l''enregistrement de la date de traitement.'#13#10
                            + 'Message d''erreur'#160': %s - %s';
  RS_ERR_CALCUL_STOCK       = 'Erreur lors du calcul des stocks "%s".'#13#10
                            + 'Message d''erreur'#160': %s';
  RS_ERR_THREAD_EN_COURS    = 'Il y a actuellement un calcul en cours.'#13#10
                            + 'Veuillez attendre qu''il ait fini, ou l''arr�ter manuellement.';
  RS_ERR_THREADS_EN_COURS   = 'Il y a actuellement %d calculs en cours.'#13#10
                            + 'Veuillez attendre qu''ils aient fini, ou les arr�ter manuellement.';
  RS_ERR_ENR_BASE_MAINT     = 'Erreur lors de l''enregistrement des informations dans la base de maintenance.';
  RS_ERR_CALCUL_LAME        = 'Il y a d�j� un calcul en cours sur la Lame "%s".';
  RS_ERR_COURRIEL           = 'Une erreur s''est produite lors de l''envoi du courriel � "%s".';

  RS_INFO_FIN_CALCUL        = 'Fin du calcul pour "%s".'#13#10
                            + ' - %s';
  RS_INFO_ANNULE_CALCUL     = 'Annulation du calcul pour "%s". Les modifications n''ont pas �t� prises en compte.'#13#10
                            + ' - %s';
  RS_INFO_TEMPS_TRAITEMENT  = 'Temps de traitement %d secondes.';
  RS_INFO_DEMARRAGE         = 'D�marrage du calcul pour "%s".'#13#10
                            + ' - %s';
  RS_INFO_PAUSE             = 'Mise en pause du calcul pour "%s".'#13#10
                            + ' - %s';
  RS_INFO_REPRISE           = 'Reprise du calcul pour "%s".'#13#10
                            + ' - %s';
  RS_INFO_ARRET             = 'Mise en arr�t du calcul par l''utilisateur pour "%s".'#13#10
                            + 'Veuillez patienter'#133;
  RS_INFO_ANNULATION        = 'Mise en annulation du calcul par l''utilisateur pour "%s".'#13#10
                            + 'Veuillez patienter'#133;

  RS_INFO_BTN_DEMARRAGE     = 'Lance le calcul de stock sur cette base.';
  RS_INFO_BTN_PAUSE         = 'Place le calcul de stock en pause.';
  RS_INFO_BTN_ARRET         = 'Initialise l''arr�t du calcul de stock sur cette base.'#13#10
                            + 'Pressez la touche Maj pour annuler les calculs effectu�s.';
  RS_INFO_LBL_TRAITES       = 'Nombre de paquets trait�s.';

  RS_INFO_ENR_BASE_MAINT    = 'Les informations ont biens �t� mises � jour dans la base de maintenance.';

  RS_INFO_DEMARRAGE_LOG     = 'D�marrage du logiciel';
  RS_INFO_ARRET_LOG         = 'Arr�t du logiciel';

  RS_INFO_CHARGE_BASE       = 'Mode avec une base de donn�es.'#13#10
                            + ' - Base : %s';
  RS_INFO_CHARGE_LISTE      = 'Mode avec un fichier de liste de bases de donn�es.'#13#10
                            + ' - Fichier : %s';
  RS_INFO_CHARGE_MAINT      = 'Mode en connection directe � la base de Maintenance.'#13#10
                            + ' - Base : %s';

  RS_INFO_ACTIF             = 'Lancement des calculs en automatique actif';
  RS_INFO_INACTIF           = 'Lancement des calculs en automatique inactif';
  RS_INFO_AUCUNE_BASE       = 'Aucune base � traiter actuellement';

  RS_INFO_ETAT              = ' ';
  RS_INFO_VALIDATION        = 'Validation'#133;
  RS_INFO_PRETRAITEMENT     = 'Ex�cution du pr�traitement'#133;
  RS_INFO_TRAITEMENT        = 'Ex�cution du traitement'#133;
  RS_INFO_TRIGGERDIFF       = '%d'#160'/'#160'%d restants'#133;

  RS_INFO_COURRIEL          = 'Le rapport de traitement a �t� envoy� par courriel a l''adresse "%s".';

  RS_LABEL_DEBUT            = 'D�but : %s';
  RS_LABEL_FIN              = 'Fin : %s';
  RS_LABEL_BASE             = '%s'#13#10
                            + '%s - (moy. %d sec)';

  RS_COURRIEL_TITRE         = '[%s] - Recalcule des stocks - Rapport de fin de traitement';
  RS_COURRIEL_MESSAGE       = 'Le recalcul des stocks s''est termin� depuis le serveur %s.'#13#10
                            + '====================================================================='#13#10#13#10
                            + '%s'#13#10#13#10
                            + 'Nous vous souhaitons une bonne journ�e,'#13#10
                            + 'L''utilitaire de recalcule des stocks du serveur %0:s.';
  RS_COURRIEL_TEST_TITRE    = '[%s] - Recalcule des stocks - Courriel de test';
  RS_COURRIEL_TEST_MESSAGE  = 'Ceci est un message de test.'#13#10
                            + 'Si vous arrivez � le visualiser, c''est que le param�trage d''envoie des courriels est correctement effectu�.'#13#10#13#10
                            + 'Nous vous souhaitons une bonne journ�e,'#13#10
                            + 'L''utilitaire de recalcule des stocks du serveur %0:s.';
  RS_INFO_COURRIEL_TEST     = 'Le courriel de test a �t� envoy� correctement. Veuillez v�rifier que celui-ci a bien �t� re�u.'#13#10
                            + 'Il se peut que celui-ci ai �t� consid�r� comme ind�sirable.';
  RS_ERR_COURRIEL_TEST      = 'L''envoi du courriel a provoqu� une erreur.'#13#10'%s';

const
  CONST_SMTP_SERVEUR        = 'smtp.office365.com';
  CONST_SMTP_UTILISATEUR    = 'dev@ginkoia.fr';
  CONST_SMTP_MOTPASSE       = 'Toru682674';
  CONST_SMTP_PORT           = 587;
  CONST_SMTP_TLS            = True;
  CONST_SMTP_EXPEDITEUR     = 'adminginkoia@gmail.com';
  CONST_SMTP_DESTINATAIRE   = 'adminginkoia@gmail.com';
  CONST_SMTP_ENVOYER        = True;

implementation

end.
