UNIT GinkoiaResStr;

INTERFACE

RESOURCESTRING
     //Bruno @@ 29/05/2002
     AnnulPasPossible=' Attention, annulation impossible,'+#13+#10+' c''est un ticket de r�ajustement de compte...';


    //Bruno @@ 20 14/05/2002
    Type31 = 'R�ajustement compte client';
    MotifObligatoire = 'La saisie d''un motif est obligatoire...';
    ReajustCompteLib ='REAJUSTEMENT DU COMPTE CLIENT';
    UILReajustCompte = 'caisse - REAJUSTEMENT D''UN COMPTE CLIENT';

//R.V @@16
    MrkDelDist = 'Confirmez que le Fournisseur "�0"' + #13 + #10 +
        'n''est plus distributeur de cette marque...';
    MrkINSDist = 'Confirmez que le Fournisseur "�0"' + #13 + #10 +
        'est distributeur de cette marque...';

    ChargeArbreMrk = 'Chargement et mise � jour de la liste des marques...';
    SupprMarque = 'Confirmez la suppression de la marque "�0"...';
    CantSupMarque = 'La suppression de la marque "�0" est IMPOSSIBLE...' + #13 + #10 +
        'Elle est r�f�renc�e par vos articles...';
    ManqueFouPrin = 'Il est indispensable de d�signer le fournisseur principal de cette marque!...';
    CancelMarque = 'Abandonner TOUTES les modifications effectu�es sur cette Marque?...';

    // 6 Lignes d�plac�es
    SupLienMrkCas1 = 'La marque distribu�e n''aura plus de fournisseur...';
    SupLienMrkCas2 = 'Vous n''avez pas d�fini de nouveau fournisseur principal pour cette marque...';
    SupLienMrkCas3 = 'Il y a des articles de cette marque en commande chez ce fournisseur...';
    SupFournCas1 = 'L''une des marques distribu�es n''aura plus de fournisseur...';
    SupFournCas2 = 'Vous n''avez pas d�fini le nouveau fournisseur principal de l''une des marques...';
    SupFournCas3 = 'Il y a des articles de l''une des marques en commande chez ce fournisseur...';

    SupLienMrkCas4 = 'Il y a des articles de cette marque dans une r�ception "NON Cl�tur�e" de ce fournisseur...';
    SupFournCas4 = 'Il y a des articles de l''une des marques dans une r�ception "NON Cl�tur�e" de ce fournisseur...';
    SupLienMrkCas5 = 'Il y a des articles de cette marque dont ce fournisseur est not� comme �tant "le fournisseur principal"...';
    SupFournCas5 = 'Il y a des articles de l''une des marques dont ce fournisseur est not� comme �tant "le fournisseur principal"...';

    SupLienMrkCas6 = 'Il y a des articles de cette marque dans un retour "NON Cl�tur�" de ce fournisseur...';
    SupFournCas6 = 'Il y a des articles de l''une des marques dans un retour "NON Cl�tur�" de ce fournisseur...';
    SupLienMrkCas7 = 'Il y a des articles de cette marque dans une annulation de commande "NON Archiv�e" de ce fournisseur...';
    SupFournCas7 = 'Il y a des articles de l''une des marques dans une annulation de commande "NON Archiv�e" de ce fournisseur...';
    SupLienMrkCas0 = 'Impossible c''est le fournisseur principal de marque';

    FrnNoDistrib = 'Marque sans fournisseur';
    FournMrkSup = 'Marque(s) supprim�e(s)';
    NapLib = 'Net � Payer';
    NapAvoirLib = 'Avoir Net';

//P.R. @@16
    InfVersementCoffre = 'Versement au coffre ';
{ @@15 Modifi� Herv� le 12/04/2002}
    CancelFourn = 'Abandonner TOUTES les modifications effectu�es pour ce fournisseur?...';
    NoMoreMagDetFrn = 'Vous avez d�j� d�fini les conditions particuli�res pour tous les magasins...';
    MessPostFrnCt = 'Enregistrement de la fiche du contact fournisseur...';
    MessPostFrnDet = 'Enregistrement de la fiche de conditions particuli�res...';
    MessDelFrnCt = 'Conrmimez la suppresion de la fiche contact fournisseur � l''�cran...';
    MessDelFrnDet = 'Conrmimez la suppresion de la fiche conditions particuli�res du fournisseur � l''�cran...';
    MessCancelFrnCt = 'Abandonner les modifications en cours dans la fiche du contact ?...';
    MessCancelFrnDet = 'Abandonner les modifications en cours dans les conditions particuli�res ?...';

// P.R. : 9/04/2002 : @@15 : ajout de la cat�gorie pour les factures
    CstCategorie9 = 'Ventes';

{ Modifi� Herv� Le : 09/04/2002  -   Ligne(s) }
    HintDbgContactFrn = '[INS] Cr�er un contact chez ce fournisseur  [Suppr] Supprimer le contact affich�';
    HintDbgCdtFrn = '[INS] Cr�er les conditions sp�cifiques d''un magasin [Suppr] Supprimer les conditions affich�es';
    LibComment = 'Commentaires';
    FrnContactDef = 'Contact Fournisseur';
    CapImpGlossaire = 'Edition du Glossaire';
    ListeDesMarques = 'Liste des marques';
    CapCreaMrk = 'Cr�ation d''une nouvelle Marque...';
    NomMrkExist = '"�0" : Nom de marque IMPOSSIBLE...' + #13 + #10 +
        'Il existe d�j� une marque r�f�renc�e portant nom !...';
    InputLabNeoMrk = 'Nom de la nouvelle marque...';
    DefCapInput = 'Boite de saisie...';
    DefLabInput = 'Votre saisie...';

    //22/03/2002 Bruno
    EtikCltTotal = 'Confirmez vous, l''impression des �tiquettes correspondant' + #13 + #10 + '� la liste des clients en cours?';
    EtikCount = 'Etiquette';
    EtikCountS = 'Etiquettes';

    //07/03/2002 Bruno
    Type00 = 'Ligne vide (Pas de fonction d�finie)';
    Type30 = 'Impression d''une �tiquette client';

{ Modifi� Herv� Le : 26/03/2002  -   Ligne(s) }
    LibRecep = 'Bon de R�ception';
    MessCreaLinkArt = 'Cr�ation de l''article et transfert' + #13 + #10 +
        'dans le "�0"';
///Pascal 25/03/2002
    CstAffInventaire = 'Affichage de l''inventaire en cours, patience...';

{ Modifi� Herv� Le : 19/03/2002  -   Ligne(s) }
    CreerMarqueDef = 'Faut-il cr�er une marque du m�me nom que celui de ce fournisseur ?...' + #13 + #10 +
        '( Cette marque se nommerait donc "�0" )';

    SupMarqueDist = 'Confirmez que la marque "�0" ne doit plus �tre distribu�e par ce fournisseur...';
    GrosYaRal = 'Il reste des articles en commande chez ce fournisseur' + #13 + #10 +
        'pour une marque qui n''est pas distribu�e par lui !...' + #13 + #10 +
        'Tant qu''il ne sera pas d�clar� comme distributeur de cette marque,' + #13 + #10 +
        'il devra imp�rativement rester grossiste...';

    AjoutMrkSel = 'Confirmez l''ajout des marques s�lectionn�es comme �tant distribu�es par ce fournisseur...';
    HintDbgMrkFrn = '[INS] Ajouter des marques distribu�es [Suppr] Si la marque point�e n''est plus distribu�e';
    HintDbgMrkFrnNoEdit = '[DoubleClic] Fiche de la marque point�e';

    HintRechFrn = '[F6] Liste des fournisseurs';

    SupFournAvort = ' La suppression ne peut �tre effectu�e...';

    HintNeoFoudef = 'S�lectionner le Nouveau fournisseur par d�faut de la marque "�0" ?...';
    PbAdresseFourn = 'Probl�me avec l''adresse de ce fournisseur ... Mise en �dition impossible !...';
    NomFournExist = 'Deux fournisseurs ne peuvent �tre cr�es avec le m�me nom !...';
    PbCreaFourn = 'Probl�me en validation de ce nouveau fournisseur ...' + #13 + #10 +
        'La cr�ation doit �tre abandonn�e...';
    TxtEnLS = 'Texte en lecture seule';
    FourNoDel = 'Impossible de supprimer ce fournisseur...'#13 + #10 +
        'car vous avez d�j� travaill� avec lui !)' + #13 + #10 +
        '(articles r�f�renc�s, articles en commande... etc.)';

{ Modifi� Herv� Le : 17/03/2002  -   Ligne(s) }

    LabProForma = 'Facture Pro Forma';
    MajTarModeles = 'Confirmez la r�actualisation des prix des mod�les s�lectionn�s... ';

    ModDevNoNeedMaj = 'Les prix sont � jour... ce mod�le ne n�cessite aucune r�actualisation !...';
    ModDevNoNeedMajSel = 'Les prix sont � jour... aucune r�actualisation n''a �t� n�cessaire !...';
    ModDevMaj = 'Mise � jour des prix du mod�le termin�e ... ';
    ModDevMajSel = 'Mise � jour des prix des mod�les s�lectinn�s termin�e ... ';

{ Modifi� Herv� Le : 11/03/2002  -   Ligne(s) }
    MessRecepRemRal = 'Cet article a �t� saisi en commande avec une remise de "�0"' + #13 + #10 +
        'diff�rente de la remise par d�faut du bon de r�ception (�1)' + #13 + #10 + #13 + #10 +
        'Faut-il forcer la remise par d�faut du bon de r�ception ?';

    NewFilterMess = 'Mise en place du filtre avanc� ...';
    StopFilterMess = 'Suppression du filtre avanc�... r�affichage des donn�es...';
    NbtAdvFilterHint = 'Expert filtre avanc�...';
    NegPxUHT = 'Px Unit HT';
    NegPxUTTc = 'Px Unit TTC';

    ConsoQteNega = 'Le stock est... ou va devenir n�gatif !... Continuer ?';

    DateDocMess = 'Votre document est � une date ... "dans le futur" !...' + #13 + #10 +
        'Est-ce bien normal et faut-il l''accepter ?... ';
    TitleExpertCat = ' Expert de gestion des cat�gories de familles';
    TitleExpertCat1 = ' Expert de gestion des cat�gories de Rayons';

    CNFCategorie0 = 'Retirer la famille "�0" de la liste des Cat�gories ?...' + #13 + #10 +
        '(Cette Famille n''aura plus de Cat�gorie associ�e...)';
    CNFAffectCategorie = 'Placer la Famille "�0"' + #13 + #10 +
        'dans la Cat�gorie "�1" ?...';

    CNFCangeCatFam = 'D�placer la Famille "�0"' + #13 + #10 +
        'de la Cat�gorie "�1"' + #13 + #10 +
        'vers la Cat�gorie "�2"';

    CNFCangeSecRay = 'D�placer le Rayon "�0"' + #13 + #10 +
        'du Secteur "�1"' + #13 + #10 +
        'vers le Secteur "�2"';
    DbgRExpertSectHint = '[Ctrl + Fl�che Droite] Affecte le rayon point� au Secteur en cours [Suppr] Retirer l''�l�ment point�';
    DbgSRExpertSectHint = '[Ctrl + Fl�che Gauche] Retire le rayon point� du Secteur  [Drag && Drop] Pour r�organiser les Secteurs';

    DbgRExpertCatHint = '[Ctrl + Fl�che Droite] Affecte la famille point�e � la Cat�gorie en cours [Suppr] Retirer l''�l�ment point�';
    DbgSRExpertCatHint = '[Ctrl + Fl�che Gauche] Retire la famille point�e de la Cat�gorie  [Drag && Drop] Pour r�organiser les Cat�gories';
    DbgRExpertCatHint1 = '[Ctrl + Fl�che Droite] Affecte le rayon point� � la Cat�gorie en cours [Suppr] Retirer l''�l�ment point�';
    DbgSRExpertCatHint1 = '[Ctrl + Fl�che Gauche] Retire le rayon point� de la Cat�gorie  [Drag && Drop] Pour r�organiser les Cat�gories';

    ExpertSectTitre = 'Liste des secteurs avec leurs rayons associ�s';
    ExpertCatFamTitre = 'Liste des cat�gories';

    ExpertCarFamTitre = 'Liste des cat�gorie avec leurs familles associ�es';
    ChargeImpMess = 'Chargement de l''impression en cours...';
    LoadArtRay = 'Chargement de la liste des articles du rayon ...';
    NkArtRefCap = 'Articles r�f�renc�s';
    NkCatFournCap = 'Articles des catalogues fournisseurs';

    SupRelGtsNK = 'Confirmez la suppression de l''association de la grille statistique' + #13 + #10 +
        '"�0"' + #13 + #10 + '� cette sous-famille...';
    NoSupGTSBaseNK = 'On ne peux pas supprimer l''association avec la grille statistique de base...';
    NKOrdre = ' [Ctrl + H ou B] R�monter / Descendre l''�l�ment dans sa liste';
    NkRayVersHaut = '[Ctrl+H] D�placer le rayon d''un cran vers le haut dans la liste des rayons';
    NkRayVersBas = '[Ctrl+B] D�placer le rayon d''un cran vers le bas dans la liste des rayons';
    NkFamVersHaut = '[Ctrl+H] D�placer la famille d''un cran vers le haut dans la liste des familles';
    NkFamVersBas = '[Ctrl+B] D�placer la famille d''un cran vers le bas dans la liste des familles';
    NkSFVersHaut = '[Ctrl+H] D�placer la sous-famille d''un cran vers le haut dans la liste des sous-familles';
    NkSFVersBas = '[Ctrl+B] D�placer la sous-famille d''un cran vers le bas dans la liste des sous-familles';

    YaKunItem = 'On ne peut pas supprimer directement le dernier "item" d''une branche de' + #13 + #10 +
        'la nomenclature (chaque branche doit avoir au moins 1 "enfant") ...' + #13 + #10 +
        'Il faut supprimer son "parent"...';

    NkDefFam = 'NOUVELLE FAMILLE';
    NkDefSF = 'NOUVELLE SOUS-FAMILLE';

    DelNkRay = 'Confirmez la suppression du rayon "�0"';
    DelNkFam = 'Confirmez la suppression de la famille "�0"';
    DelNkSF = 'Confirmez la suppression de la sous-famille "�0"';

    DeleteNKRV = 'Probl�me lors de la suppression... le traitement est annul� !';

    YaArtDedans = 'Suppression impossible car il y a des articles r�f�renc�s...' + #13 + #10 +
        '(ou des articles des catalogues fournisseurs)';
    NbtParamRech = 'D�finir une collection pour l''outil de rechereche...';
    ParamRechTout = 'Toutes collections';
    CdeRechVideCollec = 'Aucun article trouv� dans la collection active... ' + #13 + #10 +
        '(Cet article existe peut-�tre mais n''est pas accessible dans votre contexte de travail actuel )';
    NkDetail = 'D�tail de l''�l�ment s�lectionn�';
    HintNk = 'Nomenclature...  [ECHAP] Masquer la nomenclatuer';
    LabArtVide = '( Modifiable, ne contient aucun article )';
    LabArtNoVide = '( Non modifiable, contient des articles )';

    NkRefreshMess = 'Fermeture de l''outil de gestion de la nomenclature';
    NkGesCharge = 'Chargement de l''outil de gestion de la nomenclature...';
    NkChxArt = 'Liste des articles selon la nomenclature...';
    NKCapGes = ' Gestion de la nomenclature';
    NkRayon = 'Rayon';
    NkFamille = 'Famille';
    NkSSF = 'Sous-Famille';
    NkSecteur = 'Secteur';
    NkCategorie = 'Cat�gorie';

    NoNkDispo = 'Cha�nage imposssible' + #13 + #10 + 'tant que vous n''avez pas termin� le travail en cours...';

    NoNkSelected = 'Aucun �l�ment s�lectionn� !...';
    NeedRayon = 'Il faut s�lectionner un rayon !... ';
    NeedFamille = 'Il faut s�lectionner une famille !... ';
    NeedSSF = 'Il faut s�lectionner une sous-famille !... ';

    NkNoArt = 'Aucun article s�lectionn�!...';
    NkCapFourn = ' Nomenclature : [Double clic] ou [F4] Exporte l''article point� dans la liste...';
    NkCapListart = ' Nomenclature : [Double clic] ou [F4] Sur un article de la liste ouvre sa fiche...';
    NKCapNormal = ' Nomenclature Ginkoia';
    FreeNk = 'D�charger la nomenclature de la m�moire ?...';

