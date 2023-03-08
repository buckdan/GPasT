UNIT GinkoiaResStr;

INTERFACE

  // les ressourcestring ont �t� enlev�s car il y a conflit avec les composant RX  
const

  // Module STOCKIT pour EKOSPORT
  UILModuleEkoStockit = 'EKOSPORT';

  // Caisse - location
  RS_QRY_LOC_SuppOrga = 'Voulez-vous retirer l''organisme associ� � la ligne de location ?';
  RS_TXT_LOC_RegFixHL = 'Hors limite';
  RS_ERR_LOC_NotType3 = 'Il est interdit de choisir le niveau "�0" pour un poids inf�rieur � 22 Kg';
  

  //--------------------------------------------------------------------------------
  // Module et permission Tableau de bord ISF
  //--------------------------------------------------------------------------------
  UILModuleISF      = 'menu -diriger & admin- Tableau de bord Intersport';
  UILModuleObjectif = 'menu -diriger & admin- Objectifs';
  UILModuleTblbISF  = 'TABLEAU BORD ISF';


  //--------------------------------------------------------------------------------
  // Module et permission Fusion de fiche article
  //--------------------------------------------------------------------------------
  UILModuleFusion   = 'menu - g�rer les produits - Fusion de fiche mod�le';
  UILModuleFusionMod= 'FUSION FICHE MODELE';
  
  //--------------------------------------------------------------------------------
  // Module et permission BL Fournisseurs automatique
  //--------------------------------------------------------------------------------
  UILMenuBLF        = 'menu - g�rer les produits - BL Fournisseurs automatiques';
  UILModifBLF       = 'modifier - BL Fournisseurs automatiques';
  UILModifParamBLF  = 'modifier - BL Fournisseurs - Param�trage de la gestion du RAL';
  UILModifAffectBLF = 'modifier - BL Fournisseurs - Affectation de r�ception';
  UILModuleBLF      = 'BL FOURNISSEUR ISF';
  
  //--------------------------------------------------------------------------------
  // Ressource string utilis� pour les droits
  //--------------------------------------------------------------------------------
  UILRecepPxAchatVoir = 'voir - PRIX ACHAT en RECEPTION';  //Droit en r�ception pour la visualisation des prix d'achat
  UILModifNomencWeb         = 'menu - modifier - NOMENCLATURE WEB';
  UILModifier_ControleEncaissement = 'modifier - Compta - CONTROLE ENCAISSEMENT';
  UILMenu_ControleEncaissement = 'menu -diriger & admin- Compta - CONTROLE ENCAISSEMENT';
  UilModif_FicheArticleLoc = 'modifier - location - FICHE ARTICLES';
  UILModifGrilleLoc     = 'modifier - LOCATION - GRILLE TARIFAIRE';
  UilCF_EtatStkDate = 'Contr�le Fiscal - ETAT STOCK A DATE';
  UilCF_AnaMvt      = 'Contr�le Fiscal - ANALYSE MOUVEMENT';
  UilCF_LstTktBDC   = 'Contr�le Fiscal - LISTE TICKET BDC';
  UilCF_LstFact     = 'Contr�le Fiscal - LISTE FACTURE';
  UilCF_TrfInterMag = 'Contr�le Fiscal - TRF INTERMAG FACTURE';
  UILRefDynGinParam     = 'menu - param�trage - GESTION DES PRODUITS - Ref Dynamique';
  UILRefDynGinFichArt   = 'modifier - FICHE ARTICLE - Par r�f�rencement dynamique';
  UILRecepPxVteModif = 'modifier - PRIX VENTE en RECEPTION';
  UILRecepPxAchatModif = 'modifier - PRIX ACHAT en RECEPTION';
  UILRefSKMUse = 'menu - g�rer les produits - REFERENCEMENT SKIMIUM';
  UILImpODLUse = 'menu - g�rer les produits - IMPORT ODLO';
  UILDepotVenteParam    = 'menu - param�trage - DEPOT VENTE';
  UILDepotVenteModif    = 'modifier - DEPOT VENTE - G�rer les contrats';
  UILDepotVenteModifMat = 'modifier - DEPOT VENTE - G�rer le mat�riel';
  UILEntrepotParam = 'menu - param�trage - ENTREPOT';
  UILEntrepotGestPlacement = 'menu - Entrep�t - Gestion  des emplacements';
  UILEntrepotGestPicking = 'menu - Entrep�t - R�approvisionnement de la zone Picking';
  UILEntrepotModif = 'modifier - ENTREPOT';
  UILTransIMWeb = 'menu - g�rer les produits - TRANSF. INTER-MAGASINS WEB'; // remplace 'menu - g�rer les produits - TRANSF. INTER-MAGASINS PLATEFORME'
  UILTransIMWebForceMajStock = 'modifier - TRANSF. IM WEB - Forcer la mise � jour du stock';
  UILTransIMWebAffEcart = 'modifier - TRANSF. IM WEB - Affichage des �carts';
  UILTransIMWebValidEcarts = 'modifier - TRANSF. IM WEB - Valider avec �carts/sans contr�le';
  UILForceClotureRapprochement = 'menu -diriger & admin- Compta - Forcer cl�t. bon rapprochement';
  UILMenu_BeColTrace = 'menu -diriger & admin- ctrl des caisses � TRACE BE COLLECT OR';
  UILForcerControle_BonPrepa='modifier - BON DE PREPARATION - Forcer CONTROLER';
  UILAnnuler_ActionBonPrepa = 'modifier - BON DE PREPARATION - Annuler Action';
  UILMenu_VisuBonPrepra = 'menu - vendre - Bon de pr�paration';
  UILModifier_BonPrepra = 'modifier - BON DE PREPARATION';
  UILMenu_ParamBonPrepa = 'menu - param�trage - BON PREPARATION';
  UILMenu_ListArtWeb = 'menu - g�rer les produits - Web - Liste Art Web';
  UILLOCMODIFTARIF = 'modifier - location - TARIF';
  UILArticle_StatOC = 'menu - g�rer les produits -gestion articles- STAT OP. COM';
  UILClient_AnalyseFidelite = 'menu - g�rer la relation client - ANALYSE FIDELITE';
  UILMenu_EtatStockIdeal = 'menu - g�rer les produits -analyse du stock- GESTION DU STOCK IDEAL';
  UILCaisse_paramBeCol = 'caisse - param�trage - Param�trage Be Collect or';
  UILMenu_Echeancier = 'menu -diriger & admin- Compta - Ech�ancier';
  UIL_AccesAPISOFT = 'Comptabilit� : Acc�s � l''exportation APISOFT';
  UIL_AccesCEGID = 'Comptabilit� : Acc�s � l''exportation PGI (CEGID)';
  UILMenu_RapComptable = 'menu -diriger & admin- Compta - Rapprochement Factures Fourn.';
  UILCaisse_MODIFBAFIDBOX = 'caisse - FIDBOX REPRISE MANUELLE DES BONS DE REDUCTION';
  uil_Atelier = 'menu - Atelier';
  uil_ParamAtelier = 'menu - Param�trage - Atelier';
  UILModuleresa = 'RESERVATION CENTRALE';
  UILcaisse_ChequeCadeau = 'caisse - GESTION DES CHEQUES CADEAUX';
  UILCaisse_ParamFidbox = 'caisse - param�trage - Param�tres FIDBOX';
  uil_IntegAuto = 'menu - location - INTEGRATIONS AUTOMATIQUES';
  uil_integautoParam = 'menu - location - PARAMETRAGE (INTEGRATION AUTOMATIQUE)';
  uil_PrevisionReservation = 'menu - location - Pr�visionnel de r�servation';
  UILMenu_GestionGroupeeClt = 'menu - g�rer la relation client - GESTION GROUPEE DES CLIENTS';
  UILDedoublonnage = 'menu - g�rer les produits -R�f�rencement- Gestion doublons';
  UILImp_SP2000 = 'menu - g�rer les produits -Import Sport 2000';
  UILNumCB = 'voir - fiche client - NUMERO CARTE DE PAIEMENT';
  UILMenu_LocAmortLot = 'menu - location - AMORTISSEMENTS PAR LOTS';
  UILMenu_ParamWebVente = 'menu - param�trage - WEB VENTE';
  UILGestion_WebVente = 'gestion - WEB VENTE';
  UILMenu_Etiquettes = 'menu - param�trage - ETIQUETTES';
  UIl_voir_ficheclient_hisloloc = 'voir - fiche client - HISTORIQUE DES LOCATIONS';
  UILMenu_TarifOC = 'menu - g�rer les produits -gestion articles- TARIF OP. COM';
  UILMenu_ActiverTarifOC = 'menu - g�rer les produits -gestion articles- Activer TOC';
  UILMenu_GestionTarifOC = 'menu - g�rer les produits -gestion articles- Gestion TOC';
  UILMenu_AssAideTrsfMM = 'menu - g�rer les produits - ASSISTANT D''AIDE TRF INTER-MAG';
  UILMenu_CltArch = 'menu - g�rer la relation client - Liste clients archiv�s';
  UILMenu_JournalBA = 'menu -diriger & admin- ctrl de l''activit� - RECAP. BONS ACHAT';
  UILMenu_ImpCesAmort = 'menu -diriger & admin- ctrl de l''activ. - Ed. Cession et Amort.';
  UILMenu_JouLoc = 'menu -diriger & admin- ctrl de l''activ. - Journal de location';
  UILMenu_EtatPark = 'menu -diriger & admin- ctrl de l''activ. - Etat des loc. en cours';
  UILMenu_TrfGebuco = 'menu -diriger & admin- Compta - Export GEBUCO';
  UILmodif_TRfBlFact = 'modifier - BL - TRANSFERER EN FACTURE';
  UILmodif_TRfDvDv = 'modifier - DEVIS - TRANSFERER EN DEVIS';
  UILmodif_TRfDvBl = 'modifier - DEVIS - TRANSFERER EN BL';
  UILmodif_TRfDvFact = 'modifier - DEVIS - TRANSFERER EN FACTURE';
  UILMenu_GestionGroupeArtLoc = 'menu - location - GESTION GROUPEE ARTICLES LOCATION';
  UILSuperArchi = 'modifier - location - fiche article - ARCHIVAGE EXCEPTIONNEL';
  UILMenu_CltGRDLivre = 'menu -diriger & admin- gestion des cptes clients - GRAND LIVRE';
  UILmodif_Lettrage = 'modifier - CLIENT - MODIFIER LE LETTRAGE DES COMPTES';
  UILGestion_REFERENCEMENT = 'gestion - REFERENCEMENT';
  UILMenu_RefMajPrixVente = 'menu - g�rer les produits -R�f�rencement- MAJ prix de vente';
  UILMenu_RefGestionNk = 'menu - g�rer les produits -R�f�rencement- Gestion nomenclature';
  UILMenu_Artsanscol = 'menu - g�rer les produits -analyse du stock- ART. SANS COL.';
  UILMenu_ArtPlusCol = 'menu - g�rer les produits -analyse du stock- ART. PLUSIEUR COL.';
  UILMenu_Colavecart = 'menu - g�rer les produits -analyse du stock- COL. AVEC ART.';
  UILcaisse_GenerationBR = 'caisse - GENERATION BON DE RESERVATION';
  UILMenu_Depreciation = 'menu - g�rer les produits -gestion articles- DEPRECIATION';
  UILMenu_LocRnonP = 'menu -diriger & admin- ctrl de l''activ. - LOC Rend. non pay�es';
  UILMenu_CdeVrac = 'menu - acheter - commandes - COMMANDES EN VRAC';
  UILMenu_RecepVrac = 'menu - g�rer les produits - RECEPTIONS EN VRAC';
  UILVoir_VisuMagsRecepVrac = 'voir - TOUS LES MAGASINS - RECEPTIONS VRAC';
  UILMenu_LstDetArtLoc = 'menu -diriger & admin- Ed. Location - Liste d�t. des articles';
  UILMenu_AnaDetParcLoc = 'menu -diriger & admin- Ed. Location - Analyse d�t. du parc';
  UILMenu_CltRapido = 'menu - location - SAISIE RAPIDE FICHE CLIENT (LOCATION)';
  UILMenu_ClotCaisse = 'menu -diriger & admin- ctrl des caisses - CLOTURE CAISSE';
  UILMenu_AnaPerLoc = 'menu -diriger & admin- Ed. Location - Analyse p�riodique';
  UILMenu_CAPrevLoc = 'menu -diriger & admin- Ed. Location - CA Pr�visionnel';
  UILMenu_AnalyseCALoc = 'menu -diriger & admin- Ed. Location - Analyse du CA';
  UILmodif_Reservation = 'modifier - LOCATION - MODIFIER LES FICHES DE RESERVATION';
  UILMenu_LocReservation = 'menu - location - GESTION RESERVATION LOCATION';
  UILMenu_AnalyseEnchaine = 'menu -diriger & admin- ctrl de l''activit� - EDIT. ENCHAINEES';
  UILmodif_CarteBleu = 'modifier - LOCATION - N� CARTE BLEU';
  UILMenu_LocCarteMag = 'menu - location - CARTES MAGASIN';
  UILMenu_LocGestionTarif = 'menu - location - GESTION TARIF LOCATION';
  UILMenu_ParamGesArt = 'menu - param�trage - GESTION DES PRODUITS';
  UILMenu_ParamGen = 'menu - param�trage - PARAMETRAGE GENERAL';
  UILMenu_GesParamLoc = 'menu - param�trage - PARAMETRAGE LOCATION';
  UILMenu_GesLocalModules = 'menu - param�trage - GESTION MODULES VERSION';
  UILMenu_ListeDetailClt = 'menu - g�rer la relation client - LISTE DETAILLEE CLIENTS';
  UILMenu_AnalyseTrsfMM = 'menu - g�rer les produits - ANALYSE TRANSFERT INTER-MAGASINS';
  UILMenu_ListArtArchive = 'menu - g�rer les produits -analyse du stock- LISTE ART. ARCHIVES';
  UILMenu_AnalyseConsoDiv = 'menu - g�rer les produits -gestion articles- ANALYSE CONSO';
  UILMenu_RegulStock = 'menu - g�rer les produits -gestion articles- REGUL. STOCK';
  UILMenu_GestGroupArt = 'menu - g�rer les produits -gestion articles- GESTION GROUPE ART';
  UILMenu_Preco = 'menu - acheter - commandes - BLOC NOTE DE COMMANDE';
  UILMenu_Annulation = 'menu - acheter - commandes - GESTIONS DES ANNULATIONS';
  UILMenu_AnalyseNN1SF = 'menu -diriger & admin- ctrl de l''activit� - ANALYSE N/N-1 MARQUE';
  UILMenu_AnalyseNN1 = 'menu -diriger & admin- ctrl de l''activit� - ANALYSE N/N-1 SOUS FAMILLE';
  UILTrsfMMMAGSO = 'voir - TRANSFERT INTER MAG - LES AUTRES MAGASINS COMME ORIGINE';
  UILMenu_ANABAO = 'menu -diriger & admin- ctrl de l''activit� - BONS ACHAT';
  //    UILLOCMODIFDETAIL='caisse - FONCTION DETAIL MODIFICATION DU BON DE LOCATION';
  UILLOCMODIFDETAIL = 'modifier - location - DETAIL DU BON LOCATION';
  //    UILLOCMODIFGLOBALE='caisse - MODIFICATION GLOBALE DU BON DE LOCATION';
  UILLOCMODIFGLOBALE = 'modifier - location - BON LOCATION GLOBAL';
  UILLOCANNULDIC = 'location - ANNULATION DU BON DE LOCATION';
  UILMENU_LOCINVENTAIRE = 'menu - location - INVENTAIRE';
  // UILMenu_RecapTVA = 'menu -diriger & admin- ctrl des caisses - RECAP. TVA';
  UILMenu_RecapTVA = 'menu -diriger & admin- ctrl des caisses - SYNTH. CA';
  UILMenu_SynthMvt = 'menu -diriger & admin- ctrl des caisses - SYNTHESE MOUVEMENTS';
  UILMenu_DetMvtMag = 'menu -diriger & admin- ctrl des caisses - DETAIL DES MOUVEMENTS';
  UILMENU_RETFOURN = 'menu - g�rer les produits - RETOURS FOURNISSEURS';
  Uilmenu_FicheArticleLoc = 'menu - location - FICHE ARTICLES';
  Uilmenu_ControlePiccolink = 'menu - location - CONTROLE PICCOLINK';
  Uilmenu_EditionTarifLoc = 'menu - location - EDITION TARIF LOCATION';
  UILCaisse_TPE = 'caisse -TPE- VALIDATION DU TICKET MALGRE LA TRANSACTION ANNULEE';
  UILMenu_GesCoffre = 'menu -diriger & admin- Coffre - Gestion du coffre';
  UILMenu_HistoCoffre = 'menu -diriger & admin- Coffre - Historique du coffre';
  UILcaisse_GenerationBL = 'caisse - GENERATION BON DE LIVRAISON';
  UILclient_Analyse = 'menu - g�rer la relation client -mailing- CONSTRUCTION';
  UILclient_Mailing = 'menu - g�rer la relation client -mailing- GESTION DES MAILING';
  UILMenu_AnalyseVente = 'menu -diriger & admin- ctrl de l''activit� - ANALYSE DES VENTES';
  UILReajustCompte = 'caisse - REAJUSTEMENT D''UN COMPTE CLIENT';
  UILSuper = 'SUPER';
  UILPxVentePreco = 'menu - g�rer les produits - Prix de vente pr�conis�s � date';

  UIL_ModuleReportMercier = 'REPORTING MERCIER';
  UILGestionEncours = 'modifier - CLIENT - Gestion de l''encours';

  //--------------------------------------------------------------------------------
  // Gestion des marques & fournisseurs
  //--------------------------------------------------------------------------------
  UIL_MRKCREATE = 'modifier - MARQUES';

  //--------------------------------------------------------------------------------
  // Nom des vieilles Permissions
  //--------------------------------------------------------------------------------

  // UILFct_Negoce = 'FCT-NEGOCE';
  // UILFct_GestCde = 'FCT-GESTION CDE';
  // UILmodif_NK = 'NOMENCLATURE - MODIFIER';
  // UILVisuMag = 'VISU MAG';
  // UILVisuMag_Stock = 'VISU MAG - STOCK';
  // UILmodif_Art = 'FICHE ARTICLE - MODIFIER';
  // UILachatVis_Art = 'FICHE ARTICLE - ACHAT VISIBLE';
  // UILmodif_Bcde = 'BON CDE - MODIFIER';
  // UILmodif_Recep = 'BON RECEPTION - MODIFIER';
  //UILmodif_TransMM = 'BON TRANSFERT - MODIFIER';
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
  UILModif_FicheArt = 'modifier - FICHE ARTICLE';
  UILModif_LaNK = 'modifier - NOMENCLATURE';
  UILModif_Fournisseur = 'modifier - FOURNISSEUR';
  UILModif_ConsoDiv = 'modifier - CONSO DIVERSES';
  UILModif_TarVente = 'modifier - TARIFS DE VENTE';
  UILModif_Clt = 'modifier - CLIENT';
  UILModif_Livr = 'modifier - BON DE LIVRAISON';
  UILModif_Devis = 'modifier - DEVIS';
  UILModif_Fact = 'modifier - FACTURE';
  UILModif_LocFicheArt = 'modifier - LOCATION - FICHES ARTICLES';

  //--------------------------------------------------------------------------------
  // Permissions de Visualisation de donn�es
  //--------------------------------------------------------------------------------
  UILVoir_Tarif = 'voir - fiche article - ONGLET TARIF';
  UILVoir_Mags = 'voir - TOUS LES MAGASINS';
  UILVoir_StockMags = 'voir - TOUS LES MAGASINS - STOCK';

  //--------------------------------------------------------------------------------
  // Permissions de gestion de la CAISSE
  //--------------------------------------------------------------------------------
  UILCaisse_Cloturer = 'caisse -session- CLOTURER / PRELEVER';
  UILCaisse_SupprTik = 'caisse - SUPPRESSION D''UNE LIGNE DE TICKET';
  UILCaisse_EncTikNeg = 'caisse - ENCAISSEMENT D''UN TICKET NEGATIF';
  UILCaisse_AnnulTik = 'caisse - ANNULATION DU TICKET EN COURS';
  UILCaisse_SupprOldTik = 'caisse - SUPPRESSION D''UN ANCIEN TICKET';
  //    UILCaisse_VteSoldee = 'caisse - VENTE SOLDEE';
  //    UILCaisse_VtePromo = 'caisse - VENTE PROMO';
  UILCaisse_VteRemise = 'caisse - VENTE AVEC REMISE';
  UILCaisse_RetClient = 'caisse - RETOUR CLIENT';
  UILCaisse_FicheClient = 'caisse - CREATION MODIF FICHES CLIENTS';
  UILCaisse_ReajCF = 'caisse - REAJUSTEMENT D''UNE CARTE DE FIDELIETE';
  UILCaisse_Training = 'caisse - MODE TRAINING';
  UILCaisse_ParamModeEnc = 'caisse -session- PARAMETRAGE DES MODES D''ENCAISSEMENT';
  UILCaisse_OngletUtil = 'caisse - ONGLET UTILITAIRE';
  UILCaisse_OuvManu = 'caisse - OUVERTURE MANUELLE DU TIROIR';
  UILCaisse_SaisirDepense = 'caisse - SAISIR UNE DEPENSE';
  UILCaisse_RembClt = 'caisse - REMBOURSEMENT CLIENT';
  UILCaisse_Utilcaisse = 'caisse -activit�- UTILISATION DE LA CAISSE';
  UILCaisse_Gestionsessions = 'caisse -activit�- GESTION DES SESSIONS';
  UILCaisse_OuvertureSession = 'caisse -session- OUVERTURE DE SESSION';
  UILCaisse_ClotureSessions = 'caisse -session- CLOTURE DE SESSIONS';
  UILCaisse_HistoSessions = 'caisse -session- HISTORIQUE DES SESSIONS';
  UILCaisse_EditionJournaux = 'caisse -session- EDITION DES JOURNAUX';
  UILCaisse_VerifComptage = 'caisse - cl�ture de session - V�rifier le comptage';
  UILCaisse_PrelClot = 'caisse - cl�ture de session - Pr�lever / Cl�turer';
  UILCaisse_ParamCaisse = 'caisse - param�trage - Param�tres de la caisse';
  UILCaisse_ParamBtn = 'caisse - param�trage - Param�trage des boutons';
  UILCaisse_OkCreationMotif = 'caisse - CREATION MOTIF MODIFICATION DE TICKET';

  //--------------------------------------------------------------------------------
  // Permissions d'acc�s au menu de Ginkoia
  //--------------------------------------------------------------------------------
  UILMenu_TrfCompta = 'menu -diriger & admin- Compta - Transfert en comptabilit�';
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
  UILMenu_FicheArt = 'menu - g�rer les produits -gestion articles- FICHES ARTICLES';
  UILMenu_ConsoDiv = 'menu - g�rer les produits -gestion articles- CONSO DIVERSES';
  UILMenu_TarifVente = 'menu - g�rer les produits -gestion articles- TARIFS VENTES/MAG';
  UILMenu_EtikDiff = 'menu - g�rer les produits -gestion articles- ETIQUETTES DIFFER';
  UILMenu_EtatStock = 'menu - g�rer les produits -analyse du stock- ETAT STOCK';
  UILMenu_EtatStockDate = 'menu - g�rer les produits -analyse du stock- ETAT STOCK A DATE';
  UILMenu_EtatStockDetail = 'menu - g�rer les produits -analyse du stock- ETAT STOCK DETAILLE';
  UILMenu_ListArtRef = 'menu - g�rer les produits -analyse du stock- LISTE ARTICLES REF.';
  UILMenu_ListArtRefDetail = 'menu - g�rer les produits -analyse du stock- LISTE DET. ART. REF';
  //    UILMenu_ListCtlg = 'menu - g�rer les produits -analyse du stock- LISTE DU CATALOGUE';
  UILMenu_Recept = 'menu - g�rer les produits - RECEPTION';
  UILMenu_TrsfMM = 'menu - g�rer les produits - TRANSFERT INTER-MAGASINS';
  UILMenu_Inventaire = 'menu - g�rer les produits - INVENTAIRE';
  UILMenu_Clt = 'menu - g�rer la relation client - CLIENTS';
  UILMenu_Devis = 'menu - vendre - gestion du n�goce - DEVIS';
  UILMenu_Livraison = 'menu - vendre - gestion du n�goce - BONS DE LIVRAISON';
  UILMenu_Facture = 'menu - vendre - gestion du n�goce - FACTURE';
  //    UILMenu_OrgEtps = 'menu - param�trage - g�n�ral - ORGANISATION DE L''ENTREPRISE';
  //    UILMenu_ParamTva = 'menu - param�trage - g�n�ral - TVA - TYPE COMPTABLE';
  //    UILMenu_ParamCompta = 'menu - param�trage - g�n�ral - Comptabilit�';
  //    UILMenu_ParamExeComm = 'menu - param�trage - g�n�ral - EXERCICE COMMERCIAUX';
  //    UILMenu_ParamEtik = 'menu - param�trage - g�n�ral - ETIQUETTE';
  //    UILMenu_ParamNK = 'menu - param�trage - g�rer les produits - NOMENCLATURE';
  //    UILMenu_GrilleTaille = 'menu - param�trage - g�rer les produits - GRILLES DE TAILLES';
  //    UILMenu_ParamGenre = 'menu - param�trage - g�rer les produits - GENRES, GROUPES';
  //    UILMenu_ParamCF = 'menu - param�trage - g�rer la rel. client - PARAM FIDELISATION';
  //    UILMenu_ParamEncaiss = 'menu - param�trage - vendre - MODE D''ENCAISSEMENT, COFFRE';
  //    UILMenu_EditNegoce = 'menu - param�trage - vendre - REGL. EDITIONS DANS LE NEGOCE';
  //    UILMenu_PersoBarreOutil = 'menu - param�trage - gestion utilisateurs - PERSO BARRE D''OUTIL';
  UILMenu_DroitUtil = 'menu - param�trage - GESTION DES UTILISATEURS';
  UILMenu_AnalyseDetaillee = 'menu - g�rer les produits -analyse du stock- ANALYSE DETAILLEE'; // @@ Bruno 20/06/2002
  UILMenu_RecapRecep = 'menu - g�rer les produits - R�cap. R�ceptions par Fournisseur';
  //    UILclient_CarteBleu = 'Client-Location, Visu/Modif Num�ro Carte Cr�dit';
  UILMenu_ImpEtiquetteFicheArt = 'menu - g�rer les produits -gestion articles- Impression �tiq.';
  UILMenu_ImpEtiquetteRecep = 'menu - g�rer les produits - RECEPTION - Impression �tiq.';

  //--------------------------------------------------------------------------------
  // Module et permission carte cadeau
  //--------------------------------------------------------------------------------
  UILModuleCRDSVS = 'CARTECADEAUSVS';
  UILMenuParamCRDSVS = 'menu - param�trage - Carte cadeau SVS';
  UILCaisseCRDSVS = 'caisse - Achat/vente Carte cadeau SVS';

  //--------------------------------------------------------------------------------
  // Module et permission UCPA
  //--------------------------------------------------------------------------------
  UILModuleUCPA= 'UCPA';

  //--------------------------------------------------------------------------------
  // Module et permission Interclub
  //--------------------------------------------------------------------------------
  UILModuleInterclub = 'INTERFACE INTERCLUB';

  //Ressource string utilis� pour les boutons de la caisse
  Type00 = 'Ligne vide (Pas de fonction d�finie)';
  Type01 = 'Appel Client';
  Type02 = 'Suppression de la ligne courante';
  Type03 = 'Suppression du ticket en cours';
  Type04 = 'Qte +1';
  Type05 = 'Retour Article';
  Type06 = 'Acces au champ remise, qte, prix...';
  Type07 = 'Remise Article (Normale, Solde, Promo)';
  Type08 = 'Liste des pseudos articles';
  Type09 = 'Mode d''encaissement';
  Type10 = 'Mode d''encaissement Rapide';
  Type11 = 'Sous Total';
  Type12 = 'Compte Client';
  Type13 = 'Reste Du';
  Type14 = 'Bon Achat Interne';
  Type15 = 'Bon Achat Externe';
  Type16 = 'R�glement';
  Type17 = 'Versement d''avance';
  Type18 = 'Remboursement client';
  Type19 = 'Validation des modifs. De la fiche client';
  Type20 = 'Annulation des modifs. De la fiche client';
  Type21 = 'Mise en attente du client';
  Type22 = 'Appel d''un article pr�cis';
  Type23 = 'R��dition du ticket';
  Type24 = 'Annulation d''un ancien ticket';
  Type25 = 'Correction des modes d''encaissement';
  Type26 = 'Ouverture du tiroir caisse';
  Type27 = 'Saisie d''une D�pense';
  Type28 = 'Ticket Carte fid�lit�';
  Type29 = 'Acc�s � la liste compl�te des boutons';
  Type30 = 'Impression d''une �tiquette client';
  Type31 = 'R�ajustement compte client';
  Type32 = 'Transfert caisse -> Bon de livraison';
  type33 = 'Liste des produits en location';
  type34 = 'Echanges';
  type35 = 'Retour';
  type36 = 'Retour Total';
  type37 = 'Retour � la vol��';
  type38 = 'D�tail du produit';
  type39 = 'Suppression de la location courante';
  type40 = 'Abandon de la location';
  type41 = 'Acces � la fiche principale du client';
  type42 = 'Acces � la fiche divers du client';
  type43 = 'Acces � la fiche station du client';
  type44 = 'Classement des clients sur Bon de loacation';
  type45 = 'Mode training';
  Type46 = 'Rapport du mode Training';
  type47 = 'Impression directe du devis';
  type48 = 'Validation du ticket';
  type49 = 'Choix du Skiman';
  Type50 = 'Modification globale ou partielle d''un bon de location';
  type51 = 'Suppl�ments pour la location';
  Type52 = 'Paiement � la ligne d''une facture de location';
  type53 = 'Impression du d�tail du compte client';
  type54 = 'Impression d''un document de location de contr�le';
  type55 = 'Vente d''un article du parc location';
  Type56 = 'Caution';
  type57 = 'Bon de r�servation';
  type58 = 'D�taxe';
  type59 = 'Remboursement de la TVA';
  type60 = 'Vider un portable de saisie';
  type61 = 'Ch�ques cadeaux';
  Type62 = 'Fiche client WEB';
  type63 = 'Bons d''achat divers';
  type64 = 'D�tection des lots';
  Type65 = 'Trace Be Collect''or';
  Type66 = 'D�p�t Vente';
  Type67 = 'Scann Identit� + Photo du document';
  Type68 = 'Scann Idendit�';
  Type69 = 'Scann photo du document';
  Type70 = 'Visu photo du document';
  Type71 = 'FidMontagne';  
  Type72 = 'Solde FidMontagne';
  Type73 = 'R�glement facture';
  Type74 = 'Affectation d''un mat�riel identifi� � la place d''un pseudo';
  Type75 = 'Annulation d''une ligne rendu';
  Type76 = 'Carte cadeaux SVS';
  Type77 = 'Consultation Solde CC SVS';
  Type78 = 'Fid�lit� Intersport';
  Type79 = 'Calcul de r�glage fixation';

