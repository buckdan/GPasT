unit UnitThread;

interface
uses Windows, Classes, SysUtils,IB_Components,IBODataset,ADODB,Forms,DateUtils,
DBClient,DB,StrUTils,Dialogs;

type
  TTranspoThread = class(TThread)
  private
    procedure CentralControl;
  public
    constructor Create(CreateSuspended:boolean);
    destructor Destroy; override;
  protected
    procedure Execute; override;
  end;

Type
  TProcedure = procedure;
    Procedure Traitement;
    Procedure Log(Texte:String);
    Procedure CSV_To_ClientDataSet(FichCsv:String;CDS:TClientDataSet);
    Procedure Add_csv(Fichier,Texte:String);
    
Var
  Compteur     : Integer=0;          //Compte le nombre de mat�riel trait�
  NbLigne      : Integer;            //Nombre de ligne � trait�
  StartImport  : Boolean=False;      //Variable de d�marrage du traitement
  StopImport   : Boolean=False;      //Interrompt le traitement
  LibInfo      : String;             //Message d'information pour l'utilisateur
  ChemSource   : String;             //Chemin des fichiers sources
  FlagLogErr   : Boolean=False;      //Variable permettant si une erreur a �t� logg�

  CDS_Client   : TclientDataSet;     //Liste des clients
  CDS_Article  : TClientDataSet;     //Liste des articles
  CDS_Couleur  : TClientDataSet;     //Liste des couleurs
  CDS_Famille  : TClientDataSet;     //Liste des familles d'articles
  CDS_Fourn    : TClientDataSet;     //Liste des fournisseurs
  CDS_Prix     : TClientDataSet;     //Liste des prix d'articles
  CDS_Taille   : TClientDataSet;     //Liste des tailles par grille de taille
  CDS_TVA      : TClientDataSet;     //Liste des taux de TVA
implementation

uses UnitPrincipale;