{ Modifi� Sandrine Le : 15/02/2002  -   Ligne(s) }
    GestDroit = 'Vous n''avez pas les droits suffisant pour acc�der' + #13 + #10 +
        '� cette partie du programme' + #13 + #10 +
        'Contactez votre responsable !';

{ Modifi� Sandrine Le : 11/02/2002  -   Ligne(s) }
    CapCmzMenuDo = 'Activer la personnalisation des barres outils';
    CapCmzMenuOff = 'D�sActiver la personnalisation des barres outils';

    HintNextRec = 'Fiche suivante...';
    HintPriorRec = 'Fiche pr�c�dente...';

    FinFiches = 'Fin du fichier ...';
    debFiches = 'D�but du fichier ...';
    NoGoodPeriode = 'La date de fin doit �tre post�rieure � celle de d�but !...';
    FiltreReinit = 'Confirmer la suppression compl�te de toutes les conditions s�lectionn�es...';
    HintBtnDocSel = 'Ouvre le document point� dans son module de gestion...';
{ Modifi� BRUNO Le : 04/02/2002  -   Ligne(s) }
    EtiquetteEssai = 'Souhaitez vous imprimer une �tiquette d''essai?';
    SautEtiquette = 'Impossible, le nombre d''�tiquette(s) � sauter doit �tre compris entre 0 et 20...';
    TitreEtikDiff = 'Impression des �tiquettes diff�r�es';
    PasSelect = 'Impression impossible, vous n''avez pas s�lectionn� les lignes...' + #13 + #10 +
        'Le bouton en bas � gauche vous permet de tous s�lectionner.';

{ Modifi� RV Le : 04/02/2002  -   Ligne(s) }
    messClotEtArchDoc = 'Le document � l''�cran n''est pas "cl�tur�"...' + #13 + #10 +
        'Faut-il le cl�turer et l''archiver ?...' + #13 + #10 +
        '(Attention : l''archivage est irr�versible!...)';

    MessArchDoc = 'Confirmer l''archivage du document affich� � l''�cran' + #13 + #10 +
        '(Attention : l''archivage est irr�versible!...)';

    TitClotDoc = ' Cl�ture du document affich�...';
    TitArchDoc = ' Archivage du document affich�...';
    MessClotDoc = 'Confirmer la cl�ture du document affich� � l''�cran' + #13 + #10 +
        '(Attention : la cl�ture est irr�versible!...)';

    LibVendeur = 'Affaire suivie par :';
    CapMagStk = ' Magasin qui sera d�stock�...';
    CapMagDev = ' Aucun mouvement de stock...';
{ Modifi� RV Le : 26/01/2002  -   Ligne(s) }
    LibConf = 'Confirmation';
    LibInfo = 'Information';
    DefOuiNon = 'Confirmez votre choix... ';
    CapDlgTransDev = 'Transfert du devis affich�...    ';
    CapDlgTransMod = 'Copie du mod�le affich�...    ';
    LibModele = 'Mod�le';
    OkDevTransModele = '"Le document "�0" N� �1 a �t� g�n�r� � partir du mod�le affich� � l''�cran...';
    OkDevTransNeoMod = 'Le mod�le N� "�0" a �t� g�n�r� � partir du document affich� � l''�cran...  ';

    ComentDevTrans = '* Transf�r� depuis le devis N� �0';
    ComentCopyDev = '* Copi� depuis le devis N� �0';
    ComentDevTransMod = '* Copi� depuis le mod�le N� �0';

    PbTransDev = 'Probl�me lors du transfert du devis...' + #13 + #10 +
        '(Le transfert est abandonn�...)';
    NoGoodParamTrans = 'Le param�trage de Ginkoia est incomplet...' + #13 + #10 +
        'Impossible de proc�der au transfert!...';
    BLLib = 'Bon de livraison';
    DevLib = 'Devis';
    DoDevTransDoc = 'Confirmez le transfert en "�0" du Devis affich� � l''�cran...   ';
    DoCopyModele = 'Confirmez la copie en "�0" du mod�le affich� � l''�cran...   ';
    DoCopyModMod = 'Confirmez la copie en "�0" du document affich� � l''�cran...   ';

    OkDevTrans = 'Le devis affich� � l''�cran a �t� transf�r� en "�0" N� �1   ';
    DoTransNoModele = '(apr�s transfert le devis d''origine ne sera plus modifiable)';

    HintGenEdit = '[DoubleClic ou F4] Si champ avec "bouton", action associ�e au bouton';
    VendeurDef = 'Vendeur par d�faut des nouvelles lignes';
    HintEdBtnCanClear = '[DoubleClic ou F4] Liste associ�e [SUPPR] Vider le champ';
    HIntMemosLS = '[ENTREE] Champ suivant... [Double Clic ou F4] Ouvrir l''afficheur du m�mo';
    CannotChangeTipModele = 'On ne peut pas changer le type d''un mod�le...';
    DevTitreListe = 'Liste des devis';
    DevTitreMod = 'Liste des Mod�les';
    NoSupprExportedDev = 'Suppression impossible !' + #13 + #10 +
        'Ce devis contient des lignes transf�r�es dans un autre document!...';
    NoSupprExportedLine = 'Suppression impossible !' + #13 + #10 +
        'Ligne de devis transf�r�e dans un autre document...';
    ImpIntDev = 'Devis N� �0 - Client N� �1  �2';

{ Modifi� RV Le : 22/01/2002  -   Ligne(s) }
    MrkDejaRef = 'Marque d�j� r�f�renc�e chez ce fournisseur...';
    MessOuvreRal = 'Mise en place du contr�le dans le "Reste � Livrer"...';
    MessChargeArtRef = 'Chargement de la liste des articles r�f�renc�s....';
    MessChargeStkDetail = 'Chargement de la liste des articles d�taill�s...';
    MessChargeStk = 'Etat de stock en construction...';
    MessChargeCAHoraire = 'Chargement du C.A. horaire...';
    MessChargeCAVendeur = 'Chargement du C.A par vendeur...';
    MessChargeHitVte = 'Chargement du hit parade des ventes...';
    MessChargeJV = 'Chargement du journal des ventes...';
    MessChargeListeTKE = 'Chargement de la liste des tickets...';
    MessTransBL = 'Transfert des bons de livraison en facture...';
    MessSupTar = 'Suppression du tarif de vente...';
    MessChargeCatFourn = 'Chargement des articles du catalogue fournisseur...';
    MessChargeCptClt = 'Chargement des comptes clients...';
    MessChargeDemark = 'Chargement de la liste des d�marques...';
    MessInitListDoc = 'Initialisation de la liste des documents...';
    MessChargeCarnetCde = 'Chargement du carnet de commandes...';
    MessChargeAnalSynt = 'Chargement de l''analyse synth�tique...';
    MessChargeTar = 'Chargement du tarif de vente...';
    MessInvPortable = 'Patienter pendant l''int�gration du portable... ';
    MessInvCreaImp = 'Cr�ation de l''impression en cours...';
    MessAjoutArtInv = 'Ajout des articles en cours...';
    MessVerifInv = 'V�rification en cours ...';
    MessOuvreInv = 'Ouverture de l''inventaire en cours';
{ Modifi� RV Le : 18/01/2002  -   Ligne(s) }
    HintVoirFiltre = 'Voir le filtre en cours';
    ArtStkCourTitle = 'Etat de stock courant';
    Crlf = #13 + #10;
    CaHoraireDateLib = 'CA Horaire par date';
    CaHoraireVendeurLib = 'CA Horaire par vendeur';

{ Modifi� RV Le : 15/01/2002  -   Ligne(s) }
    TitleTabordBL = 'Bons de livraison en cours';
{ Modifi� RV Le : 10/01/2002  -   Ligne(s) }
    LabPxv = 'Px Vente';
    LabPxvHT = 'PxVte HT';
    MajTarFichart = 'Le prix d''achat est diff�rent de celui de la fiche article...    ' + #13 + #10 +
        '   Faut-il mettre � jour cette derni�re ?';

{ Modifi� RV Le : 07/01/2002  -   Ligne(s) }
    HintDbgDef = '[Maj+F11] Colonnes � leur largeur minimum';
  // Pascal 07/01/2001
    CstInvClotureNonOK = '    Erreur durant La cl�ture de l''inventaire   ' + #13 + #10 + #13 + #10 +
        '    Appeler ALGOL pour r�soudre votre probl�me ';
{ Modifi� RV Le : 04/01/2002  -   Ligne(s) }
    NoGoodDevise = 'IMPOSSIBLE : la devise affich�e n''est la devise de travail de vos donn�es...   ';

    LabDateStk = 'Editer l''�tat du stock au';

    StkDetailLib = 'Liste d�taill�e des articles au : �0';
{ Modifi� Pascal 31/12/2001 }
    CstAnalSynth = 'Analyse synth�tique du �0 au �1  -  ';

{ Modifi� RV Le : 04/01/2002  -   Ligne(s) }
    HintBasculeGrpFoot = 'Basculer les cumuls interm�diaires entre "pied" et "ent�te" de groupe';
{ Modifi� RV Le : 31/12/2001  -   Ligne(s) }
    AfftarBase = 'Confirmez l''affichage du tarif de vente g�n�ral...     ' + #13 + #10 +
        '  ( Ce tarif concernant tous vos articles r�f�renc�s, son affichage peut �tre assez long )     ';
    SupTarVente = 'Retirer l''article s�lectionn� de ce tarif de vente ?...    ';
    HintSumOnGroup = 'Afficher / Masquer les cumuls sur les lignes d''ent�te de groupe';
    HintAutoWidth = 'Ajustement automatique des colonnes "au mieux"';

{ Modifi� RV Le : 26/12/2001  -   Ligne(s) }
    NoTouchTarBase = 'On ne peut ni modifier ni supprimer le tarif g�n�ral !...    ';
    AffecteTarVente = 'Confirmez que le tarif              ' + #13 + #10 + #13 + #10 +
        '   �0' + #13 + #10 + #13 + #10 + '   devient le tarif du magasin                        ' + #13 + #10 +
        #13 + #10 + '   �1' + #13 + #10;
    DeleteTarVente = 'Confirmez la suppression du tarif de vente "�0"    ' + #13 + #10 +
        '( ATTENTION : cette op�ration supprime le tarif de tous les articles concern�s )   ';
    DeleteTarVente2 = 'La suppression d''un tarif de vente est irreversible...    ' + #13 + #10 +
        'Faut-il continuer ?...   ';
    SupTarVenteOk = 'Suppression du tarif de vente termin�e...    ';
    TarVenteLinked = 'Impossible de supprimer ce tarif de vente car     ' + #13 + #10 +
        'il est appliqu� par un magasin!... ';

{ Modifi� RV Le : 24/12/2001  -   Ligne(s) }
    LabInactif = 'Inactif';
    LabNoDoc = 'Aucun document';
    LabEnModif = 'En Modification';
    LabEnCrea = 'En cr�ation';
    LabArchive = 'Archiv� et Cl�tur�';
    LabCloture = 'Cl�tur�';
    LabNonModif = 'Non Modifiable';
    LabCanModif = 'Modifiable';

{ Modifi� RV Le : 19/12/2001  -   Ligne(s) }
    NoClient = 'Impossible de trouver ce client dans le fichier !    ';

    CstPassageEuro = '  ATTENTION, vous devez passer d�finitivement � l''Euro.'#13#10 +
        'Pour cela vos caisses doivent avoir leur sessions cl�tur�es.'#13#10 +
        '        De plus elles doivent �tre ferm�es.'#13#10#13#10 +
        ' Voulez-vous lancer le passage � l''Euro ? ';
    CstPassageEuro2 = 'Etes-vous sur de ne pas avoir oubli� de cl�turer vos sessions de caisse'#13#10 +
        'et de quitter le programme de caisse, ainsi que Ginkoia sur tous les autres postes.'#13#10#13#10 +
        'L''application Ginkoia de ce poste se refermera automatiquement apr�s le passage � l''euro.'#13#10 +
        'Vous devrez la relancer.';

{ Modifi� RV Le : 16/12/2001  -   Ligne(s) }
    PaysOblig = 'La saisie d''un nom de pays est obligatoire';
    VilleOblig = 'La saisie d''un nom de ville est obligatoire';

{ Modifi� RV Le : 14/12/2001  -   Ligne(s) }
    CstTousMag = 'Tous Magasins';

    BLTransDeja = 'Bon de livraison d�j� transf�r� en facture';
{ Modifi� RV Le : 08/12/2001  -   Ligne(s) }
    RetroLIb = 'R�trocession';
    FacRetroLib = 'Facture de r�trocession';
    LibHT = 'Px Vte HT';
    LibTTC = 'Px Vte TTC';
    LabTipTTC = 'Montant TTC';
    LabTipHT = 'Montant HT';

{ Modifi� RV Le : 06/12/2001  -   Ligne(s) }
    LabDateRglt = 'Date de r�glement';
    FacImpDateDef = 'En votre aimable r�glement';
    BLTransNoProd = 'Ne peut �tre transf�r� en automatique ( Montant BL Nul )';
    NoImpDocVide = 'Document vide !... aucune ligne � imprimer.    ';
    TransMultiAvorted = 'Probl�me lors du transfert d''un document, le transfert est annul�...    ';

{ Modifi� RV Le : 03/12/2001  -   Ligne(s) }
    FactNoTip = 'Le type du document est obligatoire ...   ';
    NoCatalog = 'Aucun catalogue fournisseur disponible sur votre machine ...  ';
    NoSupportedUnidim = 'Fonctionnalit� "Taille/Couleur" sans objet dans un univers qui n''en dispose pas!...     ';
    ListClient = 'Liste des clients';
    HintExpandLevel = 'Afficher les lignes de groupe suivant...';
    HintCollapseLevel = 'Afficher les lignes de groupe pr�c�dent...';

