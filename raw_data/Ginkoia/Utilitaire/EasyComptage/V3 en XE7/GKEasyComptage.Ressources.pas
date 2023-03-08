unit GKEasyComptage.Ressources;

interface

const
  DELIMITER : Char        = ';';
  RS_ERR_QUITTER          = 'Le programme va se fermer.';
  NBESSAIS_DEFAUT         = 60;
  DELAIS_DEFAUT           = 60 * 1000;

resourcestring
  RS_INF_DEMARRAGE        = 'D�marrage du programme.';
  RS_INF_ARRET            = 'Arr�t du programme.';
  RS_INF_TEST             = 'Programme lanc� en mode TEST.';
  RS_INF_PARAM            = 'Programme lanc� en mode PARAM.';
  RS_INF_CONNECTE         = 'Connect�';
  RS_INF_DECONNECTE       = 'D�connect�';
  RS_INF_TH_TRAIT_D       = 'D�marrage du thread de traitement.';
  RS_INF_TH_TRAIT_F       = 'Fin du thread de traitement.';
  RS_INF_TH_TRAIT_S       = 'Traitement effectu� avec succ�s.';
  RS_INF_TH_TRAIT_E       = 'Traitement en erreur.';
  RS_INF_CONNEXION        = 'Connexion � la base de donn�es r�ussie.';
  RS_ERR_CONNEXION        = 'Erreur de connexion � la base de donn�es.';
  RS_ERR_TRAITEMENT       = 'Un autre traitement bloque la connexion � la base de donn�es.';
  RS_ERR_PARAM_INI        = 'Erreur de lecture du fichier d�initialisation.'#13#10#13#10 + RS_ERR_QUITTER;
  RS_ERR_PARAM_BASE       = 'Erreur lors du chargement des param�tres.'#13#10#13#10 + RS_ERR_QUITTER;
  RS_ERR_PARAM_MAG        = 'Erreur dans l�identifiant magasin'#160': %d.';
  RS_ERR_PARAM_GENPARAM   = 'Les param�tres d�EasyComptage n�existent pas dans GENPARAM.';
  RS_ERR_PARAM_MODULE     = 'Vous n�avez pas le module n�cessaire pour ex�cuter cette application.'#13#10#13#10 + RS_ERR_QUITTER;
  RS_ERR_PARAM_ENREG      = 'Erreur lors de l�enregistrement des param�tres dans la base.';
//  RS_ERR_PARAM_ENREG_EXC  = 'Erreur lors de l�enregistrement des donn�es %d'#160': %s - %s.';
  RS_ERR_BARRE_STATUS     = 'Erreur (%d/%d)'#160': %s - %s';

  RS_ERR_REQUETE_CODEADH  = 'Attention :  le magasin en cours (%s) n�a pas de code adh�rent !' + #13#10 + 'C''est une information obligatoire.';

  RS_INFO_TACHE_CREER_D   = 'D�but de la cr�ation de la t�che planifi�e.';
  RS_INFO_TACHE_CREER_F   = 'Fin de la cr�ation de la t�che planifi�e.';
  RS_INFO_TACHE_SUPPR_D   = 'D�but de la suppression de la t�che planifi�e.';
  RS_INFO_TACHE_SUPPR_F   = 'Fin de la suppression de la t�che planifi�e.';
  RS_INFO_DEMAR_CREER_D   = 'D�but de la cr�ation du d�marrage automatique.';
  RS_INFO_DEMAR_CREER_F   = 'Fin de la cr�ation du d�marrage automatique.';

  RS_INFO_TRAITEMENT      = 'Traitement en cours...';
  RS_INFO_TRAIT_PROCHAIN  = 'Prochain traitement pr�vu � %s.';
  RS_INFO_EN_COURS        = 'L�application est toujours en cours d�ex�cution.'#13#10
                          + 'Double-cliquez sur cette ic�ne pour la r�afficher.';
  RS_QUES_QUITTER         = 'Voulez-vous vraiment quitter l�application'#160'?';

  RS_LIB_TITRE            = 'EasyComptage Export - %s';
  RS_LIB_ARRET            = 'Arr�t du traitement � %s';

implementation

end.