constructor TTranspoThread.Create(CreateSuspended:boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate:=false;
  Priority:=tpHigher;
end;

destructor TTranspoThread.Destroy;
begin
  inherited;
end;

procedure TTranspoThread.CentralControl;
begin
  if StartImport then
    Traitement;
end;

procedure TTranspoThread.Execute;
begin
  repeat
    Sleep(1000); //en millisecondes
    CentralControl;
  until Terminated;
end;

procedure Traitement;
//Effectue la transpo des donn�es
Var
  I,J         : Integer;      //Variable de boucle
  ChemImport  : String;       //Chemin des fichiers cr�er pour l'import GINKOIA
  CSV_Import  : TStringList;  //Variable de cr�ation du fichier csv
  Marque      : String;       //Marque de l'article
  Categorie   : String;       //Cat�gorie de l'article
  CodeBarre1  : String;       //Code barre 1 de l'article
  CodeBarre2  : String;       //Code barre 2 de l'article
  sTaille     : string;
Begin
  //Verrouille le traitement pour qu'il ne se relance pas
  StartImport := False;

  //Message d'information
  LibInfo := 'Traitement en cours...';

  //Initialise le chemin pour la cr�ation des fichier
  ChemImport  := IncludeTrailingPathDelimiter(ExtractFilePath(application.ExeName))+'Import\';

  //Cr�ation des ClientsDataSet pour l'int�gration des informations source
  CDS_Article := TClientDataSet.Create(nil);
  CDS_Famille := TClientDataSet.Create(nil);
  CDS_Fourn   := TClientDataSet.Create(nil);

  //R�cup�ration des informations � int�grer
  LibInfo   := 'R�cup�ration des informations fournisseur en cours...';
  CSV_To_ClientDataSet(ChemSource+'Fourn.csv',CDS_Fourn);
  LibInfo   := 'R�cup�ration des informations famille en cours...';
  CSV_To_ClientDataSet(ChemSource+'Famille_loc.csv',CDS_Famille);
  LibInfo   := 'R�cup�ration des informations articles en cours...';
  CSV_To_ClientDataSet(ChemSource+'Article_loc.csv',CDS_Article);

  //Traitement des articles
  LibInfo  := 'Traitement des articles de location en cours...';
  if FileExists(ChemImport+'Articles.csv') then
    DeleteFile(ChemImport+'Articles.csv');

  CDS_Article.Open;
  CDS_Famille.Open;
  CDS_Fourn.Open;
  CDS_Article.First;
  NbLigne  := CDS_Article.RecordCount;
  Compteur := 0;
  Add_CSV(ChemImport+'Articles.csv','CODE;' +
                                    'LIBELLE;' +
                                    'REFMARQUE;' +
                                    'NUMSERIE;' +
                                    'CATEGORIE;' +
                                    'COMMENTAIRE;' +
                                    'MARQUE;' +
                                    'GRILLETAILLE;' +
                                    'TAILLE;' +
                                    'CB1;' +
                                    'CB2;' +
                                    'CB3;' +
                                    'CB4;' +
                                    'STATUT;' +
                                    'DATEACHAT;' +
                                    'PRIXACHAT;' +
                                    'PRIXVENTE;' +
                                    'DATECESSION;' +
                                    'PRIXCESSION;' +
                                    'DUREEAMT;' +
                                    'LOCFOURNISSEUR;' +
                                    'SOUSFICHE;' +
                                    'SFCODE;' +
                                    'RESULTAT;');

  while (Not CDS_Article.eof) and (not stopImport) do
  Begin
    Try
        //Recherche du fournisseur
        CDS_Fourn.Locate('Codefour',CDS_Article.FieldByName('Codefour').asString,[]);
        Marque  := CDS_Fourn.FieldByName('LibFour').AsString;

        //Recherche de la cat�gorie
        CDS_famille.Locate('IDFamille_Loc',CDS_Article.FieldByName('IDFamille_Loc').asString,[]);
        Categorie  := CDS_Famille.FieldByName('Libfam_loc').AsString;

        //Exporte les articles non reforme
        if (UpperCase(trim(Categorie))<>'REFORME') then
        begin
          //Gestion du code barre 1
          if (CDS_Article.FieldByName('CB_ARTLOC1').asString <> CDS_Article.FieldByName('REFART_LOC').asString) then
            CodeBarre1  := CDS_Article.FieldByName('CB_ARTLOC1').asString
          else
            CodeBarre1  := '';

          //Gestion du code barre 1
          if (CDS_Article.FieldByName('CB_ARTLOC2').asString <> CDS_Article.FieldByName('REFART_LOC').asString) and
             (CDS_Article.FieldByName('CB_ARTLOC2').asString <> CDS_Article.FieldByName('CB_ARTLOC1').asString) then
            CodeBarre2  := CDS_Article.FieldByName('CB_ARTLOC2').asString
          else
            CodeBarre2  := '';

          if CDS_Article.FieldByName('TAILLE_ARTLOC').asString = '' then
          begin
            sTaille := 'Unitaille';
          end
          else
          begin
            sTaille := CDS_Article.FieldByName('TAILLE_ARTLOC').asString;
          end;


          //Ecriture de la ligne d'article
          Add_CSV(ChemImport+'Articles.csv',CDS_Article.FieldByName('REFART_LOC').asString + ';' +
                                            CDS_Article.FieldByName('Libelle_ARTLOC').asString + ';' +
                                            '' + ';' +
                                            CDS_Article.FieldByName('NUM_SERIE').asString + ';' +
                                            Categorie + ';' +
                                            '' + ';' +
                                            Marque + ';' +
                                            'Transpo-Cil�aLoc' + ';' +
                                            sTaille + ';' +
                                            CodeBarre1 + ';' +
                                            CodeBarre2 + ';' +
                                            '' + ';' +
                                            '' + ';' +
                                            'LOCATION' + ';' +
                                            CDS_Article.FieldByName('Date_Entree_ARTLOC').asString + ';' +
                                            CDS_Article.FieldByName('Prix_Achat_ARTLOC').asString + ';' +
                                            CDS_Article.FieldByName('PRIX_VENTE_ARTLOC').asString + ';' +
                                            '' + ';' +
                                            '' + ';' +
                                            CDS_Article.FieldByName('Duree_Amo').asString + ';' +
                                            'N' + ';' +
                                            'N' + ';' +
                                            '' + ';' +
                                            '');
        end;
        Inc(Compteur);
        CDS_Article.Next;
    except
      on E: Exception do Log(DateTimeToStr(now) + ' Erreur: ' + E.Message + ' -> ' + LibInfo);
    End;
  End;
    CDS_Famille.Close;
    CDS_Fourn.Close;
    CDS_Article.Close;

  //Fermeture des acc�s BdD et des ClientDataSet
  CDS_Article.Close;
  CDS_Article.Free;
  CDS_Famille.Close;
  CDS_Famille.Free;
  CDS_Fourn.Close;
  CDS_Fourn.Free;

  //Message d'information
  if stopImport then
    LibInfo := 'Traitement interrompu'
  else
    LibInfo := 'Traitement termin�';

  //Signale que le traitement n'est plus en cours pour l'affichage
  NbLigne := -1;

End;

Procedure Log(Texte:String);
Var
  LogFile       : TextFile;   //Varialbe d'acc�s au fichier
  Chemin        : String;     //Chemin du fichier de log
  FileLogName   : String;     //Nom du fichier de log
Begin
  Chemin      := IncludeTrailingPathDelimiter(ExtractFilePath(application.exename))+'Log\';
  FileLogName := Chemin+'Log_'+IntToStr(yearof(now))+'-'+IntToStr(monthof(now))+'-'+IntToStr(dayof(now))+'.log';
  ForceDirectories(Chemin);
  AssignFile(LogFile,FileLogName);
  if Not FileExists(FileLogName) then
    ReWrite(LogFile)
  else
    Append(LogFile);
  try
    Writeln(LogFile,Texte);
    FlagLogErr  := True;
  finally
    CloseFile(LogFile);
  end;

End;

Procedure CSV_To_ClientDataSet(FichCsv:String;CDS:TClientDataSet);
//Transfert le contenu du CSV dans un clientdataset en prenant la ligne d'ent�te pour la cr�ation des champs
Var
  Donnees	  : TStringList;    //Charge le fichier csv
  InfoLigne : TStringList;    //D�coupe la ligne en cours de traitement
  I,J       : Integer;        //Variable de boucle
  Chaine    : String;         //Variable de traitement des lignes
Begin
  //Cr�ation des variables
  Donnees   := TStringList.Create;
  InfoLigne := TStringList.Create;

  //Chargement du csv
  Donnees.LoadFromFile(FichCsv);

  //Initialisation de variable
  NbLigne   := Donnees.Count;
  Compteur  := 0;

  //Traitement de la ligne d'ent�te
  InfoLigne.Clear;
  InfoLigne.Delimiter := ';';
  InfoLigne.DelimitedText := Donnees.Strings[0];
  for I := 0 to InfoLigne.Count - 1 do
    Begin
      CDS.FieldDefs.Add(Trim(InfoLigne.Strings[I]),ftString,255);
    End;
  CDS.CreateDataSet;
  
  //Traitement des lignes de donn�es
  CDS.Open;
  for I := 1 to Donnees.Count - 1 do
  begin
    Try
      InfoLigne.Clear;
      InfoLigne.Delimiter := ';';
      InfoLigne.QuoteChar := '''';
      Chaine  := LeftStr(QuotedStr(Donnees.Strings[I]),length(QuotedStr(Donnees.Strings[I]))-1);
      Chaine  := ReplaceStr(Chaine,';',''';''');
      Chaine  := Chaine + '''';

      InfoLigne.DelimitedText := Chaine;
      CDS.Insert;
      for J := 0 to CDS.FieldCount - 1 do
        Begin
          CDS.Fields[J].AsString  := InfoLigne.Strings[J];
        End;
      CDS.Post;
      Inc(Compteur);

      //Contr�le d'une demande d'interruption
      if StopImport then break;
    
    except on e: Exception do
      begin
        Log(DateTimeToStr(now) + ' Erreur: ' + E.Message + ' -> ' + LibInfo + ' -> Ligne : <' + chaine + '>');
        ShowMessage('Erreur � la ligne : ' + IntToStr(I) + '. Avec le message ' + e.Message);
      end;
    end;
  end;

  CDS.Close;

  //Suppression des variables en m�moire
  Donnees.free;
  InfoLigne.Free;

End;

Procedure Add_csv(Fichier,Texte:String);
//Ajoute une ligne � un fichier CSV
Var
  FileCsv       : TextFile;   //Variable d'acc�s au fichier
  ChemCsv       : String;     //Chemin du fichier csv
  FileCsvName   : String;     //Nom du fichier de csv
Begin
  ChemCsv       := IncludeTrailingPathDelimiter(ExtractFilePath(Fichier));
  FileCsvName   := Fichier;
  ForceDirectories(ChemCsv);
  AssignFile(FileCsv,FileCsvName);
  if Not FileExists(FileCsvName) then
    ReWrite(FileCsv)
  else
    Append(FileCsv);
  try
    Writeln(FileCsv,Texte);
  finally
    CloseFile(FileCsv);
  end;
End;

end.