{ Modifi� RV Le : 27/11/2001  -   Ligne(s) }
    NegSumMtTTC = 'Montant TTC';
    NegSumTotalTTC = 'Total TTC';
    NegSumMtHT = 'Montant HT';
    NegSumTotalHT = 'Total HT';

    NegEntetPxuTTC = 'PxU TTC';
    NegEntetPxuHT = 'PxU HT';
    NegEntetMtTTC = 'Mt TTC';
    NegEntetMtHT = 'Mt HT';

    DevisePays = 'FRF';
    DeviseEuro = '�';
    NoNegEuro = 'D�sol�, mais on ne peut imprimer une facture que dans la monnaie de r�f�rence...    ';
    CoefNull = 'Attention : Prix de vente de base � "0"...     ' + #13 + #10 +
        '   Faut-il l''accepter ?...     '#13 + #10;

{ Modifi� RV Le : 25/11/2001  -   Ligne(s) }
    DocImp = 'Imprimer le �0 documents s�lectionn�s ?...     ';
    NegFacCroPro = 'N� � validation';
    NoDocArticle = 'Aucun article en cours (affich�) dans la fiche article...   ';
    DocCloture = 'Confirmer la cl�ture de(s) �0 document(s) s�lectionn�(s)...    ';
    NoDocCloture = 'Aucun document � cl�turer...      ';
    DocLineINEdit = 'Impossible de changer de page tant que la ligne en cours n''a pas �t� valid�e...    ';
{ Modifi� Sandrine Le : 21/11/2001  -  2 Ligne(s) }
    CsBL = 'Bons de livraison';
    CsFacture = 'Factures';

{ Modifi� RV Le : 20/11/2001  -   Ligne(s) }
    RefTotoFait = 'Mise � jour des cumuls du document effectu�...   ';
    AfterToDay = 'Impossible de saisir une date post�rieure � aujourd''hui!...    ';
    MaxToDay = 'Impossible de saisir une date ant�rieure � aujourd''hui!...    ';

{ Modifi� RV Le : 15/11/2001  -   Ligne(s) }
    CdeRefreshToto = 'ATTENTION : le recalcul n''est � ex�cuter que si vous avez    ' + #13 + #10 +
        '   une anomalie dans les cumuls affich�s dans l''ent�te du document !...   ' + #13 + #10 +
        '   Ne confirmer que si vous �tes dans ce cas !';
    ArchivedDoc = 'Document archiv� !... Il ne peut plus �tre ni modifi� ni supprim�.    ';
    CloturedDoc = 'Document cl�tur� !... Il ne peut plus �tre ni modifi� ni supprim�.    ';
    NotModifDoc = 'Document non modifiable... ( ni "supprimable" ).    ';
    NoSupprImportedLine = 'Impossible de supprimer une ligne import�e depuis un Bon de Livraison !...   ';
    NoSupprImportedFac = 'Impossible de supprimer cette facture !...     ' + #13 + #10 +
        '   ( Elle contient des lignes import�es depuis un Bon de Livraison )    ';

    FacLib = 'Facture';
    AvoirLib = 'Avoir';
    FacPbCptClt = 'Probl�me de mise � jour du compte client!...    ';
    ImpIntFac = 'Facture N� �0 - Client N� �1  �2';
    ImpIntBL = 'BL N� �0 - Client N� �1  �2';
    HintDbgDoc = '[F2] Editer  [SUPPR] Supprimer  [Double Clic] Editer ... la ligne en cours du document affich�';
    NoDocFound = 'Le document "�0" n''a pas �t� trouv� dans la liste des documents...     ';
    BLTransNoLine = 'Aucune ligne � tyransf�rer !...';
    NegLabTitle = 'Ent�te de groupe';

    // Pascal Le 6/11/2001
    CstInvAfficher = 'Appuyer sur le bouton afficher les articles pour pouvoir charger le PHL !';
    CstInvSUPNon = 'La suppression d''un inventaire n''est plus possible apr�s sa cl�ture.';
    CstStckCourDate = 'Etat de stock au �0';

{ Modifi� RV Le : 05/11/2001 }
    HIntMemos = '[CTRL+ENTREE] Pour valider le champ ... [Double Clic ou F4] Ouvrir l''�diteur associ�';
    BLNOTrans = 'Aucun transfert � effectuer';
    BLTransEnFact = 'Transf�r� en facture';
    BlConfTrans = 'Confirmez le transfert en facture des bons de livraison s�lectionn�s...    ';
    BLPBLORSTRAns = 'Probl�me lors du transfert de ce bon de livraison en facture...';
    BLTransNoPoss = 'Transfert impossible ...';
    NegCOmTransBL = 'Transfert du Bon de livraison N� ';
    DoBLTransFact = 'Confirmez le transfert du bon de livraison affich� en facture...   ' + #13 + #10 +
        '   (apr�s transfert le bon de livraison ne sera plus modifiable)';
    BLKourOkTransFact = 'Le bon de livraison a �t� transf�r� dans la facture N� �0    ';
    BLKourNoTransFact = 'Probl�me lors du transfert de ce bon de livraison en facture...    ';
    BLTitreListe = 'Liste des bons de livraison';
    FacTitreListe = 'Liste des Factures';
    HintEditGen = '[Ins] Cr�er [F2] Editer [Suppr] Supprimer';
    HintEditDBG = '[Ins] Cr�er [F2] Editer [Suppr] Supprimer la ligne s�lectionn�e';

    ChpBtnComent = '[F4 ou DoubleClic] Ouvre le bloc m�mo de saisie associ�';
    NegLabComent = 'Texte libre';
    NegLabArticle = 'D�signation';
    NoChangeBecauseModif = 'La modification de ce champ n''est possible      ' + #13 + #10 +
        '   que lorsque le document est en cr�ation...  ';
    NoChangeBecauseLines = 'La modification de ce champ n''est plus possible      ' + #13 + #10 +
        '   lorsque des lignes existent dans le document...  ';
    FactNoClt = 'La saisie d''un client est obligatoire !      ';
    FactNoMag = 'La saisie du magasin est obligatoire !      ';
    ConfDeleteDoc = 'Confirmer la SUPPRESSION du document en cours ...    ';

    // Pascal Le 9/11/2001
    CstStockTousMag = 'Stock d�taill� tous magasin';
    // Pascal le 7/11/2001
    CstCaVendeurDateLib = 'CA par vendeur du �0 au �1  -  ';
    CstCaVendHeureDateLib = 'CA horaire par vendeur du �0 au �1  -  ';
    CstCaJourHeureDateLib = 'CA horaire par jour du �0 au �1  -  ';

    // Pascal le 6/11/2001
    CstInvRecompter = 'Recompter les articles de la liste ?';
    CstInvSupprimer = 'Ne pas recompter les articles de la liste et les sortir de l''inventaire ?';

    // Pascal le 6/11/2001
    CstInvAjoutArticle = 'Ajouter la selection � l''inventaire ?';

    // Modifi� Pascal le 02/11/2001
    CstFamille = 'Famille';
    CstSSFamille = 'Sous-Famille';
    CstCategorie = 'Cat�gorie';
    CstGenre = 'Genre';

{ Modifi� RV Le :  02/11/2001 }
    ConsodivList = 'Liste des consommations diverses en saisie...    ';
    EdEcartInv = 'Ecarts d''inventaire du �0 au �1  -  ';

    // Modifi� Pascal le 31/10/2001
    CstInvClotureOK = 'La cl�ture de l''inventaire c''est bien pass�e';
    CstInvClotEnCours = 'Cl�ture de l''inventaire en cours';
    CstInvDemEnCours = 'Cr�ation de la d�marque en cours';
    CstInvProblemePHL = 'Probl�me de r�c�ption sur le PHL';
    CstInvChargePHL = 'Chargement du PHL termin�';
    CstInvTousCompte = 'Aucun article n''a �tait mouvement� pendant l''inventaire'#13#10'                Rien n''est � recompt�';
    CstInvARecompte =
        '   Les articles suivant ont �tait mouvement� pendant l''inventaire'#13#10'Vous devez les recompter ou ils ne seront pas consid�r� dans la cl�ture';
    CstInvOuvOk = 'L''ouverture d''inventaire c''est bien pass�e.'#13#10'Vous pouvez maintenant commencer � travailler';
    CstInvTitreImpNC = ' Edition des non compt�s inventaire num �0, �1';
    CstInvTitreImpEcart = ' Edition des �carts inventaire num �0, �1';
    CstInvTitreImpValo = ' Edition valoris�e de l''inventaire num �0, �1';
    CstHistoTaille = 'Toutes tailles';
    CstHistoCoul = 'Toutes couleurs';

{ Modifi� RV Le : 30/10/2001  -   Ligne(s) }
    NoDataVide = 'Impossible de valider sans une donn�e significative!...    ';

    // Pascal 11/10/2001

    CstInvTousArt = 'Vous avez d�j� ajout� tous les articles';
    CstInvTousArtConf = 'Etes-vous sur de vouloir ajouter tous les articles � l''inventaire ?';
    CstInvChoixNomenc = 'Choix d''une nomenclature pour l''inventaire';
    CstInvClot = 'Inventaire cl�tur�';
    CstInvOuv = 'Inventaire en cours';
    CstInvPrep = 'Pr�paration d''inventaire';
    CstInvQuestOuv = 'Etes-vous sur de vouloir ouvrir l''inventaire ?';
    CstInvZone = 'Zone Num : �0';
    CstInvAjoutUnArt = 'L''article n''est pas pr�sent en inventaire, '#13#10'           Voulez-vous l''ajouter ?';
    CstInvImpAjoutUnArt = 'L''article n''est pas pr�sent en inventaire, '#13#10'Impossible de l''ajouter pour un inventaire magasin ouvert';
    CstInvCorrection = 'Cr�ation d''une session de correction';
    CstInvRechVide = 'Aucun article trouv� ... ( V�rifier s''il est en inventaire )   ';
    CstInvSupInv = 'ATTENTION la suppression est d�finitive et irr�vocable. '#13#10'          Etes vous sur de vouloir supprimer ? ';
    CstInvRecep = 'R�ception des donn�es en cours';
    CstInvArtOk = ' OK ';
    CstInvArtNI = ' Pas en inventaire ';
    CstInvArtNT = ' Pas trouv� ';
    CstInvArtInd = ' R�f�rence impr�cise ';
    CstInvTitreImpINV = 'Inventaire Num : �0,   �1 ';
    CstInvTitreImpSES = 'Inventaire Num : �0, Session  �1 : �2 ';
    CstInvErreurZone = 'Veuillez saisir une zone ! ';
    CstInvCloture = ' Etes-vous sur de vouloir cl�turer l''inventaire ?';
    CstInvAnnulSaisie = 'Voulez-vous annuler votre saisie ?';

{ Modifi� RV Le : 20/10/2001  -   Ligne(s) }

    TitleHistoVente = 'Historiques de vente de l''article - Chrono : ';
    TitleHistoMvt = 'Historiques des mouvements de l''article - Chrono : ';
    TitleHistoRetro = 'Historiques "R�tros et D�marques" de l''article - Chrono : ';

// Herv�  6/10/2001
    HintcdvMM = 'Liste des consommations diverses depuis le :';
    HintBtnCopy = '[CTRL+P] ou [Clic Bouton "..."] Recopie la valeur de la fiche pr�c�dente';
    ErrFrnDelContact = 'Confirmez la suppression du contact s�lectionn�...   ';
    ErrNomContact = 'Un contact doit obligatoirement avoir un nom !... ';
    FrnCapDetail = 'Renseignements compl�mentaires';
    FrnNoDelSeul = 'Impossible, un fournisseur doit obligatoirement avoir une marque...   ';
    FrnNoDelCde = 'Impossible de supprimer,     ' + #13 + #10 + '   il y a des commandes de cette marque chez ce fournisseur...      ';
    FrnNoDelRecep = 'Impossible de supprimer,     ' + #13 + #10 + '   il y a des r�ceptions de cette marque chez ce fournisseur...      ';
    FrnNoDelPrin = 'Impossible... car cette marque n''aurait plus de fournisseur principal!   ' + #13 + #10 +
        '   (Il suffit de lui associer un autre fournisseur principal)     ';

    errMajPvteRecep = 'Erreur lors de la mise � jour du prix de vente... ' + #13 + #10 +
        ' Il faudra aller le mettre � jour dans la fiche article.   ' + #13 + #10 +
        ' SVP : prevenez Algol que vous avez eu ce message... Merci ';

// Pascal 5/10/2001
    CstCategorie1 = 'Commandes';
    CstCategorie2 = 'Achats';
    CstCategorie3 = 'R � L';
    CstCategorie4 = 'R�trocessions';
    CstCategorie5 = 'Ventes';
    CstCategorie6 = 'BL et pr�ts';
    CstCategorie7 = 'D�marque';
//------------------------------

    MessSoon = 'C''est pour bient�t';
    FormatCumStk = 'Cumul Stock';
    FormatCumVal = 'Cumul Valeur';
    FormatCumPvte = 'Cumul Px Vente';
// EAI

    ErrEAI = ' Une erreur � eu lieu lors de la r�plication de vos donn�es!' + #13 + #10 +
        ' Appelez ALGOL en urgence !';
    ErrPush = ' Erreur lors de ENVOI du module : �0 ';
    ErrPull = ' Erreur lors de la RECEPTION du module : �0 ';
    Donnee = ' - Donn�es "';
    DonneeEnvFin = '" envoy�es !';
    DonneeRecFin = '" re�ues !';
    Fin1 = 'Envoi termin� avec succ�s';
    Fin = 'R�c�ption termin� avec succ�s';
    ErrFin1 = 'Echec lors de l' + #39 + 'envoi de vos donn�es';
    ErrFin = 'Echec lors de la r�c�ption de vos donn�es';

//
    IniCreaArtSport = 'Article dimensionn� (Tailles, couleurs)';
    IniCreaArtBrun = 'Article Normal';

    RecepConfRef = 'Confirmer le r�f�rencement de l''article catalogue r�f�rence "�0" ...    ';
    PbReferencement = 'Probl�me de r�f�rencement... impossible de continuer !     ';
    RecepLibRef = 'R�f catalogue :';

