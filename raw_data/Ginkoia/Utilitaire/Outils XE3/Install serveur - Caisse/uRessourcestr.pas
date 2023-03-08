{$REGION 'Documentation'}
/// <summary>
/// Resource strings
/// </summary>
{$ENDREGION}
unit uRessourcestr;

interface

CONST
  RST_BADCODE = 'Le code client n''est pas conforme';
  RST_GINKOIA_EXISTS = 'Un r�pertoire Ginkoia existe d�j�' + #10 + 'Voulez-vous continuer ?';
  RST_STOP = 'Arr�ter';
  RST_INSTALL = 'Installer';
  RST_FILE = 'Fichier � installer';
  RST_URL = 'Url de chargement';
  RST_DATABASE = 'Interrogation de la base de donn�es';
  RST_NOTCONNECTED = 'La base n''est pas connect�e';
  RST_CONFIRM = 'Confirmez-vous l''installation du serveur';
  RST_CLIENT = 'du client: ';
  RST_CODE = 'code :';
  RST_VILLE = 'ville :';
  RST_ERROR_UNZIP = 'Une erreur s''est produite lors de l''extraction du fichier';
  RST_ERROR_UNZIP2 = ' Voulez-vous';
  RST_RETRY = 'R�essayer';
  RST_IGNORE = 'Erreur ignor�e';
  RST_CANCEL = 'Op�ration annul�e';
  RST_LOG_FILE = 'GINKOIA-INSTALLATION.txt';
  RST_ERROR_CODE = 'Le code saisi ne correspond pas';
  RST_NOCODE = 'Aucune base ne correspond au code indiqu�';
  RST_DOWNLOAD = 'Chargement';
  RST_ERROR_UNZIP3 = 'Une erreur s''est produite lors de l''installation' + #10 + 'Le processus est abandonn�';
  RST_ERROR_PATH = 'Les chemins d''installation doivent �tre renseign�s correctement';
  RST_ERROR_INSTALLFROMSERVER = 'Les param�tres d''installation depuis le serveur Easy ne sont pas corrects, veuillez v�rifier les param�tres';
  RST_ERROR_INSTALLFROMLOCAL = 'Les param�tres de la base locale ne sont pas bons ou ne peuvent �tre trouv�s dans la base du serveur';
  RTS_ERROR_COPYGINKOIAFROMSERVER = 'Erreur lors de la copie des fichiers depuis le serveur';
  RTS_ERROR_BACKUPBASE = 'Impossible de faire le backup de la base locale';
  RTS_ERROR_DEZIP = 'Erreur lors du DEZIP du fichier de version';
  RTS_ERROR_DEPERSOBASE = 'Erreur lors de la d�personnalisation de la base : ';
  RTS_ERROR_RECUPBASE = 'Erreur lors du r�cupbase : ';
  RTS_INTERRUPTIONMANU = 'Installation interrompue par l''utilisateur';

  RST_ERROR_REFERENCEMENT = 'Une erreur s''est produite lors du r�f�rencement';

  RST_ERROR_BPL = 'Une erreur s''est produite lors de l''initialisation du chemin BPL';
  RST_ERROR_BDD = 'Une erreur s''est produite lors de la connexion � la base de donn�es';
  RST_HINT_DOWNLOAD = 'Charger le fichier';
  RST_HINT_STOPDOWNLOAD = 'Cliquez ici pour arr�ter le chargement';
  RST_HINT_OPENFILE = 'S�lectionner le fichier � installer';
  RST_NOFILE = 'Aucun fichier disponible sur la lame, v�rifiez la connecxion';
  RST_RECUPBASE_ECHEC = 'Une erreur s''est produite dans la r�cup�rationde la base';
  RST_RECUPBASE_NOINI = 'Voulez-vous r�cup�rer le fichier InitParams ?';

  RST_NOXMLFILE = 'Le fichier Deploiement.xml n''a pas �t� initialis� ou d�ploy�';
  RST_RESTEACHARGER = 'reste � charger : ';
  RST_URLHINT = 'T�l�charger le fichier';

  RST_DOWNLOADRL = 'Chargement de l''url ';
  RST_ENDOFDOWNLOAD = 'Fin du chargement';
  RST_STOPPEDBYUSER = 'Chargement interrompu par l''uilisateur';
  RST_ZIPSTOPPEDBYUSER = 'L''installation a �t� interrompue par l''utilisateur';
  RST_UNZIP = 'D�compression du fichier';
  RST_CONFIRMED = 'Installation confirm�e';
  RST_NOTCONFIRMED = 'Installation non confirm�e';

  RST_NOGINKOIA = 'Le chemin d''installation de Ginkoia en local n''est pas valide';
  RST_SERVER = ' Serveur de la base de donn�es : ';
  RST_GINKOIA = ' Chemin d''installation de Ginkoia : ';
  RST_AKOI = ' connexion � la base ';
  RST_CONNECTED = 'Base connect�e';
  RST_MAG = ' Magasin : ';
  RST_POSTE = ' Poste : ';

  RST_NOBASE = 'Le fichier n''existe pas';
  RST_BADEXTENSION = 'Ce type de fichier n''est pas trait�';
  RST_FILENOTFOUND = 'Le fichier Ginkoia.IB n''a pas �t� trouv�';

  RST_BASETEST = 'Cr�ation de la base test sur  ';
  RST_CANCELBASETEST = 'Abandon de la cr�ation de la base test';
  RST_NOCONNECTED = 'Erreur de connexion � la base de donn�es';

  // easy
  RST_ERROR_EASYDEPLOY = 'Impossible de trouver l''exe de d�ploiement de Easy';
  RST_ERROR_INSTALLEASY = 'Une erreur s''est produite lors de l''installation d''EASY, veuillez contacter Ginkoia';
  RST_ERROR_INSTALLEASY2 = 'Une erreur s''est produite lors des GRANTS dans la base de donn�es, veuillez contacter Ginkoia ';
  RST_ERROR_EASYSPLIT = 'Impossible de trouver le fichier Split pour l''installation de Easy';
  RST_EASYSUCCESS = 'Installation de Easy termin�e avec succ�s';
  RST_EASY_CONFIRM_BASE_LOCALE = 'La base locale va �tre remplac�e et ne sera plus utilisable,' + #10 + 'les donn�es qui n''ont pas �t� r�pliqu�es seront d�finitivement perdues';
  RST_EASY_DELETE_BASE_LOCALE = 'Installation termin�e avec succ�s. ' + #10 + 'Voulez vous supprimer la sauvegarde l''ancienne base de donn�es ?';
  RST_ERROR_EASY_SOURCES = 'Impossible de trouver les fichiers sources d''Easy dans le r�pertoire s�lectionn�.' + #10 + ' Les fichiers "EasyDeploy.exe", "Java.7z" et "symmetric-pro-3.7.36-setup.jar" doivent �tre pr�sent';
  RTS_ERROR_FINDINGUDF = 'Impossible de trouver le r�pertoire d''installation des UDF d''Interbase sur C: ou D:';
  RTS_ERRORPUTUDF = 'Impossible de transf�rer les UDF Easy dans le r�pertoire d''Interbase.' + #13#10 + 'Cliquez sur Ok une fois la copie effectu�e, ou annuler pour annuler l''installation';
  RTS_ERRORFINDFILE = 'Installation d''Easy : Impossible de trouver le fichier : %s';

  RST_NOAMAJ = 'Impossible de cr�er le r�pertoire "GINKOIA\A_MAJ\", veuillez le cr�er manuellement';
  ERROROPENKEY = 'Erreur d''ouverture de la clef des registres';
  ERRORNOBASE = 'La base Ginkoia n''a pas �t� trouv�e';

  GINKOIA = 'Ginkoia.exe';
  CAISSE = 'CaisseGinkoia.exe'; // 'Caisse~1.exe';
  LAUNCHER = 'LaunchV7.exe';
  LAUNCHEREASY = 'LauncherEASY.exe';
  GINKOIABatD = 'GinkoiaD.bat';
  GINKOIABat = 'Ginkoia.bat';
  CAISSESECOUR = 'CaisseSecoursGinkoia.exe';
  VERIFICATION = 'Verification.exe';

  IBAdminUser = 'SYSDBA';
  IBAdminPwd = 'masterkey';

  NameFileParam = 'Deploiement.ini';
  NameVersion = 'Deploy-Version.ini';

  UsrISF = 'Nosymag';
  UsrGin = 'Ginkoia';



implementation

end.