const

  // Messages relatifs aux filiales {GesParamWebFiliales_Frm}
  RS_TXT_FilDelFilNom         = 'de la filiale :';
  RS_TXT_FilAddErrChpManquant = 'La saisie du nom de la filiale et du pays est obligatoire';

  // Message li� au module StockIT pour EKOSPORT
  RS_TXT_ConfirmStockIT = 'Le fichier sera export� et envoy� lors de la prochaine r�plication automatique';

  // Message fiche gestion group� des mod�les Frm_ExpertArt
  Crit_Titre = 'G�n�rer une liste de mod�les' + #13#10 + 'selon des crit�res de s�lection � d�finir...';
  Crit_AjouterModele = 'Ajouter des mod�les � la liste en cours';
  Crit_CreerStandart = 'Cr�er une nouvelle liste standard de mod�les';
  Crit_CreerArchive = 'Cr�er une nouvelle liste pr�paratoire d''archivage';
  Crit_ErrInterAxe = 'Charger les mod�les qui ne respectent pas les relations inter-axes';
  Crit_ErrNoAxe = 'Charger les mod�les non positionn�s sur un axe obligatoire';

  // Message d'erreur fiche client
  ErrNoVilleClient = ' La saisie d''une ville est obligatoire';
  ErrNoCPClient = ' La saisie du code postal est obligatoire';
  ErrNoPrenomClient = ' La saisie du pr�nom est obligatoire';
  ErrNoPaysClient = ' La saisie du pays est obligatoire';
  ErrEncoursDepasse = 'L''encours maximum autoris� est d�pass� (%6.2f�)';

  //--------------------------------------------------------------------------------
  //Message pour le MDE
  //--------------------------------------------------------------------------------
  ERR_MDE_ErreurPortCOm         = 'Erreur d''ouverture du port COM';
  ERR_MDE_DelaiDepasse          = 'D�lai d�pass� !';
  ERR_MDE_ErreurcheckSum        = 'Erreur CheckSum !';
  ERR_MDE_ErreurDeLecture       = 'Erreur de lecture !';
  ERR_MDE_AucunFichierARecupere = 'Aucun fichier � r�cup�rer!';

  // Analyse
  RS_TXT_ANSE_ENCOURS = 'Une statistique est d�j� en cours de calcul';
  RS_TXT_ANSE_STOCKCOURANTDET = 'Etat du stock courant (D�taill�)';
  RS_TXT_ANSE_STOCKCOURANT = 'Etat du stock courant';
  RS_TXT_ANSE_HITPARADE = 'Hit parade des ventes';
  RS_TXT_ANSE_ANVENTE = 'Analyse des ventes';
  RS_TXT_ANSE_ANDETAIL = 'Analyse d�taill�e';
  RS_TXT_ANSE_STKDATE = 'Stock � date';
  RS_TXT_ANSE_ANASYNTH = 'Analyse synth�tique';

  //Fiche article
  RS_ERR_MRKFOURN       = 'La marque choisie n''est associ�e � aucun fournisseur.';
  RS_TXT_NOTAXE         = 'Vous devez d''abord positionner le mod�le dans les axes.';

  //Grille de taille
  RS_TXT_NOVISIBLE      = '(Non visible)';
  RS_TXT_LABAFFVISIBLE  = 'Afficher les grilles Non visible';
  RS_TXT_LABMASKVISIBLE = 'Masquer les grilles Non visible';

  //Tarif SKU
  RS_QRY_SUPPRTARIF     = '�tes-vous s�r de vouloir supprimer les tarifs s�lectionn�s ?';
  RS_TXT_CTRLSUPPRTARIF = 'Vous ne pouvez pas supprimer le tarif de base du fournisseur principal'+#13+'ni le prix de base du tarif g�n�ral de vente.';
  
  //UCPA
  RS_TXT_IMPORTCLT     = 'Int�gration des stagiaires: ';
  RS_ERR_IMPORTCLT     = 'Erreur lors de l''int�gration des donn�es.';
  RS_TXT_IMPORTCLTOK   = '�0 nouveaux stagiaires ont �t� int�gr�s.';
  RS_TXT_IMPORT_NotFile= 'Aucun fichier � int�grer';
  RS_TXT_IMPORTSTAGE   = 'Int�gration des stages: ';
  RS_TXT_IMPORTSTAGEOK = '�0 nouveaux stages ont �t� int�gr�s.';
  RS_TXT_STAGIAIREOK   = '�0 stagiaires ont �t� archiv�s.';
  RS_TXT_STAGIAIREARCH = '�0 stagiaires archivable ont un bon de location en cours.';
  RS_TXT_RAPPORTARCH   = 'Consulter le rapport pour plus d''information: ';
  RS_TXT_ARCHSTAGIAIRE = 'Archivage des stagiaires en cours...';
  RS_ERR_ARCHSTAGIAIRE = 'Erreur lors de l''archivage des stagiaires.';
  
  //Ressource string commune
  RS_TXT_COMMON_Oui       = 'Oui';
  RS_TXT_COMMON_Non       = 'Non';
  RS_TXT_COMMON_Erreur    = 'Erreur';
  RS_TXT_COMMON_ANALYSE   = 'Analyse %s';
  RS_TXT_COMMON_WARNING   = 'Attention';
  RS_TXT_COMMON_ANAEND    = 'Analyse termin�e';
  RS_TXT_COMMON_CHARGEDATA= 'Chargement des donn�es en cours...';
  RS_TXT_COMMON_INFO      = 'Information';
  RS_TXT_COMMON_REPLICERR = 'R�plication en cours ! Op�ration actuelle impossible, veuillez retenter plus tard';
  
  //Client My Twinner
  RS_TXT_TWINNER_CLT = 'Client My Twinner';

  // Contr�le cham3s
  RS_ERR_FICHART_NOTARTWEB  = 'Impossible d''activer ce mod�le.';
  RS_ERR_FICHART_NOTMRKWEB  = 'La marque n''est pas r�f�renc�e web.';
  RS_ERR_FICHART_NOTPREVTE2 = '(Voir Param�trage\Param�trage Web vente\Divers)';

  //Negoce facture
  CestDejaUnAvoir = 'Impossible la facture en cours est une facture d''avoir';
  PasDAvoirSiTransIM = 'Facture li�e � un transfert intermag. Cr�ation d''avoir impossible !';

  //Reservation loc web
  LibIntegResaWeb = 'Voulez vous lancer le traitement d''int�grations des r�servations web ?';
  LibErrImpEtiq   = 'Impossible d''acc�der � l''imprimante.';

  // Type de document facture A4 :
  FactureA4 = 'Facture A4';
  LibRapFA4 = 'CaisseFactureA4.rtm';

  DatFidInvalide = 'Date de fid�lit� saisie invalide !';

  // Fiche article Modification Marque
  FichArtWarning = 'Attention';
  FicheArtChangeMrk = 'Vous allez modifer la marque du mod�le, elle va �tre associ�e au fournisseur %s. Voulez vous continuer ?';

  // LG : Lecteur de carte bancaire
  RS_ERR_CAI_CaractIncorrect  = 'La chaine re�ue contient des caract�res incorrects.';

  RS_TXT_CMN_DOFILEINPROGRESS = 'G�n�ration du fichier en cours, veuillez patienter...';
  RS_TXT_CMN_NODATANOFILE     = 'Il n''a y pas donn�es correspondant � vos crit�res de recherche.' + #10#13 + 'Aucun fichier n''a �t� g�n�r�.';


  //BN Referencement sp2000
  Libsupcb = 'Suppression impossible, ce mod�le est issu du r�f�rencement Sport 2000...';

  // TF
  RS_QRY_FICART_MAJTARIFCDERAL = 'Souhaitez vous mettre � jour le prix de vente dans les commandes ayant un reste � livrer ?';

  //LG - Libell� de Web de la fiche Expert article
  LibActGestArtWeb      = 'Activer la gestion Web des mod�les';
  LibDesctGestArtWeb    = 'D�sactiver la gestion Web des mod�les';
  LibChxActArtWeb       = 'Activation/D�sactivation de la gestion Web des mod�les';

  //LG : Classement
  LibNotClass           = '                       Pas de classement'; //Ne pas supprimer l'espace pour l'ordre de tri

  //LG juin 2010 : Export admin fiscal
  FilterExpAdminFiscal = 'fichier administration fiscal|*.txt';

  //LG mai 2010 : Param�tre Web vente g�n�rique
  WebGenMqMag1        = 'Le magasin dont le stock doit �tre extrait est obligatoire.';
  WebGenExtractExit   = 'Ce magasin est d�j� dans la liste d''extraction.';

  // FC Mars 2010 : Bons de rapprochement
  errDateEtNumObligatoire = 'Le num�ro et la date de facture doivent �tre saisis';
  infoRapprochementEnCours = 'Rapprochement des lignes en cours, veuillez patienter ....';
  askRetourAutoBRapp = 'Souhaitez-vous mettre automatiquement � jour le bon de retour ?';
  infoRetourAutoBRappCree = 'Bon de retour �0 cr��';
  errNoChangeFouBRapp = 'Impossible de modifier le fournisseur de ce bon de rapprochement lorsque la saisie est commenc�e';
  errNoChangeSocBRapp = 'Impossible de modifier la soci�t� de ce bon de rapprochement lorsque la saisie est commenc�e';
  errNoChangeMagBRapp = 'Impossible de modifier le magasin de ce bon de rapprochement lorsque la saisie est commenc�e';
  errNoChangeTitreBRapp = 'Modification impossible';
  askClotBRappEcart = 'Attention l''�cart de prix entre le bon de rapprochement et les lignes rapproch�es est important';
  askClotBRappEcartNo = 'Impossible de cloturer';
  askClotBRappEcartPlus = 'Voulez-vous tout de m�me le cl�turer ?';
  infoClotBRapp = 'Le bon de rapprochement �0 a �t� cl�tur�';
  infoClotBRappDiff = 'Le bon de rapprochement �0 a �t� cl�tur�, malgr� une diff�rence de �1';
  infoClotBRappEcart = 'La cl�ture du bon de rapprochement �0 a �t� forc�e, malgr� un �cart important de �1';
  infoNoDelRapproche = 'Impossible de supprimer une ligne rapproch�e';
  infoNoRemoveBonRapproche = 'Impossible de retirer ce document du bon de rapprochement, car des lignes ont d�j� �t� rapproch�es';
  askRapprocheDocument = 'Souhaitez-vous rapprocher automatiquement les lignes de ce document ?';
  RecepRapproche = 'Rapproch�e';
  infoBRappChronoNonTrouve = 'Bon de rapprochement inexistant';

  RcptAssocierCollection = 'Tous les mod�les de la r�ception sont associ�s � la collection choisie ! ';
  BcdeAssocierCollection = 'Tous les mod�les de la commande sont associ�s � la collection choisie ! ' ;
  errNoModifEnc ='Impossible de modifier ce type d''encaissement';
  errNoAnnuleBp = 'Vous n''�tes pas autoris� � annuler un bon de pr�paration.';

  ErrTitreTropDeBLPourUneFacture = 'Trop de BL pour une facture';
  ErrTropDeBLPourUneFacture = 'Trop de BL(%s) pour une seule facture pour %s ; max = %s';

  ErrRefManquante = 'La saisie de la r�f�rence du mod�le est obligatoire';

  ChangeAxes = 'Confirmez le d�placement des mod�les list�s dans les axes s�lectionn�s';
  ActionAxes = 'Mod�les plac�s dans la sous famille �0 pour l''axe �1';
  ActionAxesNonTraite = 'Mod�le non modifi� car dans un domaine d''activit� diff�rent';
  ActionAxesNonModifi = 'Mod�le non modifi� pour l''axe �0';
  ActionAxesDel = 'Axe �0 supprim� pour ce mod�le';

  ActionAxePasChoisi = 'Vous n''avez pas choisi de positionnement pour l''axe �0.' + #13 + #10 +
                       'Souhaitez vous supprimer le positionnement des mod�les dans cet axe ?';

  ActionAxePasChoisiPlus = 'Oui : Supprime cet axe pour les mod�les choisis'  + #13 + #10 +
                           'Non : Le positionnement actuel dans cet axe sera conserv�';


  //lab Bon Preparation
  errNoForcer = 'Vous n''�tes pas autoris� � forcer le contr�le';
  errNoBPExpeTermine = 'Veuillez completer les num�ros de colis et r�aliser les transmissions manquantes';
  errNoParamColis = 'Veuillez renseigner tous les champs';
  errNoBPNbColis = 'Veuillez indiquer le nombre de colis';
  errNoPoidsTotal = 'Veuillez indiquer le poids total';
  errNoGenerationFacture = 'Attention, la facture n''a pas �t� �mise';
  errNoImprimante = 'L''imprimante param�tr�e pour l''impression des bons de pr�paration ' + #13#10 + '( �0 ) n''est pas disponible';
  errNoExpeAction = 'Impossible d''exp�dier tant que le bon de pr�paration n''est pas control�';
  errNoSupAction = 'Vous ne pouvez supprimer une action achev�e';
  errNoControleAction = 'Impossible de contr�ler tant qu''il reste une ou plusieurs actions � traiter';
  errNoSelect = 'Veuillez s�lectionner une ou plusieurs lignes dans la liste';
  errNoAnnuleAction = 'Vous n''�tes pas autoris� � annuler une action.';
  errNoDirExiste = 'R�pertoire manquant ou inexistant.';
  ErrNomFicObliger = 'Nom de fichier obligatoire';
  ErrExtNomFicObliger = 'Extention du nom du fichier obligatoire';
  ErrCodePointRetraitSoColissimo = 'Code point de retrait obligatoire pour SoColissimo Hors Domicile';
  ErrEMailObligSoColissimo = 'E-Mail obligatoire pour SoColissimo';
  ErrEMailInvalidSoColissimo = 'E-Mail invalide pour SoColissimo';
  ErrPostableInvalidSoColissimo = 'Le N� de portable doit commencer par 06 ou 07 et doit contenir 10 chiffres pour SoColissimo';
  AskRecupInfoSaisiParClient = 'Voulez-vous r�cup�rer les informations saisies par le client ?';
  ErrAdr1Obligatoire = 'Adresse 1 obligatoire';
  ErrCPetVilleObligatoire = 'Code postal et ville obligatoire';
  ErrParamUrlInfoSaisiParClient = 'L''Url pour r�cup�rer les informations saisies par le client n''est pas param�tr� !';
  ErrPasDeCommandeWeb = 'Pas de commande Web trouv� !';
  ErrPasJoindreUrlInfoSaisiParClient = 'Impossible de joindre l''Url pour r�cup�rer les informations saisies par le client';
  ErrAuCuneInfoClientTrouv� = 'Aucune information n''a �t� trouv� !'; 
  ErrExecutableFidMontagne = 'Executable FidMontagne.exe non trouv�';
  
  BonPrepaNoNomImprimante = 'Veuillez param�trer l''imprimante par d�faut dans : Param�trage bon de pr�paration - Impression ';

  //lab 30/12/09 Bon Preparation suite
  BpListe = 'Liste des bons de pr�paration';
  BpListeControle = 'Liste des bons de pr�paration contr�l�s';
  BpListePec = 'Liste des bons de pr�paration pris en charge';
  BpListeATraiter = 'Liste des bons de pr�paration � traiter';
  BpListeColis = 'Liste des colis du bon de pr�paration ';

  //lab 28/12/09 Trace Becol
  CbStatTicket = 'Liste des tickets de la carte ';
  //lab 21/12/09
  BeColKo = 'La liaison avec Be collect''or est interrompue temporairement...';

  //Loc Tarif de la garantie  en fonction des groupes de tarif
  locnogt = 'Impossible, les groupes de tarif ne sont pas d�finis...';

  //transfert bon pr�pa
  MultiBLTransBP = 'Les bons de livraisons s�lectionn�s vont �tre transf�r�s en bon de pr�paration';
  OkBLTransBP = 'Le bon de livraison affich� � l''�cran a �t� transf�r� en bon de pr�paration N� ';
  KoBLTransBP = 'Le bon de livraison affich� � l''�cran n''a pas �t� transf�r� en bon de pr�paration. Veuillez v�rifier s''il n''existe pas d�j�.';

  warningCreerDansMags = 'Veuillez s�lectionner le ou les magasins o� vous allez cr�er la configuration actuellement affich�e.';
  warningCopyToMags = 'Veuillez s�lectionner le ou les magasins o� vous allez recopier la configuration actuellement affich�e.';
  warningCopyToMag = 'Veuillez s�lectionner le magasin dans lequel vous allez recopier la configuration actuellement affich�e.';

  // FC : WebVenteAtipic
  MessErrPathExportFact = 'Le chemin d''exports des factures en PDF est inaccessible, la facture ne sera pas envoy�e sur le site WEB, vous devrez le faire manuellement';

  AucunLotTrouve = 'Aucun lot trouv� correspondant � votre saisie...';
  MsgNofindLot = 'Aucun lot trouv�...' + #13#10 + 'Si vous �tes persuad� que ce lot existe' + #13#10 + 'V�rifiez qu''il ne soit pas archiv� !';
  MessNoSupCouleur = 'Impossible de supprimer une couleur associ�e � des donn�es';
  CapOKArchi = 'AVEC Archiv�s';
  CapNOArchi = 'SANS Archiv�s';
  //lab 01/10/09 ParamCompta
  ConfirmerAffecterTousMags = '�tes vous s�r de vouloir remplacer le param�trage ' + #13#10 + 'de tous les magasins par celui affich� ?';
  ErreurParamCompta = 'Vous devez faire r�pliquer votre serveur, les donn�es sont manquantes dans votre base !';
  //lab 29/09/2009
  MessActiveQuelSite = 'Activer le site WEB �0 pour ce mod�le ?';
  LotMessActiveQuelSite = 'Activer le site WEB �0 pour ce lot ?';
  LotMessDeleteQuelSite = 'Supprimer le site WEB �0 pour ce lot ?';
  // Lots dans n�goce
  MessLotNonCB = 'Ce lot ne peut �tre ajout� par un code barre, car plusieurs tailles/couleurs sont possibles';

  //Lab 1037 Web vente
  Base0 = 'Action interdite car l''identifiant de base actif est 0';
  confirmerArtNonWeb = 'Confirmez que vous ne souhaitez plus g�rer ce mod�le sur le WEB.' + #13#10 + 'Les param�tres WEB du mod�le seront d�sactiv�s.';
  confirmerLotNonWeb = 'Confirmez que vous ne souhaitez plus g�rer ce lot sur le WEB.' + #13#10 + 'Les param�tres WEB de ce lot seront d�sactiv�s.';
  ManqueMagasinWeb = 'Veuillez param�trer le magasin qui g�re le WEB';
  ManqueParamDelai = 'Veuillez param�trer les d�lais de livraison Web vente';
  //lab 1056 Module et droit des bons de pr�paraption
  errNoModifAction = 'Vous n''�tes pas autoris� � modifier une action.';
  errNonModifiable = 'Vous ne pouvez modifier un bon de pr�paration dans l''�tat "�0"';
  titreActionImpossible = 'Action impossible';
  ModulBonPrepa = 'BON PREPARATION';

  //lab 10/08/2009
  TipartPseudoWeb = 'Pseudo Web';
  paramConnexionAdminWebVente = 'Veuillez v�rifier le param�trage de l''administration des mod�les web';
  errConnexionAdminWebVente = 'Erreur lorsque de la connection au site d''administration des mod�les web';
  connexionImpossible = 'Connexion impossible';
  // FC : 27/07/2009
  MessDeleteWebSsfSec = 'Supprimer la sous-famille WEB �0 pour ce mod�le ?';
  MessDeleteQuelSite = 'Supprimer le site WEB �0 pour ce mod�le ?';
  MessSiteDejaActif = 'Le site WEB �0 est d�j� actif pour ce mod�le depuis le �1 ?';
  MessSiteReActive = 'Le site WEB �0 a �t� r�activ� pour ce mod�le.';
  MessDeleteWebSsfSecLot = 'Supprimer la sous-famille WEB �0 pour ce lot ?';
  MessDeleteQuelSiteLot = 'Supprimer le site WEB �0 pour ce lot ?';
  MessSiteDejaActifLot = 'Le site WEB �0 est d�j� actif pour ce lot depuis le �1 ?';
  MessSiteReActiveLot = 'Le site WEB �0 a �t� r�activ� pour ce lot.';

  LotDateLib = 'Liste des lots du �0 au �1  -  ';
  MessChargeLot = 'Chargement de la liste des lots...';
  LotTrouve = 'Attention, un ou plusieurs lots ont �t� d�tect�s automatiquement.' + #13#10 + 'Le Total � payer a �t� r�actualis� !';
  warningCopyMag = 'Attention, vous allez recopier le param�trage d''un magasin dans la fen�tre ci-dessous.' + #13#10 + 'S�lectionnez maintenant le magasin qui servira de mod�le.';
  LotNonDetecte = 'Pas de lot d�tect� pour ce ticket...';
  LotNonTrouve = 'Impossible, ce code Lot est inexistant...';
  LotNonValide = 'Impossible, ce code Lot n''est plus valide...';
  LotNonValideTC = 'Impossible, ce code Lot n''est pas utilisable avec un code barre...' + #13#10 + '(multiple Tailles/Couleurs)...';
  LotClassementNoDelete = 'Impossible de supprimer.'+#13#10+'Ce classement est attribu� � au moins un lot !';
  ManqueLibelle = 'Veuillez renseigner le libell� du lot pour le ticket.';
  ManqueDesignation = 'Veuillez renseigner la d�signation du lot.';
  NegFacLettrageNoModif = 'Le compte client associ� � cette facture est lettr�, la modification est d�sactiv�e.';
  NEG_ERR_FacRegleeNoModif = 'Cette facture est r�gl�e, la modification est d�sactiv�e.';
  NEG_TXT_ModifImpossible = 'Modification impossible';

  BcdeMessageUC = 'Attention la quantit� command�e n''est pas compatible avec l''unit� de conditionnement (�0)';

  ErrCodeVide = 'Le code est obligatoire.';
  ErrDoublonTva = 'Ce code est d�j� attribu� � un taux de TVA identique.' + #13#10 + 'Veuillez saisir un code unique pour ce taux.';
  strRedemarrer = 'Veuillez red�marrer les applications GINKOIA ' + #13 + #10 + 'pour que les modifications soient prises en compte par celles-ci.';
  //message tout param�trage
  modifParam = 'Les param�tres ont �t� chang�s.' + #13#10 + 'Voulez vous enregistrer ces modifications ?';
  //Messages param�trage Sms
  errSms = 'Impossible d' + #39 + 'envoyer le SMS : ';
  ErrParamCptSms = 'Tous les param�tres du compte doivent �tre renseign�s';
  ErrNoTelPort = 'Impossible d''envoyer un sms, num�ro de portable du client in�xistant';

  OPNCom = 'Pas de port COM valide...';
  OPNLiaison = 'Pas de liason valide avec l''OPN-2001...';
  OPNVide = 'L''OPN ne contient pas de code barre...';

  // FC : 15/01/09
  StrMajAdrClient = 'L''adresse �0 � chang�.' + #10#13 + 'Souhaitez vous mettre � jour l''adresse �1 du client ?';

  //lab 30/12/08
  cstIndiceVente = 'Indice de vente';
  //lab 09/11/08 Droit associer usr/mag
  recupererParamDroitAssocier = 'Vous devez r�pliquer : il vous manque des param�tres li�s � votre version.';
  //lab 09/11/08 Droit associer usr/mag
  noDroitAssocier = 'Vous n''avez pas le droit d''association des utilisateurs aux magasins.' + #13#10 + 'Il est attribu� � : ';
  //lab 09/11/08 Droit associer usr/mag
  attribuerDroitAssocier = 'Le droit d''association des utilisateurs aux magasins n''est pas attribu�. Veuillez ouvrir la fen�tre de gestion du droit pour le configurer.';
  //lab 18/11/08 Filtre pseudo client
  clientPseudo = 'Impossible de cr�er ce document pour un magasin appartenant � la plateforme';
  //LAB 03/11/08 Visibilit� �l�ments dans la nomenclature
  LabOCInactive = '( Peut �tre masqu� car ne r�f�rence aucune OC active )';
  LabOCActive = 'Ne peut �tre masqu� car r�f�rence au moins une OC active.';

  //LAB 15/07/08 FidNatTwinner Code barre Inexistant sur base nationale
  CbFidNatTwinnerInexistant = 'Le code barre n''existe pas sur la base nationale.';

  // FC : 07/10/2008 Bons de commande : message d'information
  StrChangerDateLivraisonPlus = 'Veuillez indiquer le nombre de jours � ajouter � aux dates de livraison';
  StrChangerDateLivraisonMoins = 'Veuillez indiquer le nombre de jours � retirer � aux dates de livraison';

  // FC : 07/10/2008 ajout d'un controle si la marque est d�j� distribu�e par un autre fournisseur
  // dans ce cas, on affiche un message qui contient le(s) fournisseur(s) d�j� associ�s
  StrMarqueDejaDistribuee = 'Attention, cette marque est d�j� distribu�e par le(s) fournisseur(s) suivant(s)';

  //Fid�lit� Nationale Twinner
  CodeBarreFidNatTwinner = '29';

  // Stat OC
  StrImprimeStatOC = ' �0 ( O�ration commerciale �1 )';

  // Analyse fidelit�
  StrImprimeAnalyseFideliteJusquAu = 'Analyse fid�lit� jusqu''au �0, Groupe Client : �1, Groupe Fid�lit� : �2';
  StrImprimeAnalyseFideliteDuAu = 'Analyse fid�lit� du �0 au �1, Groupe Client : �2, Groupe Fid�lit� : �3';

  BAO_pasmen = 'Attention, le param�trage des bons d''achats automatiques' +
    #10#13 + 'est incomplet...' +
    #10#13 +
    '(Param�trage g�n�ral/Bons d''achat/Onglet Mode encaissement)';
  BAO_DejaUtilTck = 'Ce bon d''achat a d�j� �t� enregistr� pour ce ticket...';
  BAO_PrisEnCompte = 'Le bon d''achat de �0 � est pris en compte.' + #10 + #13 + '(Onglet Encaissement)';
  BAO_PasValide = 'Ce bon d''achat n''est plus valide...';
  BAO_PasEncoreValide = 'Ce bon d''achat sera utilisable � partir du : ';
  BAO_DejaUtil = 'Ce bon d''achat est d�j� utilis�...';
  BAO_Inexistant = 'Le bon d''achat est inexistant...';
  PasFicheWeb = '(La fiche client n''est pas accessible via Internet)';
  pasbonatelier = 'Le bon atelier SAV--' + '�0' + ' n''est pas transf�rable en caisse...';

  Ideal_RAZ = 'Confirmez vous la suppression de toutes les quantit�s pour ce mod�le ?';
  Ideal_Init = 'Confirmez vous l''initialisation pour toutes les couleurs/tailles ?' + #10 + #13 +
    '(Quantit� :"�0")';

  clipasbongroupe = 'Impossible, ce client n'' appartient pas � votre groupe de magasin...';
  fidboxpasmelange = 'Impossible, pas de cumul de bons en % et montant...';
  fidboxunseulpc = 'Impossible, un seul bon en pourcentage autoris� par ticket...';
  FIBDOXDEJAUTIL = 'Impossible, vous avez d�j� utilis� ce bon dans le ticket...';
  FidboxPasCB = 'Impossible, votre client n''a pas un num�ro de carte valide...';

  AtelierPasFiche = 'Impossible, la fiche atelier est inexistante...';
  AtelierPasBonEtat = 'Impossible, cette fiche n''est pas transf�rable en caisse';
  AtelierDejaCaisse = 'Impossible, cette fiche est d�j� transf�r�e en caisse';

  rappelAtelier = 'Souhaitez-vous transf�rer la fiche atelier en caisse?';
  ImpCC = 'Impression du ch�que cadeau?';
  FBManquecorres = 'Attention la correspondance des modes d''encaissement'#10#13'pour la FIDBOX est imcompl�te.'#10#13'(Ginkoia / Param�trage g�n�ral / Modes d''encaissement)';
  FBManqueparam = 'Attention les param�tres pour utiliser la FIDBOX sont incomplets...';
  FBNumeroutilise = 'Ce num�ro de caisse est d�j� attribu�...';
  LibArrondiGinkoia = 'Gestion des arrondis pour les prix de vente';
  catInt_Sortie = 'Vous avez s�lectionn� des articles : Sortir sans valider ?';
  catInt_Avert = 'Vous avez s�lectionn� des articles : Annuler cette s�lection ?';
  CatInt_Recup = 'Patienter pendant la r�cup�ration du catalogue ...';
  RefRech_IntMult = 'Int�gration de vos articles...';

  UniquePasPoss2 = 'Impossible un autre mode de paiement est d�ja utilis� pour g�rer la carte fid�lit�';

  LocEnCours = 'Attention, votre client � des locations en cours...';
  PasMultiSelTOC = 'Pour ce choix d''impression vous devez s�lectionner une seule ligne...';
  EtktocTer = 'Vous pouvez maintenant choisir les �tiquette TOC � imprimer...';

  PasBonCBCF = 'Impossible, ce code barre est d�j� utilis�...';
  RefRech_ArtProbTaille = 'Le mod�le ne poss�de pas de taille d�finie.'#10#13'Il ne peut donc pas �tre enregistr� par l''application Ginkoia';
  RefRech_ArtProbCouleur = 'Le mod�le ne poss�de pas de couleur d�finie.'#10#13'Il ne peut donc pas �tre enregistr� par l''application Ginkoia';
  CF2000OCliCours = 'Impossible d''utiliser cette carte fid�lit�, vous avez d�j� un client en cours';
  VOdejaVendu = 'Impossible, article d�j� vendu dans le m�me ticket...';
  ClientArchiver = 'Attention, ce client �tait archiv�, il est r�activ� automatiquement' + #10#13 + 'mais pensez � v�rifier sa fiche...';
  RefRech_Confirmation = 'Voulez-vous rechercher sur le site de votre centrale';
  RefRech_InitMrq = 'Initialisation des marques r�f�renc�es en cours...';
  LocDejaEnLocPicco = 'Attention cet article est en attente de location dans le Piccolink...';
  InitOc = 'Attention, cette initialisation necessitera un nouveau param�trage'#10#13'des offres commerciales.'#10#13'Souhaitez vous continuer le traitement?';
  PasCreditClient = 'Fonction Impossible, le bouton li� au paiement "Comptes clients" a �t� supprim�...';
  ModulSP2000 = 'IMPORT SP2000';
  ModulCollection = 'REF. COLLECTION';
  ModulRef = 'REFERENCEMENT';
  LocAutreMag = 'Impossible, cet article appartient � un bon de location d''un autre magasin...';
  ModulWebDyna = 'REFERENCEMENT DYNAMIQUE';
  RefRech_Conn = 'Connexion au site central';
  RefRech_AdhNok = 'Votre code d''ad�rent n''est pas valide';
  RefRech_ArtDjRec = 'Le mod�le � d�j� �t� r�cup�r� par %s ' + #10#13 +
    'Vous devez r�pliquer pour y avoir acc�s';
  RefRech_ArtNonTrv = 'La r�f�rence demand�e n''existe pas dans cette marque...'#10#13'(Dans la base de la centrale)';
  RefRech_Analys = 'Analyse et int�gration de la fiche';
  RefRech_PrbRep = 'Votre r�plication n''est pas � jour, recommencer apr�s avoir r�pliqu�';
  RefRech_PrbCrit = 'Probl�me d''int�gration critique, veuillez pr�venir la soci�t� GINKOIA';
  RefRech_PrbInt = 'Impossible de ce connecter au site central,'#10#13'V�rifier votre acc�s internet';

  RESOURCESTRING


  AmortlocConfSup = 'Confirmez-vous la suppression de l''op�ration s�lectionn�e?';
  Amortlottypevide = 'La saisie d''un type (Entr�e/Sortie) est obligatoire...';
  Amortlotdatevide = 'La saisie d''une date est obligatoire...';
  AmortlotMotifvide = 'La saisie d''un motif est obligatoire...';
  AmortLotQteVide = 'La saisie d''une quantit� est obligatoire...';

  RemiseLoc = 'caisse - location - SAISE D''UNE REMISE SUR LE TOTAL GENERAL';
  AnnulTckLocPasPossible = ' Il est impossible d''annuler un ticket li� � une facture de location...';

  ModulWebVente = 'WEB VENTE';

  EltronAnnul = 'Confirmez-vous l''arr�t de l''impression des �tiquettes?';
  EltronEnCours = 'Impression des �tiquettes en cours...';
  InitEltron = 'Initialisation de l''imprimante en cours...';
  msgATT = 'Attention : ces modifications ne seront enregistr�es qu''� la validation finale de la fiche fournisseur !';

  HintExpertville = '[Double Clic ou F4] Ouvre l''expert de gestion des villes';

  ChargeVilles = 'Mise en place de l''expert de gestion des villes';
  msgVillePasPays = 'Vous n''avez pas d�fini de pays pour cette ville' + #13#10 +
    'Faut-il n�anmoins accepter d''enregistrer ?';
  msgVillePasCP = 'Vous n''avez pas d�fini de code Postal pour cette ville' + #13#10 +
    'Faut-il n�anmoins accepter d''enregistrer ?';
  msgNomVilleOblig = 'Impossible de valider' + #13#10 +
    'Il faut donner un nom � cette ville...';

  msgNoVille = 'Une ville sans nom significatif ne peut pas �tre s�lectionn�e ...';

  msgDoublonVilleetCp = 'Impossible de valider :' + #13#10 + '�0 �1 �2' + #13#10 +
    'Cette ville existe d�j� dans votre fichier... ';
  msgDoublonVille = '�0 �1' + #13#10 +
    'Cette ville existe d�j� !' + #13#10 +
    'Faut-il accepter le "doublon" ?';
  msgDoublonCP = '�0 �1' + #13#10 +
    'Ce code postal existe d�j� !' + #13#10 +
    'Faut-il accepter le "doublon" ?';
  msgSupprVille = '�0 �1 �2' + #13#10 +
    'Confirmez la suppression de cette ville... ';

  MsgSupFSLoc = 'Confirmez que vous d�sirez que la sous-fiche s�lectionn�e' + #13#10 + '�0' + #13#10 +
    'ne soit plus associ�e � la fiche de location' + #13#10 + '�1';
  MsgSupFSLocPlus = 'La sous fiche ne sera pas supprim�e mais deviendra "orpheline"...' + #13#10 +
    '( c''est � dire dire une sous-fiche sans fiche principale )';
  MsgModifstatLoc = 'Attention, vous avez modifi� le statut et/ou la date de cession.' + #13#10 +
    'Que souhaitez vous faire avec la ou les sous-fiches associ�es ?';
  MsgArchsfLoc = 'Attention, vous avez archiv� la fiche en cours.' + #13#10 +
    'Que souhaitez vous faire avec la ou les sous-fiches associ�es ?';
  MsgCessFichLoc = 'Comment souhaitez vous appliquer le prix de cession ?';
  MsgQuoiFaire = 'Que souhaitez-vous faire ?...';

  MessChargeArtLoc = 'Chargement de la liste des mod�les...';

  MsgConfTousEnc = 'Confirmez le pr�l�vement automatique de tous les encaissements arriv�s � �ch�ance ? ';
  MsgConfEnc = 'Confirmez le pr�l�vement des encaissements s�lectionn�s ? ';

  MsgNeedSess = 'Vous n''avez s�lectionn� aucune session de caisse';

  HintDbg = '[Double Clic ou F8] Ouvre la fiche correspondant au mod�le s�lectionn�';
  MsgGrand = 'Plus de 20000 lignes � afficher' + #13#10 +
    'Les temps de r�ponse vont �tre tr�s lents' + #13#10 + 'lorsque vous vous d�placerez dans cet �tat !' + #13#10 +
    'Voulez-vous affiner votre s�lection ? (Fortement recommand�)';

  CF2000OkClt = 'La carte fid�lit� est prise en compte pour le ticket en cours.';
  CF2000Okba = 'Le code du bon d''achat est enregistr�,' + #13 + #10 +
    'n''oubliez de le d�duire du ticket ...';
  CF2000BA = 'Impossible, un seul bon d''achat par ticket...';

  HintAffChxNeo = '[F7] Afficher / Masquer la zone de s�lection... ( On/Off )';

  confcopie = 'Confirmez-vous la cr�ation d''une copie de ce mod�le?';
  impsupetq = 'Impossible, c''est un mod�le de r�f�rence Ginkoia...';
  confsupetq = 'Confirmez-vous la suppression du mod�le d''�tiquette en cours?';
  valeurincorrecte = 'Impossible, valeur incorrecte...';
  NoPossToc = 'Impossible d''ajouter ce mod�le dans le bloc note des op�rations commerciales !...' + #13 + #10 +
    '( Nota : ce bloc note n''accepte ni les mod�les archiv�s ni les Pseudos... )';

  Etqdeborder = 'Impossible, le champ en cours d�borderait de l''�tiquette...';
  EtqConfSup = 'Confirmez-vous la suppression du champ en cours?';
  EtqPasDim = 'Impossible, vous n''avez pas encore dimensionn� l''�tiquette...';
  PasTypeImprimante = 'Le type imprimante est obligatoire !';

  MsgOkFincompage = 'Confirmez que vous souhaitez lancer le traitement de fin de comptage ...';
  msgNoInvSessToShow = 'On ne peut supprimer que des journaux correspondant � des vidages de portable ou des imports de stock r�serve ...' + #13#10 +
    'Aucun journal de ce type n''a �t� enregistr� dans cet inventaire ...';

  msgReactualiseEtat = 'L''�tat affich� a besoin d''�tre r�actualis�...' + #13#10 +
    'Son rafra�chissement peut prendre quelques secondes,' + #13#10 +
    'mais vous garantit l''exactitude des donn�es affich�es.' + #13#10 +
    'Confirmez par OUI sa r�actualisation...';
  msgReactualiseEtatPlus = #13#10 + 'NB : si vous effectuez des saisies manuelles, vous pouvez activer, dans l''�cran de "Saisie de l''inventaire", la mise � jour automatique de cet �tat.';

  MsgInvQteSaisChange = 'Les �carts de ce mod�le vont �tre r�actualis�s' + #13#10 +
    'car certaines saisies n''ont pas �t� r�percut�es...' + #13#10 +
    '( Il se peut qu''apr�s cette mise � jour cette ligne d''�cart ne soit plus illustr�e... )';

  MsgInvClotDate = 'La date de d�marque est le �0' + #13#10 +
    'Les �carts vont �tre valoris�s au "pump" des mod�les � cette date';

  MsgEcnjRefreshOblig = 'La mise � jour automatique des �carts n''est plus possible apr�s un vidage de portable ou l''ajout d''un stock r�serve' + #13#10 +
    'Il est indispensable de r�actualiser cet �tat';
  CapDesole = 'D�sol�...';
  msgNoCBFind = 'Aucun code � barre trouv� ...' + #13#10 + 'Avez-vous bien d�fini le p�rim�tre de votre inventaire ?...';
  MsgNoPHLPossible = 'Impossible de connecter le PHL ...';

  HintECNJ1 = 'Double clic charge l''article en saisie ... ( F3 pour s�lectionner plusieurs articles )';
  HintECNJ2 = 'Plusieurs �carts s�lectionn�s, vous ne pouvez que les accepter globalement';
  MessMajECNJ = 'Mise � jour des �carts...' + #13#10 + 'Le temps de mise � jour d�pend de votre s�lection ...';
  MsgAcceptGroup = 'Confirmez que vous souhaitez accepter les �carts' + #13#10 + 'des �0 lignes s�lectionn�es...';
  msgInvDoSaisAuto = 'Confirmer que ce mod�le a bien �t� compt�' + #13#10 + '"�0" sera ajout� en saisie manuelle de ce mod�le...';
  CapInvSaisManu = 'Nouvelle session de saisie';
  msgVidRecaopInv = 'Confirmez que vous souhaitez r�initialiser (vider) le r�capitulatif de saisie en cours';
  MsgInvImageStock = 'Cr�ation de l''image du stock relative � cet inventaire...' + #13#10 + 'Quelques secondes de patience Merci...';

  CstSecVerif = 'V�rification du serveur de secours';
  CstSecSession = 'Attention, des sessions sont ouvertes sur le poste de secours';
  CstSecImpConnect = 'Impossible de se connecter au serveur de secours';
  CstSecOuvBase = 'Ouverture de la base de donn�es';
  CstSecProb1 = 'Attention, la sauvegarde pour les caisses autonomes semble d�connect�e'#13#10'veuillez appeler la soci�t� GINKOIA SA pour r�gler votre probl�me';
  CstSecProb2 = 'Attention, la base de secours n''est pas � jour '#13#10'veuillez appeler la soci�t� GINKOIA SA pour r�gler votre probl�me';
  CstSecProb3 = 'Attention, Impossible de se connecter � la base principale, veuillez avertir votre responsable';
  CstSecOuvSec = 'Ouverture du serveur de secours';
  resapasVAd = 'Impossible, le param�trage du mode de paiement' + #13 + #10 + 'pour les r�servations est incomplet...';
  resacreditcompte = 'Le pr�-paiement est valid�, souhaitez-vous maintenant' + #13 + #10 +
    'cr�diter le compte du client ?';
  ResaPasSession = 'Impossible, vous n''avez pas de session de caisse ouverte...';
  MsgOCConfcopie = 'Confirmez-vous la duplication de l''op�ration commerciale en cours ?';
  MsgOCCopie = 'Duplication de l''op�ration commerciale en cours...';
  MsgOCConfSupprLNT = 'Confirmez-vous la suppression des lignes non trait�es ?' + #13 + #10 +
    '(Prix de vente = Prix de vente OC)';
  MsqOCSupencours = 'Suppression des lignes non trait�es...';
  hintOCI = 'Cr�er un nouveau tarif OC';
  hintOCD = 'Supprimer le tarif en cours';
  StkOc = 'Souhaitez-vous traiter les mod�les ayant un stock nul ?';
  CreaOc = 'Cr�ation d''une op�ration commerciale';
  Valencours = 'Validation en cours...';
  Etktoc = 'Attention, des �tiquettes normales (hors TOC) sont en attente d''impression.' + #10 + #13 +
    'Vous devez donc choisir dans un premier temps le mod�le d''�tiquette correspondant.';
  EtktocBis = 'L''impression suivante concernera les �tiquettes des op�rations commerciales.' + #10#13 + 'Veuillez choisir un mod�le d''�tiquette correspondant aux "TOC".';
  suppicco = 'Attention, l''article' + #13 + #10 + '�0' + #13 + #10 + 'n''est pas pr�vu dans le pack' + #13 + #10 +
    '�1.' + #13 + #10 + #13 + #10 + 'Voulez-vous appliquer un suppl�ment?';

  CstMessOCAvertOuvre = 'L''op�ration commerciale �0 est en cours'#10#13'Supprimer l''avertissement';
  CstMessOCAvertFerme = 'L''op�ration commerciale �0 s''est termin�e'#10#13'Supprimer l''avertissement';
  CstMessOCAvertSupp = 'Cette suppression est pour tous les postes, �tes-vous s�r ?';
  //************* RV le 19/10/2004
  MsqRecomptArt = 'Confirmez le recomptage complet de cet article !' + #13#10 +
    'Tous les comptages le concernant vont �tre supprim�s et ses donn�es r�actualis�es...' + #13#10 +
    '( L''�tat affich� � l''�cran sera obligatoirement r�actualis� lui aussi )';

  //*************
  msgNoDefPeriode = 'Impossible de r�f�rencer une op�ration commerciale dont la p�riode d''activation n''est pas d�finie !...';
  MsgNbreSupprBN = '"�0" mod�les ont �t� enlev�s du bloc note...';
  msgDesacOcKur2 = 'D�sol� de cette r�p�tition...' + #13#10 +
    'Confirmez la d�sactivation de l''op�ration commerciale affich�e ...' + #13#10 + #13#10 +
    'ATTENTION cette op�ration commerciale est active en ce moment !';
  msgDesacOcKur = 'Confirmez la d�sactivation de l''op�ration commerciale affich�e ...' + #13#10 + #13#10 +
    'ATTENTION cette op�ration commerciale est active en ce moment !';
  msgDesacOc = 'Confirmez la d�sactivation de l''op�ration commerciale affich�e ...';

  MsgSuppressionOC = 'Suppression de l''op�ration commerciale en cours ... ';
  msgSupprOcKur2 = 'D�sol� de cette r�p�tition...' + #13#10 +
    'Confirmez la suppression de l''op�ration commerciale affich�e ...' + #13#10 + #13#10 +
    'ATTENTION cette op�ration commerciale est active en ce moment !';
  msgSupprOcKur = 'Confirmez-vous la suppression de l''op�ration commerciale affich�e ?' + #13#10 + #13#10 +
    'ATTENTION cette op�ration commerciale est active en ce moment !';
  msgSupprOc = 'Confirmez-vous la suppression de l''op�ration commerciale affich�e ?';

  MsgOcNoSelected = 'Aucun mod�le s�lectionn� !...';
  MsgOcNoLotSelected = 'Aucun lot s�lectionn� !...';
  MsgNbreSuppr = '"�0" mod�les ont �t� enlev�s de cette op�ration commerciale...';
  MsgLotNbreSuppr = ' %d lots ont �t� enlev�s de cette op�ration commerciale...';
  MsgOCConfSuppr = 'Confirmer la suppression des lignes s�lectionn�es...';
  MsgMajOC = 'Traitement des mod�les s�lectionn�s...';
  MsgMajLotOC = 'Traitement des lots s�lectionn�s...';
  MsgNbreOCMaj = ' "�0" mod�les de l''op�ration commerciale ont �t� mises � jour !';
  MsgNbreLotOCMaj = ' %d lots de l''op�ration commerciale ont �t� mises � jour !';
  CapRemRoApplik = 'Remise � appliquer sur le prix des mod�les s�lectionn�s';
  CapRemRoApplikLot = 'Remise � appliquer sur le prix des lots s�lectionn�s';
  LibRemRoApplik = 'Remise sur le prix de vente habituel affich�...';
  CapOffsetRoApplik = 'Montant � d�duire sur le prix des mod�les s�lectionn�s';
  CapOffsetRoApplikLot = 'Montant � d�duire sur le prix des lots s�lectionn�s';
  LibOffsetRoApplik = 'Montant � d�duire du prix de vente habituel affich�...';
  CapFixeRoApplik = 'Prix fixe � appliquer aux mod�les s�lectionn�s';
  CapFixeRoApplikLot = 'Prix fixe � appliquer aux lots s�lectionn�s';
  MsgAjouteOnOc = '�0 mod�le(s) ont �t� rajout�(s) au tarif';

  LibRoundOC = 'Recalcul automatique des prix de l''OC';
  msgAuncunOC = 'Aucune op�ration commerciale existante' + #13#13 + '( autre que celle �ventuellement affich�e )';
  LabNoPeriode = 'P�riode non d�finie';

  MsgExisteOnOc = 'Ce mod�le est d�j� r�f�renc� dans l''op�ration commerciale !...';
  CapTitrePeriodeOC = 'P�riode de l''OC';
  MsgOCConfirmPermanent = 'Confirmez que cette op�ration commerciale est permanente...';
  //***************
  MessChargeSelOC = ' Mise � jour de la liste des mod�les de l''op�ration commerciale...';

  MsgLotExisteOnOc = 'Ce lot est d�j� r�f�renc� dans l''op�ration commerciale !...';

  MsgRefreshcloture = 'Une relecture des donn�es est imp�rative avant de lancer la cl�ture !' + #13#10 +
    'Il est indispensable de v�rifier et contr�ler que les conditions de cl�ture sont bien remplies ' +
    'et qu''aucune nouvelle modification n''a �t� effectu�e depuis un autre poste...';

  msgArchiveInvReserve = 'Faut-il archiver cet inventaire de r�serve ?...' + #13#10 +
    'Un "stock de r�serve" ne sert g�n�ralement qu''une fois, il est donc logique de l''archiver apr�s int�gration dans votre inventaire classique. ' +
    'S''il ne doit plus servir, cela peut �viter de l''int�grer par erreur dans un autre inventaire...';
  msgInvSRArchiveOK = 'L''inventaire de r�serve a �t� archiv�...';
  LabInvCloture = 'Cl�tur�';
  LabInvArchive = 'Archiv�';
  msgInvDejaMisReserve = 'Le stock r�serve "�0" a d�j� �t� ajout� � cet inventaire !';
  Capclotstkreserve = 'Cl�ture d''un pr�-inventaire';
  msgConfCloStkReserve = 'Confirmez la cl�ture du pr�-inventaire';
  messInvMetreserve = 'Chargement du stock r�serve en cours ...';
  msgNoSykReserveDispo = 'Aucun "Stock r�serve" n''est actuellement disponible' + #13#10 +
    'Pour �tre disponible un inventaire r�serve doit �tre cl�tur� mais non archiv�';
  CapInvSaisReserve = 'Int�gration de stock  r�serve...';
  LabCtrlEcartActif = 'MaJ �carts active';
  LabCtrlEcartInActif = 'MaJ �carts inactive';
  msgInvPlusEcart = 'Apr�s mis � jour des donn�es, l''�cart que vous aviez s�lectionn� n''est plus pr�sent dans cette liste...';

  MsgChargeEtatSais = 'Chargement de la liste des mod�les saisis' + #13#10 + 'Merci de patienter quelques secondes...';
  // 2 ligne modifi�e
  GenerikRefresh = 'R�actualisation des donn�es affich�es...' + #13#10 + 'Merci de patienter quelques secondes...';
  MsgInvClotIsNJ = 'Impossible de cl�turer cet inventaire  !' + #13#10 +
    'Il reste des �carts qui ne sont ni "ACCEPTES" ni "JUSTIFIES"...';

  LibLisStkSaisInv = 'Etat du stock saisi';
  MsgNofindart = 'Aucun mod�le trouv�...' + #13#10 + 'Si vous �tes persuad� que ce mod�le existe' + #13#10 + 'V�rifiez qu''il ne soit pas archiv� !';
  LibReserve = 'Pr�-inventaire';
  msgInvReservOuvert = 'Pr�-inventaire ouvert';
  MsgNosupprInvClot = 'Il n''est pas possible de supprimer un inventaire cl�tur�' + #13#10 +
    'C''est quelque part un "historique" de d�marque qu''il convient de garder...';
  CapInvSupprJournal = 'Type du journal � supprimer...';

  MessChargeSelInv = 'Mise � jour du p�rim�tre de l''inventaire...' + #13#10 + 'Le chargement peut prendre quelques secondes si le p�rim�tre d�fini est large...';

  MsgConfSupInvSais = 'Des saisies ont d�j� �t� enregistr�es dans cet inventaire...' + #13#10 +
    'Etes-vous s�r de vouloir le supprimer ?...' + #13#10 +
    'Attention : cette suppression est irr�versible...';

  MsgConfSupInvOuvert = 'Cet inventaire � �t� ouvert...' + #13#10 +
    'Confirmez-vous cependant sa suppression ?...' + #13#10 +
    'Attention : cette suppression est irr�versible...';
  MsgConfSupInvPerim = 'Vous avez d�j� d�fini le p�rim�tre de cet inventaire...' + #13#10 +
    'Confirmez-vous cependant sa suppression ?...' + #13#10 +
    'Attention : cette suppression est irr�versible...';

  MsgConfSupInv = 'Confirmez la suppression de l''inventaire affich� � l''�cran ....' + #13#10 +
    'Attention : cette suppression est irr�versible...';
  MsgInvErrSuppr = 'Probl�me lors de la suppression de l''inventaire...';
  MsgInvOkSuppr = 'L''inventaire a bien �t� supprim�';
  LIbInvEdValo = 'Edition Valoris�e des �carts';
  MsgInvClot2 = 'Confirmez la cl�ture de cet inventaire' + #13#10 +
    'LA DATE DE DEMARQUE EST BIEN LE �0';
  MsgInvClot1 = 'Confirmez la cl�ture de cet inventaire' + #13#10 +
    'Date de d�marque : �0' + #13#10 +
    'La cl�ture de l''inventaire ne touche que le stock des mod�les ayant une d�marque "ACCEPTEE"';

  LibInvAcc = 'L''�cart � accepter sera automatiquement calcul�';
  LibInvJust = 'L''�cart � justifier sera automatiquement calcul�';
  HintInv2Clics = '[Double Clic] Sur une ligne mod�le ouvre la fiche de ce mod�le';
  MsgInvNoGoodEC = 'Vous devez saisir un �cart de stock final diff�rent de celui en cours...';
  MsgMajEcarts = 'Mise � jour des �carts d''inventaire...';
  CapInvAccept = 'Gestion d''un �cart accept�';
  CapInvJustif = 'Gestion d''un �cart justifi�';
  CapInvVisu = 'D�tail des �carts';
  MsgJustifOblig = 'La saisie du motif de justification est obligatoire...';
  MsgInvDoCloture = 'Confirmez le chargement' + #13#10 + 'des donn�es de cl�ture de l''inventaire ...';
  MsgAfficherNJ = 'Confirmez le chargement' + #13#10 + 'des listes de gestion des �carts...';
  MasgChargeTCNC = 'Confirmez le chargement' + #13#10 + 'de la liste compl�te des Tailles/Couleurs non compt�es...';
  MsgAfficherNC = 'Confirmez le chargement' + #13#10 + 'de la liste compl�te des mod�les non compt�s...';
  MsgAfficherPerim = 'Confirmez le chargement' + #13#10 + 'de la liste des mod�les � inventorier...';
  MsgChargeNonComptes = 'Chargement en cours...' + #13#10 + 'Le chargement peut prendre quelques secondes si de nombreux mod�les n''ont pas �t� compt�s...';

  //-***********
  ConsoDivDuree = 'La validation du transfert est impossible sans dur�e d''amortissement...';
  CstPasDroitModule = 'Votre version ne contient pas ce module.'#10#13'Veuillez contacter le service commercial de GINKOIA SA pour plus d''informations';

  CstPatienCaisse = 'Veuillez patienter pendant l''initialisation et l''ouverture de la caisse';
  CstVilleCPDif = 'Une ville de ce nom existe avec un autre code postal : cr�ation';
  CstVillCPNone = 'Cr�ation de la ville sans code postal ';
  CstCpVilleNone = 'Cr�ation du code postal sans nom de ville';
  CstCltMemeRS = 'Attention, un client de m�me raison sociale existe d�j�';
  CstCltMemeNom = 'Attention, un client de m�me nom existe d�j�';

  DureeVoDepassee = 'La dur�e r�elle de location est sup�rieure' + #13 + #10 + '� la dur�e pr�vue par le voucher.' + #13 + #10 +
    'Souhaitez-vous appliquer un suppl�ment?';
  CstMessLocArtSuppHisto = 'Attention, ce type de modification n''est pas report�e sur les sous fiches associ�es'#13#10 +
    'Si vous le d�sirez-vous pouvez reporter manuellement cette modification';
  PasPays = 'Attention, le pays n''est pas renseign� dans votre fiche magasin.' + #13 + #10 +
    'Les adresses des nouveaux clients risquent d''�tre incompl�tes...';
  LibJFullInv = 'Journal de saisie complet';

  MessChargeFull = 'Chargement du journal...';
  MsgSupprNoPossSessOpen = 'Suppression impossible car cette session est ouverte dans l''onglet de saisie';
  MsgSessErrSuppr = 'Le journal de saisie n''a pas pu �tre supprim�...';
  MsgSessokSuppr = 'Journal de saisie supprim� !';
  MsgInvSupprSess = 'Confirmez la suppression de : �0' + #13#10 +
    'N� : �1 Zone : �2  Utilisateur : �3  Titre : �4' + #13#10#13#10 +
    'ATTENTION : Cette suppression est IRREVERSIBLE !' + #13#10 +
    '(Toute erreur de votre part vous obligera � refaire le travail)';
  MsgInvSupprSess2 = 'Confirmez la suppression de : �0' + #13#10 +
    'N� : �1 Zone : �2  Utilisateur : �3  Titre : �4' + #13#10 +
    'ATTENTION : Cette suppression est IRREVERSIBLE !' + #13#10#13#10 +
    '(D�sol� mais une double confirmation est n�cessaire...)';

  LibInvSessVidPortable = 'Session de saisie portable';
  LibInvSessReserve = 'Rajout de stock r�serve';
  CapInvSupprJrnl = 'Suppression d''un journal de saisie';
  CapInvChxJournal = 'Type de journal de saisie � afficher...';
  MessEnregToutHP = 'Validation des quantit�s de tous les mod�les not�s "Hors P�rim�tre"...';
  CapHorsperim = 'Saisies hors p�rim�tre de l''inventaire';
  MsgInvRajouteToutHP = 'Confirmez que toutes les quantit�s saisies pour les mod�les de cette liste doivent bien �tre inventori�es...';
  MsgInvRajouteaRThp = 'Confirmez que les quantit�s saisies pour le mod�le' + #13#10 + 'Chrono : �0' + #13#10 + '�1' + #13#10 + 'Doivent bien �tre inventori�es...';
  MsgConfCtrlVP = 'Confirmez que vous avez bien contr�l� et not� les erreurs de saisie correspondants � cette session de saisie !';
  MsgInvMankComent = 'La saisie du commentaire est obligatoire';
  InvLabNPE = '�0  Saisies hors p�rim�tre';
  InvLabNRC = '�0  Saisies non reconnues';

  InvPbCauseCB = 'Code-barres non reconnu';
  InvPbCausePerim = 'Hors p�rim�tre';
  InvPbCauseArchive = 'Mod�le archiv�';
  InvPbCausePalette = 'probl�me importation palette';

  MsgInvMankZone = 'La saisie du N� de zone est obligatoire !' + #13#10 +
    '( Le N� de zone doit �tre imp�rativement diff�rent de "0" )';
  CapInvStkKour = 'Stock courant du mod�le ( tient compte de TOUS les mouvements enregistr�s )';
  CapInvSaisPortable = 'Vidage de portable...';
  //***

  LocPasPseudoBis = 'Pour un �change pseudo, vous devez vous positionner sur la ligne' + #13 + #10 + 'de l''article avant d''activer la fonction �change...';
  locPasPseudoVide = 'Pas d''�change avec les pseudos articles' + #13 + #10 + 'si le bon de location du client n''est pas charg�...';
  locPasPseudo = 'Pas d''�change avec les pseudos articles.';

  CstArtLocLMessEtatActuArt = 'Cette ligne correspond � l''�tat actuel de votre article et ne peut donc �tre supprim�e';
  CstArtLocLMessConfSupHistTit = '  Suppression d''un historique';
  CstArtLocLMessConfSupHistMess = 'Etes-vous s�r de vouloir supprimer cette ligne d''historique';
  MsgChargePhl = 'Confirmez le chargement du PHL ?...';
  msgMin100Art = 'Le p�rim�tre de votre inventaire contient moins de 100 r�f�rences...' + #13#10 +
    'Faut-il continuer et ouvrir cet inventaire ?';
  msgPhlNoArtPerim = 'Le p�rim�tre de l''inventaire est vide...';
  MsgNoErrVPInv = 'Tous les articles "bip�s" sont corrects et ont pu �tre inventori�s !' + #13#10 + #13#10 +
    'Voulez-vous n�anmoins voir le r�capitulatif de saisie ?';

  InvSaisieVide = 'Vous n''avez saisi aucune quantit� � inventorier...';
  MsgAjouArtPerim = 'Le mod�le code chrono "�0"' + #13#10 + '�1' + #13#10 +
    'ne fait pas partie du p�rim�tre de votre inventaire...' + #13#10 +
    'Faut-il l''accepter et l''ajouter au p�rim�tre ?';

  CstErrDLL = 'Initialisation du portable impossible...' + #13#10 +
    '( la DLL "MDECOM32.dll" est introuvable... )';

  msgInvPerimOuvert = 'L''inventaire tournant est ouvert !' + #13#10'Vous pouvez rajouter des mod�les au p�rim�tre � inventorier mais afin d''�viter les malentendus vous ne pouvez pas en retirer...';
  msgInvOuvert = 'L''inventaire complet du magasin est ouvert !';

  msgInvVerifNbCbAjout = '"�0" mod�les ont �t� rajout�s au p�rim�tre de l''inventaire' + #13#10 +
    'V�rification de la possibilit� de charger les PHL...' + #13#10 +
    'Merci de votre patience...';

  MsgInvNoRajout = 'Aucun mod�le n''a �t� rajout� au p�rim�tre de l''inventaire...' + #13#10 +
    '(Soit aucun n''a �t� trouv� soit ils �taient tous d�j� pris en compte)';
  msgTestRapid = 'Vidage termin�' + #13#10'"�0 Bipages" d''�tiquettes ont �t� enregistr�s';

  msgInvVerifNbCb = 'V�rification de la possibilit� de charger les PHL...' + #13#10 +
    'Cela peut prendre jusqu''� 2 � 3 minutes... Merci de votre patience !';
  msgPhlNoPossible = 'Le chargement des PHL n''est plus possible !' + #13#10 + 'Le nombre de codes � barres � g�rer d�passe la capacit� des PHL';
  msgPhlIsPossible = 'Le chargement des PHL est d�sormais possible !' + #13#10 + 'Le nombre de codes � barres � g�rer ne d�passe plus la capacit� des PHL';
  MsgInvArtExists = 'Ce mod�le �tait d�j� r�f�renc� dans le p�rim�tre de l''inventaire...';
  msgPerimParPortable = '"�0" mod�les enregistr�s sur le portable ont �t� rajout�s au p�rim�tre de l''inventaire';
  MsgInvNoValidart = 'Ce mod�le ne peut pas �tre inventori� !' + #13#10 + 'Il s''agit soit d''un mod�le archiv� soit d''un PSEUDO';
  MessDeleteSelInv = 'Suppression du p�rim�tre de l''inventaire des mod�les s�lectionn�s...';
  msgSupPerim = 'Confirmez la suppression de(s) "�0" mod�le(s) s�lectionn�(s)';
  CapYes = '&Oui';
  CapNo = '&Non';
  CapMerci = 'Merci de votre patience';

  HintOkDef = '[ Entr�e ] Valider par d�faut   [ Echap ] Abandon...';
  HintCancelDef = '[ Entr�e / Echap ] Abandonner par d�faut';
  LibOk = 'Fermer en validant';
  LibCancel = 'Fermer en abandonnant';

  HintDBGSelMode = '[F3 / MAJ+F3] S�lectionne / D�s�lectionne la ligne en cours et passe � la suivante';
  LibComplet = 'Tout le magasin';
  LibPartiel = 'Tournant';
  LibAjouArtInv = 'Ajouter des mod�les';
  LibPerimInv = 'D�finir le p�rim�tre';
  LibTitreInv = ''; // obsol�te, � supprimer v13
  LabTitreInv = ''; // obsol�te, � supprimer v13

  MsgNoActiveInv = 'Aucun inventaire n''affich� � l''�cran !' + #13#10 + 'S�lectionnez l''inventaire � g�rer dans la liste des inventaires...';
  MsgNoTest = 'Vous n''avez pas confirm� que les outils de saisie avaient �t� test�s avec succ�s !';
  MsgNoPerim = 'Avant toute chose, il est imp�ratif' + #13#10 + 'de commencer par d�finir le p�rim�tre de l''inventaire...';

  // *******
  CstExpAffSfPasPrinc = 'Vous n''avez pas de fiche principale dans votre s�lection';
  CstExpAffSfPasOrph = 'Vous n''avez pas de fiche orpheline � affecter';
  CstExpAffSfPasEnr = 'Vous n''avez pas enregistr� vos modifications. Annuler ?';
  CstExpAffSfSelPrin = 'Vous devez s�lectionner des fiches principales';
  CstExpAffSfSelSFich = 'Vous devez s�lectionner des sous-fiches';
  CstExpAffSfSelAutant = 'Vous devez s�lectionner autant de fiches principales que de sous-fiches';
  CstExpAffSfPasAss = 'Vous n''avez fait aucune association, voulez-vous sortir ?';

  VoImpossible2 = 'La vente de cet article est impossible,' + #13 + #10 + 'sa date de cession est ant�rieure � la date de cl�ture...';
  VoImpossible1 = 'La vente d''un pseudo ou d''un article archiv� est impossible...';
  BADateLib = 'R�capitulatif des bons d''achat du �0 au �1  -  ';
  PasAmortissement = 'La validation d''une fiche sans dur�e d''amortissement est impossible...';
  PastraitementSF = 'S�lection d''une sous fiche non-orpheline interdite...';

  CaisseEnConsult = 'Fonction impossible, la caisse est en consultation uniquement...';

  CstOuvCaisseJour = 'Les sessions de caisse ne peuvent porter sur plusieurs jours';
  CstOuvCaisseSemaine = 'Les sessions de caisse ne peuvent porter sur plusieurs semaines';
  CstOuvCaisseMois = 'Les sessions de caisse ne peuvent porter sur plusieurs mois';
  CstOuvImpossible = 'Vous devez fermer votre sessions en cours';

  CstMessCaisseOuv = 'Attention, vous avez des sessions ouvertes dans votre s�lection';
  Cst_Ref_desArchive = 'D�sarchivage';
  Cst_ref_desarchiveNbr = 'Voulez-vous d�sarchiver les �0 fiches ?';
  CltListArch = 'Liste des clients archiv�s';

  bapaspossible = 'Encaissement impossible !!!' + #13 + #10 + #13 + #10 +
    'Le montant des bons d''achats (�0�) ne doit pas d�passer' + #13 + #10 +
    'le total des �1 (�2�)...';
  PasPossibleBA = 'Op�ration impossible sur un ticket avec des bons d''achats...';

  CstGebucoInfo = 'Informations exportation GEBUCO';
  CstExportGebuco = 'Export GEBUCO du �0 au �1';
  CstQuestGebuco = 'Attention, pour la p�riode du �0 au �1 :' + #10#13 +
    '  - Seuls les prix des Bons de r�ception seront modifiables.' + #10#13 +
    '  - Les retours fournisseurs seront cl�tur�s.' + #10#13 +
    '  - Les transferts inter-magasins seront cl�tur�s' + #10#13 +
    ' Confirmez-vous l''exportation ? ';

  // Gestion group�e des articles de location
  // ----------------------------------------
  ActionCessartloc = 'Cession d''un article de location';
  ActionCessartlocSF = 'Cession d''une sous-fiche de location';
  ActionArchLoc = 'Articles archiv�s';
  ActionArchLocSf = 'Fiches secondaires archiv�es';
  ActionRetirLocSf = 'Sous Fiches rendues "orphelines"';

  MsgGenerLocEtik = 'Confirmez la g�n�ration des �tiquettes de location pour les "�0" articles de la liste...';
  Actioncat = 'Articles plac�s dans la Cat�gorie';
  ActionStatut = 'Articles d�finis avec le statut';
  ActionStatutSf = 'Sous Fiches d�finies avec le statut';
  ChangeCat = 'Confirmez le d�placement des articles list�s vers la Cat�gorie' + #13 + #10 + '�0';
  ChangeStat = 'Confirmez le changement de statut des articles list�s pour le statut' + #13 + #10 + '�0';
  categVide = '"Pas de Cat�gorie"';
  StatutVide = '"Pas de Statut"';
  // ----------------------------------------

  PasmodifPxcession = 'Vous devez saisir dans un premier temps la date de cession...';
  CstSynthCA = 'SYNTHESE DU CHIFFRE D''AFFAIRES';
  CstPeriode = 'P�riode du �0 au �1';
  CstSCA0 = 'Chiffre d''affaires';
  CstSCA1 = 'CAISSE VENTE';
  CstSCA2 = 'FACTURE VENTE';
  CstSCA2Bis = 'FACTURE RETROCESSION';
  CstSCA3 = 'TOTAL VENTE';
  CstSCA4 = 'CAISSE LOCATION';
  CstSCA5 = 'FACTURE T.O.';
  CstSCA6 = 'TOTAL LOCATION';
  CstSCA7 = 'CHIFFRE D''AFFAIRES BRUT';
  CstSCA10 = 'CHIFFRE D''AFFAIRES NET';
  CstSCA11 = 'Ventilation comptable';
  CstSCA11_1 = 'HT';
  CstSCA11_2 = 'TVA';
  CstSCA11_3 = 'TTC';
  CstSCA13 = 'TOTAL';
  CstSCA14 = 'Comptes clients';
  CstSCA14_1 = 'R�glements';
  CstSCA14_2 = 'Mises en cpte';
  CstSCA15 = 'Op�rations saisies en caisse';
  CstSCA16 = 'Facturation';
  CstSCA18 = 'R�servations Internet';
  CstSCA19 = 'R�gularisations clients';
  CstSCA19_1 = 'Profit';
  CstSCA19_2 = 'Perte';
  CstSCA20 = 'R�gularisations comptes clients';
  CstSCA21 = 'Modes d''encaissement';
  CstSCA21_1 = 'Fond initial';
  CstSCA21_2 = 'Encaissement';
  CstSCA21_3 = 'Apport';
  CstSCA21_4 = 'Pr�lvts & D�p.';
  CstSCA21_5 = 'Solde';

  SuperArchi = 'Attention, ce mod�le n''est pas archivable. Vous pouvez n�anmoins' + #13 + #10 +
    'exceptionnellement l''archiver, mais cette op�ration peut mettre' + #13 + #10 +
    'en p�ril l''int�grit� des calculs d''amortissements.' + #13 + #10 + #10 +
    'Confirmation de l''archivage?';
  Supfichartloc = 'Suppression impossible, la date d''achat est inf�rieure' + #13 + #10 + '� la date de derni�re cl�ture...';
  modifDtcession = 'Impossible, la date de cession ne peut pas �tre inf�rieure' + #13 + #10 + '� la date de derni�re cl�ture...';
  modifDtachat = 'Impossible, la date d''achat ne peut pas �tre inf�rieure' + #13 + #10 + '� la date de derni�re cl�ture...';

  RalGroupeOblig = 'Il faut cocher au moins un groupe !...' + #13 + #10 +
    '( Sans groupe d�fini, il ne peut pas avoir de r�ponse � votre demande )';
  CstLettrageNonSel = 'Vous devez s�lectionner les lignes de comptes � lettrer...';
  CstImpGroupe = 'Impossible de lettrer un groupe, vous devez changez votre s�lection.';
  CstImpLettre2Groupe = 'Impossible de lettrer des lignes de deux groupes diff�rents...';
  CstLettrage = 'Lettrage';
  CstCreRegul = 'Voulez-vous lettrer ces �critures en cr�ant une �criture de r�gularisation ?';
  CstCreLettrage = 'Voulez-vous lettrer ces �critures ?';
  CstImpLettreDejLettre = 'Impossible de lettrer des lignes d�j� lettr�es';

  MsgNoCanDep = 'Ce mod�le n''a pas de stock !' + #13 + #10 + '( Seuls les mod�les ayant du stock peuvent �tre d�pr�ci�s ! )';
  ConfSupgesRecep = 'Confirmez le bon [ �0 ]' + #13 + #10 + 'doit �tre retir� de la liste des documents ouverts... ';
  VOnonvalide = 'Ligne non valide pour une vente d''occasion';
  Puht = '  PU HT   ';
  Pxht = ' TOT HT   ';
  VenteDetaxee = 'VENTE DETAXEE';
  detaxeHT = '(Encaissement HT)';
  detaxeTTC = '(Encaissement TTC)';
  cstRbTVA = 'Remb.' + #13 + #10 + 'TVA';
  CST_ConnectSec = 'Voulez-vous vous connecter sur votre serveur de secours ?';
  BRImpossible = 'Impossible de g�n�rer un bon de r�servation, le ticket est vide...';
  BLInserer = 'Veuillez ins�rer le bon de livraison � imprimer';
  BRInserer = 'Veuillez ins�rer le bon de r�servation � imprimer';
  BLConfSuiteProbleme = 'Souhaitez-vous imprimer le bon de livraison';
  BRConfSuiteProbleme = 'Souhaitez-vous imprimer le bon de r�servation';
  FTInserer = 'Veuillez ins�rer la facture � imprimer';
  FTConfSuiteProbleme = 'Souhaitez-vous imprimer la facture';

  Cst_Ref_Nk = 'Gestion de la nomenclature';
  Cst_Ref_NkHisto = 'Historique : Gestion de la nomenclature';
  Cst_Ref_NkSelSSF = 'S�lectionner la nouvelle sous famille';
  Cst_Ref_NkAffect = 'Affectation';
  Cst_Ref_NkAFFQUEST = 'Affecter la sous famille aux �l�ments s�lectionn�s ?';

  Cst_Ref_traite = 'Trait�';
  Cts_Ref_Ignore = 'Ignor�';
  Cts_Ref_Valide = 'Validation';
  Cst_ref_etiquette = 'Etiquette';
  Cst_Ref_Ignorer = 'Ignorer';
  Cst_Ref_Annule = 'Annulation';
  Cst_Ref_Histo = 'Historiser avant le';
  Cst_Ref_Archive = 'Archivage';
  Cst_ref_archiveNbr = 'Voulez-vous archiver les �0 enregistrements ?';
  Cst_ref_AnnuleHisto = 'Voulez-vous annuler les actions d�j� accomplies';
  Cst_Ref_Cancel = 'Annuler TOUTES vos modifications ?';
  Cst_Ref_Post = 'Valider vos modifications ?';
  Cst_Ref_Ignorer_Grp = 'Voulez-vous ignorer tout le groupe ?';
  Cst_ref_etiquette_Stk = 'Voulez-vous r�-etiqueter le stock ?';
  Cst_ref_valide_grp = 'Voulez-vous valider tous le groupe ?';
  Cst_Ref_Impossible = 'Impossible de changer d''onglet sans valider ou annuler';
  Cst_Ref_ChargPxGest = 'Chargement des prix de vente modifi�s';
  Cst_Ref_ChargPxHist = 'Chargement de l''historique des prix de vente';
  Cst_Ref_PxGestTitre = 'Gestion de la mise � jour des prix de vente';
  Cst_Ref_PxHistTitre = 'Historique : mise � jour des prix de vente';
  Cst_Ref_TraitePx = 'Des mises � jour de prix du r�f�rencement sont en attente';
  Cst_Ref_TraiteNk = 'Des mod�les sont masqu�s par le r�f�rencement';
  Cst_Ref_Traitement = 'R�f�rencement : Traitements en attente';

  RESaPAsST = 'Impossible d''ins�rer un sous total dans un bon de r�servation provenant de la caisse...';
  DejaTicketResa = 'Transfert impossible vous avez d�j� des ventes en cours...';
  Dejaresa = 'Impossible, vous avez d�j� import� une r�servation dans ce ticket...';
  rappelResa = 'Souhaitez-vous transformer la r�servation en une vente?';
  ConfFracDev2 = 'Confirmez l''enregistrement' + #13 + #10 + 'Docs g�n�r�s en date du ';
  LabDateTrans = 'Date du document g�n�r�';

  Cst_TropCol = 'Attention, modifier trop de donn�es peut entra�ner des probl�mes de r�plication'#13#10 +
    'Voulez-vous continuer ?...';
  Cst_AssocierCol = 'Associer une collection';
  Cst_AssocierColQuestTous = 'Associer la collection � tous les mod�les ?';
  Cst_AssocierColQuest = 'Associer la collection aux mod�les s�lectionn�s ?';

  Cst_dissocierCol = 'Dissocier une collection';
  Cst_dissocierColQuest = 'Dissocier la collection des mod�les s�lectionn�s ?';

  Cst_Charge_Artsanscol = 'Chargement des mod�les sans collection';
  Cst_Charge_ArtPlusCol = 'Chargement des mod�les avec plusieurs collections';
  Cst_Charge_Colavecart = 'Chargement des collections avec leurs mod�les';

  NeedOneTail = 'If faut d�finir au moins une taille !...    ';
  TailexistModel = 'Cette taille fait d�j� partie du mod�le...    ';
  Only28Tail = 'Vous ne pouvez d�finir que 28 tailles au maximum...   ';

  SupModelTTV = 'Confirmez la suppression du mod�le de tailles travaill�es' + #123 + #10 + '�0';
  LabNomModelTTV = 'Nom du mod�le';
  TitNomModelTTV = 'Nom du mod�le de tailles travaill�es';

  BRAccompte = 'Souhaitez-vous encaisser un acompte pour ce bon de r�servation?';
  BRPasSousTotal = 'Impossible de g�n�rer un bon de r�sevation avec des sous totaux...';
  LibBR = 'Bon de reservation';
  cstresa = 'Bon de' + #13 + #10 + 'Reserv.';

  PlusRemiseGlob = 'Attention la remise globale est supprim�e...';
  DureePrepMatos = 'Demander l''�tat du mat�riel � pr�parer sur plus d''une semaine risque d''�tre long ...' + #13 + #10 +
    '( Cela d�pend bien entendu du nombre de r�servations ... mais peut prendre plusieurs minutes en saison haute )' + #13 + #10 + #13 + #10 +
    'Faut-il continuer ?...';
  InsForNewTail = '[INS] [CTRL+INS] Ajoute une nouvelle taille [ Apr�s ] [ Avant ]... celle s�lectionn�e';
  CreerGTF = 'Confirmez la cr�ation d''une nouvelle grille de tailles fournisseur....';
  SupCtrl = 'Je contr�le si cette suppression est possible...';

  ChargeDeprecie = 'Chargement de la liste des mod�les d�pr�ci�s au cours des 3 derniers mois...';
  DatEtatDep = 'Etat des d�pr�ciations au : �0';
  NoStockInDep = 'Le mod�le que vous demandez � d�pr�cier :' + #13 + #10 +
    'Code chrono : �0' + #13 + #10 +
    'R�f�rence : �1' + #13 + #10 +
    'D�signation : �2' + #13 + #10 +
    'N''a pas de stock actuellement.' + #13 + #10 +
    'Voulez-vous n�anmoins le d�pr�cier ?';

  DejaDep = 'Vous avez d�j� saisi une ligne de d�pr�ciation pour ce mod�le...';
  ConfSupDep = 'Confirmez la Suppression de la d�pr�ciation s�lectionn�e ...' + #13 + #10 +
    'Code chrono du mod�le : �0';

  DepNoSupTodo = 'Il n''y a aucune d�pr�ciation � supprimer dans votre s�lection de mod�les...';
  DepDateTravTooBig = 'La date de travail ne peut pas �tre post�rieure � aujourd''hui';
  DepDateTravTooSmall = 'Vous ne pouvez pas travailler au del� de 1 mois en arri�re...';
  DepDateLivrTooBig = 'La date limite de livraison ne peut pas �tre post�rieure � aujourd''hui...';
  DepMotifDef = 'Enregister [ �0 ]' + #13 + #10 + #13 + #10 + 'comme �1 par d�faut au chargement du module sur ce poste de travail';
  NoArtToShow = 'Aucune mod�le ne correspond � vos crit�res de s�lection';
  TxDeprecie0 = 'Impossible de valider une d�pr�ciation avec un Taux ' + #13 + #10 + 'inf�rieur ou �gal 0.00% ... ';
  MajDeprecie = 'Enregistrement des d�pr�ciations pour les mod�les s�lectionn�s ... ';
  GenerikWork = 'Travail en cours';

  DifPlusque1 = 'Confirmez ce nouveau montant SVP...' + #13 + #10 + #13 + #10 +
    'Ancien montant TTC : �0' + #13 + #10 +
    'Nouveau montant TTC : �1';

  LocPackCategPasBonRL = 'Attention, la cat�gorie de l''article �0' + #13 + #10'n''est pas r�f�renc�e dans le pack.' + #13 + #10 +
    'Souhaitez-vous tout de m�me accepter la location?';

  LocPackDejaSaisiRL = 'Impossible, vous avez plusieurs articles avec le type : �0';

  RLligneMauvaise = 'Une des lignes s�lectionn�es n''est pas compatible avec cette fonction...';
  Repriseligne = 'Souhaitez-vous int�grer les �0 ligne(s) s�lectionn�e(s) dans un pack?';
  CstMessChargeRnonP = 'Chargement de l''�tat des locations rendues, non pay�es...';
  CstTitreLocRnonP = 'Etat des locations rendues, non pay�es';

  CautionL1 = 'Le montant de la caution en cours est de �0';
  CautionL2 = 'La caution propos�e pour les nouveaux articles est de �0';
  CautionL3 = 'Que souhaitez-vous faire?';
  cautionB1 = '&Rendre';
  CautionB2 = '&Ajouter automatiquement';
  cstcaution = 'Caution';
  clientpassage = 'Client de passage';
  MotPack = 'Pack';
  CstTitreLocPark_RETLOC = 'Articles en retard de location';
  CstEdEnch_RetLoc = 'Articles en retard de location';
  cstvo = 'Vente' + #13 + #10 + 'occas.';
  horsparc = 'Article hors parc location...';
  paramvo = 'Ce param�trage sera disponible apr�s r�plication...';
  BLSoldedeb = 'COMPTE CLIENT DEBITEUR :';
  BLSoldeCre = 'COMPTE CLIENT CREDITEUR :';
  ReprisePL = 'Souhaitez-vous rappeler, pour ce client, les articles non s�lectionn�s' + #13 + #10 +
    'dans le paiement � la ligne?';
  Packauto = 'Pack automatique';
  AffMessNotDesarchTMM = 'Les transferts ayant �t� regroup�s ne peuvent plus �tre d�sarchiv�s';
  CapContinuer = '&Continuer';
  CVracExistCadence = 'Impossible de valider cette ligne de commande :' + #13 + #10 +
    'La commande s�lectionn�e contient dej� une livraison en date du �0 pour ce mod�le...' + #13 + #10 + #13 + #10 +
    'Proposez une autre cadence de livraison... ou Abandonnez...';
  YaDEsRetik = 'Il y a des �tiquettes de "R�-�tiquettage de stock" en attente' + #13 + #10 +
    'Faut-il les imprimer ?...';
  NoRecepDispo = 'Il ne reste plus de r�ception ouverte && disponible chez ce fournisseur...   ';
  NoCdeDispo = 'Il ne reste plus de commande ouverte && disponible chez ce fournisseur...   ';
  MaskOptVracTxtHint = '[ALT+M] Afficher / Masquer le d�tail du tarif && de la zone de d�finition des options';
  MaskOptVracUnidimHint = '[ALT+M] Afficher / Masquer la zone de d�finition des options';
  NoSelRecep = 'Il n''y a aucun bon de r�ception ouvert pour recevoir cette livraison...';
  NoSelCde = 'Il n''y a aucun bon de commande ouvert pour r�cevoir cette ligne de commande...';
  ValidRecepVrac = 'Confirmez l''enregistrement de cette ligne' + #13#10 +
    'Dans le bon N� : �0 du �1 ' + #13 + #10 +
    'Magasin : �2';

  ResaPasDecat = 'Impossible de poursuivre...'#13 + #10 +
    'Ce type d''article n''a aucune cat�gorie de location associ�e !...' + #13 + #10 +
    '(Ce param�trage est d�fini dans l''outil de gestion de la nomenclature)';

  CstLocEtatDetTit = 'Analyse d�taill�e du parc de location';
  CstLocEtatDetDisp = 'Dispo';
  CstLocEtatDetLoc = 'Loc';

  NoSupResaPaye = 'Vous ne pouvez pas supprimer une r�servation "Pr� Pay�e"';
  NoSupResaNlle = 'Vous ne pouvez pas supprimer une r�servation Web sans l''avoir pr�alablement "Regard�e"';
  NoSupResaAccepte = 'Vous ne pouvez pas supprimer une r�servation "Accept�e"';

  CapOrga = 'Organisme';
  CapStatLoc = 'Statut de location';
  CapCategLoc = 'Cat�gorie de location';
  CapTipArtLoc = 'Type d''article';
  CapTipSelToc = 'Op�. commerciales';

  SupTransLine = 'Confirmez la suppression de la ligne de transfert s�lectionn�e...  ';
  CstImpTckEqui = 'Impossible si le ticket n''est pas �quilibr�';

  NoCritDefined = 'Aucun domaine de s�lection n''est d�fini... ';
  LibPotentielTrans = 'Etude du potentiel de transfert Inter-Magasins ( Magasin d''origine �0 )';
  CapColumnStkMag = 'Stk Mag';
  NoTransTodo = 'Aucun transfert de mod�le � g�n�rer selon les crit�res que vous avez d�fini';
  LibNoDomaine = 'Vous n''avez pas d�fini de domaine d''�tude...   ';
  OneMagDestOblig = 'Il est imp�ratif de s�lectionner au moins 1 magasin de destination !';

  cstControleDoc = 'Contr�le' + #13 + #10 + 'Loc.';
  cstdetailcompte = 'D�tail' + #13 + #10 + 'compte';
  dcDETAILCOMPTE = 'DETAIL DU COMPTE';
  dcREGLEMENT = 'REGLEMENT';
  NotAcceptTx0 = 'Le taux de transfert ne peut pas �tre �gal � "0" !' + #13 + #10 +
    '( Rappel : un taux �gal � "1" �quivaut � pas de taux de transfert )';
  CapTauxTrans = 'Taux de transfert';
  LabTauxTrans = 'Taux de transfert � appliquer aux prochains mod�les transf�r�s';
  LibDetMatos = '�0 � pr�parer';

  CstLocEtatPer = 'Analyse de l''�tat p�riodique P�riodes : �0 au �1, �2 au �3,  �4 au �5';
  CstLocEtatPerTot = 'Tot';
  CstLocEtatPerPAge = '%age';
  CstLocEtatPerDispo = 'Disponible';
  CstLocEtatPerPeriode = '�0 au �1';

  CstLocPrevCA = 'CA Pr�visionnel ';
  RetourImpossiblePL = 'Retour Impossible pour ce mod�le, la fonction ''Paiement � la Ligne'' est en cours...';
  PLAnnul = 'Annul. Paiement Ligne';
  AnnulPl = 'Souhaitez-vous annuler le paiement � la ligne?';
  FracReliquat = 'Lignes restantes...';


  CstLocAnaCA = 'Analyse du CA Location P�riodes du �0 au �1 et du �2 au �3';
  DoPrintFracDev = 'Imprimer le rapport de transfert ?' + #13 + #10 +
    '( vivement conseill�... )';
  FracEncours = 'Transfert du devis en cours...' + #13 + #10 +
    'En fin de traitement ce devis sera cl�tur�';
  FracNoGener = 'Probl�me en cours de travail, le transfert n''a pas �t� effectu�...';

  PbFracDev = 'Probl�me : Document non g�n�r�...';
  ConfFracDev = 'Confirmez l''enregistrement du travail � effectuer...';

  LibFracDoc = 'Document';
  LibFracVerDev = 'Transfert vers Devis';
  LibFracVerBL = 'Transfert vers Bon de Livraison';
  LibFracVerFac = 'Transfert vers Facture';

  NonDevUsed = 'Modification ou Suppression impossibles car cet "Item de transfert" est d�j� utilis�';
  NonDevExist = 'Impossible : un "Item de transfert" porte d�j� ce nom !...';

  PasSelectPL = 'Fonction impossible, vous avez s�lectionn� aucune ligne...';
  cstPL = 'Paiement' + #13 + #10 + 'Ligne';
  HintClearSel = 'Tout D�s�lectionner...';
  ConfirmChangeResa = 'Confirmez-vous mettre l''�tat :' + #13 + #10 + #13 + #10 + '�0' + #13 + #10 + #13 + #10 +
    '� toutes les r�servations s�lectionn�es';

  SupResEncours = 'Suppression en cours...     ';
  LibResEdit = 'Modifier';
  SupprResaLoc = 'Confirmez la suppression de cette r�servation ...' + #13 + #10 +
    'ATTENTION : cette SUPPRESSION est IRREVERSIBLE !...';

  etiqclientCB = 'Souhaitez-vous imprimer une �tiquette code barre client?';
  locpasRV = 'Pas de retour � la vol�e sur les pseudos articles';
  dernierrendu = 'Dernier article rendu :';
  Retouralavolee = 'Retours � la vol�e';
  articlerendu = 'Saisir le code de l''article � rendre';

  NeedDetailResa = 'Impossible de valider une r�servation sans ligne de d�tail associ�e � un client !';
  NosupprLastIdent = 'Impossible de supprimer cette ligne de r�servation !' + #13 + #10 +
    'Une fiche de r�servation doit avoir au moins une ligne de d�tail associ�e � un client...';
  SupprLineIdentResa = 'Confirmez la suppression de la ligne de r�servation concernant la personne s�lectionn�e ...';
  RetModifResa = 'Attention : Vous ne voyez pas la fiche de r�servation que vous venez de cr�er ou modifier...' + #13 + #10 +
    'car elle ne correspond pas � vos crit�res de s�lection !';
  HintDbgIdentResa = '[Double Clic] Editer la ligne de r�servation s�lectionn�e... ';
  AbandonIdentResa = 'Confirmer l''abandon de toutes les modifications �ventuellement effectu�es dans cette ligne de r�servation ?...';
  NoResaToEdit = 'La ligne s�lectionn�e n''est pas une ligne de r�servation !... ';
  ResaPerdQuest = 'Vous allez perdre toutes les modifications effectu�es dans la liste des questions...' + #13 + #10 +
    'Confirmez cette d�cision SVP ....';
  NeedDataResa = 'Pour saisir la suite de votre fiche de r�servation vous devez d''abord d�finir le champ �0! ...';
  LibResNeo = 'Nouveau';

  BtnAssur = 'Garantie';
  EchPicco = 'Echange Piccolink' + #13 + #10 +
    'L''article �0 n''est pas pr�vu dans le pack.' + #13 + #10 +
    'Souhaitez-vous appliquer un suppl�ment?';

  NotNullPxBase = 'Le prix de base ne peut pas �tre � 0.00 ...' + #13 + #10 + 'lorsque certaines tailles ont d�j� un prix d�fini non nul !';
  ForcePxBase = 'La saisie du prix de base du tarif est obligatoire...   ';

  newremiseorg = 'Souhaitez-vous appliquer la remise li�e au nouvel organisme?';
  annulremorg = 'Souhaitez-vous annuler la remise?';
  ModifToutesLignes = 'Souhaitez-vous modifier toutes les lignes du bon de location?';
  Qsupplement = 'Attention, cet article ne correspond pas � la m�me offre commerciale. ' + #13 + #10 + 'Souhaitez-vous appliquer un suppl�ment?';
  TctOblig = 'La d�finition du type comptable est obligatoire...';
  CaptionDetailticket = 'D�tail du ticket';

  NeoGrptarLoc = 'Nouveau groupe de tarif';
  HintBtnSoveCmz = 'Sauver un mod�le de configuration des lignes';
  HintFullCollapse = 'Fermer la liste (n''afficher que son 1er niveau de d�tail)';
  HintAutoHeight = 'Activer / D�sactiver ... l''affichage complet du contenu des colonnes';

  ReafTransTarLoc = 'R�organisation des tarifs...      ';
  TransTarifLoc = 'Confirmez le transfert du tarif sur l''offre commeriale' + #13 + #10 + '�0';

  cstsupp = 'Suppl�-' + #13 + #10 + 'ment';
  AucunData = 'Aucun �0 d�fini';

  ErrNoDeletePerWeb = 'Vous ne pouvez pas supprimer les p�riodes import�es depuis la centrale...';

  LibToOrig = 'T.O d''Origine';
  LibToTwinnerNotInited = 'Le param�trage TO de votre centrale est incorrect...';

  BLNoTransThisDate = 'Aucun BL � transf�rer en facture sur cette p�riode....';

  chronoExiste = 'D�sol� mais le code chrono [�0] est d�j� associ� � un autre mod�le...';
  PBParamLocTO = 'Impossible de d�finir le param�trage T.O ... SVP pr�venez GINKOIA SA !';
  capLocTo = 'Location TO';
  ArtUtilInterne = 'Ce PSEUDO Article est utilis� en interne par Ginkoia et ne peut �tre ni modifi� ni supprim�...';

  CstEdEnch_Detmvt = ' D�tail des mouvements';
  CstEdEnch_recTVA = ' Synth�se du chiffre d''affaires';
  CstEdEnch_SyntMvt = ' Synth�se des mouvements';
  CstEdEnch_JouCai = ' Edition du journal de caisse';
  CstEdEnch_LstTke = ' Liste des tickets';
  CstEdEnch_JrnVte = ' Journal des ventes';
  CstEdEnch_CAHorDa = ' CA horaire par date';
  CstEdEnch_JrnLoc = ' Journal des locations';
  CstEdEnch_EtatLoc = ' Etat des locations en cours';
  CstEdEnch_CesAmor = ' Edition des cessions et des amortissements';
  CstEdEnch_HitVte = ' Hit parade des ventes';
  CstEdEnch_CaVend = ' CA par vendeur';
  CstEdEnch_CaHorVend = ' CA horaire par vendeur';
  CstEdEnch_HistCff = ' Historique du coffre';


  PasTarifOrganisme = 'Le tarif pour l''offre commerciale �0' + #13 + #10 +
    'et l''organisme �1 n''existe pas.' + #13 + #10 +
    'C''est le tarif magasin qui est appliqu�...';

  PasOrganisme = 'Pas d''organisme';

  CltArchive = 'On ne peut pas archiver un client poss�dant des membres';
  RegroupFin = 'Regroupement des bons de transfert termin�...    ';
  ArchivageFin = 'Archivage termin�...   ';
  LibRecap = 'R�capitulatif';
  RegroupEnCours = 'Regroupement des documents en cours...   ';
  ConfirmArchTrans = 'Confirmez l''archivage des bons de transfert s�lectionn�s ... ';
  DoingArchivage = 'Archivage des documents en cours ...    ';
  NoTransToRegroup = 'Il n''y a pas de regroupement de transfert � effectuer ... ';


  TransTailDevientNega = 'Attention : Magasin �0' + #13 + #10 + 'Le stock de cette Taille/Couleur est n�gatif';
  GesCouleursMagasin = '[F4] ou [Double clic] Pour d�finir la couleur � associer au magasin s�lectionn�';
  TransRapNoCb = 'Votre saisie ne correspond pas � un code � barre valide !... ';
  //****************************
  GlobEch = 'Attention, pour les articles �chang�s, v�rifiez la coh�rence' + #13 + #10 + 'des dates de sortie et de retour...';

  CstPortabPasLoc = 'Pas dans le parc';
  CstLocInvEtat = 'Ouverture Le �0';
  CstLocNew = 'L''ouverture d''un inventaire efface le pr�c�dent';
  CstLocDejaExistant = 'Le mod�le est d�j� saisi dans l''inventaire ...';
  CstLocInvBtEtat = 'Etat d''inventaire';
  CstLocInvBtSaisie = 'Saisie';
  CstLocInvOk = 'OK';
  CstLocInvPP = 'Pas dans le parc';
  CstLocInvLouecp = 'Lou� et compt�';
  CstLocInvPasCpt = 'Pas compt�';

  cstRegulGlob = 'Global' + #13 + #10 + '[Alt+F7]';
  CltStatFid = 'Fid�lit� du client �0';
  CltStatBlNonFac = 'Liste des BL non factur�s du client �0';
  CltStatCptClient = 'Compte du client �0';
  CltStatFacture = 'Liste des factures du client �0';
  CltStatDevis = 'Liste des devis du client �0';
  CltStatTicket = 'Liste des tickets du client �0';

  cstChoixSkiman = 'Skiman';
  CstDetailMvt = 'D�tail des mouvements Magasin �0 du �1 au �2';
  CstSynthMvt = 'Synth�se des mouvements Magasin �0 du �1 au �2';
  CstRecapTva = 'Synth�se du chiffre d''affaires Magasin �0 du �1 au �2';

  InfoRndOFF = 'Arrondis INACTIFS';
  InfoRndON = 'Arrondis ACTIFS';

  HintCreTarAlone = '[[Double clic] ou [F4] Cr�er un tarif pour l''offre commerciale s�lectionn�e...';
  HintDbgRap = '[Double clic]ou [F4] Pour ouvrir la fiche du tarif s�lectionn�';
  HintMajRap = '[F5] Activer / D�sactiver le mode M�J rapide';
  MessKitTarloc = 'Confirmez que vous d�sirez quitter le module de gestion' + #13 + #10 + 'des param�tres de location...';

  RoundOn = 'Arrondis' + #13 + #10 + 'ON';
  RoundOff = 'Arrondis' + #13 + #10 + 'OFF';

  LibProduit = 'Offre commerciale';

  LibTarifLocVide = 'Tarif de Location';

  Locpasbontype = 'Echange impossible avec ce type d''article...';
  NoTipCatActif = 'Il faut d�finir au moins un type article !...' + #13 + #10 +
    'pour pouvoir associer des cat�gories...';

  NoCatLocDispo = 'Plus aucune cat�gorie disponible pour les types d''articles d�finis...';

  PrepareAnalVte = 'Recherche des articles vendus sur la p�riode...';
  // 3 d�plac�es
  OrdreRay = 'Position du Rayon';
  OrdreFam = 'Position de la Famille';
  OrdreSF = 'Position de la S/Famille';

  CategInDyna = 'Impossible de supprimer ce type de cat�gorie, car vous venez de rajouter une cat�gorie qui le r�f�rence...';
  //************
  LibFicheSecond = 'Fiche secondaire';
  Affecteorpheline = 'Confirmez l''association de la fiche secondaire s�lectionn�e' + #13 + #10 + '� la fiche de location �0';

  RetfNoDateRglt = 'Vous n''avez pas saisi la date de r�glement de l''avoir...' + #13 + #10 +
    'Faut-il n�anmoins cl�turer ce bon de retour ?';

  ReftDocNotClot = '�0 documents de votre s�lection n''ont pas pu �tre archiv�s car ils n''�taient pas cl�tur�s ...';
  ImpNoDoc = 'Aucun document � imprimer... ';
  ImpDocVide = 'Aucune ligne � imprimer dans ce document !...';
  RetFOkArchive = 'Confirmez l''archivage du document affich�...';
  ReTFOkCloture = 'Confirmez la cl�ture du bon de Retour affich�... ' + #13 + #10 +
    '  ATTENTION : ce document ne sera plus modifiable ! ';

  RetNoArchive = 'Seuls les retours cl�tur�s peuvent �tre archiv�s !';
  RetfTitreListe = '  Liste des retours fournisseurs';
  RetfLinexist = 'Il existe d�j� une ligne de retour pour ce mod�le ! ' + #13 + #10 +
    'Confirmez que vous d�sirez en ajouter une nouvelle...';
  HintGenEnEdit = '[F12] Enregistrer [ECHAP] Abandonner';
  RetfEdit = '[Suppr] Supprimer la ligne s�lectionn�e';
  RetfDelete = 'Confirmez la suppression du bon de retour affich� ...';
  RetFSupLin = 'Confirmez la suppression de la ligne de retour s�lectionn�e...';
  RetFNonModif = 'Un bon de retour cl�tur� ne peut �tre ni modifi� ni supprim� ... ';

  // *************************************

  QuitPicco = 'Attention, si vous fermer cette application, les Piccolink' + #13 + #10 +
    'ne pourront plus fonctionner!' + #13 + #10 +
    'Confirmez-vous la fermeture ?';

  LibLabAnnulDJ = 'Annulation du retour avant �0';
  LibLabDJ = 'Retour avant �0';
  LibFormDtRetour = 'si retour avant �0';

  CdeRechChronoLoc = 'Le code chrono recherch�... ' + #13 + #10 +
    'est celui d''une fiche secondaire de cet article...';

  CdeRechVide = 'Aucun article trouv�... ' + #13 + #10 +
    '( Si cet article existe il n''est pas accessible ici... )';

  LocartArchivable = 'Article archiv� si coch�';
  LocartNONArchivable = 'Article non archivable';

  AnnulTckTPE = 'Attention une transaction avec le TPE a d�j� �t� enregistr�e' + #10 + #13 +
    'pour ce ticket, il faudra l''annuler manuellement.';
  PasAnnulTPE = 'Attention, la transaction avec le TPE n''est pas annul�e' + #13 + #13 +
    'automatiquement, il faudra effectuer cette op�ration  manuellement';
  PasNegatifTPE = 'Attention pas de transaction en n�gatif avec le TPE,' + #10 + #13 +
    'le ticket est n�anmoins valid�.';
  TPEDejaEnreg = 'Modification/Suppression impossible, la transaction avec le TPE est d�j� enregistr�e...';

  ValidDevis = 'Enregistrement du devis impossible, vous avez des op�rations' + #13 + #10 + 'de caisse en cours...';
  ValidTicket = 'Validation du ticket impossible,' + #13 + #10 + 'la somme des modes de paiement est inf�rieure au montant du ticket...';

  cstFinTicket = 'Valid' + #13 + #10 + '[F12]';
  cstDevisLoc = 'Devis' + #13 + #10 + '[F5]';

  DevisLocInserer = 'Veuillez ins�rer le devis � imprimer';
  DevisLocSuiteInserer = 'Veuillez ins�rer la suite du devis � imprimer';

  FactLocInserer = 'Veuillez ins�rer la facture � imprimer';
  FactLocSuiteInserer = 'Veuillez ins�rer la suite de la facture � imprimer';

  ConfSuiteProblemeDevis = 'Souhaitez-vous imprimer le devis de location?';
  ConfSuiteProblemeFact = 'Souhaitez-vous imprimer la facture de location?';

  CshHistoCfrCOFPl = 'Versement coffre : �0';
  CshHistoCfrCOFMo = 'Vers le coffre : �0';
  CshHistoCfrBANPl = 'Versement Banque : �0';
  CshHistoCfrBANMo = 'Vers la Banque : �0';
  CshHistoCfrSES = 'Session : �0';
  CstTpeAttServ = 'Attente de r�ponses du serveur';
  CstTpeEnvDemServ = 'Envoie de la demande au serveur ';
  CstTpeErrConServ = 'Le serveur n''est pas lanc�...   Tentative dans �0 s';
  CstTpeUtilise = 'Le TPE est actuellement utilis� Patienter...   Reconnexion dans �0 s';
  CstTpeServTraite = 'Le TPE prend en charge la demande : Patienter ... ';
  CstTpeServEchoue = 'La transaction a �chou�e ';
  CstTpeServRefu = 'La transaction est refus�e par le TPE ';
  CstTpeTimeOut = 'Le TPE ne r�pond pas dans les temps ';
  CstTpeOk = 'Transaction accept�e ';
  CstTpeVerif = 'V�rification de la pr�sence du TPE';
  CstTpeAttValid = 'Attente validation de l''action par le TPE';
  CstTpeLectureCarte = 'Ins�rer la carte, faire le code et valider la transaction';
  CstTpeLectureCheq = 'Ins�rer le ch�que et valider la transaction';
  CstTPERecRep = 'Reception de la r�ponses du TPE';
  CstTpeLecRep = 'Lecture de la r�ponses du TPE';
  CstTpeAttFinCom = 'Attente de la fin de communication';
  CstTpeRequeteEchoue = 'Requete �chou�';
  CstTpeTransactionEchoue = 'Transaction �chou�';
  CstTPETrfInf = 'Demande Informations';
  CstTPETrfChkSum = 'Calcule CheckSum';
  CstTPETrfAcce = 'Acc�s TPE';
  CstTPETrfDecon = 'D�connect�';
  CstTPETrfFermPort = 'Fermeture du port';
  CstTPETrfOuvPort = 'Ouverture du port';
  CstTPETrfEnvMess = 'Envoie du message';
  CstTPETrfRecClot = 'R�ception Cl�ture';
  CstTPETrfRecChk = 'R�ception CheckSum';
  CstTPETrfRecMess = 'R�ception Message';
  CstTPETrfRecStx = 'R�ception STX';
  CstTPETrfRecENQ = 'R�ception ENQ';
  CstTPETrfRecAck = 'R�ception ACK/NACK';
  CstTPETrfTimeOut = 'TIME OUT';
  CstTPETrfDecRep = 'D�code r�ponse TPE';
  CstTPETrfTpePres = 'Demande Si TPE pr�sent ';
  CstTPETrfTpeUtil = 'Demande Si Utilisation TPE ';
  CstTPETrfTpeEtat = 'Demande Etat TPE ';
  CstTPETrfConnexion = 'Connexion de ';
  CstOui = 'OUI';
  CstNON = 'NON';
  CstCessionEtAmmortissement = 'Amortissements et Cessions au �0';
  ArchiveTrans = 'Confirmez l''archivage (ou d�sarchivage) des transferts s�lectionn�s...' + #13 + #10 +
    '( L''�tat d''archivage des transferts s�lectionn�s sera invers� )';
  TransArchNoVisible = 'Attention : les transferts archiv�s sont retir�s de la liste...  ';
  RefreshListeTrans = 'R�actualisation de la liste des transferts...  ';

  CstInvTitreImpRecompt = ' Liste des mod�les � recompter : inventaire num �0, �1';

  LibRoundTarLoc = 'Recalcul automatique du tarif de location';
  // *****************
  EpurTraining = 'Confirmez-vous la suppression du contenu du rapport du mode training?';
  Loctraining = 'Impossible,  vous avez un bon de location en cours...';

  LocDocArt = 'Art.';
  LocDocClient = 'Client';
  LocDocCateg = 'Categorie';
  LocDocFix = 'Fix.';
  ChangeNom = 'Attention, vous venez de modifier le nom d''un client r�f�renc�.' + #13 + #10 +
    'Confirmez-vous le changement du nom?';
  LocpassupligneEch = 'Suppression d''une ligne suivant un �change impossible...';
  locdocVte = 'TOTAL VENTES ET SERVICES';
  locdocPaye = 'PAYE CE JOUR';
  locdoctva = 'Dont TVA';
  locDocTotal = 'TOTAL LOCATION';
  LocdocDJP = 'TOTAL DEJA PAYE';
  LocdocRap = 'RESTE A PAYER';
  locdevis = 'Devis numero :';
  locnon = 'Non';
  LocDocGarantie = 'Gar.';
  LocDocPrix = 'Prix';
  LocDocNBJ = 'D.';
  LocDocSortie = 'Sortie';
  LocDocRetour = 'Retour';
  LocCode = 'Code';
  ValidConso = 'Confirmez l''enregistrement des consommations diverses' + #13 + #10 +
    'Type  : �0' + #13 + #10 +
    'Motif : �1';

  locpastarifbis = 'Attention vous n''avez pas de tarif d�fini pour cette offre � cette p�riode...';
  LocDedegress = 'Souhaitez-vous continuer le tarif d�gressif?';
  LocmemeArticle = 'Attention vous ne pouvez pas relouer le m�me article...';
  locPasEnLoc = 'Cet article n''est pas en location...';
  PasBonDoc = 'Cet article ne fait pas parti du bon de location en cours';
  LocPasEnCoursdeLoc = 'Cet article n''est pas en cours de location...';

  CstMessChargeLoc = 'Chargement du journal des locations...';
  CstJLocDateLib = 'Journal des locations du �0 au �1  -  ';
  CstJLocSess = 'Journal des locations, Poste �0 - Session No �1';
  CstEtatARTLoc = 'En Location';
  CstEtatARTRet = 'Retour';
  CstEtatARTEch = 'Echange';
  CstMessChargeLocPark = 'Chargement de l''�tat des locations...';
  CstTitreLocPark = 'Etat des locations en cours';

  locfacture = 'Facture n�';
  locBL = 'Bon de location n�';

  DelOrpha = 'Confirmez la suppression de la fiche orpheline' + #13 + #10 + '�0';
  CapSfOrpha = 'Sous-Fiche Orpheline';
  DefConsoLoc = 'Mise en location...';
  CapFichePrinLoc = 'Fiches Principales';
  CapFicheSecLoc = 'Fiches Secondaires orphelines';
  LibTransEnLoc = 'Codes Chronos des �0 de location g�n�r�es : �1';
  F3Sel = '[F3] S�lectionner [MAJ F3] D�-S�lectionner';
  PasEnLoc = 'Cet article n''est pas actuellement en location';
  LoueAClt = 'Lou� au client';
  ConfSupCodacces = 'Attention : c''est ce code d''acc�s qui �tait imprim� sur vos �tiquettes !' + #13 + #10 +
    'Confirmez que vous d�sirez effectivement le supprimer...';

  // RV 06-10-2003
  CstNbrFacLoc = 'Nombre de factures';
  CstCALoc = 'CHIFFRE D''AFFAIRES LOCATION';
  CstCAVente = 'CHIFFRE D''AFFAIRES  VENTE';

  SupTck = 'Confirmez-vous l''abandon du ticket en cours?';
  SupLoc = 'Confirmez-vous l''abandon du bon de location en cours?';

  SupTckLoc = 'Attention, l''abandon du ticket en cours, abandonnera' + #13 + #10 +
    'aussi le bon de location en cours.' + #13 + #10 +
    'Confrimez-vous l''abandon?';
  SupLocTck = 'Attention,l''abandon du bon de location en cours, abandonnera' + #13 + #10 +
    'aussi le ticket de vente en cours.' + #13 + #10 +
    'Confrimez-vous l''abandon?';

  LocValidDoc = 'Validation du bon de location ?';
  Locpassuplignepack = 'Suppression d''une ligne de pack impossible, il faut supprimer l''ent�te.';
  LocSupLCPack = 'Confirmez-vous la suppression compl�te du pack s�lectionn�?';

  HintBtnLoadCmz = 'Charger une configuration sauvegard�e sur le disque...';

  btnSortie = 'Sorties';
  btnRetour = 'Retours';
  btnRien = 'Rien';
  btnTout = 'Tout';

  RecapVente = 'Vente';
  RecapCompte = 'Compte Client';
  RecapLoc = 'Location';

  TotLocation = 'Total des locations';
  LocPastarif = 'Attention, pas de tarif d�fini pour ce produit... ';
  LocPasRetourPck = 'Attention, retour impossible sur une ent�te ou un pied de pack...';
  LocPasAnnulRetourPck = 'Attention, annulation de retour impossible sur une ent�te ou un pied de pack...';
  cstpack = 'Pack' + #13 + #10 + 'F8';
  cstregroup = 'Classer';

  OdPerHint = 'S�lection : [Clic Gauche] D�but P�riode [Clic Droit] Fin P�riode  - Clic Actif sur  : Jour, Semaine, Mois';
  OdPerHintYear = ' et Ann�e';
  LabDureePeriode = '�0 Jour(s)';

  HeadProdRay = 'Offres commerciales du rayon';
  HeadProdFam = 'Offres commerciales de la famille';
  HeadProdSF = 'Offres commerciales de la S/Famille';

  HeadCatLocRay = 'Cat�gories du rayon';
  HeadCatLocFam = 'Cat�gories de la famille';
  HeadCatLocSF = 'Cat�gories de la S/Famille';

  StandardSupprLigne = 'Confirmez la suppression de l''enregistrement s�lectionn�';
  NoDeleteId0 = 'Cet enregistrement de base ne peut jamais �tre supprim�...';
  MakeOrphelines = '( Les sous-fiches associ�es ne seront pas supprim�es mais rendues "orphelines"...)';
  DbleClicAffSF = '[Double Clic] Voir la sous-fiche s�lectionn�e';
  Rajoutorpheline = 'Confirmez le rattachement de la sous-fiche' + #13 + #10 + '�0' + #13 + #10 +
    '� la fiche en cours...';
  InsGenerik = 'Cr�er un nouvel �l�ment : �0';
  DelGenerik = 'Supprimer l''�l�ment s�lectionn� : �0';
  EditGenerik = 'Modifier l''�l�ment s�lectionn� : �0';
  LabSousFiche = 'Sous-Fiche';
  AccessCodeCB = 'le code d''acc�s';
  DelCode = '[SUPPR]';
  InsCode = '[INS]';
  NodelCBInterne = 'Ce code est un code � barres interne g�n�r� par le programme !...' + #13 + #10 +
    'On ne peut pas le supprimer ... ( ''est notamment celui qui apparait sur les �tiquettes )';
  CodeLocUnik = 'Un code d''acc�s doit �tre UNIQUE !' + #13 + #10 +
    'Le code [�0] a d�j� �t� utilis�... ';
  HintPseudoLoc = '[INS] Cr�er un pseudo [Double Clic] Modifier [SUPPR] Supprimer ';
  NoChangeChrono = 'Le code chrono de ce mod�le ne peut pas �tre modifi� !...';
  SelectaTaille = 'S�lectionnez une taille ...';
  NoItemClasse = 'Il n''y a aucun �0 de d�fini dans votre param�trage...';
  NoChangeBecauseTransfert = 'Non modifiable pour les articles transf�r�s depuis la vente';
  ArriveDepuisConso = 'On ne peut pas supprimer un article transf�r� depuis la vente...';
  ClasLoc = 'Articles de Location';

  IntegCatCom = 'Vous ne pouvez pas retirer ce type d''article car il est utilis� par d''autres �l�ments li�s � cette Sous-Famille';
  CanInsForAlone = '[Double clic] ou [F4] Cr�e le tarif de l''offre commerciale s�lectionn�e...';
  TarLocExist = 'Impossible d''enregistrer :' + #13 + #10 + '�0 a d�j� un tarif d�fini avec ces caract�ristiques' + #13 + #10 +
    '(Tarif magasin - Organisme - P�riode)';

  LabTarifLoc = 'Tarif de location';
  NoNameperiode = 'Il faut un nom � votre p�riode !... ';

  NoNameMultiTar = 'Le nom du tarif magasin est obligatoire';
  LocProdNomOblig = 'Vous n''avez pas donn� de nom � votre offre commerciale !...';

  GenerikNomOblig = 'La saisie de �0 est obligatoire';
  ConfDelDegress = 'Confirmez la suppression du mod�le de d�gressivit� du tarif de location' + #13 + #10 + '�0';
  ConfDelTarif = 'Confirmez la suppression du tarif de location' + #13 + #10 + '�0';

  LabModelDegress = 'Mod�le de D�gressivit� de tarif';
  InsF2DelF12 = '[INS] Cr�er  [F2] Editer  [SUPPR] Supprimer  [F12] Enregistrer  [Echap] Abandonner';
  LocNomDegressOblig = 'Il faut un nom � votre mod�le de d�gressivit� !... ';

  ConfDelAssCat = 'Confirmez que vous d�sirez retirer la cat�gorie �0 de cette S/Famille...';
  InsDelLocCatHint = '[INS] ou [Double Clic] Ajouter une cat�gorie  [SUPPR] Retire la cat�gorie point�e';

  NoTipCatLocDispo = 'Tous les types d''articles disponibles sont d�j� s�lectionn�s...' + #13 + #10 +
    '( ou il n''y en a aucun de possible )';
  NoCategLocDispo = 'Toutes les cat�gories disponibles sont d�j� s�lectionn�es...' + #13 + #10 +
    '( ou il n''y en a aucune de possible )';
  LocNoChangeTipCat = 'Impossible de changer le type d''article de cette cat�gorie car il y des offres commerciales d�finies...';

  DoubleClicSel = '[Double clic] ou [Ok] S�lectionne l''�l�ment de la ligne s�lectionn�e...';
  ConfDelCat = 'Confirmez la suppression de cette cat�gorie';
  NoTipCateg = 'La d�finition d''un type d''article est obligatoire ...';
  NoCatGtf = 'La d�finition d''une Grille de tailles est obligatoire ...';
  LabElement = 'El�ment';
  DElTipCatCom = 'Confirmez que ce type d''article n''est plus � associer � cette sous-famille...';
  HintPrintNk = 'Edition - Export de la nomenclature';
  HintPrintNkLoc = 'Edition - Export de la nomenclature de location';
  NoProdLoc = 'Aucune offre commerciale d�finie';
  ConfDelProdLoc = 'Confirmez la suppression de l''offre commerciale' + #13 + #10 + '�0';
  LocProdNoSuppr = 'Suppression IMPOSSIBLE : offre commerciale r�f�renc�e...';

  IsPxvTTC = 'Prix de vente TTC';
  IsPxvHT = 'Prix de vente HT';
  //
  AfftarBase = 'Confirmez l''affichage du tarif de vente g�n�ral...     ' + #13 + #10 +
    '( Ce tarif concernant tous vos mod�les r�f�renc�s, son affichage peut �tre assez long )     ';
  MajTarFichart = 'Le tarif d''ACHAT est diff�rent de celui enregistr� dans la fiche mod�le...    ' + #13 + #10 +
    'Faut-il mettre � jour le tarif d''ACHAT de la fiche mod�le ?' + #13 + #10 + #13 + #10 +
    '( REMARQUE : LE TARIF DE VENTE DU MAGASIN EST TOUJOURS MIS A JOUR !... )';

  AffecteTarVente = 'Confirmez que le tarif : �0' + #13 + #10 +
    'est � appliquer dans le magasin : �1';
  DeleteTarVente = 'Confirmez la suppression du tarif de vente "�0"' + #13 + #10 +
    '( ATTENTION : cette op�ration supprime tous les prix d�finis sur ce tarif )   ';
  DeleteTarVente2 = 'La suppression d''un tarif de vente est irr�versible... ' + #13 + #10 +
    'Faut-il continuer ? ... ';
  NoTarVte = 'Aucun tarif de vente s�lectionn� !';
  InsF2Del = '[INS] Cr�er  [F2] Editer  [SUPPR] Supprimer';
  InsTarvte = 'Cr�er un nouveau tarif de vente';
  DelTarvte = 'Supprimer le tarif de vente s�lectionn�';
  EditTarVte = 'Modifier le nom du tarif de vente s�lectionn�';

  // rev 16 05 ***************************************************
  LocPackArticlepasbontype = 'Impossible ce pack n''accepte le type d''article (�0)';
  LocPackCategPasBon = 'Attention, la cat�gorie de cet article n''est pas r�f�renc�e dans le pack.' + #13 + #10 +
    'Souhaitez-vous tout de m�me accepter la location?';
  LocPackDejaSaisi = 'Impossible, vous avez d�j� saisi un article pour le type d''article : �0';

  cstSupLigneLoc = 'Sup Ligne';
  Locparamloc = 'Le param�trage des heures de location est incomplet...';
  LocPasClient = 'Location impossible, vous n''avez pas de client en cours...';
  LocAutreClient = 'Impossible de changer de client, vous avez un bon de location en cours...';

  loclib0 = 'Veille';
  loclib1 = 'Matin';
  loclib2 = 'Apr�s midi';
  loclib3 = 'Lendemain';

  CstPortabNonTrouve = 'L''article n''existe pas';
  CstPortabImprecis = 'R�f�rence impr�cise';
  CstPortabArchive = 'L''article est archiv�';

  CstPortableVide = 'Int�gration des articles termin�e';
  CstPourlevidage = 'Veuillez enregistrer vos modifications avant de vider le portable';
  CstDebutVidage = 'Vidage du portable en cours...';
  CstErrCom = 'Le Port de communication n''est pas valide';

  //Bruno 05/05/2003

  LocHeureRetour = 'Impossible pour une location � la journ�e, il est plus de �0 ';
  LocHeureRetourBis = 'Attention le retour avant �0 est annul�...';

  LocDejaEnLoc = 'Attention cet article est d�j� en location...';
  LocPasSorti = 'Impossible, cet article n''est pas en cours de location...';
  LocPasLoc = 'Impossible, vous n''avez pas de location en cours...';
  LocRetourTotal = 'Confirmez-vous le retour de toutes les locations en cours?';
  LocDejaPresent = 'Attention cet article est d�j� pr�sent dans le bon de location en cours...';
  locpassupligne = 'Impossible, cet article est d�j� enregistr�...';
  LocSupLC = 'Confirmez-vous la suppression de la location de cet article?';

  CstVersEncAEcheance = 'Versement des encaissements arriv�s � �ch�ance';
  CstPasencaissementAtt = 'Aucun encaissement en attente';

  CstInitInventaire = 'Initialisation du module inventaire en cours...';

  SupprCb = 'Confirmez la suppression du Code � Barres s�lectionn�';
  ExportCPT = 'Export comptable';
  ErrExportCpt = 'Liste des comptes en erreur';

  PasEnEuro = 'Cette partie du programme n''est accessible' + #13 + #10 +
    'que lorsque la devise active est la devise de travail d�finie...   ';
  CstCptFacture = 'Toutes les factures du �0 au �1' + #13 + #10 +
    'vont �tre cl�tur�es !... Faut-il continuer ?';
  NoGoodDevise = 'IMPOSSIBLE d''acc�der � votre demande' + #13 + #10 +
    'car la devise en cours n''est pas la devise de r�f�rence de vos donn�es...   ';
  HintBtnPost = '[F12] Valider les modifications effectu�es';
  CstHistoCoffre = 'Historique de �0 - �1 : du �2 au �3';
  CstCoffreDebut = 'Solde pour le �0';
  CstgestCoffre = 'Mouvement(s) du coffre';
  HintChpBtn = '[F4 ou Double Clic] Ouvre la liste des choix possibles...';
  CoffreChangeTab = 'Pour changer d''onglet il est d''abord n�cessaire d''avoir enregistr� les saisies en cours...';
  CptCltVide = 'Aucun compte client � afficher en rapport avec votre s�lection...';
  LabVisuCptClt = 'Comptes clients au �0';
  CstCaVendHeureDateLib = 'Caisse : CA horaire par vendeur du �0 au �1  -  ';
  CstCaJourHeureDateLib = 'Caisse : CA horaire par jour du �0 au �1  -  ';

  VendeurOblig = 'Il faut cocher au moins un vendeur !...' + #13 + #10 +
    '( Sans vendeur d�fini il ne peut pas y avoir de r�ponse � votre demande )';

  VendIndefini = 'Vendeur non d�fini';
  LabTKl = 'Ticket';
  LTDateLib = 'Liste des Tickets du �0 au �1  -  ';
  DetailTKL = '[Double clic] D�tail du ticket point�';
  MessChargeLT = 'Chargement de la liste des tickets...';
  MessChargeCaVend = 'Chargement du CA par vendeur...';

  // RV le 28-04-2003
  CstPortableOk = 'Le portable s''est bien vid�, vous pouvez l''utiliser';

  CstInvAbandon = 'Abandonner la fin de comptage.';

  CstInvVide = 'actuellement, Vous n''avez aucun mod�le dans l''inventaire';
  CstInvPlein = 'actuellement, Vous avez %s mod�les dans l''inventaire';

  MessChargeJcaisse = 'Construction du journal de caisse...' + #13 + #10 + 'Merci de patienter le temps de sa mise en place...';
  ChxPosteOblig = 'Il faut cocher au moins un Poste !...' + #13 + #10 +
    '( Sans Poste d�fini il ne peut pas y avoir de r�ponse � votre demande )';

  MessChargeNN1 = 'Chargement de l''analyse N / N-1...';
  HintPreco = '[F5] Ins�rer le mod�le de la ligne en cours dans le bloc note de pr�-commande...';
  HintAffChx = '[F7] Afficher / Masquer la zone de s�lection...';
  HintBrnPreco = '[F5] Ins�rer le mod�le de la ligne en cours dans le bloc note de pr�-commande...';
  HintBtnUndo = 'Remettre la configuration d''affichage par d�faut';
  DoubleArt = '[Double clic] Ouvre la fiche du mod�le point�...';
  SelPeriode = '[Double Clic] S�lection de la p�riode';
  TipPumpOblig = 'Vous n''avez s�lectionn� aucun mode de calcul de la marge !... ';
  TipVteOblig = 'Vous n''avez s�lectionn� aucun type de vente !... ';
  PanMessFiltre = 'Attention : si vous ne ciblez pas votre demande sur une s�lection pr�cise la construction de cette �tude peut prendre plusieurs minutes ';
  RalMagOblig = 'Il faut cocher au moins un magasin !...' + #13 + #10 +
    '( Sans magasin d�fini il ne peut pas y avoir de r�ponse � votre demande )';
  RalDateLivOblig = 'Date de livraison obligatoire.';
  RalFournisseurOblig = 'Il faut s�lectionner au moins un fournisseur !...' + #13 + #10 +
    '( Sans fournisseur d�fini il ne peut pas y avoir de r�ponse � votre demande )';
  RalEtatVide = 'L''�tat correspondant � votre s�lection est vide ...';
  //   rv

  EtatVide = 'Aucune r�ponse pour l''�tat que vous avez demand� !' + #13#10 + 'Liste vide...';
  LocNkReserved = 'Suppression impossible : cet �l�ment de la nomenclature ne peut pas �tre supprim� !...';
  YaProdDedans = 'Suppression impossible !... Il y a des offres commerciales r�f�renc�es...';
  NKCapGesLoc = ' Gestion de la nomenclature de location...';
  NkLocCapListart = ' Nomenclature Loc & liste des offres commerciales...';
  NkLocCapNormal = 'Nomenclature de location';
  // rv 16/04/2002
  CstSaisieCodeBarre = 'Pour pouvoir saisir des codes barres ,' + #13 + #10 +
    'il faut d''abord valider [F12] ou abandonner la fiche en cours de saisie ';
  // Bruno 10/04/2003
  cstFichePrinc = 'Fiche' + #13 + #10 + '[F10]';
  cstFicheDivers = 'Divers' + #13 + #10 + '[F11]';
  cstFicheStation = 'Station' + #13 + #10 + '[F12]';


  TipConsoOblig = 'Vous n''avez s�lectionn� aucun type de consommation !...';
  NeedValidConso = 'Pour changer d''onglet il est d''abord n�cessaire d''enregistrer ou abandonner la consommation en cours de saisie...';
  ArtDoArchive = 'Mod�le(s) archiv�(s)';
  ArtDejaArchive = 'Mod�le(s) d�j� archiv�(s)';
  ArtCdeArchive = 'Mod�le(s) non archiv�(s) car pr�sent(s) en commande non cl�tur�e';
  ArtStkArchive = 'Mod�le(s) non archiv�(s) car en stock';
  CstARCYaDesCom = 'Mod�le(s) non archiv�(s) car pr�sent(s) en commande non cl�tur�e';
  CstARCYaDesDev = 'Mod�le(s) non archiv�(s) car pr�sent(s) en devis non cl�tur�';
  CstArchivePasListe = 'Aucun Mod�le ne peut �tre archiv� dans votre s�lection';
  CstARCYaDuStock = 'Mod�le(s) non archiv�(s) car en stock';
  CstARCWeb = 'Mod�le(s) non archiv�(s) car activ� sur le web';
  // 11 lignes d�plac�es

  // RV 09/04/2003
  ChangeConfigCour = 'Confirmez le changement de NIVEAU UTILISATEUR du Magasin...  ' + #13 + #10 +
    'Niveau actuel : �0' + #13 + #10 + 'Nouveau niveau : �1';
  NomNiveauOblig = 'Le niveau d''activation du module est obligatoire';
  ConfirmDelModule = 'Confrmez la suppression du contr�le de module [ �0 ]';
  NomModuleOblig = 'Le nom du module est obligatoire...   ';

  // Bruno 04/04/2003

  cstProduit = 'Offre';
  cstEchange = 'Echange' + #13 + #10 + 'F12';
  cstRetourProduit = 'Retour' + #13 + #10 + 'F10';
  cstRetourTotal = 'Retour' + #13 + #10 + 'Total F9';
  cstRetourVolee = 'Retour' + #13 + #10 + 'Volee F11';
  cstDetailProduit = 'D�tail' + #13 + #10 + 'F7';
  cstAbandon = 'Abandon' + #13 + #10 + 'Loc.';

  Location = 'Location';

  // RV 02-04-2003
  GenereTMPduFiltre = 'Recherche des mod�les correspondant � vos crit�res de s�lection...';
  TabNoNegaValue = 'La saisie de quantit�s n�gatives n''est pas autoris�e...';
  TabToBigValue = 'Vous avez d� saisir un code � barre!... La quantit� maximum autoris�e est de "99 999"   ';

  ValidTransRap = 'Enregistrer la totalit� des transferts rapides saisis ?...' + #13 + #10 +
    '( Les lignes avec une quantit� � "0" ne seront pas prises en compte )';
  AbandonTransRap = 'Abandonner la totalit� des transferts rapides saisis ?...';
  RvSupprLigne = 'Confirmez la suppression de la ligne s�lectionn�e...';

  // RV 18/03/2003
  ReorgAff = 'R�organisation de l''affichage...   ';
  // ****************
  CsDevis = 'Devis';
  CsRal = 'Gestion des R.�.L';

  AffectCollec = 'A la validation finale tous les mod�les ajout�s dans le document seront associ�s � la collection : �0';
  SupprColDef = 'Confirmez qu''� la validation finale' + #13 + #10 +
    'aucune collection ne doit �tre associ�e aux mod�les ajout�s dans le document!...';
  //---------------
  CstCumulEnc = 'Cumul';
  CstClientDivers = 'Divers : (Client Non identifi�)';

  ExpartArtTraites = 'Nombre d''informations trait�es : �0     ';
  // 1 ligne d�plac�e
  ProcessArch = 'Confirmez l''archivage des mod�les list�s...';
  // RV 02/03/2003
  HintBtnGroupart = 'Activer / D�sactiver le groupement sur les mod�les';
  DefCritSel = 'D�finissez les crit�res d''�tude de l''analyse...';
  RalDoArch = 'Confirmez l''archivage demand�...';
  CarnetCdeNoExe = 'Lorsqu''aucun exercice commercial n''est d�fini,' + #13 + #10 +
    'seules les commandes NON CLOTUREES sont prises en compte...' + #13 + #10 + #13 + #10 +
    'Souhaitez-vous continuer ?...';

  TousFourn = 'Tous fournisseurs';
  RalFOURNOblig = 'Il est imp�ratif de d�finir quels fournisseurs �tudier !...';

  cstQte = 'QTE +1';
  cstSousTotal = 'S/ TOTAL';
  cstSupLigne = 'Sup Ligne' + #13 + #10 + 'courante';
  cstPseudo = 'Pseudo';
  cstSupTicket = 'Abandon' + #13 + #10 + 'TICKET';
  cstAttente = 'Attente';
  cstReglement = 'R�gle' + #13 + #10 + 'ment [F7]';
  cstAcompte = 'Acompte';
  cstRembourser = 'Rembour' + #13 + #10 + 'ser [F9]';
  cstValid = 'Valid';
  cstAnnul = 'Annul';
  cstCf = 'Carte' + #13 + #10 + 'Fidelit�';
  cstEtiqCB = 'Etiquette' + #13 + #10 + 'C.B.';
  cstReajust = 'R�ajust' + #13 + #10 + 'Compte';
  cspBtnEspeces = 'Esp�ces';
  cspBtnCheques = 'Ch�ques';
  cspBtnCB = 'CB';
  cspBAI = 'B.Achat' + #13 + #10 + 'Interne';
  cspBAE = 'B.Achat' + #13 + #10 + 'Ext.';
  cspCPTCLI = 'Compte' + #13 + #10 + 'Client';
  cspResteDu = 'Reste' + #13 + #10 + 'du';
  cspAC = 'Autres' + #13 + #10 + 'cartes';
  cspVirement = 'Virement';
  cspCV = 'Ch�ques' + #13 + #10 + 'Vacances';
  cspRegul = 'R�gul.' + #13 + #10 + 'Caisse';
  cspDepense = 'D�pense';
  cspReedition = 'R��dition' + #13 + #10 + 'TICKET';
  cspAnnulTCK = 'Annul.' + #13 + #10 + 'TICKET';
  cspTC = 'Ouvre' + #13 + #10 + 'tiroir';
  cspBL = 'Transfert' + #13 + #10 + 'B.L.';
  cspCD = 'Ch�que' + #13 + #10 + 'Diff [F11]';
  cspAmex = ' AMEX' + #13 + #10 + ' [F10]';
  cspPNF = '   PNF';
  cspCCI = 'Carte Kdo' + #13 + #10 + 'Intersport';
  cspCadhoc = ' CADHOC';
  cspAurore = ' CARTE' + #13 + #10 + 'AURORE';
  cspBF = '   Bon' + #13 + #10 + '   FID';
  cspTG = '   TIR' + #13 + #10 + 'GROUPE';
  cspRemChq = 'Rbt' + #13 + #10 + 'Ch�que';
  cspHAVAS = 'HAVAS';
  cspBonAccor = 'BON' + #13 + #10 + 'ACCOR';
  cspBEST = 'BEST';
  cspED = 'ELEGANCE ET' + #13 + #10 + 'DISTINCTION';
  cspCU = 'COMPLIMENT UNIVERSEL';
  cspSP = 'SHOPPING' + #13 + #10 + 'PASS';
  cspTI = 'TICKET' + #13 + #10 + 'INFINI';
  cspTH = 'TICKET' + #13 + #10 + 'HORIZON';
  cspKDO = 'KADEOS';
  cspBonKy = 'BON' + #13 + #10 + 'KYRIELLES';
  cspCC = 'CADO' + #13 + #10 + 'CHEQUE';
  cspCbCof = 'CARTE' + #13 + #10 + 'COFINAGA';
  cspSOC = 'SPIRIT OF' + #13 + #10 + 'CADEAU';
  cspCbKDO = 'CADO' + #13 + #10 + 'CARTE';
  cspCbKy = 'CARTE' + #13 + #10 + 'KYRIELLES';
  cspSB = 'Suite des' + #13 + #10 + 'boutons';

  RalSaisOblig = 'Il faut saisir au moins une saison !...' + #13 + #10 +
    '( Sans saison d�finie il ne peut pas y avoir de r�ponse � votre demande )';
  RalModifOblig = 'Il faut saisir au moins un statut !...' + #13 + #10 +
    '( Sans statut d�fini il ne peut pas y avoir de r�ponse � votre demande )';

  annulRapLine = '�0 Commande(s) annul�(es) et archiv�(es)' + #13 + #10 +
    '�1 Commandes(s) partiellement annul�(es)' + #13 + #10 + #13 + #10 +
    'D�sirez-vous imprimer un rapport d''annulation ?';

  annulRap = '�0 Commande(s) ont �t� annul�es et archiv�es' + #13 + #10 + #13 + #10 +
    'D�sirez-vous imprimer un rapport d''annulation ?';
  DbgRalHint = '[INS][Glisser-D�placer] Copie la ligne en cours dans la s�lection... [Double Clic][F4] Fiche mod�le';
  DbgSelRalHint = '[SUPPR][Glisser-D�placer] Supprime la ligne en cours de la s�lection... [Double Clic][F4] Fiche mod�le';

  // 4 ligne d�plac�es

  ValidRapidTrans = 'Enregistrement des �0 transferts saisis par code � barres...';
  // ************************
  CstCptProb = 'Probl�me sur le compte ';
  CstCptVente = 'Vente ';
  CstCptTVA = 'TVA ';
  CstCptCltdiv = 'CLT DIV';
  CstCptCltdivers = 'Client divers';
  CstCptClt = 'CLT ';
  CstCptInfo = 'Information exportation comptable';
  CstCptGeneraux = 'Les comptes g�n�raux doivent �tre renseign�s pour faire l''export comptable';
  CstCptSessions = 'Toutes les sessions de caisse doivent �tre ferm�es pour faire l''export comptable';
  CstCptRegCltDiv = 'R�glement Clt Div';
  CstCptVRS = 'VRS ';
  CstCptDepense = 'DEPENSE';
  CstCptIrrecouvrable = 'Client Irr�couvrable';
  CstCptTropPaye = 'Client trop pay�';

  BonTransfert = 'Bon de transfert';
  RechSurNom = 'Chrono non trouv�... Rechercher sur le nom, la r�f�rence ?...';
  ValidExpertTrans = 'Confirmez l''enregistrement du transfert en cours...';
  CancelExpertTrans = 'Confirmez l''abandon du transfert en cours...';
  //------------------
  TransLabMagCoul = 'Stock avant transfert du Magasin �0 - Couleur �1';
  NoTransTailPossible = 'Magasin �0' + #13 + #10 + 'Il n''y a pas de stock � transf�rer pour cette Taille/Couleur!...';
  PlusDeTransTailPossible = 'Magasin �0' + #13 + #10 + 'Tout le stock de cette Taille/Couleur a d�j� �t� r�parti en transfert !...';
  TransTailPossibleIsNega = 'Magasin �0' + #13 + #10 + 'Le stock de cette Taille/Couleur ne doit pas devenir n�gatif' + #13 + #10 +
    'La quantit� maximum que vous pouvez transf�rer est de [ �1 ]';

  UniColor = 'Unicolor';
  // ********************************* RV

  ConsoVide = 'Aucune consommation diverse � enregistrer...';
  ValidMajStk = 'Confirmez l''enregistrement du r�ajustement de stock' + #13 + #10 +
    'Motif : �0';
  NeoStock = 'Nouveau stock';

  DefConso = 'Motif de la consommation diverse...';
  MessSupTailleTTter = 'Impossible de supprimer cette taille,' + #13 + #10 + '   car elle a d�j� �t� utilis�e en gestion de ce mod�le...';

  // Etiquettes

  RecepEtikMess = 'Valider le bouton correspondant � votre choix... ';
  RecepEtikP1 = 'ATTENTION CE MODELE EXISTE EN STOCK A UN PRIX DE VENTE DIFFERENT';
  RecepEtikP2 = 'SI VOUS choisissez d''�tiqueter cette ligne de r�ception';
  RecepEtikP3 = 'Des �tiquettes seront AUTOMATIQUEMENT IMPRIMEES pour le STOCK EXISTANT';

  //********************************************** d�plac�

  CapNotEtik = 'Mod�les pour lesquels aucune �tiquette ne sera g�n�r�e (pas de stock)...';
  CstPasDeTicket = 'Aucun ticket dans votre s�lection';
  CstProbVersion = 'VOTRE POSTE N''EST PAS A JOUR'#10#13 +
    'Si c''est un portable : Lancer le Live-Update'#10#13 +
    'Si c''est un poste : v�rifier que vous lancez Ginkoia � travers l''ic�ne du bureau'#10#13#10#13 +
    'Autrement veuillez contacter la soci�t� GINKOIA SA';

  CapLab3mois = 'Apr�s 3 mois il n''est plus possible d''ajouter de nouveaux mod�les r�f�renc�s ni de modifier ceux existants';
  InitGenerEtik = 'G�n�ration de la liste des �tiquettes � imprimer...';
  TitreEtikGener = ' R�impression g�n�rique des �tiquettes';
  ReinitPrecos = 'Confirmez la r�initialisation du bloc note de pr�-commande...';
  SbtnOkPrecoHint0 = 'Quitter en enregistrant les modifications effectu�es';
  SbtnOkPrecoHint1 = 'Commander le mod�le point� par la ligne en cours';
  NoArtprecoToImport = 'Aucun mod�le distribu� par ce fournisseur dans le bloc note de pr�-commande...';
  PrecosHintGes = '[Suppr] Supprimer la ligne en cours';
  PrecosHintGesCde = '[Double clic] Sur une Qt� s�lectionne le mod�le [Suppr] Supprimer la ligne en cours';
  PrecoDelart = 'du mod�le ';
  PrecoDuBloc = 'du bloc note de pr�-commande';
  NoPossPreco = 'Impossible d''ajouter ce mod�le dans le bloc note de pr�-commande !...' + #13 + #10 +
    '( Nota : ce bloc note n''accepte ni les mod�les archiv�s ni les Pseudos... )';

  // RV 24/01/2003
  CapArtRef = 'Mod�les non archiv�s';
  MessChargeArtRef = 'Chargement de la liste des mod�les... ';

  VideselExpertArt = 'Confirmer la r�initialisation compl�te de la liste de s�lection en cours...   ';
  Traitencours = 'Traitement des donn�es en cours...';

  ToutPref = 'Ajouter tous les mod�les de votre s�lection � la liste pr�f�rentielle ?...';
  MetStkId = 'Affectation d''un stock id�al de';
  StkIdCap = ' Gestion du stock id�al...';
  StkIdLab = 'Stock id�al � affecter aux mod�les list�s';
  ConfStkId = 'Confirmez l''affectation d''un stock id�al de [ �0 ] aux mod�les list�s';

  ChangeClasse = 'Confirmez l''affectation �0 [�1] aux mod�les list�s';
  ActionClasse = 'mod�les affect�s �0';

  SClaVide = '"Pas de classe"';
  ChangeTCT = 'Confirmez l''affectation du type comptable �0 aux mod�les list�s';
  ActionTCT = 'Mod�les affect�s au taux de Type Comptable';

  OnPub = 'Activation de la coche "En Publicit�"';
  OutPub = 'D�sactivation de la coche "En Publicit�"';

  MetPub = 'Confirmez qu''il faut ajouter "En Publicit�" tous les mod�les list�s';
  RetirePub = 'Confirmez qu''il faut retirer la "Publicit�" de tous les mod�les list�s';

  ChangeTVA = 'Confirmez l''affectation du taux de TVA �0 aux mod�les list�s';
  ActionTVA = 'Mod�les affect�s au taux de TVA';

  OnFid = 'Activation de la coche "En Fid�lit�"';
  OutFid = 'D�sactivation de la coche "En Fid�lit�"';

  MetFidelite = 'Confirmez qu''il faut ajouter "En Fid�lit�" tous les mod�les list�s';
  RetireFidelite = 'Confirmez qu''il faut retirer la "Fid�lit�" de tous les mod�les list�s';

  ReinitCollec = 'Confirmez la r�initialisation de toutes les collections pour les mod�les list�s...';
  ReinitCollection = 'R�initialisation de toutes les collections';
  ReinitGroupe = 'Confirmez la r�initialisation de tous les groupes pour les mod�les list�s...';
  ReinitGroupes = 'R�initialisation de tous les groupes';
  ChangeGroupe = 'Confirmez l''affectation du groupe �0 aux mod�les list�s';
  SupprGroupe = 'Confirmez la suppression du groupe �0 pour les mod�les list�s';
  ActionGroupe = 'Mod�les plac�s dans le groupe';
  ActionDelGroupe = 'Mod�les retir�s du groupe';

  ScatVide = '"Pas de Sous-Cat�gorie"';
  SGreVide = '"Pas de Genre"';

  ActionSF = 'Mod�les plac�s dans la sous famille';
  ActionCollec = 'Mod�les plac�s dans la collection';
  ActionDelCollec = 'Mod�les enlev�s de la collection';
  ActionGenre = 'Mod�les affect�s au genre';
  ActionScat = 'Mod�les plac�s dans la Sous-Cat�gorie';
  ChangeSCat = 'Confirmez le d�placement des mod�les list�s vers la Sous-Cat�gorie' + #13 + #10 + '�0';
  ChangeGenre = 'Confirmez l''affectation du genre �0 aux mod�les list�s';
  ChangeCollec = 'Confirmez l''affectation de la collection �0 aux mod�les list�s';
  SupprCollec = 'Confirmez la suppression de la collection �0 pour les mod�les list�s';
  ChangeSF = 'Confirmez le d�placement des mod�les list�s vers la Sous-Famille' + #13 + #10 + '�0';
  CapNt = 'A ne pas traiter';
  CapPref = 'Pr�f�rentiels';

  YaSelPref = 'Faut-il conserver les mod�les not�s dans la liste "pr�f�rentielle" ?' + #13 + #10 +
    '( Ces mod�les sont repr�sentes sur un fond jaune )';

  ViderSelNT = 'R�initialiser la liste des mod�les "� ne pas traiter" ?...' + #13 + #10 +
    '( Ces mod�les sont repr�sent�s sur un fond gris )';
  ChangeSfArtCap = ' Nouvelle Sous-Famille des mod�les list�s...';
  SupSelArt = 'Voulez-vous enlever de la s�lection tous les mod�les s�lectionn�s' + #13 + #10 +
    '( ou tous les mod�les du groupe s''il s''agit d''une ligne de groupe )';

  ViderSelArt = 'La liste de s�lection "pr�f�rentielle" permet de conserver' + #13 + #10 +
    'les mod�les qu''elle identifie lors d''une nouvelle s�lection g�n�rique...' + #13 + #10 +
    '( Ces mod�les sont repr�sentes sur un fond jaune )' + #13 + #10 + #13 + #10 +
    'Faut-il vider cette liste ?...';

  RienAAjouterSelArt = 'Aucun nouveeau mod�le � ajouter � votre s�lection !...';
  DejaSelArt = 'Ce mod�le � d�j� �t� rajout� � votre s�lection...';
  SelMaxi900 = 'Vous ne pouvez avoir que 800 mod�les "Pr�f�rentiels" dans votre s�lection';
  SelMaxi900Del = 'Vous ne pouvez "Retirer" que 800 mod�les au maximum � votre s�lection';

  TipDev106 = 'Pour Information';
  NomSocOblig = 'La saisie du nom de la soci�t� est obligatoire...';
  DataStrObligatoire = 'Pour pouvoir enregistrer, la saisie d''une donn�e significative est obligatoire...';
  // RV 31/12/2002

  NoDelDevCateg = 'Impossible de supprimer cette cat�gorie car elle est r�f�renc�e dans un document !';

  AutoEnvoye = 'Voulez-vous que les (ou le) documents venant d''�tre imprim�s soient not�s comme "Exp�di�s" ?...  ';
  AnnulNotImprimed = 'Ce bon d''annulation n''a pas �t� imprim� !' + #13 + #10 +
    'Faut-il n�anmoins l''accepter comme "Exp�di�" ?...';

  // Bruno 30/12/2002
  TOTALAfficheur = 'TOTAL';

  PrepListarchCde = 'Pr�paration de la liste des documents � archiver...';
  Enregencours = 'Enregistrement du document en cours...   ';
  // RV 17-12-2002
  ChargeNoSupGros = 'Suppression de la coche grossiste impossible...' + #13 + #10 +
    '(Chargement de la liste des mod�les concern�s )';
  MessNoSupCocheGros = 'Ce grossiste est d�clar� comme fournisseur principal des mod�les list�s ci-dessous...' + #13 + #10 +
    'et la marque de ces articles n''est pas distribu�e par lui !';

  SolutionArtSupGlos = '2 Solutions pour pouvoir d�cocher l''option "Grossiste" : ' + #13 + #10 +
    '1. D�clarer un autre fournisseur principal pour ces articles...' + #13 + #10 +
    '2. D�clarer les marques de ces articles comme distribu�es par ce fournisseur...';

  CapListartPbSupGlos = 'suppression de la coche "Grossiste" impossible ...';

  IsFouPrinArt = 'Impossible : ce grossiste est not� comme fournisseur principal' + #13 + #10 +
    'des articles de marques qui ne sont pas not�es comme distribu�es par lui...';
  ISInCde = 'Impossible : ce grossiste a en commande (non cl�tur�e)' + #13 + #10 +
    'des articles de marques qui ne sont pas not�es comme distribu�es par lui...';
  ISInRecep = 'Impossible : ce grossiste a en r�ception (non cl�tur�e)' + #13 + #10 +
    'des articles de marques qui ne sont pas not�es comme distribu�es par lui...';
  ISInRetour = 'Impossible : ce grossiste a en retour fournisseur (non cl�tur�e)' + #13 + #10 +
    'des articles de marques qui ne sont pas not�es comme distribu�es par lui...';
  ISInAnnul = 'Impossible : ce grossiste a en annulation de commande (non cl�tur�e)' + #13 + #10 +
    'des articles de marques qui ne sont pas not�es comme distribu�es par lui...';

  //Bruno 16/12/2002
  ImpressionEnCours = 'Impression en cours...';

  AnulLineCde = 'Annulation partielle de commande';

  ConfirmAnnulLineCde = 'Confirmez l''annulation des �0 lignes de commande s�lectionn�es' + #13#10 +
    'ATTENTION : Une fois effectu�e cette op�ration est irr�versible !';

  AnnulTravEnCours = 'Impossible de changer d''onglet tant que vous n''avez pas Termin� o� Abandonn� le travail en cours';
  LibCdeNo = 'Cde N�';
  LibBaNo = 'Annul N�';
  LabPanSelLineAnnul = 'Lignes de Cde � annuler';

  // rv 12/12/2002
  CdeArchiveAuto = 'Il y a �0 commandes sans "Reste � Livrer...' + #13 + #10 +
    'Confirmer l''archivage de ces commandes...    ';
  NeedArchiveAnnul = 'Ce bon d''annulation est not� comme "Exp�di�" ... ' + #13 + #10 +
    'Faut-il l''archiver ? ';
  RalThereNonEnoye = 'Dans votre s�lection il y a des documents not�s comme' + #13 + #10 +
    'NON EXPEDIES' + #13 + #10 + 'Faut-il continuer l''archivage ?...';
  ArchivageRal = 'Archivage des bons d''annulation en cours...';

  AnnulTitreListe = '   Liste des bons d''Annulation';
  AnuIntLibCum = 'Global annulation';
  CdeAnnul = 'G�n�ration des bons d''annulation en cours ...     ';
  CapBtnGenerRAL = 'G�n�rer les annulations';
  CapBtnCloseAnnul = 'Terminer l''annulation';
  MessNumBonAnnul = 'Bon d''annulation N� ';
  GenerikCharge = 'Chargement en cours ...           ';

  // Ligne modifi�es
  HintNextRec = '[Ctrl + N] Fiche suivante...';
  HintPriorRec = '[Ctrl + P] Fiche pr�c�dente...';
  //****************

  PastFromGlos = 'Copie des donn�es en cours ...    ';
  NosupprpxBase = 'Le prix de base d''un article est obligatoire !' + #13 + #10 +
    'Suppression impossible ...';
  HintVideselAnnul = 'Abandonner toute la s�lection en cours (la liste des commandes � annuler est r�initialis�e)';
  HintVideselRap = 'Cl�turer le rapport d''annulation...';

  LabPanSelAnnul = 'Commandes � annuler';
  LabRapAnnul = 'Rapport d''annulation';

  MessPbAnnul = 'Probl�me lors de l''annulation';
  LibAnulRal = 'Annulation des R.�.L';
  LibAnulCde = 'Annulation de le commande';

  NoRalAtraiter = 'Liste vide ... Aucune commande � traiter !';
  ConfirmAnnulCde = 'Confirmez l''annulation des �0 commandes s�lectionn�es' + #13#10 +
    'ATTENTION : Une fois effectu�e cette op�ration est irr�versible !';
  ConfirmAnnulCdePlus = 'Un bon d''annulation diff�rent sera g�n�r� pour chacune des commandes trait�es';

  ConfirmRalVidesel = 'Abandonner toute la s�lection en cours ?...';
  LibExeCial = 'Exercice';

  //Bruno 28/11/2002
  TitListeTicket01 = 'R��dition d''un ticket';
  TitListeTicket02 = 'Annulation d''un ticket';
  TitListeTicket03 = 'R�gularisation de caisse sur un ticket pr�cis';
  TitListeTicket04 = 'Liste des tickets';
  ImpBandeControle = 'Impression de la bande contr�le?';
  ImpSession = 'SESSION No :';

  Session = 'Session n� ';
  Lignepasvalide = 'Validation impossible, vous n''�tes pas positionn� sur une ligne de ticket...';

  // Herv� au 25-11-2002
  NomMagOblig = 'Le nom du magasin est obligatoire !...  ';
  NoAgsect = 'Une cat�gorie de ressource doit obligatoirement �tre associ�e � un type !...';
  AgCatUsed = 'Suppression impossible car cette cat�gorie est utilis�e dans vos donn�es...';
  AgSectHasCat = 'On ne peut pas supprimer un type de ressource ayant des cat�gories d�finies...';
  JzGen = 'G�n�ral';
  jzDeleteRes = 'Confirmez la suppression de la ressource s�lectionn�e ...' + #13 + #10 +
    'ATTENTION : cette op�ration est irr�versible !...';
  HintResColor = '[F4] [CLIC] Ouvre la liste associ�e   [Fl�che Haut/Bas] Fait d�filer les choix possibles';
  NoRessName = 'Le nom de la ressource � g�rer est obligatoire...';

  // Bruno 23/11/2002
  TrfBLImpossible = 'Traitement impossible, vous avez d�j� r�alis� des encaissements,' + #13 + #10 +
    'ou des op�rations sur le compte de votre client...';

  CstProbTrfPort = 'Probl�me de transfert : tous les articles ne sont pas r�cup�r�s ' + #13#10 +
    '%s lignes d''articles transmises pour %s lignes d''articles attendues' + #13#10 +
    'Conserver quand m�me la saisie ?';
  // Pascal 20/11/2002
  CstAttention = ' Avertissement...';
  CstAcrobatMessage = '      Veuillez installer une version d''Acrobat Reader(TM) ' + #13 + #10 +
    ' Une version est disponible sur le CD d''installation de Ginkoia ';
  //Bruno 15/11/2002
  TransBL = 'Confirmez-vous le transfert en bon de livraison des articles en cours?';
  PasTransBL = 'Transfert impossible le ticket est vide...';

  // rv 14-11-2002

  TipDev102 = 'Fait';
  TipDev105 = 'Sign�';
  TipDev108 = 'S�r';

  YaKunFam = 'Chaque Rayon doit obligatoirement avoir au moins une Famille ...' + #13 + #10 +
    'Cette Famille ne peut �tre supprim�e qu''en supprimant son Rayon...';
  YaKunSF = 'Chaque Famille doit obligatoirement avoir au moins une Sous-Famille ...' + #13 + #10 +
    'Cette Sous-Famille ne peut �tre supprim�e qu''en supprimant sa Famille voire son Rayon...';

  YaArtDedans = 'Suppression impossible !... Il y a des articles r�f�renc�s...';
  NKOrdre = ' [Ctrl + Fl�che Haut/Bas] Remonter / Descendre l''�l�ment dans sa liste';
  NkRayVersHaut = '[Ctrl+Fl�che Haut] D�placer le rayon d''un cran vers le haut dans la liste des rayons';
  NkRayVersBas = '[Ctrl+Fl�che Bas] D�placer le rayon d''un cran vers le bas dans la liste des rayons';
  NkFamVersHaut = '[Ctrl+Fl�che Haut] D�placer la famille d''un cran vers le haut dans la liste des familles';
  NkFamVersBas = '[Ctrl+Fl�che Bas] D�placer la famille d''un cran vers le bas dans la liste des familles';
  NkSFVersHaut = '[Ctrl+Fl�che Haut] D�placer la sous-famille d''un cran vers le haut dans la liste des sous-familles';
  NkSFVersBas = '[Ctrl+Fl�che Bas] D�placer la sous-famille d''un cran vers le bas dans la liste des sous-familles';

  LabArtVide = 'Peut �tre masqu� car ne r�f�rence aucun article.';
  LabArtNoVide = 'Ne peut �tre masqu� car r�f�rence des articles.';

  LibFooterNKGTS = ' [INS] Ajouter  [SUPPR] Supprimer  [Echap] Fermer';

  // BRUNO 13/11/2002
  BLNumero = 'Bon de livraison : ';
  // RV 12-11-2002
  CapTxtFactor = 'Texte associ� au paiement par factor';
  TxtPmtFactor = 'Veuillez effectuer votre paiement directement � l�ordre de GARANT SCHUH qui le re�oit par subrogation';
  LabNkGinko = 'Nomenclature des articles';
  AlerteSelNK = 'V�rifiez la pertinence de votre s�lection !...' + #13 + #10 +
    'Vous avez au moins une cat�gorie de famille s�lectionn�e' + #13 + #10 +
    'qui rend certains de vos choix de Rayons ou de Secteurs "Inop�rants"...';

  DelCollec = 'Confirmez la suppression de la collection �0';
  NoGoodSexe = 'Pour les codes de sexe les valeurs permises sont :' + #13 + #10 +
    '1 = HOMME' + #13 + #10 +
    '2 = FEMME' + #13 + #10 +
    '3 = ENFANT';
  NoNameGRE = 'La saisie d''un nom de Genre est obligatoire...';
  NoNameCTF = 'La saisie d''un nom de Cat�gorie est obligatoire...';
  NoNameCAT = 'La saisie d''un nom de Sous-Cat�gorie est obligatoire...';
  NoNameSEC = 'La saisie d''un nom de Secteur est obligatoire...';
  NoNameGRP = 'La saisie d''un nom de Groupe est obligatoire...';
  NoNameCOL = 'La saisie d''un nom de Collection est obligatoire...';
  NoLibMrg = 'La saisie d''un mode de r�glement est obligatoire...';
  NKCapGes = ' Gestion de la nomenclature des Rayons...';
  NoSecNk = '{ Secteur non d�fini... }';
  NoAxeDefini = '{ Axe non d�fini... }';
  NoActiviteDefini = '{ Domaine non d�fini... }';
  NoSecDefined = 'Cet expert n''est accessible que lorsque des secteurs sont d�finis !...';
  NoCTFDefined = 'Cet expert n''est accessible que lorsque des cat�gories de famille sont d�finies !...';


  ClasNeoItem = 'Cr�er un nouveau th�me dans une classe';
  BeforeDElCla = 'Confirmez la suppression du th�me de classement �0  ';
  NomClasseOblig = 'Il est indispensable de d�finir un nom de classement significatif...';
  NomThemeOblig = 'Il est indispensable de d�finir un nom de th�me de classement significatif...';
  CreClas = 'Cr�er un nouveau th�me dans la classe �0';
  ClasModifName = 'Modifier le nom du classement s�lectionn�';
  ClasModifItem = 'Modifier le nom du th�me de classement s�lectionn�';
  ClasDeleteItem = 'Supprimer le th�me de classement s�lectionn�';
  ClasArt = 'Articles';
  ClasClt = 'Clients Particuliers';
  ClasPro = 'Clients Professionnels';

  //Bruno 07/11/2002
  PasGroupeclient = 'Le param�trage des groupes clients est inexistant...';
  PasGroupeCF = 'Le param�trage des groupes clients fid�lit� est inexistant...';
  //Bruno 07/11/2002

  AffDetail = 'Vue D�taill�e';
  AffSynth = 'Vue Synth�tique';
  RecepCollecDef = 'D�sirez-vous affecter automatiquement une "Collection" � tous les articles qui seront ajout�s dans ce Bon de R�ception?...';
  ImpDevLib = ' Titre � imprimer sur le(s) document(s)';

  LibPeriodeOblig = 'La p�riode d''�tude n''a pas �t� d�finie ... ';
  LabDebetude = 'Depuis le �0';
  LabFinetude = 'Jusqu''au �0';
  AlerteMin = 'La p�riode d''�tude ne peut �tre ant�rieure � �0';
  AlerteMax = 'La p�riode d''�tude ne peut �tre post�rieure � �0';
  AlerteDebSupFin = 'La date de d�but ne peut �tre post�rieure � la date de fin !...   ';

  HintDate = '[F4] Ouvre le calendrier associ�... [SUPPR] Vider la Date';
  CapDefFiltre = ' Conditions de filtrage d�finies...';
  TmpVide = 'Aucun article ne correspond aux conditions de filtrage d�finies !... ';
  cmbdropDown = '[F4] Ouvre la liste d�roulante des choix possibles...';
  CapFRN = 'Fournisseur';
  ChargeFiltre = 'Chargement et initialisation des crit�res de filtrage...';

  //****************
  CstCltLstDet = 'Liste d�taill�e';
  CstCltLstDetWait = 'Attention l''affichage de cette liste prend du temps. Continuer ?';

  CapRay = 'Rayon';
  CapFam = 'Famille';
  CapSSF = 'S/Famille';
  DelDefFiltre = 'Supprimer tous les �l�ments s�lectionn�s ?...';
  PbgenerFiltre = 'Probl�me lors de la pr�paration du filtre ...';

  CapSid = 'Stock Id�al d�fini';
  CapFid = 'En Fid�lit�';
  CapMpx = 'Px Achat <> Taille';
  CapPVT = 'Tarif Magsin d�fini';
  CapFRC = 'Vente Fractionn�e';

  CapCollection = 'Collection';
  CapGroupe = 'Groupe';
  CapFouPrin = 'Fournisseur';
  CapGTF = 'Grille de tailles';
  CapTVA = 'Taux de TVA';
  CapTCT = 'Type Comptable';
  CapTVT = 'Tarif de vente';
  CapGenre = 'Genre';
  CapArchive = 'Archiv�s';
  CapVirtuel = 'Pseudos';
  CapCatalogue = 'Catalogue Fournisseur';
  CapStN = 'Stock < 0';
  CapStP = 'Stock > 0';
  CapSt0 = 'Stock = 0';
  CapStk = 'Stock <> 0';

  SoveFltTit = ' Sauvegarder le filtre...';
  LabelSoveFlt = 'Donnez un nom � ce filtre';
  Nofiltertosave = 'Aucune d�finition de filtre � sauver ...     ';

  CapNk = 'Nomenclature';
  CapDomaine = 'Domaine commercial';
  CapAxe = 'Axe statistique';
  CapSecteur = 'Secteur';
  CapCateg = 'Cat�gorie';
  CapSousCateg = 'Sous Cat�gorie';
  CapMarque = 'Marque';

  HIntMemos = '[CTRL+ENTREE] Valide le champ... [Double Clic ou F4] Ouvre l''�diteur associ� au champ';
  HIntMemosLS = '[ENTREE] Champ suivant... [Double Clic ou F4] Ouvre l''�diteur associ� au champ';

  HintMemoRV = '[Double Clic] ou [F4] Ouvre l''�diteur de m�mos associ�';
  NegGarant = 'Code Garant';
  NegSumAcompte = 'Acompte';
  NegSumCdt = 'Conditions de r�glement';
  NegSumNap = 'Net � Payer';
  NegSumSoitle = 'Soit le';

  MajFicMarques = 'Contr�le du fichier des marques' + #13 + #10 +
    'Quelques instants tout au plus...  Merci d''avance !';

  CdeRefreshToto = 'ATTENTION : ce contr�le n''est effectu� que si vous avez ' + #13 + #10 +
    '   r�ellement constat� une anomalie dans le document ! ... ' + #13 + #10 +
    '   Faut-il proc�der au contr�le ?';
  RefTotoFait = 'Contr�le et mise � jour des cumuls du document effectu�s...   ';

  //Pascal 29/10/2002
  CstSelectionDuAu = 'Votre s�lection %s au %s';
  // RV 23-10-2002
  NegTetFactor = 'Code Garant';
  Negtetnum = 'Num�ro';
  Negtetdate = 'Date';
  Negtetref = 'R�f�rence';
  Negtetdes = 'D�signation';
  NegTetEmpl = 'Emplacement';
  Negtettva = 'TVA';
  Negtetqte = 'Qt�';

  Negtetclt = 'Code Client';
  NegtetLabtva = 'N� TVA';
  Negtetcoul = 'Couleur';
  NegtetTail = 'Taille';
  NegtetRem = 'Rem';

  NegSumRemGlo = 'Remise globale';
  NegSumTvatx = 'Taux TVA';
  NegSumTvamt = 'Montant Tva';
  NegSumTvatoto = 'Totaux';

  NoGroupetoadd = 'Aucun groupe � ajouter � ce mod�le...    ';
  NoCollectiontoadd = 'Aucune collection � ajouter � ce mod�le...    ';

  DblClic = '[Double Clic]';
  LabMags = 'Magasin �0';
  LabArtMvt = 'Mouvements depuis la cr�ation du mod�le';
  LabRecep = 'R�ception';
  LabDocN = 'Doc N� :';
  LabQte = 'Qt� :';
  LabStockA = 'Stock Apr�s :';
  LabTransE = 'Transfert Entrant';
  LabTransS = 'Transfert Sortant';
  LabRetour = 'Retour Fournisseur';
  ArtPanStat = 'P�riode d''�tude du �0 au �1';
  LabUnicolor = 'Unicolor';

  //Pascal 22/10/2002
  CltPart = 'PART';
  CltPro = 'PRO';
  CltStat = 'Historique d''achat de %s';
  CltStat2 = 'Statistique du client %s';
  CltList = 'Liste des clients';
  //Bruno 15/10/2002
  ChangTypCF_1 = 'Attention, vous venez de d�cocher le Type';
  ChangTypCF_2 = 'Cependant, vous avez';
  ChangTypCF_3 = 'clients qui l''utilisent.';
  ChangTypCF_4 = 'Si vous confirmez votre choix, vous devrez modifier manuellement' + #13 + #10 +
    'le type de la fid�lit� pour tous les clients concern�s...';

  // RV 14/10/2002
  ArtPeriode1 = 'P�riode d''�tude du �0 au �1';
  ChxArtDebEtude = 'Date de d�but d''�tude';
  ArtDebEtude = 'D�but d''�tude';
  CapPrincipal = 'Principal';
  NoGoodPrefix = 'Le pr�fixe du code chrono doit obligatoirement �tre celui d�fini pour le magasin dorrespondant cet ordinateur...  ';
  NeedChrono = 'Vous n''avez pas d�fini un code chrono valide ...   ';
  NegMaxiLine = 'Impossible de valider cette ligne...' + #13 + #10 +
    'Elle d�passe le montant maximum possible ( TTC 910 000.00 )   ';
  HintDbgDoc2 = '[SUPPR] Supprimer la ligne [F2] Editer... la ligne en cours du document affich�';
  NoSelection = 'Aucune s�lection en cours...    ';
  CapArtArch = 'Articles Archiv�s';
  AlerteStk = 'Le stock de cet article est n�gatif [�0]';
  AlerteStkIdeal = 'Le stock de cet article [�0] est inf�rieur au stock id�al [�1]';

  ImpdevTitle = ' Impression de Devis...';
  NegDateLim = 'Au del� de trois mois il n''est plus possible d''ajouter, de supprimer' + #13 + #10 +
    'ou de modifier les lignes se rapportant � des articles r�f�renc�s...';

  // Bruno 10/10/2002
  MailDateValiditeIncoherente = 'La date de fin de validit� est inf�rieure � la date de d�but...';

  // RV 04-10-2002
  NomModeleOblig = 'La saisie d''un nom de mod�le est obligatoire !...';
  OuvreNeoModele = 'Nouveau mod�le �0 cr�� [ N� : �1 ]' + #13 + #10 +
    'Voulez-vous afficher ce mod�le � l''�cran ?';
  CreaModele = ' Cr�ation d''un mod�le...';
  NomCreaModele = 'Nom du nouveau mod�le';

  NoLivrDev = 'La date de livraison pr�vue est obligatoire...';
  OpeNoRetour = '(ATTENTION : Cette op�ration est irr�versible !...)';
  NegArchiveNoClot = 'Dans votre s�lection, il y a des documents non cl�tur�s !' + #13 + #10 +
    'Faut-il continuer et les archiver ?' + #13 + #10 +
    '( ATTENTION : l''archivage d''un document est IRREVERSIBLE !...)';

  // Bruno 03/10/2002
  MailClientDejaExistant = 'Ce client a d�j� �t� s�lectionn� pour ce mailing...';
  MailDesiObligatoire = 'La saisie d''une d�signation est obligatoire...';
  MailDateValidite = 'La saisie d''une date de validit� est obligatoire...';

  // RV 26-09-2002
  HintFltPsc = 'D�finir un filtre �tendu...';
  LoadingFilter = 'Mise � jour filtre sur l''affichage des donn�es ...';

  //@@Bruno  20/09/2002
  SupClientMailing = 'Confirmez-vous la suppression de ce client dans le mailing en cours?';

  // RV 20-09-2002
  YaKunItem = 'Chaque branche de la nomenclature doit avoir au moins 1 "enfant" ...' + #13 + #10 +
    'Pour suupprimer cet �l�ment, il faut supprimer son "parent"...';
  HintDbgDoc = '[Ctrl+SUPPR] Supprimer la ligne [F2] Editer... la ligne en cours du document affich�';

  NkRayonUsed = 'Impossible de valider : il existe d�j� un Rayon portant ce nom...';
  NkFamilleUsed = 'Impossible de valider : il existe d�j� une Famille de ce Rayon portant ce nom...';
  NkSFamilleUsed = 'Impossible de valider : il existe d�j� une Sous-Famille de cette Famille portant ce nom...';
  GesRayon = 'Rayon ...';
  GesFamille = 'Famille ...';
  GesSFamille = 'Sous-Famille ...';

  NegCmzMrkNOM = 'Marque';

  NoDelProjet = 'Suppression impossible, ce PROJET est utilis� dans vos donn�es...';
  NoDelVille = 'Suppression impossible, cette VILLE est utilis�e dans vos donn�es...';
  NoDelPays = 'Suppression impossible, ce PAYS est utilis� dans vos donn�es...';

  STDragGloNoPossible = 'Impossible d''importer un Sous-Total du glossaire' + #13 + #10 +
    'dans un Sous-Total du document!...';
  STGloIsInModele = 'Impossible d''importer ce mod�le dans un Sous-Total' + #13 + #10 +
    'car il contient lui-m�me un Sous-Total !...';

  NegCapSousTot = 'Remise % && Montants du SOUS-TOTAL';
  NegCapValCom = 'Valeur affich�e dans la ligne (NON prise en compte dans les totaux)';
  NoSupTetST = 'On ne peut pas supprimer un en-t�te de Sous-Total...';
  LibEntetST = 'Ent�te de Sous-Total';

  NegLabPack = 'Sous-Total';

  //@@Bruno  19/09/2002
  GeneMail = 'G�n�ration du mailing en cours';

  //@@Bruno  17/09/2002
  SupMailing = 'Confirmez-vous la suppression de ce mailing?';
  GenereMailing = 'Confirmez-vous la g�n�ration d''un mailing � partir de cette analyse client ?';
  ASK_MAILING_EXCLUSANSADR = 'Souhaitez-vous exclure du mailing les clients sans adresse ?';
  //@@Bruno 12/11/2002
  MontantMauvais = 'Le montant est erron�...';
  QteMauvais = 'La qt� est erronn�e...';
  RemiseMauvaise = 'Le taux de remise ne peut pas �tre sup�rieur � 100%...';
  PrixMauvais = 'Le prix est erron�...';

  // 3 lignes d�plac�es
  HintGenEdit = 'Si le champ dispose d''un bouton [Double-clic ou F4] d�clenche l''action associ�e...';
  NegLabTitle = 'Ligne de groupe';

  NegNoArticleStk = 'La ligne en cours ne pointe sur aucun article...';
  InfoStkCour = ' Stock de l''article en cours...';
  F5Neg = '[F5] Afficher le Stock  ';
  VirtuelNoStock = 'Cet article est un "PSEUDO" et n''a donc pas de stock';
  NegAffStk = 'Chrono : �0' + #13 + #10 +
    'R�f�rence : �1' + #13 + #10 +
    'D�signation : �2' + #13 + #10 +
    'Stock : �3';

  NegLabSousTot = 'Sous Total';

  // RV 27-28-2002
  LibAFact = 'Facture � g�n�rer';
  TransRapTitle = 'Rapport de transfert en facture...';
  DoingTransBL = 'Transfert des documents en cours ...';
  InitTransBL = 'Initialisation de l''expert de transfert...';
  LibIsClotured = 'Ce document est cl�tur�';
  LibIsNoModifed = 'Ce document a d�j� �t� transf�r�';
  LibIsArchived = 'Ce document est archiv�';
  LibNOTrans = 'Documents NON Transf�rables en facture';
  NoBlToTrans = 'Aucun document � transf�rer en facture !...';

  // RV 22/08/2002
  HistoRechVide = 'Historique de recherche vide...';
  MajFouPrin = 'Mise � jour n�cessaire de votre fichier des marques...' + #13 + #10 +
    'Quelques instants tout au plus...  Merci d''avance !';

  // Pascal 20/08/2002
  HintEditInterne = 'Edition interne du document ...';
  // RV 19-08-2002