// Boutons et Hints

    CapRayon = 'Rayons';
    CapMag = 'Magasin';
    CapCaNet = 'CA NET';
    CapCaBrut = 'CA BRUT';
    CapMrgV = 'Marge Valeur';
    CapCamv = 'C.A.M.V';

    CapCouleur = 'Couleur';
    CapChrono = 'Chrono';
    CapRef = 'Ref';
    CapArticle = 'Article';
    CapEte = 'Et�';
    CapHiver = 'Hiver';

    CapEnregSel = 'Enregistrer la s�lection';
    CapEnregistrer = '&Enregistrer';
    CapFamilleDe = 'Familles de';
    CapLaNk = 'La Nomenclature';
    CapSfDe = 'Sous-Familles de';
    CapFermer = '&Fermer';
    CapPrincipal = 'Principal';
    CapQuitter = '&Quitter';
    CapCancel = '&Abandonner';
    HintDlgQuit = '[Echap] Quitter';
    HintDlgOkCancel = '[F12]  OK    [Echap]  Abandonner ';
    HintMemo = '[Maj+Fl�che Haut] Champ pr�c�dent  [Maj+Fl�che Bas] Champ Suivant';

    HintExpandNode = 'Ouvrir toutes les lignes du groupe de lignes s�lectionn�';
    HintCollapseNode = 'Fermer le groupe de lignes s�lectionn�';
    HintFullExpand = 'Ouvrir la liste � son niveau de d�tail maximum';
    HintFullCollapse = 'Fermer la liste (n''afficher que son 1er niveau de d�tail)';

    HintBtnConvert = 'Changer la monnaie d''affichage ...';
    HintBtnPreview = 'Afficher / Cacher la ligne de donn�e suppl�mentaire';
    HintBtnPrintDbg = 'Imprimer la liste affich�e';
    HintBtnSelMag = 'Liste de s�lection des magasins... ';
    HintPeriodeEtude = 'D�finir une p�riode d''�tude... ';
    HintBtnCmzDbg = 'Outil de configuration des lignes';
    HintBtnSoveCmz = 'Sauver / Charger un mod�le de configuration des lignes';
    HintBtnClearFilterDbg = '[F11] R�initialiser le filtre actif dans les lignes...';
    HintBtnShowGroupPanel = 'Afficher / Cacher la zone d''affichage des groupes';
    HintBtnShowFooter = 'Afficher / Cacher les cumuls de fin des lignes';
    HintBtnShowFooterRow = 'Afficher / Cacher les cumuls interm�diaires des lignes';
    HintBtnExcelDbg = 'Exporter les lignes dans Excel (Excel est automatiquement ouvert)';
    HintBtnPopup = 'Menu des fonctions annexes  [Clic droit]';
    HintBtnRefresh = 'Rafra�chir les donn�es affich�es (Relecture des donn�es sur le serveur)';
    HintBtnCancel = '[Echap]  Abandonner les modifications effectu�es';
    HintBtnPost = '[F12] Enregistrer les modifications effectu�es';
    HintBtnEdit = '[F2] Modifier le document affich�';
    HintBtnDelete = '[Suppr] Supprimer le document affich�';
    HintBtnInsert = '[Ins] Ouvrir un nouveau document';
    HintBtnPrintDoc = 'Imprimer le document affich� � l''�cran';
    HintBtnQuitDlg = 'Fermer la liste [Echap]';
    HintGenerikFrm = '[F12] Enregistrer   [Echap] Abandonner   [F2] Modifier   [SUPPR] Supprimer';
    HintGenerikFrmNoSuppr = '[F12] Enregistrer   [Echap] Abandonner   [F2] Modifier';

    HintBtnCancelLine = '[Echap]  Abandonner les modifications effectu�es dans la ligne';
    HintBtnPostLine = '[F12] Enregistrer les modifications effectu�es dans la ligne';
    HintBtnEditLine = '[F2] Modifier le la ligne affich�e';
    HintBtnDeleteLine = '[Suppr] Supprimer la ligne affich�e';
    HintBtnInsertLine = '[Ins] Cr�er une nouvelle ligne';

    // Frm_Screen et Frm_Main

    OrgaParam = 'Param�trage de Ginkoia';
    OrgaMenu = 'Menu de Ginkoia';
    DeLogin = 'retour � l' + #39 + 'utilisateur pr�c�dent : ';
    EtikAttente = ' �tiquettes en attente';

// CSreen
    CsGerProd = 'G�rer les produits';
    CsCdes = 'Commandes';
    CsFourn = 'Fournisseurs';
    CsRecep = 'R�ception';
    CsTransMM = 'Transferts inter-magasins';
    CsInvent = 'Inventaires';
    CsClient = 'Clients';

// Fichart
    SexeH = 'Homme';
    SexeF = 'Femme';
    SexeE = 'Enfant';
    ErrGenre = ' Ce genre n' + #39 + 'est pas valable!';
    ErrGroupe = ' Ce groupe n' + #39 + 'est pas valable!';
    ErrCollection = ' Cette collection n' + #39 + 'est pas valable!';
    ErrCatGuelt = ' Cette cat�gorie de Guelt n' + #39 + 'est pas valable!';

    FichartMagBtn = 'Magasins';

    CtrlJetons = 'Impossible d''ouvrir Ginkoia ...    ' + #13 + #10 +
        '   Nombre de postes autoris�s d�pass� ...   ';
    ErrPoste = 'Impossible d''ouvrir GINKOIA sans un nom de poste d�fini';
    ErrServeurPoste = 'Le serveur �0 ' + #13 + #10 + 'n' + #39 + 'a pas de poste d�fini !';
    NomTVT = 'Tarif g�n�ral';
    NietConvert = 'On ne peut pas changer de devise lorsqu''une t�che est en �dition ...   ';
    NietModifTTrav = 'On ne peut pas supprimer une taille travaill�es ou une couleur     ' + #13 + #10 +
        '   lorsque une commande, une r�ception ou un transfert sont en �dition ...    ';
    NietDeleteArt = 'On ne peut pas supprimer un article     ' + #13 + #10 +
        '   lorsque une commande, une r�ception ou un transfert sont en �dition ...    ';
    TransNoStk = 'IMPOSSIBLE : cet article n''a jamais �t� r�f�renc� en stock ...   ';

// Messages du module de dimension

    GtfMajData = 'Probl�me de mise � jour des donn�es...  ';
    MessGTFREF = 'Impossible de supprimer une grille de taille de r�f�rence...';
    MessGTFSup = 'Confirmez-vous la suppression de cette grille de taille?';
    MessSupIndGt = 'Impossible de supprimer une taille de r�f�rence...';
    MessGtfIndVid = 'Attention tous les libell�s de tailles sont obligatoires...';
    MessModSup = 'Confirmer la suppression du mod�le "�0"     ';

    MessLibGTS = 'Le libell� de la grille statistique est obligatoire...';
    MessGtfIndStat = 'Attention le num�ro de la colonne de la grille statistique doit �tre compris entre 1 et 28...';
    MessGtfSupIND = 'Confirmez-vous la suppression de cette taille?';
    MessGTFSupEnfant = 'Impossible de supprimer une taille ayant des "sous-tailles" d�finies...   ' + #13 + #10 +
        '(Il faut commencer par supprimer toutes les sous-tailles)';
    MessValTT = 'Confirmez-vous la liste des nouvelles tailles travaill�es?';
    MessNoSelTT = 'Vous n''avez pas s�lectionn� une taille...';
    MessGCSSupEnfant = 'Impossible de supprimer une couleur ayant des "sous-couleurs" d�finies...   ' + #13 + #10 +
        '(Il faut commencer par supprimer toutes les sous-couleurs)';
    MessSupTaille = 'Impossible de supprimer cette taille,' + #13 + #10 + '   car elle est pr�sente dans les historiques...';
    MessSupTailleBis = 'Impossible de supprimer cette taille,' + #13 + #10 +
        '   car elle est pr�sente dans les commandes clients...';
    MessSupTailleTT = 'Impossible de supprimer cette taille,' + #13 + #10 + '   car elle est pr�sente dans les historiques...';
    MessSupTailleTTBis = 'Impossible de supprimer cette taille,' + #13 + #10 +
        '   car elle est pr�sente dans les commandes clients...';
    MessSupCoul = 'Impossible de supprimer cette couleur,' + #13 + #10 + '   car elle est pr�sente dans les historiques...';
    MessSupCoulBis = 'Impossible de supprimer cette couleur,' + #13 + #10 +
        '   car elle est pr�sente dans les commandes clients...';
    MessCategVide = 'Le libell� de la cat�gorie est obligatoire';
    MessSupCoulStat = 'Confirmez-vous la suppression de cette couleur statistique?';
    MessLibCS = 'Attention le libell� de la couleur est obligatoire...';
    MessLibCou = 'Impossible d''enregistrer : code et libell� de couleur sont obligatoires...';

    TitreListePoste = 'Liste des Postes disponibles sur le serveur';

// Nomenclature

    NkOrdreaff = 'Gestion de l''ordre d''affichage';
    NkFamDef = 'Famille par d�faut';
    NkSfDef = 'Sous-Famille par d�faut';

    BtnMRayon = ' [F2] Modifier le Rayon';
    BtnCRayon = ' [INSER] Cr�er un Rayon';
    BtnSRayon = ' [SUPPR] Supprimer le Rayon';
    BtnMFamille = ' [F2] Modifier la Famille';
    BtnCFamille = ' [INSER] Cr�er une Famille';
    BtnSFamille = ' [SUPPR] Supprimer la Famille';
    BtnMSSFamille = ' [F2] Modifier la Sous-Famille';
    BtnCSSFamille = ' [INSER] Cr�er une Sous-Famille';
    BtnSSSFamille = ' [SUPPR] Supprimer la Sous-Famille';
    UpRayon = '[Ctrl+fl�che Haut] D�placer le Rayon vers le haut';
    DownRayon = '[Ctrl+fl�che Bas] D�placer le Rayon vers le bas';
    UpFamille = '[Ctrl+fl�che Haut] D�placer la Famille vers le haut';
    DownFamille = '[Ctrl+fl�che Bas] D�placer la Famille vers le bas';
    UpSSFamille = '[Ctrl+fl�che Haut] D�placer la Sous-Famille vers le haut';
    DownSSFamille = '[Ctrl+fl�che Bas] D�placer la Sous-Famille vers le bas';

    TitreGesart = ' Gestion des articles';
    TitreGesVis = 'Visibilit� de la Nomenclature';

    DefHint = ' Nomenclature';
    BtnCancelCap = 'Quitter';
    HintCancelCap = '[Echap] Quitter';
    HintAnnuler = '[Echap] Abandon';

    ErrSansUnivers = ' Cette application fonctionne sans Univers !';
    ErrSansTVA = ' Cette application fonctionne sans TVA par d�faut !';
    INFUnivers = ' Cette application fonctionne sur l' + #39 + 'univers �0' + #13 + #10 + 'car �1 n' + #39 + 'est pas disponible !';

    ErrSansFamille = ' La Famille g�n�rique de ce Rayon est introuvable!';
    ErrSansSSFamille = ' La Sous-Famille g�n�rique de cette Famille est introuvable!';

    ErrNom = ' Ce nom n' + #39 + 'est pas valable!';
    ErrNomRayon = ' Ce nom de Rayon n' + #39 + 'est pas valable!';
    ErrNomFamille = ' Ce nom de Famille n' + #39 + 'est pas valable!';
    ErrNomSSFamille = ' Ce nom de Sous-Famille n' + #39 + 'est pas valable!';

    ErrNiveau = ' Le niveau de l' + #39 + 'univers doit �tre compris 1 et 3 !';
    ErrUnivers = ' Cet Univers r�f�rence une nomenclature!';
    ErrSportLink = ' SportLink est la nomenclature de r�f�rence...' + #10 + #13 +
        ' Aucune modification n' + #39 + 'est autoris�e!';
    ErrCatFamille = ' Cette cat�gorie est utilis�e par une Famille!';
    ErrSecteur = ' Ce Secteur est utilis� par un Rayon!';
    ErrCategorie = ' Cette cat�gorie est utilis�e par une Sous-Famille!';
    ErrTaux = ' Ce taux de TVA n' + #39 + 'est pas valable!';
    ErrTVA = ' Cette TVA est utilis�e par une Sous-Famille!';
    ErrTCT = ' Ce type comptable est utilis�e!';
    ErrTCTcode = ' Ce type comptable n' + #39 + 'a pas de code!';

    ErrManqueCatFamille = ' La cat�gorie n' + #39 + 'est pas d�finie!';
    ErrManqueSecteur = ' Le Secteur n' + #39 + 'est pas d�fini!';
    ErrManqueCategorie = ' La Cat�gorie n' + #39 + 'est pas d�finie!';
    ErrManqueTVA = ' La TVA n' + #39 + 'est pas d�finie!';
    ErrManqueTCT = ' Le type comptable d' + #39 + 'achat et de vente n' + #39 +
        'est pas d�fini!';
    ErrManqueSSF = 'La Sous-Famille n' + #39 + 'est pas d�finie!';
    ErrManqueGTS = ' La Grille de Taille Statistique n' + #39 + 'est pas d�finie!';

    ErrSupprRayon = ' Au moins un Article r�f�rence une sous-famille de ce Rayon !';
    ErrSupprFamille =
        ' Au moins un Article r�f�rence une sous-famille de cette Famille!';
    ErrSupprSSFamille = ' Au moins un Article r�f�rence cette sous-famille!';

    ErrCle = ' Cette s�lection est vide!';
    ErrNiveauCle = ' Aucun niveau cette s�lection!';

//    WARSuppr = ' Etes-vous s�r de vouloir supprimer �0 de votre Nomenclature ?';
    WARSupprSelection = ' Etes-vous s�r de vouloir supprimer la s�lection "�0" ?';
    ErrDetruireSelection = ' Votre s�lection r�f�rence des donn�es qui ne sont plus valides,' + #10 + #13 +
        '  Elle est donc supprim�e !';
    CNFModifSelection = ' Etes-vous s�r de vouloir modifier la s�lection "�0" ?';
    INFRayonInvisible =
        ' Les Rayons ne sont pas visible, modifiez leur visibilit� pour pouvoir travailler !';

    CeRayon = 'ce Rayon';
    SsFamDefaut = 'Sous-Famille par d�faut';
    CetteFamille = 'cette Famille';
    CetteSSFamille = 'cette Sous-Famille';

// Test pour IdRef
    LeSecteur = 'Secteur';
    LaCentrale = 'la centrale';

//Origine

    Dimension = 'Equipement de la personne';
    BrunBlanc = 'Hifi - Electrom�nag� - Informatique';

// ExpertcatFamille_Dial

    CNFSecteur0 = 'Ne plus associer "�0" � aucune Cat�gorie ?';
    CNFAffectSecteur = 'Affecter "�0" � la Cat�gorie "�1" ?';
    SecteurCap = 'Les Cat�gories et leurs Rayons';
    FamilleCap = 'Les Rayons non affect�s';
    AjoutHint = '[Alt+<--] Affecter le Rayon � la Cat�gorie.';
    SupprHint = '[Alt+-->] Retirer le Rayon de la Cat�gorie.';

// ExpertCreationDial

    TitreC_Rayon = '  Cr�ation d' + #39 + 'un Rayon/Famille/Sous-Famille';
    TitreC_Famille = '  Cr�ation d' + #39 + 'une Famille/Sous-Famille';
    TitreC_SSFamille = '  Cr�ation d' + #39 + 'une Sous-Famille';
    TitreM_Rayon = '  Modification d' + #39 + 'un Rayon';
    TitreM_Famille = '  Modification d' + #39 + 'une Famille';
    TitreM_SSFamille = '  Modification d' + #39 + 'une Sous-Famille';

    MsgNomNK = 'de Nomenclature';

// ExpertSecteur_Dial

    CNFSuperRayon0 = 'Retirer le Rayon "�0" de la liste des secteurs?...' + #13 + #10 +
        '(Ce Rayon n''aura plus de Secteur associ�...)';
    CNFAffectSuperRayon = 'Placer le Rayon "�0"' + #13 + #10 +
        'dans le Secteur "�1" ?...';

