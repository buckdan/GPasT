unit UConstants;

interface

const
  DEFAULT_HOST = 'localhost';
  DEFAULT_PORT = 3050;
  DEFAULT_DB_USER = 'SYSDBA';
  DEFAULT_DB_PWD = 'masterkey';
  DEFAULT_DB_LIB = 'gds32.dll';

  // Cl� de chiffrement du mot de passe
  PWD_KEY = 'algol1082';
  // Mot de passe par d�faut au format Unicode chiffr� : ch@mon1x
  PWD_DEFAULT = 'MAAyADAANAAyADcAMAAyADAAMwA1AEYAMAAxADQAMAA=';

  // Cl� de registre du moteur InterBase
  HK_INTERBASE = 'SOFTWARE\Borland\InterBase\';
  HK_IB_XE = HK_INTERBASE + 'Servers\gds_db';
  HK_IB_71 = HK_INTERBASE + 'CurrentVersion';
  HK_IB_VALUES = 'ServerDirectory';
  // Nom du moteur InterBase
  IB_EXE_NAME = 'ibserver.exe';

  // Nom du Launcher
  LAUNCHER_EXE_NAME = 'launchv7.exe';

  // Chemin par d�faut pour base Ginkoia
  IB_DATABASE_DIR = '\Ginkoia\Data\';
  IB_DATABASE_NAME = 'Ginkoia';
  SUFFIXE_COPIE = '-Copie';


  // Sections et cl�s du fichier Ini
  INI_SECTION_APP = 'APPLICATION';
  INI_APP_PWD = 'PWD';

  INI_SECTION_DB = 'DATABASE';
  INI_DB_HOST = 'HOST';
  INI_DB_PORT = 'PORT';
  INI_DB_USER = 'USER';
  INI_DB_PWD = 'PWD';
  INI_DB_LIBRARY = 'CLIENTLIB';

  INI_SECTION_DIV = 'DIVERS';
  INI_LAUNCHER='LAUNCHER';

  INI_SECTION_INTERDIT = 'INTERDIT';

  // Partie de nom de postes pour lesquels le rebbot est interdit
  INTERDIT1 = 'lame';
  INTERDIT2 = 'ginkoia';
  INTERDIT3 = 'symreplic';
  INTERDIT4 = 'magmdc';
  INTERDIT5 = 'tools';

  // Message
  IB_DATABASE = 'Base de donn�es Interbase';
  IB_COPY = 'Copie de la base de donn�es';
  IB_DIFF_NAME = 'La copie doit �tre nomm�e diff�remment !';
  IB_LOCATION = 'Emplacement de sauvegarde de la base de donn�es';
  IB_BACKUP = 'Sauvegardes Bases de donn�es Interbase';
  IB_RESTORE = 'Emplacement de restauration de la base de donn�es';

  DB_NOT_EXIST = 'Base de donn�es inexistante !';
  LOG_FILE_LOCATION = 'Emplacement du fichier de suivi';
  LOG_FILE = 'Fichiers de suivi';

  STOP_WORK_IN_PROGRESS = 'Voulez vous arr�ter le traitement en cours ?';
  STOP_REQUESTED = 'Arr�t du traitement demand�...';
  WORK_FINISHED = 'Traitement termin�...';
  SAVE_TO_FILE = 'Enregistrement dans le fichier ';

  IB_OP_INFO = 'Informations sur la base de donn�es';
  IB_OP_SHUTDOWN = 'Mise hors ligne de la base de donn�es';
  IB_OP_ONLINE = 'Mise en ligne de la base de donn�es';
  IB_OP_VALIDATE = 'Analyse de la base de donn�es';
  IB_OP_MEND = 'R�paration de la base de donn�es';
  IB_OP_BACKUP = 'Sauvegarde de la base de donn�es';
  IB_OP_RESTORE = 'Restauration de la base de donn�es';

  STARTED = ' d�marr�e';
  FINISHED = ' termin�e'#13#10;
  CANCELED = ' annul�e';

  OP_BACKUP_STARTED = IB_OP_BACKUP + STARTED;
  OP_BACKUP_FINISHED = IB_OP_BACKUP + FINISHED;
  OP_BACKUP_CANCELED = IB_OP_BACKUP + CANCELED;
  OP_RESTORE_STARTED = IB_OP_RESTORE + STARTED;
  OP_RESTORE_FINISHED = IB_OP_RESTORE + FINISHED;
  OP_RESTORE_CANCELED = IB_OP_RESTORE + CANCELED;
  OP_COPY_STARTED = IB_COPY + STARTED;
  OP_COPY_FINISHED = IB_COPY + FINISHED;
  OP_COPY_CANCELED = IB_COPY + CANCELED;
  OP_INFO_STARTED = IB_OP_INFO + STARTED;
  OP_INFO_FINISHED = IB_OP_INFO + FINISHED;
  OP_INFO_CANCELED = IB_OP_INFO + CANCELED;
  OP_SHUTDOWN_STARTED = IB_OP_SHUTDOWN + STARTED;
  OP_SHUTDOWN_FINISHED = IB_OP_SHUTDOWN + FINISHED;
  OP_SHUTDOWN_CANCELED = IB_OP_SHUTDOWN + CANCELED;
  OP_ONLINE_STARTED = IB_OP_ONLINE + STARTED;
  OP_ONLINE_FINISHED = IB_OP_ONLINE + FINISHED;
  OP_ONLINE_CANCELED = IB_OP_ONLINE + CANCELED;
  OP_VALIDATE_STARTED = IB_OP_VALIDATE + STARTED;
  OP_VALIDATE_FINISHED = IB_OP_VALIDATE + FINISHED;
  OP_VALIDATE_CANCELED = IB_OP_VALIDATE + CANCELED;
  OP_MEND_STARTED = IB_OP_MEND + STARTED;
  OP_MEND_FINISHED = IB_OP_MEND + FINISHED;
  OP_MEND_CANCELED = IB_OP_MEND + CANCELED;
  OP_STOP_LAUNCHER = 'Arr�t du "launcher" demand�';
  OP_STOP_LAUNCHER_OK = '"Launcher" arr�t�';
  OP_STOP_LAUNCHER_KO = 'Echec d''arr�t du "Launcher"';
  OP_START_LAUNCHER = 'D�marrage du "launcher" demand�';
  OP_START_LAUNCHER_OK = '"Launcher" relanc�';
  OP_START_LAUNCHER_KO = 'Echec du d�marrage du "Launcher"';
  OP_LAUNCHER_NOT_FOUND = 'Processus "Launcher" non trouv�';

  OP_RUNNING = 'Op�ration en cours...';
  OP_FINISHED = 'Op�ration termin�e...';
  OP_CANCELED = 'Op�ration annul�e...';

implementation

end.