//   MajFicFod = 'Mise � jour n�cessaire du format de votre fichier fournisseurs'+#13+#10+
//      'Quelques instants tout au plus...  Merci d''avance !';
  MajFicAdresse = 'Mise � jour n�cessaire du format de votre fichier d''adresses' + #13 + #10 +
    'Quelques instants tout au plus...  Merci d''avance !';
  ModDevMajSelVide = 'Aucun document � r�actualiser !' + #13 + #10 +
    '( Les lignes des groupes et les mod�les archiv�s ne sont pas pris en compte... )';
  HintNkMode1 = '[Double clic] ou [F12]  Ouvre la fiche de l''article point� dans la liste   [F4]  S�lection de la nomenclature';
  HintNkModex = '[Double clic] ou [F12]  S�lectionne l''article point� dans la liste   [F4]  S�lection de la nomenclature';
  HintARTNk = 'Nomenclature...  [ECHAP] Fermer la nomenclature  [F4] Affiche les articles associ�s';

  // 7 lignes d�plac�es
  NkCapFourn = ' Nomenclature & liste des articles du fournisseur...';
  NkCapListart = ' Nomenclature & liste des articles...';
  NKCapNormal = ' Nomenclature...';

  HintNk = 'Nomenclature...  [ECHAP] Fermer la nomenclature';
  GenerAbon = 'Confirmer la g�n�ration de(s) "�0" facture(s) d''abonnement correspondant au(x) mod�le(s) s�lectionn�(s)...';

  NeedParamimp = 'Avant d''imprimer ce document il est n�cessaire' + #13 + #10 +
    'd''aller d''abord param�trer vos impressions courrier...' + #13 + #10 + #13 + #10 +
    '[Menu : Param�trage / Impressions Courrier]';

  ChxModelDev = 'Nouveau mod�le de devis';
  NegCmzVendeur = 'Vendeur';
  NegCmzChrono = 'Code Chrono';
  NegCmzTaille = 'Taille';
  NegCmzCouleur = 'Couleur';
  NegCmzPxNet = 'Prix Unitaire Net';
  NegCmzMarge = 'Marge';

  GenerLAbon = 'Confirmer la g�n�ration de la facture d''abonnement correspondant au mod�le affich�...';
  CapPxvHT = 'PxVte HT';
  CapPxvTTC = 'PxVte TTC';
  CapMtHT = 'Mt HT';
  CapMtTTC = 'Mt TTC';

  OnlyOneSelected = 'Cette fonction n''est pas possible lorsque plusieurs lignes sont s�lectionn�es !...';
  LbRecepModif = 'Bon de livraison modifiable';
  LbRecepClot = 'Bon de livraison cl�tur� (non modifiable)';
  LbRecepArch = 'Bon de livraison archiv� (non modifiable)';

  // Bruno 13/08/2002
  AnalysePrealable = 'Analyse pr�alable en cours ...' + #10#13 +
    '(Quelques secondes de patience)';
  AnalyseMailing = 'Analyse en cours de construction';

  // Pascal
  CstArchiveChxDate = 'Date de dernier mouvement';
  CstArchiveSur = 'Etes-vous sur de vouloir archiver ces articles ?';
  CstArchive = 'Archivage des articles';
  CstArchiveEnCours = 'Archivage en cours patience ...';

  TitEdRal = 'Edition des restes � livrer';
  LibCdeNoLivr = 'Commande modifiable : aucune livraison encore enregistr�e...';
  LibCdeNotModif = 'Commande non modifiable : "en cours de livraison"...';
  LibCdeArchive = 'Commande cl�tur�e ( Pas de Reste � Livrer )...';
  CdeIntLibCum = 'Global commande';
  RalIntLibCum = 'Global R.� L';
  RecepIntLibCum = 'Global r�ception';
  LibArticle = 'Article';

  // Pascal 29/07/2002
  CstARCDansDate = 'Le dernier mouvement du mod�le date du %s ' + #10#13 +
    '     Voulez-vous quand m�me l''archiver ?';

  // Pascal 23/07/2002
  CstCaisOuv = 'Ouverture par %s, le %s � %s';
  CstCaisFer = 'Fermeture par %s, le %s � %s';
  CstCaisFer2 = 'pas ferm�e';
  CstCANET = 'CHIFFRE D''AFFAIRES NET';
  CstJSESDet = 'D�tail';
  CstJSESHT = 'HT';
  CstJSESTVA = 'TVA';
  CstJSESTTC = 'TTC';
  CstFondCais1 = 'GESTION DU FOND DE CAISSE';
  CstDepense = 'D�penses';
  CstFondFinal = 'Fond final';
  CstMessCaisseFaux = 'La somme de votre journal de caisse est diff�rente de z�ro.'#13#10 +
    'Veuillez contacter l''assistance de GINKOIA SA afin que nous puissions intervenir.'#13#10 +
    'Cela ne vous emp�che pas de travailler';
  CstCaiMagasin = 'Magasin %s';
  CstCaiPoste = 'Poste : ';
  CstSesOuv = 'Sessions ouvertes : ';
  JVLibSess = 'Poste �0 - Session No �1';

  // RV 22-07-2002
  NoEditCde = 'Cette commande n''est plus modifiable !...';
  CtrlCdeAbandon = 'Confirmez que vous ne d�sirez archiver aucune des commandes list�es...';
  DelCdeImp = 'Ce document � �t� imprim� !...' + #13 + #10 +
    'Confirmez que vous d�sirez n�anmoins le supprimer ...';
  CdeTipOblig = 'Le type de commande est obligatoire';
  ValidEnCours = 'Enregistrement en cours...';
  DebCdeDef = 'Monsieur' + #13 + #10 + 'Je vous remercie de bien vouloir enregistrer la commande suivante';
  FinCdeDef = 'Avec mes remerciements anticip�s, je vous prie de recevoir Monsieur, mes salutations les meilleures';
  BasFactDef = '';
  RgltDef = 'En votre aimable r�glement';

  // Bruno @@ 02/07/2002
  Cstdetail = 'Analyse d�taill�e du �0 au �1  -  ';

  //Bruno @@ 20/06/2002
  MessChargeAD = 'Analyse d�taill�e en construction...';
  AnaDetailleeStock = 'Stock';
  AnaDetailleeVentes = 'Ventes';
  AnaDetailleeMonnaie = '�';

  // RV @@28 10-07-2002
  LibDatLivr = 'Date de livraison';
  LibCadDelai = 'Livraison & D�lai';
  // Pascal 15/07/2002
  NkSsCategorie = 'Sous Cat�gorie';
  // RV @@28 10-07-2002
  LibFranco = 'Franco';
  LibTel = 'T�l';
  LibFax = 'Fax';

  CtrlAfterToDay = 'Attention... Vous avez valid� une date � venir! ... ' + #13 + #10 +
    '(N''oubliez pas de la corriger s''il s''agit d''une erreur...)';
  CtrlMinDateCdeDef = 'La date de livraison par d�faut ne peut pas �tre ant�rieure � la date de commande!...';
  NoSupCollec = 'Cette collection ne peut pas �tre supprim�e car elle est r�f�renc�e par des articles!...';
  CdeCollecDef = 'D�sirez-vous affecter automatiquement une "Collection" � tous les articles qui seront ajout�s dans cette commande?...';
  CdeCopy = 'Confirmez que vous d�sirez g�n�rer une copie de la commande affich�e';
  CdeCopyMag = #13 + #10 + 'pour le magasin "�0"';
  OkCdeCopy = 'Copie de commande effectu�e...' + #13 + #10 +
    'La nouvelle commande � �t� g�n�r�e avec le num�ro "�0"';
  OnCopyCde = 'Copie de commande en cours...';
  OnParamCollec = 'Proposition de mise � jour des collections "Activ�e"';
  NotParamCollec = 'Proposition de mise � jour des collections "D�sactiv�e"';
  // d�plac�es
  CdeRechVideCollec = 'Aucun article trouv� dans la collection demand�e... ' + #13 + #10 +
    '(Si cet article existe, il n''est pas accessible dans le cadre de votre travail en cours..';

  CdeCadexist = '(Article chrono "�0") IMPOSSIBLE de valider la cadence de livraison d�finie pour cette ligne' + #13 + #10 +
    'car elle existe d�j� dans la commande';

  // Pascal @@24 11/06/2002
  CstTabTaiMag1 = 'A Vendre %s';
  CstTabTaiMag2 = 'A Vendre ';
  CstTabTaiMag3 = 'Ventes %s';
  CstTabTaiMag4 = 'Ventes';
  CstTabTaiMag5 = 'Stock %s';
  CstTabTaiMag6 = 'R�L %s';
  CstTabTaiMag7 = 'R�L';
  CstTabArtDeb = 'Du %s';
  CstTabArtFin = 'Au %s';
  CstTabTaiCou1 = 'Stock de d�but';
  CstTabTaiCou2 = 'Achat';
  CstTabTaiCou3 = 'R�tro';
  CstTabTaiCou4 = 'D�marque';
  CstTabTaiCou5 = 'A Vendre';
  CstTabTaiCou6 = 'Ventes Normales';
  CstTabTaiCou7 = 'Ventes Promo';
  CstTabTaiCou8 = 'Ventes Sold�es';
  CstTabTaiCou9 = 'Ventes Professionnelles';
  CstTabTaiCou10 = 'Ventes';
  CstTabTaiCou11 = 'Stock de Fin';
  CstTabTaiCou12 = 'R�L';
  CstTitTabTailCoul = 'Tableau de bord Taille/Couleur';
  CstTitTabTailMAG = 'Tableau de bord Taille/Magasin';

  // @@24 RV
  HintEditGenNoSuppr = '[Ins] Cr�er [F2] Editer';


  //Bruno @@ 29/05/2002
  AnnulPasPossible = ' Attention, annulation impossible,' + #13 + #10 + ' c''est un ticket de r�ajustement de compte...';

  // RV @@22 29/05/2002  3 lignes d�plac�es car modifi�es
  FournMrkSup = 'Les Marques suivantes n''�tant plus r�f�renc�es dans la base ont �t� automatiquement supprim�es';
  SupLienMrkCas1 = 'Suppression impossible...' + #13 + #10 + 'La marque distribu�e n''aurait plus de fournisseur...';
  NegFacCroPro = 'En cours...';

  // Pascal @@22 28/05/2002
  MessChargeAnalVente = 'Chargement de l''analyse des ventes ...';
  CstAnalVente = 'Analyse des ventes du �0 au �1 ';
  CstAnalVenteCum = 'Analyse des ventes (cumul des magasins) du �0 au �1 ';
  // Bruno @@ 20 14/05/2002
  MotifObligatoire = 'La saisie d''un motif est obligatoire...';
  ReajustCompteLib = 'REAJUSTEMENT DU COMPTE CLIENT';

  // P.R. @@19
  MessNettoyAnalSynt = 'V�rification des articles...';

  //R.V @@17
      // 2 lignes d�plac�es
  HintEditDBG = '[Ins] Cr�er [F2] Editer [Ctrl+Suppr] Supprimer la ligne s�lectionn�e';

  SupprModFacture = 'Suppression de(s) mod�le(s) de facture d''abonnement en cours...';
  LibDatFacAbon = 'Date de facturation';
  ConfCreModFac = 'Confirmez la cr�ation d''un mod�le de facture d''abonnement' + #13 + #10 +
    '� partir de la facture en cours...';

  NoGenerAbon = 'Aucune facture d''abonnement � g�n�rer';
  SupprAbon = 'Confirmer la SUPPRESSION de(s) "�0" facture(s) d''abonnement s�lectionn�e(s)...';
  NoSupprAbon = 'Aucune facture d''abonnement � SUPPRIMER';

  GenerAbonFactures = 'G�n�ration des factures d''abonnement en cours...';
  GenerAbonFacture = 'G�n�ration de la facture d''abonnement...';
  GenerModFacture = 'Cr�ation d''un mod�le de facture d''abonnement � partir de la facture affich�e...';
  ModFactOk = 'Le mod�le de facture d''abonnement "�0" a �t� g�n�r�' + #13 + #10 +
    '� partir de la facture "�1"';
  ModFactPb = 'Probl�me lors de la cr�ation du mod�le � partir de la facture "�1"' + #13 + #10 +
    '(Le mod�le n''a pas pu �tre g�n�r�...)';
  GenerFacAbonOk = 'Facture d''abonnement g�n�r�e...';
  GenerFacAbonPB = 'Probl�me : Facture d''abonnement NON g�n�r�e...';

  //R.V @@16
  MrkDelDist = 'Confirmez que le Fournisseur "�0"' + #13 + #10 +
    'n''est plus distributeur de cette marque...';
  MrkINSDist = 'Confirmez que le Fournisseur "�0"' + #13 + #10 +
    'est distributeur de cette marque...';

  ChargeArbreMrk = 'Chargement et mise � jour de la liste des marques...';
  SupprMarque = 'Confirmez la suppression de la marque "�0"...';
  CantSupMarque = 'La suppression de la marque "�0" est IMPOSSIBLE...' + #13 + #10 +
    'Elle est r�f�renc�e par vos articles...';
  ManqueFouPrin = 'Il est indispensable de d�signer le fournisseur principal de cette marque! ...';
  CancelMarque = 'Abandonner TOUTES les modifications effectu�es sur cette Marque? ...';

  // 6 Lignes d�plac�es
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
  NapLib = 'Net � Payer';
  NapAvoirLib = 'Avoir Net';

  //P.R. @@16
  InfVersementCoffre = 'Versement au coffre ';
  { @@15 Modifi� Herv� le 12/04/2002}
  CancelFourn = 'Abandonner toutes les modifications effectu�es pour ce fournisseur ? ...';
  NoMoreMagDetFrn = 'Vous avez d�j� d�fini les conditions particuli�res pour tous les magasins possibles...';
  MessPostFrnCt = 'Enregistrement de la fiche du contact fournisseur...';
  MessPostFrnDet = 'Enregistrement de la fiche de conditions particuli�res...';
  MessDelFrnCt = 'Confirmez la suppression de la fiche contact fournisseur � l''�cran...';
  MessDelFrnDet = 'Confirmez la suppression de la fiche conditions particuli�res du fournisseur � l''�cran...';
  MessCancelFrnCt = 'Abandonner les modifications en cours dans la fiche du contact ? ...';
  MessCancelFrnDet = 'Abandonner les modifications en cours dans les conditions particuli�res ? ...';

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
    'Il existe d�j� une marque r�f�renc�e portant nom ! ...';
  InputLabNeoMrk = 'Nom de la nouvelle marque...';
  DefCapInput = 'Boite de saisie...';
  DefLabInput = 'Votre saisie...';

  //22/03/2002 Bruno
  EtikCltTotal = 'Confirmez-vous, l''impression des �tiquettes correspondant' + #13 + #10 + '� la liste des clients en cours?';
  EtikCount = 'Etiquette';
  EtikCountS = 'Etiquettes';


  { Modifi� Herv� Le : 26/03/2002  -   Ligne(s) }
  LibRecep = 'Bon de R�ception';
  MessCreaLinkArt = 'Cr�ation de l''article et transfert' + #13 + #10 + 'dans le "�0"';
  ///Pascal 25/03/2002
  CstAffInventaire = 'Affichage de l''inventaire en cours, patience...';

  { Modifi� Herv� Le : 19/03/2002  -   Ligne(s) }
  CreerMarqueDef = 'Faut-il cr�er une marque du m�me nom que celui de ce fournisseur ? ...' + #13 + #10 +
    '( Cette marque se nommerait donc "�0" )';

  SupMarqueDist = 'Retirer la marque "�0" comme marque distribu�e par ce fournisseur ?...';
  GrosYaRal = 'Il reste des articles en commande chez ce fournisseur' + #13 + #10 +
    'pour une marque qui n''est pas distribu�e par lui ! ...' + #13 + #10 +
    'Tant qu''il ne sera pas d�clar� comme distributeur de cette marque,' + #13 + #10 +
    'il devra imp�rativement rester grossiste...';

  AjoutMrkSel = 'Confirmez l''ajout des marques s�lectionn�es comme �tant distribu�es par ce fournisseur...';
  HintDbgMrkFrn = '[INS] Ajouter des marques distribu�es [Suppr] Si la marque point�e n''est plus distribu�e';
  HintDbgMrkFrnNoEdit = '[Double-clic] Fiche de la marque point�e';

  HintRechFrn = '[F6] Liste des fournisseurs';

  SupFournAvort = ' La suppression ne peut pas �tre effectu�e...';

  HintNeoFoudef = 'S�lectionner le Nouveau fournisseur par d�faut de la marque "�0" ? ...';
  PbAdresseFourn = 'Probl�me avec l''adresse de ce fournisseur... Mise en �dition impossible ! ...';
  NomFournExist = 'Deux fournisseurs ne peuvent �tre cr��s avec le m�me nom ! ...';
  PbCreaFourn = 'Probl�me en validation de ce nouveau fournisseur...' + #13 + #10 +
    'La cr�ation doit �tre abandonn�e...';
  TxtEnLS = 'Texte en lecture seule';
  FourNoDel = 'Impossible de supprimer ce fournisseur...'#13 + #10 +
    'car vous avez d�j� travaill� avec lui !)' + #13 + #10 +
    '(articles r�f�renc�s, articles en commande... etc.)';

  { Modifi� Herv� Le : 17/03/2002  -   Ligne(s) }

  LabProForma = 'Facture Pro Forma';
  MajTarModeles = 'Confirmez la r�actualisation des prix des mod�les s�lectionn�s... ';

  ModDevNoNeedMaj = 'Les prix sont � jour... ce mod�le ne n�cessite aucune r�actualisation ! ...';
  ModDevNoNeedMajSel = 'Les prix sont � jour... aucune r�actualisation n''a �t� n�cessaire !...';
  ModDevMaj = 'Mise � jour des prix du mod�le termin�e... ';
  ModDevMajSel = 'Mise � jour des prix des mod�les s�lectionn�s termin�e... ';

  { Modifi� Herv� Le : 11/03/2002  -   Ligne(s) }
  MessRecepRemRal = 'Cet article a �t� saisi en commande avec une remise de "�0"' + #13 + #10 +
    'diff�rente de la remise par d�faut du bon de r�ception (�1)' + #13 + #10 + #13 + #10 +
    'Faut-il forcer la remise par d�faut du bon de r�ception ?';

  NewFilterMess = 'Mise en place du filtre avanc�...';
  StopFilterMess = 'Suppression du filtre avanc�... r�affichage des donn�es...';
  NbtAdvFilterHint = 'Expert filtre avanc�...';
  NegPxUHT = 'Px Unit HT';
  NegPxUTTc = 'Px Unit TTC';

  ConsoQteNega = 'Le stock est... ou va devenir n�gatif ! ... Continuer ?';

  DateDocMess = 'Votre document est � une date... "dans le futur" ! ...' + #13 + #10 +
    'Est-ce bien normal et faut-il l''accepter ? ... ';
  TitleExpertCat = ' Expert de gestion des cat�gories de familles';
  TitleExpertCat1 = ' Expert de gestion des cat�gories de Rayons';

  CNFCategorie0 = 'Retirer la famille "�0" de la liste des Cat�gories ? ...' + #13 + #10 +
    '(Cette Famille n''aura plus de Cat�gorie associ�e...)';
  CNFAffectCategorie = 'Placer la Famille "�0"' + #13 + #10 + 'Dans la Cat�gorie "�1" ? ...';

  CNFCangeCatFam = 'D�placer la Famille "�0"' + #13 + #10 + 'de la Cat�gorie "�1"' + #13 + #10 +
    'vers la Cat�gorie "�2"';

  CNFCangeSecRay = 'D�placer le Rayon "�0"' + #13 + #10 + 'du Secteur "�1"' + #13 + #10 + 'vers le Secteur "�2"';
  DbgRExpertSectHint = '[Ctrl + Fl�che Droite] Affecte le rayon point� au Secteur en cours [Suppr] Retire l''�l�ment point�';
  DbgSRExpertSectHint = '[Ctrl + Fl�che Gauche] Retire le rayon point� du Secteur [Drag && Drop] Pour r�organiser les Secteurs';

  DbgRExpertCatHint = '[Ctrl + Fl�che Droite] Affecte la famille point�e � la Cat�gorie en cours [Suppr] Retire l''�l�ment point�';
  DbgSRExpertCatHint = '[Ctrl + Fl�che Gauche] Retire la famille point�e de la Cat�gorie [Drag && Drop] Pour r�organiser les Cat�gories';
  DbgRExpertCatHint1 = '[Ctrl + Fl�che Droite] Affecte le rayon point� � la Cat�gorie en cours [Suppr] Retire l''�l�ment point�';
  DbgSRExpertCatHint1 = '[Ctrl + Fl�che Gauche] Retire le rayon point� de la Cat�gorie [Drag && Drop] Pour r�organiser les Cat�gories';

  ExpertSectTitre = 'Liste des secteurs avec leurs rayons associ�s';
  ExpertCatFamTitre = 'Liste des cat�gories';

  ExpertCarFamTitre = 'Liste de cat�gorie avec leurs familles associ�es';
  ChargeImpMess = 'Chargement de l''impression en cours...';
  LoadArtRay = 'Chargement de la liste des articles du rayon...';
  NkArtRefCap = 'Articles r�f�renc�s';
  NkCatFournCap = 'Articles des catalogues fournisseurs';

  SupRelGtsNK = 'Confirmez la suppression de l''association de la grille statistique' + #13 + #10 +
    '"�0"' + #13 + #10 + '� cette sous-famille...';
  NoSupGTSBaseNK = 'On ne peut pas supprimer l''association avec la grille statistique de base...';

  NkDefFam = 'NOUVELLE FAMILLE';
  NkDefSF = 'NOUVELLE SOUS-FAMILLE';

  DelNkRay = 'Confirmez la suppression du rayon "�0"';
  DelNkFam = 'Confirmez la suppression de la famille "�0"';
  DelNkSF = 'Confirmez la suppression de la sous-famille "�0"';

  DeleteNKRV = 'Probl�me lors de la suppression... le traitement est annul� !';

  NbtParamRech = 'D�finir une collection pour l''outil de recherche...';
  ParamRechTout = 'Toutes collections';
  NkDetail = 'D�tail de l''�l�ment s�lectionn�';
  NkRefreshMess = 'Fermeture de l''outil de gestion de la nomenclature';
  NkGesCharge = 'Chargement de l''outil de gestion de la nomenclature...';
  NkChxArt = 'Liste des mod�les selon la nomenclature...';
  NkRayon = 'Rayon';
  NkFamille = 'Famille';
  NkSSF = 'Sous-Famille';
  NkSecteur = 'Secteur';
  NkCategorie = 'Cat�gorie';

  NoNkDispo = 'Cha�nage impossible' + #13 + #10 + 'tant que vous n''avez pas termin� le travail en cours...';

  NoNkSelected = 'Aucun �l�ment s�lectionn� ! ...';
  NeedRayon = 'Il faut s�lectionner un rayon ! ... ';
  NeedFamille = 'Il faut s�lectionner une famille !... ';
  NeedSSF = 'Il faut s�lectionner une sous-famille !... ';

  NkNoArt = 'Aucun mod�le s�lectionn�! ...';
  FreeNk = 'D�charger la nomenclature de la m�moire ? ...';

  { Modifi� Sandrine Le : 15/02/2002  -   Ligne(s) }
  GestDroit = 'Vous n''avez pas les droits suffisant pour acc�der' + #13 + #10 +
    '� cette partie du programme' + #13 + #10 +
    'Contactez votre responsable !';

  { Modifi� Sandrine Le : 11/02/2002  -   Ligne(s) }
  CapCmzMenuDo = 'Activer la personnalisation des barres outils';
  CapCmzMenuOff = 'D�sActiver la personnalisation des barres outils';

  FinFiches = 'Fin du fichier...';
  debFiches = 'D�but du fichier ...';
  NoGoodPeriode = 'La date de fin doit �tre post�rieure � celle de d�but ! ...';
  FiltreReinit = 'Confirmer la suppression compl�te de toutes les conditions s�lectionn�es...';
  HintBtnDocSel = 'Ouvre le document point� dans son module de gestion...';
  { Modifi� BRUNO Le : 04/02/2002  -   Ligne(s) }
  EtiquetteEssai = 'Souhaitez-vous imprimer une �tiquette d''essai?';
  SautEtiquette = 'Impossible, le nombre d''�tiquette(s) � sauter doit �tre compris entre 0 et 20...';
  TitreEtikDiff = 'Impression des �tiquettes diff�r�es';
  PasSelect = 'Impression impossible, vous n''avez pas s�lectionn� les lignes...' + #13 + #10 +
    'Le bouton en bas � gauche vous permet de tout s�lectionner.';

  { Modifi� RV Le : 04/02/2002  -   Ligne(s) }
  messClotEtArchDoc = 'Le document � l''�cran n''est pas "cl�tur�"...' + #13 + #10 +
    'Faut-il le cl�turer et l''archiver ? ...' + #13 + #10 +
    '(Attention : l''archivage est irr�versible! ...)';

  MessArchDoc = 'Confirmer l''archivage du document affich� � l''�cran' + #13 + #10 +
    '(Attention : l''archivage est irr�versible! ...)';

  TitClotDoc = ' Cl�ture du document affich�...';
  TitArchDoc = ' Archivage du document affich�...';
  MessClotDoc = 'Confirmer la cl�ture du document affich� � l''�cran' + #13 + #10 +
    '(Attention : la cl�ture est irr�versible! ...)';

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
    'Impossible de proc�der au transfert! ...';
  BLLib = 'Bon de livraison';
  DevLib = 'Devis';
  DoDevTransDoc = 'Confirmez le transfert en "�0" du Devis affich� � l''�cran...   ';
  DoCopyModele = 'Confirmez la copie en "�0" du mod�le affich� � l''�cran...   ';
  DoCopyModMod = 'Confirmez la copie en "�0" du document affich� � l''�cran...   ';

  OkDevTrans = 'Le devis affich� � l''�cran a �t� transf�r� en "�0" N� �1   ';
  DoTransNoModele = '(apr�s transfert le devis d''origine ne sera plus modifiable)';

  VendeurDef = 'Vendeur par d�faut des nouvelles lignes';
  HintEdBtnCanClear = '[Double-clic ou F4] Liste associ�e [SUPPR] Vider le champ';
  CannotChangeTipModele = 'On ne peut pas changer le type d''un mod�le...';
  DevTitreListe = 'Liste des devis';
  DevTitreMod = 'Liste des Mod�les';
  NoSupprExportedDev = 'Suppression impossible !' + #13 + #10 +
    'Ce devis contient des lignes transf�r�es dans un autre document! ...';
  NoSupprExportedLine = 'Suppression impossible !' + #13 + #10 +
    'Ligne de devis transf�r�e dans un autre document...';
  ImpIntDev = 'Devis N� �0 - Client N� �1  �2';

  { Modifi� RV Le : 22/01/2002  -   Ligne(s) }
  MrkDejaRef = 'Marque d�j� r�f�renc�e chez ce fournisseur...';
  MessOuvreRal = 'Mise en place du contr�le dans le "Reste � Livrer"...';
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
  MessVerifInv = 'V�rification en cours...';
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

  { Modifi� RV Le : 07/01/2002  -   Ligne(s) }
  HintDbgDef = '[Maj+F11] Colonnes � leur largeur minimum';
  // Pascal 07/01/2001
  CstInvClotureNonOK = '    Erreur durant La cl�ture de l''inventaire   ' + #13 + #10 + #13 + #10 +
    '    Appeler GINKOIA SA pour r�soudre votre probl�me ';

  LabDateStk = 'Editer l''�tat du stock au';

  StkDetailLib = 'Liste d�taill�e des articles au : �0';
  { Modifi� Pascal 31/12/2001 }
  CstAnalSynth = 'Analyse synth�tique du �0 au �1 ';
  CstAnalSynthCUM = 'Analyse synth�tique (cumul des magasins) du �0 au �1 ';

  { Modifi� RV Le : 04/01/2002  -   Ligne(s) }
  HintBasculeGrpFoot = 'Basculer les cumuls interm�diaires entre "pied" et "ent�te" de groupe';
  { Modifi� RV Le : 31/12/2001  -   Ligne(s) }
  SupTarVente = 'Retirer l''article s�lectionn� de ce tarif de vente ? ... ';
  HintSumOnGroup = 'Afficher / Masquer les cumuls sur les lignes d''ent�te de groupe';
  HintAutoWidth = 'Ajustement automatique des colonnes "au mieux"';

  { Modifi� RV Le : 26/12/2001  -   Ligne(s) }
  NoTouchTarBase = 'On ne peut ni modifier ni supprimer le tarif g�n�ral ! ... ';
  SupTarVenteOk = 'Suppression du tarif de vente termin�e...    ';
  TarVenteLinked = 'Impossible de supprimer ce tarif de vente car ' + #13 + #10 +
    'il est appliqu� par un magasin! ... ';

  { Modifi� RV Le : 24/12/2001  -   Ligne(s) }
  LabExporte = 'Export�';
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

  CstPassageEuro = ' ATTENTION, vous devez passer d�finitivement � l''Euro.'#13#10 +
    'Pour cela vos caisses doivent avoir leurs sessions cl�tur�es.'#13#10 +
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
  NoImpDocVide = 'Document vide ! ... aucune ligne � imprimer. ';
  TransMultiAvorted = 'Probl�me lors du transfert d''un document, le transfert est annul�...    ';

  { Modifi� RV Le : 03/12/2001  -   Ligne(s) }
  FactNoTip = 'Le type du document est obligatoire... ';
  NoCatalog = 'Aucun catalogue fournisseur disponible sur votre machine... ';
  NoSupportedUnidim = 'Fonctionnalit� "Taille/Couleur" sans objet dans un univers qui n''en dispose pas! ... ';
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
  DeviseEuro = '�'; //DeviseEuro = 'EUR';
  NoNegEuro = 'D�sol�, mais on ne peut imprimer une facture que dans la monnaie de r�f�rence...    ';
  CoefNull = 'Attention : Prix de vente de base � "0"... ' + #13 + #10 +
    ' Faut-il l''accepter ? ... '#13 + #10;

  { Modifi� RV Le : 25/11/2001  -   Ligne(s) }
  DocImp = 'Imprimer les �0 documents s�lectionn�s ? ... ';
  NoDocArticle = 'Aucun article en cours (affich�) dans la fiche article...   ';
  DocCloture = 'Confirmer la cl�ture de(s) �0 document(s) s�lectionn�(s)...    ';
  NoDocCloture = 'Aucun document � cl�turer...      ';
  DocLineINEdit = 'Impossible de changer de page tant que la ligne en cours n''a pas �t� valid�e...    ';
  { Modifi� Sandrine Le : 21/11/2001  -  2 Ligne(s) }
  CsBL = 'Bons de livraison';
  CsFacture = 'Factures';

  { Modifi� RV Le : 20/11/2001  -   Ligne(s) }
  AfterToDay = 'Impossible de saisir une date post�rieure � aujourd''hui! ... ';
  MaxToDay = 'Impossible de saisir une date ant�rieure � aujourd''hui!...    ';

  { Modifi� RV Le : 15/11/2001  -   Ligne(s) }
  ArchivedDoc = 'Document archiv� ! ... Il ne peut plus �tre ni modifi� ni supprim�. ';
  CloturedDoc = 'Document cl�tur� !... Il ne peut plus �tre ni modifi� ni supprim�.    ';
  NotModifDoc = 'Document non modifiable... ( ni "supprimable" )';
  NoSupprImportedLine = 'Impossible de supprimer une ligne import�e depuis un Bon de Livraison ! ... ';
  NoSupprImportedFac = 'Impossible de supprimer cette facture ! ... ' + #13 + #10 +
    '   ( Elle contient des lignes import�es depuis un Bon de Livraison ) ';

  FacLib = 'Facture';
  AvoirLib = 'Avoir';
  FacPbCptClt = 'Probl�me de mise � jour du compte client! ... ';
  ImpIntFac = 'Facture N� �0 - Client N� �1  �2';
  ImpIntBL = 'BL N� �0 - Client N� �1  �2';

  NoDocFound = 'Le document "�0" n''a pas �t� trouv� dans la liste des documents...     ';
  BLTransNoLine = 'Aucune ligne � transf�rer ! ...';

  // Pascal Le 6/11/2001
  CstInvAfficher = 'Appuyer sur le bouton afficher les articles pour pouvoir charger le PHL !';
  CstInvSUPNon = 'La suppression d''un inventaire n''est plus possible apr�s sa cl�ture.';
  CstStckCourDate = 'Etat de stock au �0';

  { Modifi� RV Le : 05/11/2001 }

  BLNOTrans = 'Aucun transfert � effectuer';
  BLTransEnFact = 'Transf�r� en facture';
  BlConfTrans = 'Confirmez le transfert en facture des bons de livraison s�lectionn�s...    ';
  BLPBLORSTRAns = 'Probl�me lors du transfert de ce bon de livraison en facture...';
  BLTransNoPoss = 'Transfert impossible...';
  NegCOmTransBL = 'Transfert du Bon de livraison N� ';
  DoBLTransFact = 'Confirmez le transfert du bon de livraison affich� en facture... ' + #13 + #10 +
    '   (Apr�s transfert le bon de livraison ne sera plus modifiable)';
  BLKourOkTransFact = 'Le bon de livraison a �t� transf�r� dans la facture N� �0    ';
  BLKourNoTransFact = 'Probl�me lors du transfert de ce bon de livraison en facture...    ';
  BLTitreListe = 'Liste des bons de livraison';
  FacTitreListe = 'Liste des Factures';
  HintEditGen = '[Ins] Cr�er [F2] Editer [Suppr] Supprimer';

  ChpBtnComent = '[F4 ou Double-clic] Ouvre le bloc m�mo de saisie associ�';
  NegLabComent = 'Texte libre';
  NegLabArticle = 'D�signation';
  NoChangeBecauseModif = 'La modification de ce champ n''est possible ' + #13 + #10 +
    '   que lorsque le document est en cr�ation... ';
  NoChangeBecauseLines = 'La modification de ce champ n''est plus possible ' + #13 + #10 +
    '   lorsque des lignes existent dans le document... ';
  FactNoClt = 'La saisie d''un client est obligatoire !      ';
  FactNoMag = 'La saisie du magasin est obligatoire !      ';
  ConfDeleteDoc = 'Confirmer la SUPPRESSION du document en cours... ';

  // Pascal Le 9/11/2001
  CstStockTousMag = 'Stock d�taill� tout magasin';
  // Pascal le 7/11/2001
  CstCaVendeurDateLib = 'CA par vendeur du �0 au �1  -  ';

  // Pascal le 6/11/2001
  CstInvRecompter = 'Recompter les articles de la liste ?';
  CstInvSupprimer = 'Ne pas recompter les articles de la liste et les sortir de l''inventaire ?';

  // Pascal le 6/11/2001
  CstInvAjoutArticle = 'Ajouter la s�lection � l''inventaire ?';

  // Modifi� Pascal le 02/11/2001
  CstFamille = 'Famille';
  CstSSFamille = 'Sous Famille';
  CstCategorie = 'Cat�gorie';
  CstGenre = 'Genre';

  { Modifi� RV Le :  02/11/2001 }
  ConsodivList = 'Liste des consommations diverses en saisie...    ';
  EdEcartInv = 'Ecarts d''inventaire du �0 au �1  -  ';

  // Modifi� Pascal le 31/10/2001
  CstInvClotureOK = 'La cl�ture de l''inventaire s''est bien pass�e';
  CstInvClotEnCours = 'Cl�ture de l''inventaire en cours';
  CstInvDemEnCours = 'Cr�ation de la d�marque en cours';
  CstInvProblemePHL = 'Probl�me de r�ception sur le PHL';
  CstInvChargePHL = 'Chargement du PHL termin�';
  CstInvTousCompte = 'Aucun article n''a �t� mouvement� pendant l''inventaire'#13#10'                Rien n''est � recompter';
  CstInvARecompte =
    '   Les articles suivants ont �t� mouvement� pendant l''inventaire'#13#10 +
    'Vous devriez les recompter ou les supprimer pour que la cl�ture soit exacte';

  CstInvOuvOk = 'L''ouverture d''inventaire s''est bien pass�e.'#13#10'Vous pouvez maintenant commencer � travailler';
  CstInvTitreImpNC = ' Edition des non compt�s inventaire num �0, �1';
  CstInvTitreImpEcart = ' Edition des �carts inventaire num �0, �1';
  CstInvTitreImpValo = ' Edition valoris�e de l''inventaire num �0, �1';
  CstHistoTaille = 'Toutes tailles';
  CstHistoCoul = 'Toutes couleurs';

  { Modifi� RV Le : 30/10/2001  -   Ligne(s) }
  NoDataVide = 'Impossible de valider sans une donn�e significative! ... ';

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
  CstInvRechVide = 'Aucun article trouv�... ( V�rifier s''il est en inventaire ) ';
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

  TitleHistoVente = 'Historique de vente de l''article - Chrono : ';
  TitleHistoMvt = 'Historique des mouvements de l''article - Chrono : ';
  TitleHistoRetro = 'Historique "R�tros et D�marques" de l''article - Chrono : ';

  // Herv�  6/10/2001
  HintcdvMM = 'Liste des consommations diverses depuis le :';
  HintBtnCopy = '[CTRL+P] ou [Clic Bouton "..."] Recopie la valeur de la fiche pr�c�dente';
  ErrFrnDelContact = 'Confirmez la suppression du contact s�lectionn�...   ';
  ErrNomContact = 'Un contact doit obligatoirement avoir un nom !... ';
  FrnCapDetail = 'Renseignements compl�mentaires';
  FrnNoDelSeul = 'Un fournisseur doit avoir au moins 1 marque distribu�e...';
  FrnNoDelCde = 'Impossible de supprimer,     ' + #13 + #10 + '   il y a des commandes de cette marque chez ce fournisseur...      ';
  FrnNoDelRecep = 'Impossible de supprimer,     ' + #13 + #10 + '   il y a des r�ceptions de cette marque chez ce fournisseur...      ';
  FrnNoDelPrin = 'Impossible... car cette marque n''aurait plus de fournisseur principal!   ' + #13 + #10 +
    '   (Il suffit de lui associer un autre fournisseur principal)     ';

  errMajPvteRecep = 'Erreur lors de la mise � jour du prix de vente... ' + #13 + #10 +
    ' Il faudra aller le mettre � jour dans la fiche article. ' + #13 + #10 +
    ' SVP : Pr�venez GINKOIA que vous avez eu ce message... Merci ';

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
    ' Appelez GINKOIA en urgence !';
  ErrPush = ' Erreur lors de ENVOI du module : �0 ';
  ErrPull = ' Erreur lors de la RECEPTION du module : �0 ';
  Donnee = ' - Donn�es "';
  DonneeEnvFin = '" envoy�es !';
  DonneeRecFin = '" re�ues !';
  Fin1 = 'Envoi termin� avec succ�s';
  Fin = 'R�ception termin�e avec succ�s';
  ErrFin1 = 'Echec lors de l' + #39 + 'envoi de vos donn�es';
  ErrFin = 'Echec lors de la r�ception de vos donn�es';

  //
  IniCreaArtSport = 'Article dimensionn� (Tailles, couleurs)';
  IniCreaArtBrun = 'Article Normal';

  RecepConfRef = 'Confirmer le r�f�rencement de l''article catalogue r�f�rence "�0"... ';
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
  CapQuitter = '&Quitter';
  CapCancel = '&Abandonner';
  HintDlgQuit = '[Echap] Quitter';
  HintDlgOkCancel = '[F12]  OK    [Echap]  Abandonner ';
  HintMemo = '[Maj+Fl�che Haut] Champ pr�c�dent  [Maj+Fl�che Bas] Champ Suivant';

  HintExpandNode = 'Ouvrir toutes les lignes du groupe de lignes s�lectionn�';
  HintCollapseNode = 'Fermer le groupe de lignes s�lectionn�';
  HintFullExpand = 'Ouvrir la liste � son niveau de d�tail maximum';

  HintBtnConvert = 'Changer la monnaie d''affichage...';
  HintBtnPreview = 'Afficher / Cacher la ligne de donn�e suppl�mentaire';
  HintBtnPrintDbg = 'Imprimer la liste affich�e';
  HintBtnSelMag = 'Liste de s�lection des magasins... ';
  HintPeriodeEtude = 'D�finir une p�riode d''�tude... ';
  HintBtnCmzDbg = 'Outil de configuration des lignes';
  HintBtnClearFilterDbg = '[F11] R�initialiser le filtre actif dans les lignes...';
  HintBtnShowGroupPanel = 'Afficher / Cacher la zone d''affichage des groupes';
  HintBtnShowFooter = 'Afficher / Cacher les cumuls de fin des lignes';
  HintBtnShowFooterRow = 'Afficher / Cacher les cumuls interm�diaires des lignes';
  HintBtnExcelDbg = 'Exporter les lignes dans Excel (Excel est automatiquement ouvert)';
  HintBtnPopup = 'Menu des fonctions annexes  [Clic droit]';
  HintBtnRefresh = 'Rafra�chir les donn�es affich�es (Relecture des donn�es sur le serveur)';
  HintBtnCancel = '[Echap]  Abandonner les modifications effectu�es';
  HintBtnEdit = '[F2] Modifier le document affich�';
  HintBtnDelete = '[Suppr] Supprimer le document affich�';
  HintBtnInsert = '[Ins] Ouvrir un nouveau document';
  HintBtnPrintDoc = 'Imprimer le document affich� � l''�cran';
  HintBtnQuitDlg = 'Fermer la liste [Echap]';
  HintGenerikFrm = '[F12] Enregistrer   [Echap] Abandonner   [F2] Modifier   [SUPPR] Supprimer';
  HintGenerikFrmNoSuppr = '[F2] Modifier   [F12] Enregistrer   [Echap] Abandonner';

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

  CtrlJetons = 'Impossible d''ouvrir Ginkoia... ' + #13 + #10 +
    '   Nombre de postes autoris�s d�pass�... ';
  ErrPoste = 'Impossible d''ouvrir GINKOIA sans un nom de poste d�fini';
  ErrServeurPoste = 'Le serveur �0 ' + #13 + #10 + 'n' + #39 + 'a pas de poste d�fini !';
  NomTVT = 'Tarif g�n�ral';
  NietConvert = 'On ne peut pas changer de devise lorsqu''une t�che est en �dition... ';
  NietModifTTrav = 'On ne peut pas supprimer une taille travaill�e ou une couleur ' + #13 + #10 +
    '   lorsqu''une commande, une r�ception ou un transfert sont en �dition... ';
  NietDeleteArt = 'On ne peut pas supprimer un article ' + #13 + #10 +
    '   lorsqu''une commande, une r�ception ou un transfert sont en �dition... ';
  TransNoStk = 'IMPOSSIBLE : cet article n''a jamais �t� r�f�renc� en stock... ';

  // Messages du module de dimension

  GtfMajData = 'Probl�me de mise � jour des donn�es...  ';
  MessGTFREF = 'Impossible de supprimer une grille de tailles de r�f�rence...';
  MessGTFSup = 'Confirmez-vous la suppression de cette grille de tailles ?';
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
  ErrNomSSFamille = ' Ce nom de Sous Famille n' + #39 + 'est pas valable!';

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
  ErrManqueTCT = ' Le type comptable d''achat et de vente n''est pas d�fini!';
  ErrManqueSSF = 'La Sous-Famille n' + #39 + 'est pas d�finie!';
  ErrManqueGTS = ' La Grille de tailles Statistique n' + #39 + 'est pas d�finie!';

  ErrSupprRayon = ' Au moins un Article r�f�rence une sous-famille de ce Rayon !';
  ErrSupprFamille =
    ' Au moins un Article r�f�rence une sous-famille de cette Famille!';
  ErrSupprSSFamille = ' Au moins un Article r�f�rence cette sous-famille!';

  ErrCle = ' Cette s�lection est vide!';
  ErrNiveauCle = ' Aucun niveau cette s�lection!';

  //    WARSuppr = ' Etes-vous s�r de vouloir supprimer �0 de votre Nomenclature ?';
  WARSupprSelection = ' Etes-vous s�r de vouloir supprimer la s�lection "�0" ?';
  ErrDetruireSelection = ' Votre s�lection r�f�rence des donn�es qui ne sont plus valides,' + #10 + #13 +
    ' Elle est donc supprim�e !';
  CNFModifSelection = ' Etes-vous s�r de vouloir modifier la s�lection "�0" ?';
  INFRayonInvisible = ' Les Rayons ne sont pas visibles, modifiez leur visibilit� pour pouvoir travailler !';

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

  CNFSuperRayon0 = 'Retirer le Rayon "�0" de la liste des secteurs? ...' + #13 + #10 +
    '(Ce Rayon n''aura plus de Secteur associ�...)';
  CNFAffectSuperRayon = 'Placer le Rayon "�0"' + #13 + #10 + 'Dans le Secteur ? " " ...';

  // Selection_Dial

  NkItemRadioRay = 'S�lectionner tous les Rayons contenant :';
  NkItemRadioFam = 'S�lectionner toutes les Familles contenant :';
  NkItemRadioSf = 'S�lectionner toutes les Sous-Familles contenant :';
  NkCeRayon = 'ce Rayon';
  NkCetteFam = 'cette Famille';
  NkCetteSf = 'cette Sous-Famille';

  CNFAbandonSelection = ' Si vous abandonnez maintenant votre s�lection sera perdue.' + #13 + #10 +
    '  Etes-vous s�r de vouloir abandonner ?';
  CNFSupprFam = ' Attention des Familles de �0 sont d�j� dans la s�lection !' + #13 + #10 +
    ' Pour rajouter �0, il faut les enlever.';

  CNFSupprSSFam = ' Attention des Sous-Familles de �0 sont d�j� dans la s�lection !' + #13 + #10 +
    ' Pour rajouter �0, il faut les enlever.';
  CNFSupprFam_SSFam = ' Attention des Familles et des Sous-Familles de �0 sont d�j� dans la s�lection !' +
    #13 + #10 + ' Pour rajouter �0, il faut les enlever.';
  ErrRayon = ' Le Rayon de �0 est d�j� s�lectionn� !';
  ErrFamille = ' La Famille de cette Sous-Famille est d�j� s�lectionn�e !';
  WarSupprItem = ' Etes-vous s�r de vouloir enlever "�0" de la s�lection !';
  WarViderListe = ' Etes-vous s�r de vouloir supprimer tous les �l�ments de la s�lection!';

  // Bon de commande

  CdeSsGenre = 'Sans Genre';
  CdeListeVide = 'Liste de recherche vide...    ';
  CdeTitCritRech = 'Crit�re de recherche : ';
  CdeSaisLine = 'Saisie d''une ligne';
  CdeBcde = 'Bon de Commande';
  CdeOkModif = 'Modifiable';
  CdeNotModif = 'Non Modifiable';
  CdeCancelBcde = 'Abandonner toutes les modifications entreprises dans le document ? ' + #13 + #10 +
    'Toutes les modifications �ventuellement faites dans les lignes seront abandonn�es !';
  CdeCancelLine = 'Abandonner les modifications r�alis�es dans cette ligne ?   ';
  CdePostBcde = 'Enregistrer les modifications du document en cours ?    ';
  CdeTabloVide = 'Impossible de valider une ligne sans quantit� saisie... ';
  cdeLineInModif = 'Pour pouvoir changer d''onglet,' + #13 + #10 +
    'il faut d''abord valider [F12] ou abandonner la ligne en cours de saisie ';

  CdePxBase = 'Prix de Base';
  CdeConfDelLine = 'Confirmer la suppression de la ligne s�lectionn�e...   ';
  CdeConfDelBcde = 'Confirmer la suppression compl�te du document affich�... ';
  CdeConfConfDelBcde = 'La suppression de ce document est irr�versible !' + #13 + #10 +
    'Etes-vous bien certain de vouloir le supprimer ?   ';
  CdeFournOblig = 'La saisie du fournisseur est obligatoire! ... ';
  CdeMagOblig = 'La saisie du magasin est obligatoire!...    ';
  CdeExercice = 'La saisie de l''exercice commercial est obligatoire! ... ';
  CdeRgltOblig = 'La saisie des conditions de paiement est obligatoire!...   ';
  CdeOnlyOneSuppr = 'Plusieurs lignes s�lectionn�es...    ' + #13 + #10 +
    ' On ne peut supprimer qu''une seule ligne � la fois !     ';
  CdeNewBcde = 'Nlle Commande';
  CdeNewRecep = 'Nlle R�ception';
  CdeNewTrans = 'Nx Transfert';
  CdeExerciceOblig = 'La saisie de l''exercice commercial est obligatoire...   ';
  CdeDateRglt = 'La date de r�glement ne peut pas �tre ant�rieure � la date de livraison! ... ';

  CdeArchive = 'Confirmer l''archivage de(s) �0 document(s) s�lectionn�(s)...    ';
  CdeNoArchive = 'Aucun document � archiver... ';
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

  RechNoCollec = 'IMPOSSIBLE, aucune collection n''est s�lectionn�e... ';

  // FicheArticle

  MessExcel = ' Voulez-vous ouvrir Excel ?';
  InfExcel = ' Le fichier Excel �0 a �t� g�n�r�.';
  TipartPseudo = 'Pseudo';
  TipartRefSP2000 = 'R�f. SP2000';
  TipartCATMAN = 'CATMAN';
  TipartRef = 'Mod�le';
  TipartCat = 'Catalogue';
  FartDelartCnf = 'de la fiche article - code chrono :';
  FartListeDes = 'Liste des';
  FartGarantie = 'GARANTIE CONSTRUCTEUR';
  TipartISF = 'Intersport';
  TipartMagISF = 'Mod�le local';
  
  // ClassementDial

  ClasseTitle = ' El�ments du classement : ';
  ClasseDbgHint = '[INSER] Cr�er    [F2] Modifier    [SUPPR] Supprimer';

  ErrClassement = 'Ce nom de classement n' + #39 + 'est pas valide !';
  ErrItemClassement = 'Le nom n' + #39 + 'est pas valide !';
  ErrIntegrityArticle = 'Ce classement est utilis� par un article !';
  ErrIntegrityClient = 'Ce classement est utilis� par un client...';
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
  RechFiltre = 'Impossible d''acc�der � la fiche trouv�e...' + #13#10 +
    'V�rifiez que vous n''avez pas un filtre en cours';
  OnRef = 'R�f�rencement';
  OnIns = 'Cr�ation';
  ArtSupGroup = 'Supprimer le groupe "�0" pour cet article? ... ';
  ArtSupCollec = 'Supprimer la collection "�0" pour cet article ?...';

  ArtSupGarantie = 'Confirmez la suppression de la garantie �0';
  ErrEditGarantie = 'Le nom de cette garantie ne peut pas �tre modifi�...';

  FartCBFNoValid = 'Code Barre fournisseur Non Valide ( ou d�j� utilis� )...    ';

  Fart_dela = 'de la fiche article en cours...';
  FartCtrlCdmnt = 'Le champ conditionnement est d�coch� !          ' + #13 + #10 +
    #13 + #10 +
    'Un article ne peut �tre conditionn� que si :   ' + #13 + #10 +
    '- L''unit� est d�finie.' + #13 + #10 +
    '- La quantit� de conditionnement est sup�rieure � 1';
  FartTdb = 'Prix de base';
  FartSupprTar = 'Confirmez la suppression du particulier de la taille affich�e... ';
  FartNoGTaille = 'IMPOSSIBLE car aucune grille de tailles de s�lectionn�e... ';
  FartTarifExist = 'La taille �0 a d�j� un tarif sp�cifique d�fini... ';
  FartErrMajTailles = 'Probl�me lors de la mise � jour du tarif ...     ' + #13 + #10 + 'Vos modifications sont abandonn�es !';
  FartSupprTailBase = 'On ne peut pas supprimer le prix de base ! ... ';
  FartSupprTail = 'Pour supprimer des tailles travaill�es' + #13 + #10 +
    'il faut commencer par la plus petite et descendre une � une...' + #13 + #10 +
    '( On ne peut supprimer ni la taille de base ni une taille interm�diaire )';
  FartAvortCrea = 'Cr�ation d''article impossible... ' + #13 + #10 +
    '  Probl�me de g�n�ration du prix de vente de base. ';
  TabachatStd = 'Tarif';
  TabachatCrea = 'Nouvel Article';
  FartNomartOblig = 'Le nom du mod�le est obligatoire... ';
  FartFournOblig = 'La d�signation d''un fournisseur est obligatoire ...     ';
  FartMarkOblig = 'La d�signation d''une marque est obligatoire ...      ';
  FartCodeModeleOblig = 'Le code mod�le doit contenir au moins trois caract�res ...      ';
  FartCodeCouleurUnique = 'Le code couleur doit �tre unique dans le mod�le ...      ';
  FartCodeCouleurTropCourt = 'Le code couleur doit contenir au moins trois caract�res ...      ';
  FartArtCouleurCodeDefaut = 'UNI';
  FartArtCouleurNomDefaut = 'Unicolor';
  FartSsfOblig = 'La d�signation d''un classement dans la nomenclature est obligatoire... ';
  FartGtOblig = 'La d�signation d''une grille de tailles est obligatoire... ';
  FartFourCrea = 'Probl�me lors de l''initialisation du fournisseur... ';
  FartNeoFourn = 'Ajouter le fournisseur "�0" � la liste ' + #13 + #10 +
    'des fournisseurs de l''article en cours ? ';
  FartFournExist = 'Le fournisseur "�0" est d�j� r�f�renc� par cet article...   ';
  FartFourn = 'Fournisseur';
  FartFPrin = 'Frn.Principal';
  CnfSupFourn = 'Confirmer la suppression du fournisseur "�0" ';
  FournSupPrin = 'Impossible de supprimer "�0" car c''est le fournisseur principal    ';
  FournDejaPrin = '"�0" est d�j� le fournisseur principal...   ';
  ChangeFornPrin = 'D�finir "�0" comme fournisseur principal ?   ';
  FartchangeSf = 'ATTENTION : Si vous venez de changer l''affectation nomenclature ' + #13 + #10 +
    ' de cet article, v�rifiez que son affectation comptable et sa TVA conviennent toujours ! ';
  ArtRefMarque = ' R�f�rence Marque : ';

  ErrCoefTheorique = 'Le coefficient th�orique doit �tre sup�rieur � 0 !';
  CanModifHint =
    '[INS] Nouveau mod�le [F2] Modifier [F12] Enregistrer [SUPPR] Supprimer le mod�le [Clic Droit] Popup Menu';
  CannotModifHint = 'Fiche mod�le';
  HintNotEditChpTaille = '[F4, Double Clic ou Bouton] Liste des tailles travaill�es du mod�le';
  HintInsertChpTaille = '[F4, Double Clic ou Bouton] Liste des grilles de tailles  [Suppr] Supprimer la grille de tailles s�lectionn�e';
  HintEditChpTaille = '[F4, Double Clic ou Bouton] Gestion des tailles travaill�es du mod�le';
  HintDesDbgs = '[INS] Ajouter un nouvel �l�ment  [SUPPR] Supprimer l''�l�ment s�lectionn�';
  HintEditFourn = 'Liste des fournisseurs r�f�renc�s pour ce mod�le    ';

  TitleStk = 'Etat de stock de l' + #39 + 'article - Chrono :';
  TitleRal = 'Reste � Livrer de l' + #39 + 'article - Chrono :';
  TitleStkMM = 'Etat de stock par magasin de l' + #39 + 'article - Chrono :';
  TitleRalMM = 'Reste � Livrer par magasin de l' + #39 + 'article - Chrono :';
  TitleHistoFourn = 'Historique d''achat de l''article - Chrono : ';

  MsgLKNotEdit = 'Vous n''�tes pas en �dition ! Impossible de mettre � jour la fiche article... ';
  ChronoMess = ' Le pr�fixe n''est pas modifiable';
  SupprImgCap = ' Suppression de l''image associ�e';
  CopyImgCap = ' Association d''une image � l''article en cours';
  SupprImg = 'Supprimer l''image associ�e � l''article en cours ?';
  Fart_UnikChrono = 'Ce code chrono est d�j� pris par un autre article... ';
  FartNoFourn = 'Avant de saisir le tarif il faut d�finir le fournisseur principal !    ';
  FartCoulGes = 'Gestion des couleurs de l''article';
  FartCoulVisu = 'Liste des couleurs d�finies pour l''article';
  FartSupprGT = 'La suppression de la grille de tailles va supprimer le tarif d�fini... ' + #13 + #10 +
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
  MessGtfLibVid = 'Le nom de la grille de tailles est obligatoire...';
  MessNbtaille = 'Impossible de valider votre grille de tailles, elle ne contient pas de taille...';
  MessModLibGTF = 'Impossible de changer le libell� d''une grille de tailles de r�f�rence';
  MessModLibTail = 'Impossible de changer le libell� d''une taille de r�f�rence';
  MessModLibVid = 'Le nom du mod�le est obligatoire...';
  MessMod28 = 'Impossible, le nombre de tailles travaill�es est limit� � 28...';
  GtfHintTailles = '[INS] Ins�rer une nouvelle taille   [CTRL+INS] Ins�rer une sous-taille';
  GtfNoDelete = 'IMPOSSIBLE de supprimer cette grille de tailles car elle est utilis�e !...   ';
  GTSCannotDelete = 'IMPOSSIBLE de supprimer la grille de tailles statistique "�0" ' + #13 + #10 +
    ' car elle est r�f�renc�e par une Sous-Famille.';

  GtfModeleHint = '[F3] S�lectionne la taille point�e  [Double Clic] Ajoute la taille point�e � la liste des tailles travaill�es';
  GtfModeleHint2 = '[F3] S�lectionne la taille point�e  [Double Clic] Retire la taille point�e de la liste des tailles travaill�es';
  MessModEnf = 'Impossible de d�placer cette "taille", car la taille parent n''est pas un s�lectionn�e...';
  MessGTSCancel = 'Abandonner les modifications effectu�es dans la grille de tailles "�0"   ';
  GtsCreaChpOblig = 'Le nom et la cat�gorie doivent �tre obligatoirement renseign�s! ... ';
  GtfManqueNom = 'Le nom de la taille doit �tre obligatoirement d�fini... ';
  GtfCancelWork = 'Abandonner tout le travail effectu� sur cette grille de tailles ? ... ';

  MessSupCoulTer = 'Impossible de supprimer cette couleur,' + #13 + #10 + '   car elle est pr�sente dans les commandes...';
  SelcoulDbg = '[F4] et [Double Clic] Ex�cuter la fonction associ�e au bouton';
  CoulFormHint = '[F12] OK  [Echap]  Abandonner';
  CoulOkGesFormHint = '[Ins] Cr�er [F2] Editer [Suppr] Supprimer [F4] Ouvrir liste';
  CoulStatOkGesFormHint = '[Ins] Cr�er [Ctrl+Ins] Sous-couleur [F2] Editer [F12] Ok';
  RecepModerOblig = 'La saisie du mode de r�glement est obligatoire! ... ';

  // Marque_Frm

  messMARQUEGtf = 'Attention vous pouvez d�placer 100 tailles maximums � la fois...';

  // SelGt_Frm

  SelTTailO = 'La s�lection d''au moins une taille travaill�e est obligatoire... ';
  SelGTTitle = ' S�lection d''une grille de tailles et des tailles � travailler';

  // Fournisseurs
  FourNoVille = 'Attention pas de ville !!!';
  FourErrNoDelete = 'Impossible de supprimer ce fournisseur car il a des donn�es associ�es     ';
  FourCnfDel = 'Etes-vous s�r de vouloir supprimer ce fournisseur?';
  ErrNoPaysListeFact = 'Vous devez obligatoirement renseigner le pays de cette ville �0';
  ErrNoPaysExprfourn = 'Vous devez obligatoirement renseigner le pays de cette ville �0';
  ErrNoVilleExprfourn = 'Vous devez obligatoirement renseigner la ville du fournisseur �0';
  ErrNomFournExprfourn = 'Le nom du fournisseur est obligatoire !';
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
  RecepOkCloture = 'Confirmer la cl�ture du bon de r�ception affich�... ' + #13 + #10 +
    '  ATTENTION : ce document ne sera plus modifiable ! ';
  RecepArtExist = 'Cet article est d�j� r�f�renc� dans le bon de r�ception ! ... ';
  RecepCadExist = '[ Chrono : "�0" ] Cette cadence est d�j� r�f�renc�e dans le bon de r�ception. ' + #13 + #10 +
    '   Faut-il compl�ter cette ligne avec les quantit�s restant � livrer ? ... ';
  RecepDateRglt = 'La date de r�glement ne peut pas �tre ant�rieure � la date de livraison! ... ';
  RecepNoRal = 'Aucun reste � livrer chez ce fournisseur...     ';
  RecepNotModif = 'Cl�tur�';
  TransArtExist = '[ Chrono : "�0" ] Cet article est d�j� r�f�renc� dans le bon de transfert ! ... ';
  TransIdemMag = 'Magasin d''origine et de destination doivent �tre diff�rents ! ... ';
  CdeNoDocVide = 'Impossible de valider un " document " vide ! ... ';
  CdeNoChangeChp = 'Modification impossible lorsque le document a des lignes... ';
  TransOkCloture = 'Confirmer la cl�ture du bon de Transfert affich� ...   ' + #13 + #10 +
    '  ATTENTION : ce document ne sera plus modifiable ! ';
  CdeVR = 'Voir RAL';
  CdeNVR = 'Masquer RAL';
  CdeTitreListe = '  Liste des bons de commande';
  recepTitreListe = '   Liste des bons de r�ception';
  transTitreListe = '   Liste des bons de transfert';
  TransIsNega = 'ATTENTION : le stock de cette taille / couleur va devenir n�gative ! ... ';
  TransNoEdit = 'IMPOSSIBLE de modifier un bon de transfert au-del� de 30 jours ! ... ';
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
  SelectLineBre = 'Vous devez s�lectionner les lignes que vous voulez r�-�tiquetter !';
  RecepCapFrmRal = ' Restes � livrer : ';

  RecepErrInitTab1 = 'Probl�me lors de la cr�ation de cette ligne de r�ception...';
  RecepErrInitTab2 = 'Cette ligne doit �tre abandonn�e...';
  RecepErrInitTab3 = 'R�essayez une nouvelle fois et...';
  RecepErrInitTab4 = '        Merci de pr�venir GINKOIA SA qu''il subsiste des probl�mes lors de la     ';
  RecepErrInitTab5 = '        cr�ation de nouvelles lignes de r�ception.';

  // Edition de caisse

  JVTklDateLib = 'Journal des ventes du �0 au �1  -  ';
  HITParadeVte = 'Hit parade des ventes du �0 au �1  -  ';
  JVTkeDateLib = 'Liste des tickets du �0 au �1  -  ';
  JvTklSel = 'S�lection de magasins';
  FontCourierNew = 'Courier New';

  ConsoDivLib = 'Consommations diverses du �0 au �1  -  ';

  ChxDateJV = 'P�riode incorrecte ! ... Le date de fin ne peut �tre ant�rieure � celle de fin. ';
  ChxSessJV = 'Choix de session non valide ! ....    ';
  CHXDateJVMP = 'Le choix d''un magasin et d''un poste sont obligatoire... ';
  CptCltTit = 'Comptes clients  ';

  // Clients

  ErrNomClient = 'Vous devez obligatoirement sp�cifier un nom pour ce client';
  ErrNoAdrClient = ' La saisie d''une adresse est obligatoire';
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
  CdvOblig = ' La saisie du champ "�0" est obligatoire ! ... ';
  CdvNoPx = ' Le prix unitaire de cet article est � "0.00"... ' + #13 + #10 +
    '   (Il n''est certainement pas r�f�renc� en stock � cette date )' + #13 + #10 + #13 + #10 +
    '   Faut-il continuer et accepter cette op�ration ?';
  CdvCtrlDate = ' La date de cette op�ration ne peut pas �tre post�rieure ' + #13 + #10 +
    '   � la date courante... ';
  CdvDelai = ' Cette op�ration n''est plus modifiable... ';
  HintConsodiv = 'Pour une nouvelle ligne de consommation... rechercher l''article     [F12] Enregistrer [Echap] Abandonner [F2] Modifier';

  // Ressourcesstring communes des applications
  // ******************************************

  // 29/01/2001 - Sandrine MEDEIROS - ajout Messages Classiques : WarAbandon, WarAbandonCreat, WarAbandonModif

  //--------------------------------------------------------------------------------
  // Messages d'erreurs BDD
  //--------------------------------------------------------------------------------

  ErrLectINI = 'Erreur de lecture du fichier d''initialisation';
  ErrConnect = 'Erreur de connection � la base de donn�es';
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
    'Pr�venir GINKOIA SA en pr�cisant bien le contexte dans lequel cela se produit    ';
  ErrToMuchTransac = 'Probl�me de gestion du compteur de transaction' + #13 + #10 +
    'Le signaler � GINKOIA en pr�cisant bien le contexte dans lequel cela se produit.   ';

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
  RS_TXT_UIL_ErreurConfirmationCode = 'Erreur lors de la confirmation du mot de passe';

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

  WarAbandon = 'Etes-vous s�r de vouloir abandonner le travail en cours ?';
  WarCancel = 'Etes-vous s�r de vouloir abandonner les modifications effectu�es ?';
  WarAbandonCreat = 'Etes-vous s�r de vouloir abandonner votre cr�ation �0 ?';
  WarAbandonModif = 'Etes-vous s�r de vouloir abandonner votre modification �0 ?';
  WarSuppr = 'Confirmez la suppression �0 ... ';
  WarPost = 'Enregistrer le travail en cours ?';

  ErrIdRefCentrale = 'Cette �0 a �t� fournie par �1, elle n' + #39 + 'est pas modifiable !';
  ErrIdRefCentrale1 = 'Ce �0 a �t� fourni par �1, il n' + #39 + 'est pas modifiable !';

  //--------------------------------------------------------------------------------
  // Hints Standards
  //--------------------------------------------------------------------------------
  HintEditMemo1 = '[F4 ou Double Clic ou Bouton] Ouvre la zone d''�dition associ�e au bouton';
  HintNoEditMemo1 = 'La zone d''�dition n''est pas accessible';
  HintEditLookup1 = '[F4 ou Double Clic ou Bouton] Ouvre la liste associ�e au bouton  [Suppr] Effacer';
  HintNotEditLookup1 = 'La liste associ�e au bouton n''est pas accessible';
  HintEditCheck1 = 'Appuyer sur la barre d''espace ou cliquer pour inverser l''�tat de la coche';

  // Ressourcesstring communes des applications
  // ******************************************


  //****************************
  // Ressources de la caisse
  //****************************

      //28/02/2002 Bruno
  TrancheVide = 'Impossible, la correspondance entre la monnaie et les points est � z�ro';

  // Pascal 27/02/2002
  CstProbSession = ' Vous avez un probl�me de cl�ture'#13#10 +
    'Veuillez noter le message d''erreur et appeler GINKOIA'#13#10 +
    'Cliquer sur OK pour visualiser le message d''erreur';
  // Pascal 18/02/2002
  CstPasVersement = 'Aucun type de versement n''a �t� s�lectionn�';
  CstPasCoffre = 'Aucun coffre n''a �t� s�lectionn�';
  CstPasBanque = 'Aucune banque n''a �t� s�lectionn�e';

  // Bruno 18/02/2001
  RegulGlob01 = 'Dans un premier temps, vous allez devoir choisir le ticket � corriger.' + #13 + #10 +
    ' ' + #13 + #10 +
    '   Ensuite, Vous pourrez intervenir directement sur les encaissements r�alis�s sur ce ticket.';

  RegulGlob03 = 'Confirmez-vous l''annulation de votre correction d''encaissement?';

  // Bruno 15/02/2002
  ClientPasPossible = 'Impossible d''appeler ce client en caisse...';

  // 15/02/2002 Correction
  CstPasDencaissement = 'Aucun encaissement de ce type n''existe dans la session';
  //15/02/2002
  CstLibVerifComptage = 'Comptage  : Pi�ce %4d    Montant %10.2n';
  CstTickNum = 'Ticket num ';

  // Pascal 11/02/2002
  CstPanMoy = 'Panier moyen';
  CstValeur = 'Valeur';
  CstQuantite = 'Quantit�';
  CstVtProduit = 'Vente produit %s';
  CstVersAutoCoffre = 'VERSEMENTS AUTO AU COFFRE';
  CstVersAutoBQe = 'VERSEMENTS AUTO EN BANQUE';
  // Pascal le 7/02/2002
  CstDuAu = 'Du %s au %s';

  // Tri�
  Pas2Caisse = 'Vous ne pouvez pas, sur un m�me poste, activer plusieurs fois le module ''Caisse Ginkoia''...';

  DejaClientEnCours = 'Attention vous ne pouvez pas appeler ce client, il est d�j� en cours sur une autre caisse...';

  Aucuntrouve = 'Aucun article trouv� correspondant � votre saisie...';
  LibSousTotal = 'SOUS TOTAL';
  Question = 'Souhaitez-vous terminer' + #13 + #10 + 'le ticket en cours ?';
  LibTicketenCours = 'Impossible de quitter la caisse, vous avez un ticket en cours...';
  LibRapido = 'Impossible vous avez d�j� effectu� des op�rations dans l''onglet ''Encaissement''...';
  PasSessionEnCours = 'Attention, il n''y a pas de session en cours...';
  PasClientEnCours = ' Impossible, vous n''avez pas de client en cours ';
  Acompte = 'Acompte';
  Reglement = 'Reglement du compte';
  TXT_ReglementFacture = 'R�glement facture';
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
  PblImpressionFacturetteSuite = 'Probl�me lors de l''impression.' + #13 + #10 + 'Veuillez ins�rer � nouveau le document suivant...';

  FactureNumero = 'Facture Numero : ';
  LibCaissier = 'Caissier : ';
  LibVendeurCaisse = 'Vendeur  : ';
  AnnuationTck = 'ANNULATION DU TICKET NUMERO ';
  LbCorrectionMP = 'CORRECTION ENCAISSEMENT';
  LibCorrectionMP = 'Op�ration impossible, vous �tes en correction d''encaissement...';

  QuestionDepense = 'Confirmez-vous la saisie de d�pense?';
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
  InfEtatSesClotNoCtrl = 'Cl�tur�e mais non contr�l�e';
  InfEtatSesOuverte = 'Ouverte';
  ErrRecNotFound = 'Enregistrement non trouv�. Mise � jour impossible';

  InfApportFromSession = 'Fond Initial';
  InfRetraitToSession = 'Retrait vers la session n�';
  InfVersementBanque = 'Versement � la banque ';

  InfApportPoste = 'Apport en caisse : ';
  InfRetraitPoste = 'Retrait de la caisse : ';
  InfComptageGlobModeEnc = 'Comptage global d''un mode d''encaissement';
  InfComptageDetModeEnc = 'Comptage d�taill� d''un mode d''encaissement';
  InfPrelevement = 'Saisie manuelle d''un pr�l�vement';

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
  ErrNoPosteNoSession = 'Pas de poste ou de session s�lectionn�e';
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
  ErrNoModeEnc = 'Aucun mode d''encaissement s�lectionn�';
  ErrInvalidSource = 'Pas de source s�lectionn�e';
  ErrInvalidDest = 'Pas de destination s�lectionn�e';
  InfMontant = 'Montant en ';
  ErrInvalidQte = 'Nombre de pi�ces saisies incorrect';

  //General

      //PasCaissier = 'Attention, votre caisse est param�tr�e avec une gestion caissier,' + #13 + #10 + 'mais vous n''avez pas cr�� de caissier...';
      //PasSessionEnCours = 'Attention, il n''y a pas de session en cours...';
  InitModeEncImpossible = 'Impossible, des modes de paiement existent d�j� pour ce magasin...';
  Pascoffre = 'Vous devez au pr�alable cr�er un coffre pour ce magasin...';
  Pasbanque = 'Vous devez au pr�alable cr�er une banque pour ce magasin...';
  BtnDejaCree = 'Attention des boutons existent d�j�, voulez-vous les supprimer?';
  CaisseEnCours = 'Impossible de cl�turer la session, la caisse est encore ouverte';
  TMnonConnectee = ' L''imprimante ticket n''est pas allum�e ou pas branch�e...';
  TCnonConnecte = ' Le tiroir caisse n''est pas branch�...';
  JourDifferentSessionL1 = ' Attention, il existe une session en cours ouverte le ';
  JourDifferentSessionL2 = 'Souhaitez-vous cl�turer la session?';
  ConfAnnul = 'Confirmez-vous l''annulation de ce ticket?';
  DejaAnnule = 'Op�ration impossible, ce ticket est d�j� annul�...';
  AnnulRegul = 'Annulation de la correction des encaissements en cours?';
  Pasledroit = 'Attention, vous n''avez pas les droits pour utiliser cette fonction...';
  TicketSimple = 'Ticket simple';
  TicketTVA = 'Ticket avec TVA';
  Facturet = 'Facturette';
  TicketSansPrix = 'Ticket sans prix';
  Noticket       = 'Pas de ticket'; 
  SupEncaissement = 'Confirmez-vous l''annulation de cet encaissement?';
  CaptionAnnul = 'Annulation d''un ticket';
  CaptionCptcli = 'Liste des tickets';
  CaptionRegul = 'Correction des encaissements';

  //Param Caisse
  Chrono = 'Code Chrono';
  RefFourn = 'Ref. Fournisseur';

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
  BADispo = 'POINTS CUMULABLES JUSQU''AU';
  Utilisable = 'UTILISABLE JUSQU''AU';
  GenerationBAL1 = 'Votre client a droit � un Bon d''achat de';
  GenerationBAL2 = 'Souhaitez-vous le g�n�rer aujourd''hui?';
  BenefBA = 'Votre client b�n�ficie d''un bon d''achat de';
  ValiditeBA = 'valide jusqu''au';
  QuestionBenefBA = 'Est ce qu''il souhaite l''utiliser maintenant?';
  PasModeEncFidelite = 'Op�ration impossible, vous n''avez pas de mode d''encaissement avec le type ''Fid�lit�''';
  FidManuel = 'Points fid�lit�s saisis manuellement, pas de liaison avec un ticket de caisse...';
  BaPasUtilise = 'Ce bon d''achat n''a pas �t� utilis�...';
  BonAchat = 'Bon d''achat';
  NewParamCF = 'La liste des bons d''achat va �tre recalcul�e sur la base du param�trage que vous venez de saisir. ' +
    'Le param�trage pr�c�dent va �tre effac�...' + #13#10#13#10 +
    'Faut-il continuer ?';
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

  vente = 'Vente';
  Client = 'Client';
  Encaissement = 'Encaissement';
  Utilitaires = 'Utilitaires';
  BonLocA4 = 'Format A4 (2 Bon A5)';
  BonLocA5 = 'Format A5';
  BonLocA4Ident = 'Format A4 Tri� par identit� (2 Bon A5)';
  BonLocA5Ident = 'Format A5 Tri� par identit�';
  BonLocEtq     = 'Format Etiquette';

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
    '   Souhaitez-vous poursuivre la r�initialisation?';
  QuitterBtn = 'Pour que les changements soient pris en compte, il faut fermer tous les tickets en cours.' + #13 + #10 +
    '   Lorsqu''il ne reste plus que l''onglet ''Ecran de contr�le'' vous pouvez r�ouvrir la caisse...';
  CopierBtn = 'Attention cette op�ration d�truit les boutons existant et les remplace' + #13 + #10 +
    '   en prenant comme mod�le une caisse que vous allez s�lectionner ensuite.' + #13 + #10 +
    '   Souhaitez-vous poursuivre le traitement?';

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
  CstEnQuantite = '                    en Quantit�';
  CstEnQte = '             en Qte';
  CstCA = 'CHIFFRE D''AFFAIRES';
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
  CstFondCais2 = 'FOND DE CAISSE';
  CstEnc1 = '      Encaissements';
  CstEnc2 = ' Encaisse';
  CstSoldeEncaissement = '  Solde de l''encaissement : ';

  OKRegulGlob = 'Impossible, pour valider l''op�ration le solde doit �tre � z�ro';
  // Wilfrid 23/12/2007
  MessChargeZoneDeChalandise = 'Chargement de l''analyse des zones de chalandises ...';
  //Wilfrid 07/01/2008
  TitreUniteFedas = 'Nomenclature FEDAS';
  CodeFedasInexistant = 'Le code Fedas est inexistant';
  LongueurFedasCode = 'La longueur du code FEDAS doit �tre de 6 caract�res';

  // FTH : 07/10/2009
  msgNoMail = 'Aucune adresse email trouv�e pour %s, veuillez la renseigner ';
  msgYNMailling = 'Etes vous s�r de vouloir envoyer un mailling au(x) %s client(s) s�lectionn�(s) ? ' + #13#10#13#10 +
    'Attention : les clients sans adresse mail ne seront pas trait�s';
  msgNoSelectedClient = 'Vous devez s�lectionner au moins 1 client';
  msgNotEnoughSms = 'Vous n''avez pas assez de sms en reserve ! %s Restant - %s � envoyer';
  msgIsRemainSms = 'Il vous reste %s sms sur votre forfait';
  msgYNSms = 'Etes vous s�r de vouloir envoyer un Sms au(x) %s client(s) s�lectionn�(s) ? ' + #13#10#13#10 +
    'Attention : les clients sans num�ro de portable ne seront pas trait�s';
  msgNoGsmFound = 'Aucun des clients s�lectionn�s n''a de num�ro de portable renseign�';

  // FTH: 29/10/2009
  // ResCENTRAL****.*
  msgErrResCentSaveMailCFG = 'Erreur lors de l''enregistrement des donn�es mail : ';
  msgErrResCentSaveIdenMag = 'Erreur lors de la sauvegarde des donn�es identifiant magasin : ';
  msgErrResCentSaveOffComCFG = 'Erreur lors de l''enregistrement des donn�es offres commerciales : ';
  msgErrResCentSavePoinTailCFG = 'Erreur lors de la sauvegarde des donn�es pointures/tailles : ';

  msgErrResCentVerifAdrPrinc = 'Configuration %s : Veuillez saisir une adresse mail principale !!';
  msgErrResCentVerifPassWord = 'Configuration %s : Veuillez saisir un mot de passe !!';
  msgErrResCentVerifAdrMess = 'Configuration %s : Veuillez saisir une adresse de serveur de messagerie (Pop) !!';
  msgErrResCentVerifAdrMessSMTP = 'Configuration %s : Veuillez saisir une adresse de serveur de messagerie (SMTP) !!';

  CSH_TXT_AnnulLigne  = 'Annul. ligne';
  CSH_TXT_AnnulTicket = 'Abandon ticket';
  CSH_TXT_RetourCli   = 'Retour client';
  CSH_TXT_Remise      = 'Remise';

  CSH_TXT_ListeMotifSession = 'Liste motif de modification de tickets session N� %s';
  CSH_TXT_ListeMotifPeriode = 'Liste motif de modification de tickets du %s au %s';

  CSH_TXT_ExportBcdEnTxtOk = 'Le fichier %s a �t� g�n�r� avec succ�s '+#13#10+'dans le r�pertoire %s';
  CSH_TXT_ChargeExport = 'Chargement de l''export en cours...';

  CSH_ASK_CarteCBExpire = 'La carte bancaire est expir�e !'+#13#10+'Continuez ?';

  INV_TXT_Tous = 'Tous';
  INV_TXT_ModeChargeEcart      = 'Mode de chargement des �carts';
  INV_CHX_ChargeEcartToutRayon = 'Charger les �carts avec tous les rayons';
  INV_CHX_ChargeEcartUnRayon   = 'Charger les �carts pour 1 rayon au choix';

  ModuleTranporteurGLS = 'TRANSPORTEUR GLS';
  
  INV_ASK_JustifieEcart = 'Confirmez que vous souhaitez justifier les �carts' + #13#10 + 'des %s lignes s�lectionn�es...';
  INV_TXT_JustifieEcart = 'Justifier les �carts';
  INV_TXT_ModifJustifie = 'Motif de Justification (Saisie obligatoire)';

  BP_ASK_ConfirmerRecupColis = 'Confirmer que vous voulez r�cup�rer les N� de colis' + #13#10 + 'de Colissimo et/ou de So-Colissimo.';
  BP_ERR_MustConfigurerParamPoste = 'Veuillez param�trer le transporteur Colissimo et/ou So-Colissimo.';
  BP_ERR_AucunFichierLaPosteTrouve = 'Aucun fichier d''importation n''a �t� trouv�';
  BP_TXT_AucunColisImporte = 'Aucun colis n''a �t� import�';

  STA_TXT_ChargementReporting = 'Chargement du reporting';
  RESA_TXT_AnalyseResaDispo = 'Analyse de r�servation par cat�gorie d''article pour la p�riode du %s au %s';
  RESA_ERR_AucuneResaPourCetteCateg = 'Aucune r�servation pour cette cat�gorie';
  RESA_ERR_AuMoinsUnMagasin = 'Il faut cocher un magasin';
  RESA_ERR_IlNeFautQuUnMagasin = 'Il ne faut cocher qu''un seul magasin';

  COL_TXT_AvecLesNonActives = 'Avec les non actives';
  COL_TXT_SansLesNonActives = 'Sans les non actives';
  COL_TXT_AvecLesAnalysables = 'Avec les non analysables';
  COL_TXT_SansLesAnalysables = 'Sans les non analysables';
  COL_ERR_NomCollectionOblig = 'Le nom de la collection d''article est obligatoire !';
  
  RS_ERR_NomFichierInvalide = 'Un nom de fichier ne peut pas contenir les carat�res suivants: \/:*?"<>|';

  TOC_TXT_Permanent = 'Permanent';
  SLIP_TXT_RetireDocument = 'Veuillez retirer le document';
  SLIP_TXT_InsertDocument = 'Veuillez ins�rer le document'; 
  
  PXPRECO_TXT_PxVenPrecoATraiter = 'Il y a un ou plusieurs tarifs de vente pr�conis�s � traiter pour la p�riode du %s au %s';
  PXPRECO_LstEtat_Propose = 'Tarifs propos�s';
  PXPRECO_LstEtat_Accepte = 'Tarifs accept�s';
  PXPRECO_LstEtat_NoPropose = 'Tarifs � ne plus propos�s';
  PXPRECO_LstEtat_MisAJour = 'Tarifs Mises � jour';
  PXPRECO_Grille_EtatPropose = 'Propos�';
  PXPRECO_Grille_EtatAccepte = 'Accept�';
  PXPRECO_Grille_EtatNoPropose = 'Plus propos�';
  PXPRECO_Grille_EtatPlusieurs = 'Plusieurs';
  PXPRECO_Grille_EtatMisAJour = 'Mise � jour';
  PXPRECO_ERR_FautUnTarif = 'Il faut au moins un tarif de s�lectionn� !';
  PXPRECO_ERR_FautUnEtat = 'Il faut au moins un �tat de s�lectionn� !';
  PXPRECO_ERR_AucunModelePropose = 'Aucun mod�le n''a une proposition';
  PXPRECO_ASK_NePlusProposer = 'Ne plus proposer le tarif pr�conis� ?';
  PXPRECO_ASK_AppliquerDateEtPrixPreco = 'Appliquer la date et le prix pr�conis� ?';
  PXPRECO_ERR_DateDoitPlusGrandAujourdhui = 'La date doit �tre plus grande que la date du jour !';
  PXPRECO_ERR_TarifInvalide = 'Tarif invalide !';

  RS_TXT_PXPRECO_MajOK= 'Certains prix de vente ont �t� r�actualis�s, v�rifiez l''�tiquetage des mod�les concern�s.';
  RS_ERR_PXPRECO_MajNotOK= 'ATTENTION, des erreurs sont apparues lors de la mise � jour des prix de vente.';
  RS_TXT_PXPRECO_ConsultLst= 'Consulter la gestion des prix de vente pr�conis� � date pour obtenir la liste des articles concern�s.';
  RS_TXT_PXPRECO_EnteteMaj= 'Mise � jour des tarifs de vente';
  RS_TXT_PXPRECO_EnteteAlerte= 'Changement des tarifs de vente planifi�s';
  RS_TXT_PXPRECO_Alerte= 'Des changements de prix de vente sont planifi�s entre le �0 et le �1.';
  RS_TXT_PXPRECO_RECEPTIMM= 'Mise � jour des prix de ventes imm�diat.';
  RS_TXT_PXPRECO_RECEPTDIF= 'Mise � jour des prix de ventes diff�r� � date.';
  RS_TXT_PXPRECO_DATEMAJ= 'Date de mise � jour';
  RS_TXT_PXPRECO_ModeMaj= 'Choisissez le mode de mise � jour.';
  RS_TXT_MISEAJOUR_ENCOURS = 'Mise � jour en cours...';
  RS_TXT_PXPRECO_ENTETEPRINT = 'Prix de vente pr�conis�s � date';
  RS_TXT_PXPRECO_AjoutPxPreco = 'Ajouter un prix pr�conis�';
  RS_TXT_PXPRECO_AjoutPxDiffere = 'Ajouter un prix � une date diff�r�e';
  RS_TXT_PXPRECO_DatePreco = 'Date pr�conis�e';
  RS_TXT_PXPRECO_PrixPreco = 'Prix pr�conis�';
  RS_TXT_PXPRECO_DateValide = 'Date valid�e';              
  RS_TXT_PXPRECO_PrixValide = 'Prix valid�';
  RS_ERR_PXPRECO_NeedTarifGeneral = 'Veuillez au pr�alable, d�finir un tarif pour cette article';
  RS_ERR_PXPRECO_DateInvalide = 'La date doit �tre sup�rieure � la date du jour';
  RS_ERR_PXPRECO_PrixObligatoire = 'Prix Obligatoire';
  RS_ERR_PXPRECO_DatePrise = 'Il y a d�j� un prix pr�conis� � cette date';
  RS_ERR_PXPRECO_TarifAuSKU = 'Des prix sp�cifiques sont pr�sents � la taille/couleur' + #13#10 +
                              'Veuillez saisir un tarif pr�conis� et ' + #13#10 +
                              'passer par l''�cran " Prix de vente pr�conis�s � date "';
  RS_ERR_PXPRECO_NoTarifCoche = 'Aucun tarif n''est s�lectionn�';
  RS_ERR_PXPRECO_Rafraichir = 'Veuillez rafra�chir les donn�es';

  RS_ERR_ImpossibleAvantDateMigration = 'Impossible de cr�er ou de modifier un document avant le %s.'+ #13#10+
                                        'Cette date �tant la date de migration de du magasin';
  RS_ERR_DateDansUnExeComptableClot = 'Impossible de cr�er ou de modifier un document'+#13#10+
                                      'dont la date est dans un exercice comptable clotur�.';
  RS_ERR_DateInvalide = 'Date invalide !';

  RS_ERR_SocieteOblig = 'Soci�t� obligatoire !';
  RS_ERR_NomExeComptableOblig = 'Nom exercice comptable obligatoire !';
  RS_ERR_DateDebutObligatoire = 'Date de d�but obligatoire !';
  RS_ERR_DateFinObligatoire = 'Date de fin obligatoire !';
  RS_ERR_DateFinPlusPetitQueDebut = 'La date de fin doit �tre plus grande que celle du d�but !';
  RS_ASK_ClotureExeComptable = 'Vous ne pourrez plus saisir de document pendant cette p�riode'+#13#10+
                               'si vous cl�tur� cet exercice comptable.'+#13#10+
                               'Etes-vous s�r de vouloir le cl�turer ?';
  RS_ERR_DeleteImpossibleCarCloture = 'Impossible de supprimer ou de modifier un exercice comptable cl�tur� !';
  RS_ASK_SupprimerComptable = 'Etes-vous s�r de vouloir supprimer cet exercice comptable ?';

  RS_GENERIQUE_MODIF_ENREG = 'Voulez-vous enregistrer les modifications ?';

  RS_CAISSE_ERREUR_ENREG = 'Erreur lors de l''enregistrement du ticket.'#10#13'Vous devez resaisir la vente.';

IMPLEMENTATION

END.