// Selection_Dial

    NkItemRadioRay = 'S�lectionner tous les Rayons contenant :';
    NkItemRadioFam = 'S�lectionner toutes les Familles contenant :';
    NkItemRadioSf = 'S�lectionner toutes les Sous-Familles contenant :';
    NkCeRayon = 'ce Rayon';
    NkCetteFam = 'cette Famille';
    NkCetteSf = 'cette Sous-Famille';

    CNFAbandonSelection = '  Si vous abandonez maintenant votre s�lection sera perdue.' +
        #13 + #10 +
        '  Etes-vous s�r de vouloir abandonner ?';
    CNFSupprFam = ' Attention des Familles de �0 sont d�j� dans la s�lection !' + #13 + #10
        +
        '  Pour rajouter �0, il faut les enl�ver.';
    CNFSupprSSFam = ' Attention des Sous-Familles de �0 sont d�j� dans la s�lection !' +
        #13 + #10 +
        '  Pour rajouter �0, il faut les enl�ver.';
    CNFSupprFam_SSFam = ' Attention des Familles et des Sous-Familles de �0 sont d�j� dans la s�lection !'
        + #13 + #10 +
        '  Pour rajouter �0, il faut les enl�ver.';
    ErrRayon = ' Le Rayon de �0 est d�j� s�lectionn� !';
    ErrFamille = ' La Famille de cette Sous-Famille est d�j� s�lectionn�e !';
    WarSupprItem = ' Etes-vous s�r de vouloir enl�ver "�0" de la s�lection !';
    WarViderListe = ' Etes-vous s�r de vouloir supprimer tous les �l�ments de la s�lection!';

// Bon de commande

    CdeSsGenre = 'Sans Genre';
    CdeListeVide = 'Liste de recherche vide...    ';
    CdeTitCritRech = 'Crit�re de recherche : ';
    CdeSaisLine = 'Saisie d''une ligne';
    CdeBcde = 'Bon de Commande';
    CdeOkModif = 'Modifiable';
    CdeNotModif = 'Non Modifiable';
    CdeCancelBcde = 'Abandonner toutes les modifications entreprises dans le document ?   ' + #13 + #10 + #13 + #10 +
        'ATTENTION : Toutes les modifications �ventuellement faites dans les lignes   ' + #13 + #10 +
        'vont �tre abandonn�es ...';
    CdeCancelLine = 'Abandonner les modifications r�alis�es dans cette ligne ?   ';
    CdePostBcde = 'Enregistrer les modifications du document en cours ?    ';
    CdeTabloVide = 'Impossible de valider une ligne sans quantit�s saisies ... ';
    cdeLineInModif = 'Pour pouvoir changer d''onglet,' + #13 + #10 +
        'if faut d''abord valider [F12] ou abandonner la ligne en cours de saisie    ';

    CdeRechVide = 'Aucun article trouv� ... ' + #13 + #10 +
        '(Cet article existe peut-�tre mais n''est pas accessible dans votre contexte de travail actuel )';
    CdePxBase = 'Prix de Base';
    CdeCadexist = 'Cette date de livraison existe d�j� pour le code chrono : �0   ';
    CdeConfDelLine = 'Confirmer la suppression de la ligne s�lectionn�e...   ';
    CdeConfDelBcde = 'Confirmer la suppression compl�te du document affich�...   ';
    CdeConfConfDelBcde = 'La suppression de ce document est irr�versible !' + #13 + #10 +
        'Etes-vous bien certain de vouloir le supprimer ?   ';
    CdeFournOblig = 'La saisie du fournisseur est obligatoire!...    ';
    CdeMagOblig = 'La saisie du magasin est obligatoire!...    ';
    CdeExercice = 'La saisie de l''exercice commercial est obligatoire!...   ';
    CdeRgltOblig = 'La saisie des conditions de paiement est obligatoire!...   ';
    CdeOnlyOneSuppr = 'Plusieurs lignes s�lectionn�es...    ' + #13 + #10 +
        ' On ne peut supprimer qu''une seule ligne � la fois !     ';
    CdeNewBcde = 'Nlle Commande';
    CdeNewRecep = 'Nlle R�ception';
    CdeNewTrans = 'Nx Transfert';
    CdeExerciceOblig = 'La saisie de l''exercice commercial est obligatoire...   ';
    CdeDateRglt = 'La date de r�glement ne peut pas �tre ant�rieure � la date de livraison!...   ';

    CdeArchive = 'Confirmer l''archivage de(s) �0 document(s) s�lectionn�(s)...    ';
    CdeNoArchive = 'Aucun document � archiver ...      ';
    cdeVoirArch = '     Voir      archiv�s';
    cdeMaskArch = 'Masquer archiv�s';
    cdeVoirNM = '     Voir      Non modif';
    cdeMaskNM = 'Masquer Non Modif';
    cdeVoirClot = '     Voir      Cl�tur�s';
    cdeMaskClot = 'Masquer Cl�tur�s';
    BcdeHintBtnCancel = '[Echap] Ne pas cr�er une nouvelle ligne de commande pour cet article...';
    BcdeCapBtnMag1 = 'Afficher les autres &Magasins';
    BcdeCapBtnMag2 = 'Masquer les autres &Magasins';
    CarnetCdeLabMag = 'Carnet de commandes ';

    RechNoCollec = 'IMPOSSIBLE, aucune collection n''est s�lectionn�e ...   ';

// FicheArticle

    MessExcel = ' Voulez-vous ouvrir Excel ?';
    InfExcel = ' Le fichier Excel �0 a �t� g�n�r�.';
    TipartPseudo = 'Pseudo';
    TipartRef = 'R�f�renc�';
    TipartCat = 'Catalogue';
    FartDelartCnf = 'de la fiche article - code chrono :';
    FartListeDes = 'Liste des';
    FartGarantie = 'GARANTIE CONSTRUCTEUR';

// ClassementDial

    ClasseTitle = ' El�ments du classement : ';
    ClasseDbgHint = '[INSER] Cr�er    [F2] Modifier    [SUPPR] Supprimer';

    ErrClassement = 'Ce nom de classement n' + #39 + 'est pas valide !';
    ErrItemClassement = 'Le nom n' + #39 + 'est pas valide !';
    ErrIntegrityArticle = 'Ce classement est utilis� par un article !';
    ErrIntegrityClient = 'Ce classement est utilis� par un client ...';
    ErrClass0 = 'La suppression du classement "VIDE" n''est pas possible...';
    ErrLibClasse = 'Un classement ne peut �tre valid� sans un nom significatif...';
    ClaDelItem = 'Confirmez la suppression du classement : �0   ';

// Ficharticle

    FartRemPart = 'Outil de remplacement non encore impl�ment�';
    LaMarque = 'marque';

    ErrGarantie = 'Nom de garantie incorrect !';

    ErrDeleteGroupe = 'Suppression IMPOSSIBLE' + #13 + #10 + 'Le groupe "�0" est r�f�renc� par des articles !';
    ErrDeleteCollec = 'Suppression IMPOSSIBLE' + #13 + #10 + 'La collection "�0" est r�f�renc�e par des articles !';
    ErrDeleteGarantie = 'Suppression IMPOSSIBLE' + #13 + #10 + 'La garantie "�0" est r�f�renc�e par des articles !';
    ConfDelGroup = 'Confirmez la suppression du groupe :  �0     ';

    ErrCatGroupe = 'Nom de cat�gorie de groupe non valide !';
    ErrDeleteCatGroupe = 'Suppression IMPOSSIBLE' + #13 + #10 +
        'Cat�gorie de groupe "�0" r�f�renc�e par un groupe !';

    RechVide = 'Aucune fiche trouv�e';
    RechEof = 'Fin de la liste de recherche';
    RechBof = 'D�but de la liste de recherche';
    RechFiltre = 'Impossible d''acceder � la fiche trouv�e...' + #13#10 +
        'V�rifiez que vous n''avez pas un filtre en cours';
    OnRef = 'R�f�rencement';
    OnIns = 'Cr�ation';
    ArtSupGroup = 'Supprimer le groupe "�0" pour cet article?... ';
    ArtSupCollec = 'Supprimer la collection "�0" pour cet article ?...';

    ArtSupGarantie = 'Confirmez que la suppression de la garantie �0';
    ErrEditGarantie = 'Le nom de cette garantie ne peut pas �tre modifi� ...';

    FartCBFNoValid = 'Code Barre fournisseur Non Valide ( ou d�j� utilis� )...    ';

    Fart_dela = 'de la fiche article en cours...';
    FartCtrlCdmnt = 'Le champ conditionnement est d�coch� !          ' + #13 + #10 +
        #13 + #10 +
        'Un article ne peut �tre conditionn� que si :   ' + #13 + #10 +
        '- L''unit� est d�finie.' + #13 + #10 +
        '- La quantit� de conditionnement est sup�rieure � 1';
    FartTdb = 'Prix de base';
    FartSupprTar = 'Confirmez la suppression du particulier de la taille affich�e ...  ';
    FartNoGTaille = 'IMPOSSIBLE car aucune grile de taille de s�lectionn�e ...   ';
    FartTarifExist = 'La taille �0 a d�j� un tarif sp�cifique d�fini ... ';
    FartErrMajTailles = 'Probl�me lors de la mise � jour du tarif ...     ' + #13 + #10 + 'Vos modifications sont abandonn�es !';
    FartSupprTailBase = 'On ne peut pas supprimer le prix de base !...    ';
    FartSupprTail = 'Pour supprimer des tailles travaill�es' + #13 + #10 +
        'il faut commencer par la plus petite et descendre une � une ...' + #13 + #10 +
        '( On ne peut supprimer ni la taille de base ni une taille interm�diaire )';
    FartAvortCrea = 'Cr�ation d''article impossible ...    ' + #13 + #10 +
        '  Probl�me de g�n�ration du prix de vente de base.   ';
    TabachatStd = 'Tarif';
    TabachatCrea = 'Nouvel Article';
    FartNomartOblig = 'Le nom de l''article est obligatoire ...     ';
    FartFournOblig = 'La d�signation d''un fournisseur est obligatoire ...     ';
    FartMarkOblig = 'La d�signation d''une marque est obligatoire ...      ';
    FartSsfOblig = 'La d�signation d''un classement dans la nomenclature est obligatoire ...     ';
    FartGtOblig = 'La d�signation d''une grille de taille est obligatoire ...     ';
    FartFourCrea = 'Probl�me lors de l''initialisation du fournisseur ... ';
    FartNeoFourn = 'Ajouter le fournisseur "�0" � la liste    ' + #13 + #10 +
        'des fournisseurs de l''article en cours ?   ';
    FartFournExist = 'Le fournisseur "�0" est d�j� r�f�renc� par cet article...   ';
    FartFourn = 'Fournisseur';
    FartFPrin = 'Frn.Principal';
    CnfSupFourn = 'Confirmer la supression du fournisseur "�0"   ';
    FournSupPrin = 'Impossible de supprimer "�0" car c''est le fournisseur principal    ';
    FournDejaPrin = '"�0" est d�j� le fournisseur principal...   ';
    ChangeFornPrin = 'D�finir "�0" comme fournisseur principal ?   ';
    FartchangeSf = 'ATTENTION : Si vous venez de changer l''affectation nomenclature  ' + #13 + #10 +
        ' de cet article, v�rifiez que son affectation comptable et sa TVA conviennent toujours !  ';
    ArtRefMarque = ' R�f�rence Marque : ';

    ErrCoefTheorique = 'Le coefficient th�orique doit �tre sup�rieur � 0 !';
    CanModifHint =
        '[INS] Nouvel article [F2] Modifier [F12] Enregistrer [SUPPR] Supprimer l''article [Clic Droit] Popup Menu';
    CannotModifHint = 'Fiche article';
    HintNotEditChpTaille = '[F4, Double Click ou Bouton] Liste des tailles travaill�es de l''article';
    HintInsertChpTaille = '[F4, Double Click ou Bouton] Liste des grilles de tailles  [Suppr] Supprimer la grille de taille s�lectionn�e';
    HintEditChpTaille = '[F4, Double Click ou Bouton] Gestion des tailles travaill�es de l''article';
    HintDesDbgs = '[INS] Ajouter un nouvel �l�ment  [SUPPR] Supprimer l''�l�ment s�lectionn�';
    HintEditFourn = 'Liste des fournisseurs r�f�renc�s pour cet article    ';

    TitleStk = 'Etat de stock de l' + #39 + 'article - Chrono :';
    TitleRal = 'Reste � Livrer de l' + #39 + 'article - Chrono :';
    TitleStkMM = 'Etat de stock par magasin de l' + #39 + 'article - Chrono :';
    TitleRalMM = 'Reste � Livrer par magasin de l' + #39 + 'article - Chrono :';
    TitleHistoFourn = 'Historiques d''achat de l''article - Chrono : ';

    MsgLKNotEdit = 'Vous n''�tes pas en �dition ! Impossible de mettre � jour la fiche article ...   ';
    ChronoMess = ' Le pr�fixe n''est pas modifiable';
    SupprImgCap = ' Suppression de l''image associ�e';
    CopyImgCap = ' Association d''une image � l''article en cours';
    SupprImg = 'Supprimer l''image associ�e � l''article en cours ?';
    Fart_UnikChrono = 'Ce code chrono est d�j� pris par un autre article ...   ';
    FartNoFourn = 'Avant de saisir le tarif il faut d�finir le fournisseur principal !    ';
    FartCoulGes = 'Gestion des couleurs de l''article';
    FartCoulVisu = 'Liste des couleurs d�finies pour l''article';
    FartSupprGT = 'La suppression de la grille de taille va supprimer le tarif d�fini ...    ' + #13 + #10 +
        'Faut-il continuer ?';
    ErrPasMrk = 'Impossible de cr�er un article si aucune marque n''existe !';

// Gesart_Frm

    ErrFermerFiche = 'Vous devez valider ou abandonner les modifications �0 !';

    FicheArticle = 'de la fiche Article';
    QuitHint = 'Quitter la gestion des articles';
    OutBarHint = 'Barre des fonctions';

// Image_Frm
    ImageCap = ' Image de l''article : ';

// Grilles de tailles

    MessQuitGTF = 'Attention, pour sortir vous devez VALIDER ou ABANDONNER  les modifications en cours...';
    MessOngletGTF = 'Attention, pour changer d''onglet vous devez    ' + #13 + #10 +
        ' VALIDER ou ABANDONNER  les modifications en cours...';
    MessGtfLibVid = 'Le nom de la grille de taille est obligatoire...';
    MessNbtaille = 'Impossible de valider votre grille de taille, elle ne contient pas de taille...';
    MessModLibGTF = 'Impossible de changer le libell� d''une grille de taille de r�f�rence';
    MessModLibTail = 'Impossible de changer le libell� d''une taille de r�f�rence';
    MessModLibVid = 'Le nom du mod�le est obligatoire...';
    MessMod28 = 'Impossible, le nombre de tailles travaill�es est limit� � 28...';
    GtfHintTailles = '[INS] Ins�rer une nouvelle taille   [CTRL+INS] Ins�rer une sous-taille';
    GtfNoDelete = 'IMPOSSIBLE de supprimer cette grille de taille car elle est utilis�e !...   ';
    GTSCannotDelete = 'IMPOSSIBLE de supprimer la grille de taille statistique "�0"   ' + #13 + #10 +
        ' car elle est r�f�renc�e par une Sous-Famille.';

    GtfModeleHint = '[F3] S�lectionne la taille point�e  [Double Clic] Ajoute la taille point�e � la liste des tailles travaill�es';
    GtfModeleHint2 = '[F3] S�lectionne la taille point�e  [Double Clic] Retire la taille point�e de la liste des tailles travaill�es';
    MessModEnf = 'Impossible de d�placer cette "taille", car la taille parent n''est pas un s�letionn�e...';
    MessGTSCancel = 'Abandonner les modifications �ffectu�es dans la grille de taille "�0"   ';
    GtsCreaChpOblig = 'Le nom et la cat�gorie doivent �tre obligatoirement renseign�s!...   ';
    GtfManqueNom = 'Le nom de la taille doit �tre obligatoirement d�fini ...    ';
    GtfCancelWork = 'Abandonner tout le travail effectu� sur cette grille de taille ?...   ';

    MessSupCoulTer = 'Impossible de supprimer cette couleur,' + #13 + #10 + '   car elle est pr�sente dans les commandes ...';
    SelcoulDbg = '[F4] et [Double Clic] Ex�cuter la fonction associ�e au bouton';
    CoulFormHint = '[F12]  OK    [Echap]  Abandonner';
    CoulOkGesFormHint = '[Ins] Cr�er [F2] Editer [Suppr] Supprimer [F4] Ouvrir liste';
    CoulStatOkGesFormHint = '[Ins] Cr�er [Ctrl+Ins] Sous-couleur [F2] Editer [F12] Ok';
    RecepModerOblig = 'La saisie du mode de r�glement est obligatoire!...   ';

// Marque_Frm

    messMARQUEGtf = 'Attention vous pouvez d�placer 100 tailles maximun � la fois...';

// SelGt_Frm

    MessSupTailleTTter = 'Impossible de supprimer cette taille,' + #13 + #10 + '   car elle est pr�sente dans les commandes ...';
    SelTTailO = 'La s�lection d''au moins une taille travaill�e est obligatoire ...  ';
    SelGTTitle = ' S�lection d''une grille de tailles et des tailles � travailler';

// Fournisseurs
    FourNoVille = 'Attention pas de ville !!!';
    FourErrNoDelete = 'Impossible de supprimer ce fournisseur car il a des donn�es associ�es     ';
    FourCnfDel = 'Etes-vous s�r de vouloir supprimer ce fournisseur?';
    ErrNoPaysListeFact = 'Vous devez obligatoirement renseigner le pays de cette ville �0';
    ErrNoPaysExprfourn = 'Vous devez obligatoirement renseigner le pays de cette ville �0';
    ErrNoVilleExprfourn = 'Vous devez obligatoirement renseigner la ville du fournisseur �0';
    ErrNomFournExprfourn = 'Un fournisseur doit obligatoirement avoir un nom !';
    ErrMrkFournExprfourn = 'Vous devez associer au moins une marque � ce fournisseur';
    ErrNoPays = 'Vous n' + #39 + 'avez pas d�fini de pays pour cette ville �0';
    ErrNomFourn = 'Un fournisseur doit obligatoirement avoir un nom !';
    ErrMrkFourn = 'Vous devez associer au moins une marque � ce fournisseur';
    FourChangePrin = 'Le fournisseur principal de cette marque est    ' + #13 + #10 +
        '  " �0 "' + #13 + #10 +
        '  Faut-i le remplacer par' + #13 + #10 +
        '  " �1 " ?   ' + #13 + #10 + '   ';

    MessQuitFourn = 'Attention, pour sortir vous devez VALIDER ou ABANDONNER  les modifications en cours...';
    ErrMrkDel = 'Etes-vous s�r de vouloir enlever cette marque ?';

// Etiquettes article

    EtqVidQte = 'Vider les quantit�s du tableau';
    EtqLoadQte = 'Recharger les quantit�s en stock';
    EtikVide = 'Aucune �tiquette � imprimer...     ';
    NomTaille = 'Taille : ';
    NomTailleItalie = 'Taglia : ';
    NomImprimante = 'Vous devez choisir une imprimante !';

// Bons de reception

    RecepRalFourn = 'Liste des RAL du fournisseur : ';
    RecepOkCloture = 'Confirmer la cl�ture du bon de r�ception affich� ...   ' + #13 + #10 +
        '  ATTENTION : ce document ne sera plus modifiable ! ';
    RecepArtExist = 'Cet article est d�j� r�f�renc� dans le bon de r�ception !...   ';
    RecepCadExist = '[ Chrono : "�0" ] Cett cadence est d�j� r�f�renc�e dans le bon de r�ception.   ' + #13 + #10 +
        '   Faut-il compl�ter cette ligne avec les quantit�es restant � livrer ?...   ';
    RecepDateRglt = 'La date de r�glement ne peut pas �tre ant�rieure � la date de livraison!...   ';
    RecepNoRal = 'Aucun reste � livrer chez ce fournisseur...     ';
    RecepNotModif = 'Cl�tur�';
    TransArtExist = '[ Chrono : "�0" ] Cet article est d�j� r�f�renc� dans le bon de transfert !...   ';
    TransIdemMag = 'Magasin d''origine et de destination doivent �tre diff�rents !...     ';
    CdeNoDocVide = 'Impossible de valider un " document " vide !...    ';
    CdeNoChangeChp = 'Modification impossible lorsque le document a des lignes ...    ';
    TransOkCloture = 'Confirmer la cl�ture du bon de Transfert affich� ...   ' + #13 + #10 +
        '  ATTENTION : ce document ne sera plus modifiable ! ';
    CdeVR = 'Voir RAL';
    CdeNVR = 'Masquer RAL';
    CdeTitreListe = '  Liste des bons de commande';
    recepTitreListe = '   Liste des bons de r�ception';
    transTitreListe = '   Liste des bons de transfert';
    TransIsNega = 'ATTENTION : le stock de cette taille / couleur va devenir n�gatif !...     ';
    TransNoEdit = 'IMPOSSIBLE de modifer un bon de transfert au del� de 30 jours !...   ';
    TMMHintStkCour = 'Les transferts saisis ne seront pris en compte dans le stock affich� qu''apr�s validation du bon... ';
    TMMHintStkDate = 'Le stock affich� est le stock � la date du bon "APRES LE TRANSFERT" ';
    TMMStkCour = 'Stock courant';
    TMMStkDate = 'Stock au';

    StkChkCoulS = 'Couleurs affich�es';
    StkChkCoulM = 'Couleurs masqu�es';
    StkPPL = 'Etat de stock du magasin : ';
    PPStkHint = 'Param�trage des colonnes � �diter';
    CmzEditDoc = 'Afficher / Masquer l''outil de configuration de l''�dition';
    SbtnEditDoc = 'Imprimer le document';
    SelectLineBre = 'Vous devez s�l�ctionnez les lignes que vous voulez r�-�tiquetter !';
    RecepCapFrmRal = ' Restes � livrer : ';

    RecepErrInitTab1 = 'Probl�me lors de la cr�ation de cette ligne de r�ception ...';
    RecepErrInitTab2 = 'Cette ligne doit �tre abandonn�e...';
    RecepErrInitTab3 = 'R�-essayez une nouvelle fois et ...';
    RecepErrInitTab4 = '        Merci de pr�venir "Herv�" � Algol qu''il subsiste des probl�mes lors de la     ';
    RecepErrInitTab5 = '        cr�ation de nouvelles lignes de r�ception.';

// Etiquettes

    RecepEtikMess = 'Valider le bouton correspondant � votre choix ... ';
    RecepEtikP1 = 'Vous avez en stock des articles � un prix de vente diff�rent.';
    RecepEtikP2 = 'Selon votre choix...';
    RecepEtikP3 = '         ...des �tiquettes seront g�n�r�es pour ces articles.';

// Edition de caisse

    JVTklDateLib = 'Journal des ventes du �0 au �1  -  ';
    HITParadeVte = 'Hit parade des ventes du �0 au �1  -  ';
    JVTkeDateLib = 'Liste des tickets du �0 au �1  -  ';
    JvTklSel = 'S�lection de magasins';
    JVLibSess = 'Magasin �0 - Poste �1 - Session No �2';
    FontCourierNew = 'Courier New';

    ConsoDivLib = 'Consommations diverses du �0 au �1  -  ';

    ChxDateJV = 'P�riode incorrecte !... Le date de fin ne peut �tre ant�rieure � celle de fin.   ';
    ChxSessJV = 'Choix de session non valide !?....     ';
    CHXDateJVMP = 'Le choix d''un magasin et d''un poste sont obligatoires...     ';
    CptCltTit = 'Comptes clients  ';

// Clients

    ErrNomClient = 'Vous devez obligatoirement sp�cifier un nom pour ce client';
    ErrNoAdrClient = ' La saisie d''une ville est obligatoire';
    ErrCivClient = ' Vous devez sp�cifier une civilit� pour ce client ';
    ErrRecheditClient = 'Vous ne pouvez pas effectuer une recherche sans valider la fiche en cours';

// Etiquettes

    TitreEtikBR = ' Impression des �tiquettes du Bon de R�ception';
    EtikPlanche = 'Etiquette Planche';
// Edit stkMag

    ArtStkTitle = 'Etat du stock';

// Param

    ErrCtpAV = ' Au moins un compte doit �tre renseign�!';

// Consos
    CdvOblig = ' La saisie du champ "�0" est obligatoire !...    ';
    CdvNoPx = ' Le prix unitaire de cet article est � "0.00" ... ' + #13 + #10 +
        '   (Il n''est certainement pas r�f�renc� en stock � cette date )' + #13 + #10 + #13 + #10 +
        '   Faut-il continuer et accepter cette op�ration ?';
    CdvCtrlDate = ' La date de cette op�ration ne peut pas �tre post�rieure     ' + #13 + #10 +
        '   � la date courante ... ';
    CdvDelai = ' Cette op�ration n''est plus modifiable ...    ';
    HintConsodiv = 'Pour une nouvelle ligne de consommation... rechercher l''article     [F12] Enregistrer [Echap] Abandonner [F2] Modifier';

// Ressourcesstring communes des applications
// ******************************************

// 29/01/2001 - Sandrine MEDEIROS - ajout Messages Classiques : WarAbandon, WarAbandonCreat, WarAbandonModif

//--------------------------------------------------------------------------------
// Messages d'erreurs BDD
//--------------------------------------------------------------------------------

    ErrLectINI = 'Erreur de lecture du fichier d''initialisation';
    ErrConnect = 'Erreur de connection � la base de donn�e';
    ErrTransaction = 'Mise � jour impossible de la base de donn�e.' + #13 + #10 + '   Pas de transaction Active';
    ErrBD = 'Probl�me avec la base de donn�es';
    ErrMajDB = 'Impossible de mettre � jour la base de donn�es. Modifications annul�es.';
    ErrCommit = 'Impossible de valider les informations dans la base de donn�e';
    ErrRollback = 'Impossible d''annuler les informations dans la base de donn�e';
    ErrGenId = 'Probl�me avec le g�n�rateur de cl� de la base';
    ErrNoFieldDef = 'Pas de champ d�fini pour la table �0';
    ErrNoPkFieldDef = 'Pas de cl� primaire d�finie pour la table �0';
    ErrNoPkFieldFound = 'La cl� primaire �0 doit �tre pr�sente dans la query';
    ErrNoDeleteNullRec = 'La suppression de cet enregistrement n''est pas autoris�e    ';
    ErrNoEditNullRec = 'La modification de cet enregistrement n''est pas autoris�e     ';
    ErrNoDeleteIntChk = 'Cet enregistrement �tant r�f�renc� vous ne pouvez pas le supprimer    ' + #13 + #10 +
        '   (Le supprimer d�truirait la coh�rence de vos donn�es)';
    ErrUsingScript = 'Utilisation incorrecte de script SQL';
    ErrNegativeTransac = 'Compteur de transaction n�gatif !    ' + #13 + #10 +
        'Pr�venir Algol en pr�cisant bien le contexte dans lequel cela se produit    ';
    ErrToMuchTransac = 'Probl�me de gestion du compteur de transaction' + #13 + #10 +
        'Le signaler � Algol en pr�cisant bien le contexte dans lequel cela se produit.   ';

    errSQL803 = 'Doublon dans un identifiant unique. Mise � jour impossible.';
    errSQL625 = 'Champ obligatoire non d�fini. Mise � jour impossible.';
    errSQL = 'Erreur SQL n��0.  Mise � jour impossible.';

//--------------------------------------------------------------------------------
// Messages d'erreurs ReportBuilder
//--------------------------------------------------------------------------------

    ErrInitRap = 'Impossible d''initialiser le module Report Builder';
    ErrLoadReport = 'Impossible de charger le rapport �0';
    ErrDesignReport = 'Impossible de modifier le rapport �0';
    ErrArchivingtReport = 'Impossible d''archiver le rapport �0';
    ErrParamNotDefined = '< Non d�fini >';
    InfLoadingMessage = 'Veuillez patienter...';

//--------------------------------------------------------------------------------
// Messages d'erreurs UIL
//--------------------------------------------------------------------------------

    ErrInitUil = 'Impossible d''initialiser le module Uil Security System';
    ErrLogin = 'Nom d''utilisateur ou mot de passe incorrect';
    ErrOverLoginActive = 'Un sur-login est d�j� en cours';
    ErrOverLoginNotActive = 'Pas de sur_login actif';
    NoAcces = 'Vous n' + #39 + 'avez pas le droit d' + #39 + 'acc�der aux �0.';
    LesPerm = 'Permissions';
    LesGroup = 'Groupes';

//--------------------------------------------------------------------------------
// Messages de gestion des pages
//--------------------------------------------------------------------------------

    ErrPgTab = 'Changement d''onglet interdit' + #13 + #10 + '   tant que vous n''avez pas termin� le travail en cours...';
    ErrItemMenu = 'Fonction d�sactiv�e     ' + #13 + #10 + '   tant que le travail en cours n''est pas Enregistr� ou Abandonn�...';
    ErrFullPages = 'Impossible d''ouvrir un onglet de plus...     ' + #13 + #10 + '   Le maximum autoris� est atteint...';
    ErrTacheOpen = 'Vous ne pouvez pas quitter le programme       ' + #13 + #10 + '   tant qu''il reste des "onglets" ouverts...';
    ErrPgFc = 'Changement d''onglet interdit' + #13 + #10 + '   il reste du travail inachev� dans une page...';

//--------------------------------------------------------------------------------
// Messages Classiques
//--------------------------------------------------------------------------------

    WarAbandon = 'Est-vous s�r de vouloir abandonner le travail en cours ?';
    WarCancel = 'Est-vous s�r de vouloir abandonner les modifications effectu�es ?';
    WarAbandonCreat = 'Est-vous s�r de vouloir abandonner votre cr�ation �0 ?';
    WarAbandonModif = 'Est-vous s�r de vouloir abandonner votre modification �0 ?';
    WarSuppr = 'Confirmez la suppression �0 ... ';
    WarPost = 'Enregistrer le travail en cours ?';

    ErrIdRefCentrale = 'Cette �0 a �t� fournie par �1, elle n' + #39 + 'est pas modifiable !';
    ErrIdRefCentrale1 = 'Ce �0 a �t� fourni par �1, il n' + #39 + 'est pas modifiable !';

//--------------------------------------------------------------------------------
// Hints Standards
//--------------------------------------------------------------------------------
    HintEditMemo1 = '[F4 ou Double Click ou Bouton] Ouvre la zone d''�dition associ�e au bouton';
    HintNoEditMemo1 = 'La zone d''�dition n''est pas accessible';
    HintEditLookup1 = '[F4 ou Double Click ou Bouton] Ouvre la liste associ�e au bouton  [Suppr] Effacer';
    HintNotEditLookup1 = 'La liste associ�e au bouton n''est pas accessible';
    HintEditCheck1 = 'Appuyer sur la barre d''espace ou cliquer pour inverser l''�tat de la coche';

// Ressourcesstring communes des applications
// ******************************************
// 06/02/2001 - Sandrine MEDEIROS - Permission G�n�rale : SUPER
//                                  Permission Nomenclature : CMS_NK
    UILSuper = 'SUPER';

//--------------------------------------------------------------------------------
// Nom des vieilles Permissions
//--------------------------------------------------------------------------------

    UILFct_Negoce = 'FCT-NEGOCE';
    UILFct_GestCde = 'FCT-GESTION CDE';
    UILmodif_NK = 'NOMENCLATURE - MODIFIER';
    UILVisuMag = 'VISU MAG';
    UILVisuMag_Stock = 'VISU MAG - STOCK';
    UILmodif_Art = 'FICHE ARTICLE - MODIFIER';
    UILachatVis_Art = 'FICHE ARTICLE - ACHAT VISIBLE';
    UILmodif_Bcde = 'BON CDE - MODIFIER';
    UILmodif_Recep = 'BON RECEPTION - MODIFIER';
    UILmodif_TransMM = 'BON TRANSFERT - MODIFIER';
    UILsupligne = 'CAISSE - SUPLIGNE';
    UILsupticket = 'CAISSE - SUPTICKET';
    UILannulTicket = 'CAISSE - ANNULTICKET';
    UILOuvreTC = 'CAISSE - OUVTC';
    UILtiketNegatif = 'CAISSE - TICKETNEGATIF';
    UILremise = 'CAISSE - REMISE';
    UILmajCF = 'CAISSE - MAJCF';
    UILOdSession = 'CAISSE - OLDSESSION';
    UILtraining = 'CAISSE - TRAINING';

//--------------------------------------------------------------------------------
// Permissions de Modification - Cr�ation - Suppression
//--------------------------------------------------------------------------------
    UILModif_BonBcde = 'modifier - BON DE COMMANDE';
    UILModif_BonRecep = 'modifier - BON DE RECEPTION';
    UILModif_TrsfMM = 'modifier - BON DE TRANSFERT INTER MAGASINS';
    UILModif_FicheArt = 'modifier - FICHE ARTCLE';
    UILModif_LaNK = 'modifier - NOMENCLATURE';
    UILModif_Fourn = 'modifier - FOURNISSEUR';
    UILModif_ConsoDiv = 'modifier - CONSO DIVERSES';
    UILModif_TarVente = 'modifier - TARIFS DE VENTE';
    UILModif_Clt = 'modifier - CLIENT';
    UILModif_Livr = 'modifier - BON DE LIVRAISON';
    UILModif_Devis = 'modifier - DEVIS';
    UILModif_Fact = 'modifier - FACTURE';

//--------------------------------------------------------------------------------
// Permissions de Visualisation de donn�es
//--------------------------------------------------------------------------------
    UILVoir_Tarif = 'voir - fiche article - ONGLET TARIF';
    UILVoir_Mags = 'voir - TOUS LES MAGASINS';
    UILVoir_StockMags = 'voir - TOUS LES MAGASINS - STOCK';

//--------------------------------------------------------------------------------
// Permissions de gestion de la CAISSE
//--------------------------------------------------------------------------------
    UILCaisse_Cloturer = 'caisse - CLOTURER / PRELEVER';
    UILCaisse_SupprTik = 'caisse - SUPPRESSION D''UNE LIGNE DE TICKET';
    UILCaisse_EncTikNeg = 'caisse - ENCAISSEMENT D''UN TICKET NEGATIF';
    UILCaisse_AnnulTik = 'caisse - ANNULATION DU TICKET EN COURS';
    UILCaisse_SupprOldTik = 'caisse - SUPPRESSION D''UN ANCIEN TICKET';
    UILCaisse_VteSoldee = 'caisse - VENTE SOLDEE';
    UILCaisse_VtePromo = 'caisse - VENTE PROMO';
    UILCaisse_VteRemise = 'caisse - VENTE AVEC REMISE';
    UILCaisse_RetClient = 'caisse - RETOUR CLIENT';
    UILCaisse_FicheClient = 'caisse - CREATION MODIF FICHES CLIENTS';
    UILCaisse_ReajCF = 'caisse - REAJUSTEMENT D''UNE CARTE DE FIDELIETE';
    UILCaisse_Training = 'caisse - MODE TRAINING';
    UILCaisse_ParamModeEnc = 'caisse - PARAMETRAGE DES MODES D''ENCAISSEMENT';
    UILCaisse_ParamBtn = 'caisse - PARAMETRAGE DES BOUTONS';
    UILCaisse_OngletUtil = 'caisse - ONGLET UTILITAIRE';
    UILCaisse_OuvManu = 'caisse - OUVERTURE MANUELLE DU TIROIR';
    UILCaisse_SaisirDepense = 'caisse - SAISIR UNE DEPENSE';
    UILCaisse_RembClt = 'caisse - REMBOURSEMENT CLIENT';

//--------------------------------------------------------------------------------
// Permissions d'acc�s au menu de Ginkoia
//--------------------------------------------------------------------------------
    UILMenu_ListeTik = 'menu -diriger & admin- ctrl des caisses - LISTE DES TICKETS';
    UILMenu_RecapCaisse = 'menu -diriger & admin- ctrl des caisses - EDITION RECAP.';
    UILMenu_JournalVte = 'menu -diriger & admin- ctrl de l''activit� - JOURNAL DE VENTE';
    UILMenu_CAHorDate = 'menu -diriger & admin- ctrl de l''activit� - CA HORAIRE/DATE';
    UILMenu_HitParade = 'menu -diriger & admin- ctrl de l''activit� - HIT PARADE VENTES';
    UILMenu_AnalyseSynth = 'menu -diriger & admin- ctrl de l''activit� - ANALYSE SYNTHETIQUE';
    UILMenu_CAVend = 'menu -diriger & admin- gestion du personnel - CA PAR VENDEUR';
    UILMenu_CAHorVend = 'menu -diriger & admin- gestion du personnel - CA HORAIRE/VENDEUR';
    UILMenu_CltSolde = 'menu -diriger & admin- gestion des cptes clients - CTRL SOLDES';
    UILMenu_Fourn = 'menu - acheter - FOURNISSEURS';
    UILMenu_Cde = 'menu - acheter - commandes - GESTION DES COMMANDES';
    UILMenu_CarnetCde = 'menu - acheter - commandes - ANALYSE DU CARNET DE COMMANDES';
    UILMenu_FicheArt = 'menu - g�rer les produits - gestion du stock - FICHES ARTICLES';
    UILMenu_ConsoDiv = 'menu - g�rer les produits - gestion du stock - CONSO DIVERSES';
    UILMenu_TarifVente = 'menu - g�rer les produits - gestion du stock - TARIFS VENTES/MAG';
    UILMenu_EtikDiff = 'menu - g�rer les produits - gestion du stock - ETIQUETTES DIFFER';
    UILMenu_EtatStock = 'menu - g�rer les produits -analyse du stock- ETAT STOCK';
    UILMenu_EtatStockDate = 'menu - g�rer les produits -analyse du stock- ETAT STOCK A DATE';
    UILMenu_EtatStockDetail = 'menu - g�rer les produits -analyse du stock- ETAT STOCK DETAILLE';
    UILMenu_ListArtRef = 'menu - g�rer les produits -analyse du stock- LISTE ARTICLES REF.';
    UILMenu_ListArtRefDetail = 'menu - g�rer les produits -analyse du stock- LISTE DET. ART. REF';
    UILMenu_ListCtlg = 'menu - g�rer les produits -analyse du stock- LISTE DU CATALOGUE';
    UILMenu_Recept = 'menu - g�rer les produits - RECEPTION';
    UILMenu_TrsfMM = 'menu - g�rer les produits - TRANSFERT INTER-MAGASINS';
    UILMenu_Inventaire = 'menu - g�rer les produits - INVENTAIRE';
    UILMenu_Clt = 'menu - g�rer la relation client - CLIENTS';
    UILMenu_Devis = 'menu - vendre - gestion du n�goce - DEVIS';
    UILMenu_Livraison = 'menu - vendre - gestion du n�goce - BONS DE LIVRAISON';
    UILMenu_Facture = 'menu - vendre - gestion du n�goce - FACTURE';
    UILMenu_OrgEtps = 'menu - param�trage - g�n�ral - ORGANISATION DE L''ENTREPRISE';
    UILMenu_ParamTva = 'menu - param�trage - g�n�ral - TVA - TYPE COMPTABLE';
    UILMenu_ParamExeComm = 'menu - param�trage - g�n�ral - EXERCICE COMMERCIAUX';
    UILMenu_ParamEtik = 'menu - param�trage - g�n�ral - ETIQUETTE';
    UILMenu_ParamNK = 'menu - param�trage - g�rer les produits - NOMENCLATURE';
    UILMenu_GrilleTaille = 'menu - param�trage - g�rer les produits - GRILLES DE TAILLES';
    UILMenu_ParamGenre = 'menu - param�trage - g�rer les produits - GENRES, GROUPES';
    UILMenu_ParamCF = 'menu - param�trage - g�rer la rel. client - PARAM FIDELISATION';
    UILMenu_ParamEncaiss = 'menu - param�trage - vendre - MODE D''ENCAISSEMENT, COFFRE';
    UILMenu_EditNegoce = 'menu - param�trage - vendre - REGL. EDITIONS DANS LE NEGOCE';
    UILMenu_PersoBarreOutil = 'menu - param�trage - gestion utilisateurs - PERSO BARRE D''OUTIL';
    UILMenu_DroitUtil = 'menu - param�trage - gestion utilisateurs - MODIF. DES DROITS';

//****************************
// Ressources de la caisse
//****************************

    //28/02/2002 Bruno
    TrancheVide = 'Impossible, la correspondance entre la monnaie et les points est � z�ro';

    // Pascal 27/02/2002
    CstProbSession = '      Vous avez un probl�me de cl�ture'#13#10 +
        'Veuillez noter le message d''erreur et appeler ALGOL'#13#10 +
        'Clicker sur OK pour visualiser le message d''erreur';
    // Pascal 18/02/2002
    CstPasVersement = 'Aucun type de versement n''a �t� selectionn�';
    CstPasCoffre = 'Aucun coffre n''a �t� s�lectionn�';
    CstPasBanque = 'Aucune banque n''a �t� s�lectionn�e';

    // Bruno 18/02/2001
    RegulGlob01 = 'Dans un premier temps, vous allez devoir choisir dans la liste des tickets' + #13 + #10 +
        '   de la session en cours, le ticket � corriger.' + #13 + #10 +
        '  ' + #13 + #10 +
        '   Ensuite, Vous allez retrouver les encaissements r�alis�s sur ce ticket.' + #13 + #10 +
        '   Vous pourrez soit supprimer un encaissement [Suppr] pour ' + #13 + #10 +
        '   le remplacer par un autre, soit intervenir sur les valeurs.';

    RegulGlob03 = 'Confirmez vous l''annulation de votre correction d''encaissement?';

    // Bruno 15/02/2002
    ClientPasPossible = 'Impossible d''appeler ce cleint en caisse...';
    // Bruno 15/02/2002 Correction
    Type24 = 'Annulation d''un ancien ticket';

    // 15/02/2002 Correction
    CstPasDencaissement = 'Aucun encaissement de ce type n''existe dans la session';
    CstCaisOuv = 'Ouverture';
    CstCaisFer = 'Fermeture';
    //15/02/2002
    CstLibVerifComptage = 'Comptage  : Pi�ce %4d    Montant %10.2n';
    CstTickNum = 'Ticket num ';

    // Pascal 11/02/2002
    CstPanMoy = 'Panier moyen';
    CstValeur = 'Valeur';
    CstQuantite = 'Quantit�';
    CstVtProduit = 'Vente produit %s';
    CstVersAutoCoffre = 'VERSEMENTS AUTOMATIQUES AU COFFRE';
    CstVersAutoBQe = 'VERSEMENTS AUTOMATIQUES EN BANQUE';
    // Pascal le 7/02/2002
    CstDuAu = 'Du %s au %s';

    // Tri�
    Pas2Caisse = 'Vous ne pouvez pas, sur un m�me poste, activer plusieurs fois le module ''Caisse Ginkoia'' ...';
    DejaClientEnCours = 'Attention vous ne pouvez pas appeler ce client, il est d�j� en cours sur une autre caisse...';

    Aucuntrouve = 'Aucun article trouv� correspondant � votre saisie...';
    LibSousTotal = 'SOUS TOTAL';
    Question = 'Souhaitez vous terminer le ticket en cours ?';
    LibTicketenCours = 'Impossible de quitter la caisse, vous avez un ticket en cours...';
    LibRapido = 'Impossible vous avez d�j� �ffectu�s des op�rations dans l''onglet ''Encaissement''...';
    PasSessionEnCours = 'Attention, il n''y a pas de session en cours...';
    PasClientEnCours = ' Impossible, vous n''avez pas de client en cours ';
    Acompte = 'Acompte';
    Reglement = 'Reglement';
    Remboursement = 'Remboursement';
    TestAppelClient = 'Impossible, il y a des op�rations en cours pour le client actuel...';
    RenduPasPossible = 'Attention le ''Rendu de monnaie'' est interdit pour ce mode de paiement...';
    CompteBloque = 'Op�ration impossible, le compte du client est bloqu�...';
    SoldeNonCrediteur = 'Op�ration impossible, le solde du compte client n''est pas cr�diteur...';
    CreditEpuise = 'Attention vous avez �puis� le cr�dit du compte...';
    OpeAnnule = 'Op�ration annul�e, le reste � payer est nul...';
    TotAcoReg = 'TOTAL OPERATIONS CLIENT';
    TotVente = 'TOTAL DES VENTES';
    PasVendeur = 'Attention, votre caisse est param�tr�e avec une gestion vendeur,' + #13 + #10 + 'mais vous n''avez pas cr�� de vendeur...';
    PasCaissier = 'Attention, votre caisse est param�tr�e avec une gestion caissier,' + #13 + #10 + 'mais vous n''avez pas cr�� de caissier...';
    LibTicketVide = 'TICKET VIDE';
    LibTicketCours = 'TICKET EN COURS';
    TotalAPayer = 'TOTAL A PAYER';
    ARendre = 'A RENDRE';
    MoinsRemise = '  DONT REMISE : ';
    TotalVente = 'TOTAL DES VENTES';
    TotalEuros = '  (SOIT ';
    Euros = ' EUR)';
    ImpressionCheque = 'Ins�rez le ch�que � imprimer pour un montant de ';
    PBLImpressionCheque = 'Probl�me lors de l''impression du ch�que.' + #13 + #10 + ' Ins�rez le ch�que � imprimer pour un montant de ';
    Caissier = 'CAISSIER : ';
    TermineLigne = 'Les boutons seront actifs lorsque la ligne en cours sera valid�e...';

    NomClient = 'Votre client doit avoir un nom ou un pr�nom !';
    TicketDuplicata = 'DUPLICATA';
    TicketenCoursBis = 'Op�ration impossible, vous avez un ticket en cours...';
    Le = 'Le ';
    Facture = 'FACTURE';
    ImpressionFacurette = 'Veuillez ins�rer le document � imprimer...';
    PblImpressionFacturette = 'Probl�me lors de l''impression.' + #13 + #10 + 'Veuillez ins�rer � nouveau le document...';
    ImpressionFacuretteSuite = 'Veuillez ins�rer le document suivant � imprimer...';
    PblImpressionFacturetteSuite = 'Probl�me lors de l''impression.' + #13 + #10 + 'Veuillez ins�rer � nouveau le document suivant ...';

    FactureNumero = 'Facture Numero : ';
    LibCaissier = 'Caissier : ';
    LibVendeurCaisse = 'Vendeur  : ';
    AnnuationTck = 'ANNULATION DU TICKET NUMERO ';
    LbCorrectionMP = 'CORRECTION ENCAISSEMENT';
    LibCorrectionMP = 'Op�ration impossible, vous �tes en correction d''encaissement...';

    QuestionDepense = 'Confirmez vous la saisie de d�pense?';
    //Attention les champs qui suivent sont avec des espaces
    //C'est pour l'impression sur la TM, il faut toujours tenir compte
    //de la longueur des champs.
    CdArticle = 'ARTICLE   ';
    Desi = 'DESIGNATION ARTICLE                            ';
    Puttc = '  PU TTC  ';
    LibRemise = '  REMISE ';
    Qte = '  QTE ';
    PxTCC = ' TOT TTC  ';
    Ltaux = ' TAUX ';
    LTVA = '    TVA   ';
    LMHT = 'MONTANT HT';

//Cloture de session

    InfLibelleTke = 'Encaissement Ticket N� ';
    InfNoEcheance = 'Disponible';
    InfTitreFond = 'Fond de caisse initial et mouvement d''argent';
    InfTitreEncaissement = 'Encaissements r�alis�s';
    InfEtatSesClotCtrl = 'Cl�tur�e et contr�l�e';
    InfEtatSesClotNoCtrl = 'Clotur�e mais non control�e';
    InfEtatSesOuverte = 'Ouverte';
    ErrRecNotFound = 'Enregistrement non trouv�. Mise � jour impossible';

    InfApportFromSession = 'Fond Initial';
    InfRetraitToSession = 'Retrait vers la session n�';
    InfVersementBanque = 'Versement � la banque ';

    InfApportPoste = 'Apport en caisse : ';
    InfRetraitPoste = 'Retrait de la caisse : ';
    InfComptageGlobModeEnc = 'Comptage global d''un mode d''encaissement';
    InfComptageDetModeEnc = 'Comptage d�taill� d''un mode d''encaissement';
    InfPrelevement = 'Saisie manuelle d''un prelevement';

//Gestion du coffre

    InfNoMagasin = 'Aucun magasin existant';
    InfNoCoffre = 'Aucun coffre existant';
    //InfNoEcheance = 'Disponible';

    InfCreditingCff = 'Cr�diter le coffre : ';
    InfDebitingCff = 'D�biter le coffre : ';

//Journal de caisse

    TitleJC = 'Journal de Caisse';

//Mode encaissement
    InfNewModeEnc = 'Nouveau mode d''encaissement';
    //InfNoMagasin = 'Aucun magasin existant';
    InfDetailDefini = '<D�fini>';
    InfDetailIndefini = '<Ind�fini>';

//Ouverture de session
   //InfEtatSesClotCtrl   = 'Cl�tur�e et contr�l�e';
   //InfEtatSesClotNoCtrl = 'Clotur�e mais non control�e';
   //InfEtatSesOuverte    = 'Ouverte';
    InfNumSession = ' - Session n� ';
    ErrNoPosteNoSession = 'Pas de poste ou de session selectionn�';
   //InfNoEcheance        = 'Disponible';
    ErrOpenedSessionExists = 'Il existe d�j� une session ouverte sur ce poste';
    ErrNoMoreThan1SessionCounted = 'Cl�turez les sessions en cours sur ce poste avant d''en ouvrir une autre';
   //ErrRecNotFound       = 'Enregistrement non trouv�. Mise � jour impossible';
   //InfApportFromSession = 'Fond Initial';
   //InfRetraitToSession  = 'Retrait vers la session n�';

    //InfApportPoste = 'Apport en caisse : ';
    //InfRetraitPoste = 'Retrait de la caisse : ';

//Saisie des op�rations

    ErrNoLibelle = 'Aucun libell� saisi';
    ErrInvalidAmount = 'Montant saisi incorrect';
    ErrNoModeEnc = 'Aucun mode d''encaissement selectionn�';
    ErrInvalidSource = 'Pas de source selectionn�e';
    ErrInvalidDest = 'Pas de destination selectionn�e';
    InfMontant = 'Montant en ';
    ErrInvalidQte = 'Nombre de pi�ce saisi incorrect';

//General

    //PasCaissier = 'Attention, votre caisse est param�tr�e avec une gestion caissier,' + #13 + #10 + 'mais vous n''avez pas cr�� de caissier...';
    //PasSessionEnCours = 'Attention, il n''y a pas de session en cours...';
    InitModeEncImpossible = 'Impossible, des modes de paiement existent d�j� pour ce magasin...';
    Pascoffre = 'Vous devez au pr�alable cr�er un coffre pour ce magasin...';
    Pasbanque = 'Vous devez au pr�alable cr�er une banque pour ce magasin...';
    BtnDejaCree = 'Attention des boutons existent d�j�, voulez vous les supprimer?';
    CaisseEnCours = 'Impossible de cl�turer la session, la caisse est encore ouverte';
    TMnonConnectee = ' L''imprimante ticket n''est pas allum�e ou pas branch�e...';
    TCnonConnecte = ' Le tiroir caisse n''est pas branch�...';
    JourDifferentSessionL1 = ' Attention, il existe une session en cours ouverte le ';
    JourDifferentSessionL2 = 'Souhaitez vous cl�turer la session?';
    ConfAnnul = 'Confirmez vous l''annulation de ce ticket?';
    DejaAnnule = 'Op�ration impossible, ce ticket est d�j� annul�...';
    AnnulRegul = 'Annulation de la correction des encaissements en cours?';
    Pasledroit = 'Attention, vous n''avez pas les droits pour utiliser cette fonction...';
    TicketSimple = 'Ticket simple';
    TicketTVA = 'Ticket avec TVA';
    Facturet = 'Facturette';
    SupEncaissement = 'Confirmez vous l''annulation de cet encaissement?';
    CaptionAnnul = 'Annulation d''un ticket';
    CaptionCptcli = 'Liste des tickets';
    CaptionRegul = 'Correction des encaissements';

//Param Caisse
    Chrono = 'Code Chrono';
    RefFourn = 'Ref. fournisseur';

//Ticket Fidelite

    PointPrecedent = 'POINTS DEJA OBTENUS :';
    PointDuJour = 'ACQUIS CE JOUR :';
    PointTotal = 'TOTAL DES POINTS :';
    PointMontantL1 = 'EQUIVALENT A';
    PointMontantL2 = 'UN BON D''ACHAT DE :';
    MontantBA = 'VALEUR DU BON D''ACHAT :';
    NombreTicket = 'NOMBRE DE TICKETS :';
    PasdeCarteFidelite = 'Ce client n''a pas de carte de fid�lit�...';
    DAteDebut = 'CARTE OUVERTE LE :';
    PointObtenir = 'NOMBRE DE POINTS A OBTENIR :';
    BADispo = 'POINTS CUMULABLE JUSQU''AU';
    Utilisable = 'UTILISABLE JUSQU''AU';
    GenerationBAL1 = 'Votre client a droit � un Bon d''achat de';
    GenerationBAL2 = 'Souhaitez vous le g�n�rer aujourd''hui?';
    BenefBA = 'Votre client b�n�ficie d''un bon d''achat de';
    ValiditeBA = 'valide jusqu''au';
    QuestionBenefBA = 'Est ce qu''il souhaite l''utiliser maintenant?';
    PasModeEncFidelite = 'Op�ration impossible, vous n''avez pas de mode d''encaissement avec le type ''Fid�lit�''';
    FidManuel = 'Points fid�lit�s saisis manuellement, pas de liaison avec un ticket de caisse...';
    BaPasUtilise = 'Ce bon d''achat n''a pas �t� utilis�...';
    BonAchat = 'Bon d''achat';
    NewParamCF = 'Attention cette fonction vous permet de param�trer la grille des bon d''achat.' + #13 + #10 +
        'Souhaitez vous annuler le param�trage pr�c�dent?';
    BAImcomplet = 'Le param�trage est incomplet...';

    LibTyp0 = 'Pas de carte fid�lit�';
    LibTypA = 'Type A (Nbre de passages)';
    LibTypB = 'Type B (P�riode)';
    LibTypC = 'Type C (Nbre de points)';

    //Compte client
    PositionCompte = 'POSITION DU COMPTE';
    SoldeCrediteur = 'SOLDE CREDITEUR :';
    SoldeDebiteur = 'SOLDE DEBITEUR :';

    //param caisse
    Bouton = 'Boutons';
    Grille = 'Grille';

    Centime = 'Centime';
    Decime = 'Decime';
    Unite = 'Unit�';
    Dizaine = 'Dizaine';
    Centaine = 'Centaine';

    //Lib Btn Appel Client
    Creation = 'Cr�ation [INS]';
    Visu = 'Visu. [F2]';

    //Fonctions boutons
    Type01 = 'Appel Client';
    Type02 = 'Suppression de la ligne courante';
    Type03 = 'Suppression du ticket en cours';
    Type04 = 'Qte +1';
    Type05 = 'Retour Article';
    Type06 = 'Acces au champs remise,qte,prix...';
    Type07 = 'Remise Article (Normale, Solde,Promo)';
    Type08 = 'Liste des pseudos articles';
    Type09 = 'Mode d''encaissement';
    Type10 = 'Mode d''encaissement Rapide';
    Type11 = 'Sous Total';
    Type12 = 'Compte Client';
    Type13 = 'Reste Du';
    Type14 = 'Bon Achat Interne';
    Type15 = 'Bon Achat Externe';
    Type16 = 'Reglement';
    Type17 = 'Versement d''avance';
    Type18 = 'Remboursement client';
    Type19 = 'Validation des modifs. de la fiche client';
    Type20 = 'Annulation des modifs. de la fiche client';
    Type21 = 'Mise en attente du client';
    Type22 = 'Appel d''un article pr�cis';
    Type23 = 'R��dition du ticket';
    Type25 = 'Correction des modes d''encaissement';
    Type26 = 'Ouverture du tiroir caisse';
    Type27 = 'Saisie d''une Depense';
    Type28 = 'Ticket Carte fidelite';
    Type29 = 'Acces � la liste complete des boutons';

    vente = 'Vente';
    Client = 'Client';
    Encaissement = 'Encaissement';
    Utilitaires = 'Utilitaires';

    Promo = 'Promo';
    Solde = 'Solde';
    Normale = 'Normale';

    PasTypeBouton = 'Attention vous n''avez pas s�lectionn� la fonction du bouton...';
    PasTypeRemise = 'Attention vous n''avez pas indiqu� le type de la remise...';
    PasArticle = 'Attention vous n''avez pas indiqu� l''article associ� au bouton...';
    PasModeenc = 'Attention vous n''avez pas indiqu� le mode d''encaissement associ� au bouton...';
    AttTFDejaUtil = 'Attention, cette touche de fonction est d�j� utilis�e...';
    TfVide = 'Vide';
    ParamBtn = 'Attention cette op�ration r�tablie les boutons d''origine.' + #13 + #10 +
        '   Souhaitez vous poursuivre la r�initialisation?';
    QuitterBtn = 'Pour que les changements soient pris en compte, il faut fermer tous les tickets en cours.' + #13 + #10 +
        '   Lorsqu''il ne reste plus que l''onglet ''Ecran de contr�le'' vous pouvez r�ouvrir la caisse...';
    CopierBtn = 'Attention cette op�ration d�truit les boutons existant et les remplace' + #13 + #10 +
        '   en prenant comme mod�le une caisse que vous allez s�lectionner ensuite.' + #13 + #10 +
        '   Souhaitez vous poursuivre le traitement?';

    // Pascal 24/01/2002
    CstEditComptage = 'EDITION DU COMPTAGE';
    CstPostDate = '%s, Le %s';
    CstSession = 'Session Num %s';
    CstTitreImp1 = 'Encaissement       | Qte  |   Montant  ';
    CstTotalImp = 'TOTAL              |      |';
    CstDetailImp = 'Detail de %s';
    CstPiece = 'Piece Num %s';
    CstEditEnc = 'EDITION DES ENCAISSEMENTS';
    CstEditEncTitre = ' Edition des encaissements de la session';
    CstMontantCaption = 'Montant encaiss�';
    CstTypeEnc1 = 'Apport initial';
    CstTypeEnc2 = 'Encaissement';
    CstTypeEnc3 = 'Pr�l�vement manuel';
    CstTypeEnc4 = 'Pr�l�vement automatique';
    CstTypeEnc5 = 'Versement � une session';

    CstLaBanque = 'LA BANQUE';
    CstLeCoffre = 'LE COFFRE';
    CstChequeEuro = 'CHEQUES EURO';
    CstEspeceFranc = 'ESPECES FRANCS';
    CstEspeceEuro = 'ESPECES EURO';
    CstEspece = 'ESPECES';
    CstCheque = 'CHEQUES';
    CstCBEuro = 'CB EURO';
    CstCarteBleu = 'CARTES BLEUES';
    cstBonAchInt = 'BON D''ACHAT INTERNE';
    cstBonAchExt = 'BON D''ACHAT EXTERNE';
    CstRemiseFidelite = 'REMISE CARTE FIDELITE';
    CstCompteClient = 'COMPTES CLIENTS';
    CstResteDu = 'RESTE DU';
    CstAutreCarte = 'AUTRES CARTES';
    CstVirement = 'VIREMENT';
    CstChequeVacance = 'CHEQUES VACANCES';
    CstClient = 'Clients';
    CstTicket = 'Ticket';
    CstRetour = 'Retour';
    CstEditerLe = 'EDITE LE %s';
    CstNbrTicket = 'Nombre de tickets';
    CstPanMoyVal = 'Panier Moyen en valeur';
    CstEnQuantite = '                    en Quantite';
    CstEnQte = '             en Qte';
    CstCA = 'CHIFFRE D''AFFAIRE';
    CstVenteProduit = '      Vente produit %s%%';
    CstVente = ' Vte %s%%';
    CstTVA1 = '      TVA %s%%';
    CstTVA2 = ' TVA %s%%';
    CstReglementClient = 'REGLEMENTS CLIENTS';
    CstCltDiv1 = '      Clients divers';
    CstCltDiv2 = ' Clt. div';
    CstRemise = 'REMISES';
    CstDestination = 'Destination';
    InfAjoutToSession = 'Versement session ';
    CstTotEnc = 'TOTAL ENCAISSE';
    CstVersCfr1 = 'VERSEMENTS AU COFFRE';
    CstVersCFr2 = 'VERSEMENTS COFFRE';
    CstVersBq1 = 'VERSEMENTS EN BANQUE';
    CstVersBq2 = 'VERSEMENTS BANQUE';
    CstFondCais1 = 'GESTION DU FOND DE CAISSE';
    CstFondCais2 = 'FOND DE CAISSE';
    CstEnc1 = '      Encaissements';
    CstEnc2 = ' Encaisse';
    CstSoldeEncaissement = '  Solde de l''encaissement : ';

    OKRegulGlob = 'Impossible, pour valider l''op�ration le solde doit �tre � z�ro';

IMPLEMENTATION

END.

