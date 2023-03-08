unit UnitThread;

interface
uses Windows, Classes, SysUtils,IB_Components,IBODataset,ADODB,Forms,DateUtils,
DBClient,DB,StrUTils,midaslib;

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
  Start        : Boolean=False;      //Variable de d�marrage du traitement
  Stop         : Boolean=False;      //Interrompt le traitement
  LibInfo      : String;             //Message d'information pour l'utilisateur
  ChemSource   : String;             //Chemin des fichiers sources
  Param_MAGID  : String;             //param�tre de Que_CarnetCde, magasin � traiter
  Param_SAIS   : String;             //param�tre de Que_CarnetCde, saison � traiter
  Param_CIAL   : String;             //param�tre de Que_CarnetCde, exercice commercial � traiter
  Param_FOURN  : String;             //param�tre de Que_CarnetCde, fournisseur � traiter
  Param_TIP    : String;             //param�tre de Que_CarnetCde, tip � traiter
  Param_ARCH   : String;             //param�tre de Que_CarnetCde, avec ou sans les archiv�
  Param_COLID  : String;             //param�tre de Que_CarnetCde, collection � traiter
implementation

uses UnitPrincipale;

constructor TTranspoThread.Create(CreateSuspended:boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate:=false;
  Priority:=tpNormal;
end;

destructor TTranspoThread.Destroy;
begin
  inherited;
end;

procedure TTranspoThread.CentralControl;
begin
  if Start then
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
  I,J                 : Integer;         //Variable de boucle
  Transaction         : TIB_Transaction; //Transaction
  CDS_CptClient       : TclientDataSet;  //Liste des lignes de comptes clients � int�grer
  CurrentFile         : String;          //Nom du fichier � traiter, � remplacer en d�but de traitement, facilit� les copier/Coller
  CurrentCDS          : TClientDataSet;  //Permets de passer la CDS Principale dans une variable, facilit� les copier/Coller
  Que_CarnetCde       : TIBOQuery;       //Requ�te principale de la procedure RV_CARNETCDE
  Que_CtrlReq         : TIBOQuery;       //Requ�te contr�le des sous requ�te de la procedure RV_CARNETCDE pouvant provoquer un Multiple Rows in singleton select
Begin
  //Verrouille le traitement pour qu'il ne se relance pas
  Start := False;

  //Message d'information
  LibInfo := 'Traitement en cours...';

  //Cr�ation de la transaction
  Transaction               := TIB_Transaction.Create(nil);
  Transaction.IB_Connection := Frm_Principale.Ginkoia;
  Transaction.AutoCommit    := False;
  Frm_Principale.Ginkoia.DefaultTransaction := Transaction;

  //Cr�ation des query d'int�gration
  Que_CarnetCde   := TIBOQuery.Create(nil);
  Que_CtrlReq     := TIBOQuery.Create(nil);

  //Initialisation
  Que_CtrlReq.DatabaseName              := Frm_Principale.Ginkoia.DatabaseName;
  Que_CtrlReq.IB_Connection             := Frm_Principale.Ginkoia;

  Que_CarnetCde.DatabaseName    := Frm_Principale.Ginkoia.DatabaseName;
  Que_CarnetCde.IB_Connection   := Frm_Principale.Ginkoia;

  //Requete principale
  Que_CarnetCde.SQL.Clear;
  Que_CarnetCde.SQL.Text  := 'Select * from DIAG_CARNETCDE(:MAGSID,:SAIS,:CIAL,:FOURN,:TIP,:ARCH,:COLID)';

  //Ouverture de la requ�te principale
  LibInfo   := 'Ouverture de la requ�te principale en cours...';
  Que_CarnetCde.ParamCheck                      := True;
  Que_CarnetCde.ParamByName('MAGSID').asString  := Param_MAGID;
  Que_CarnetCde.ParamByName('SAIS').asString    := Param_SAIS;
  Que_CarnetCde.ParamByName('FOURN').asString   := Param_FOURN;
  Que_CarnetCde.ParamByName('CIAL').asString    := Param_CIAL;
  Que_CarnetCde.ParamByName('TIP').asString     := Param_TIP;
  Que_CarnetCde.ParamByName('ARCH').asString    := Param_ARCH;
  Que_CarnetCde.ParamByName('COLID').asString   := Param_COLID;
  Que_CarnetCde.Open;
  NbLigne  := Que_carnetCde.RecordCount;
  Compteur := 0;

  //Traitement des lignes
  LibInfo  := 'Traitement en cours...';
  Que_CarnetCde.First;
  while Not Que_CarnetCde.eof do
  begin
    Que_CtrlReq.Close;
    Que_CtrlReq.SQL.Text  := 'SELECT RAL_QTE FROM agrral WHERE RAL_CDLID = :CDLID';
    Que_CtrlReq.ParamByName('CDLID').AsInteger  := Que_CarnetCde.FieldByName('CDL_ID').asInteger;
    Que_CtrlReq.Open;
    if Que_CtrlReq.RecordCount>1 then
    begin
      Frm_Principale.Memo_info.Lines.Append('RQ: '+Que_CtrlReq.SQL.Text+' - CDLID = '+Que_CarnetCde.FieldByName('CDL_ID').asString);
    end;

    Que_CtrlReq.Close;
    Que_CtrlReq.SQL.Text  := 'SELECT ANL_QTE FROM COMANNULL WHERE ANL_CDLID = :CDLID';
    Que_CtrlReq.ParamByName('CDLID').AsInteger  := Que_CarnetCde.FieldByName('CDL_ID').asInteger;
    Que_CtrlReq.Open;
    if Que_CtrlReq.RecordCount>1 then
    begin
      Frm_Principale.Memo_info.Lines.Append('RQ: '+Que_CtrlReq.SQL.Text+' - CDLID = '+Que_CarnetCde.FieldByName('CDL_ID').asString);
    end;

    Que_CtrlReq.Close;
    Que_CtrlReq.SQL.Text  := 'SELECT (A.RAL_QTE*L2.CDL_PXACHAT) FROM agrral A JOIN COMBCDEL L2 ON (L2.CDL_ID=A.RAL_CDLID) WHERE A.RAL_CDLID = :CDLID';
    Que_CtrlReq.ParamByName('CDLID').AsInteger  := Que_CarnetCde.FieldByName('CDL_ID').asInteger;
    Que_CtrlReq.Open;
    if Que_CtrlReq.RecordCount>1 then
    begin
      Frm_Principale.Memo_info.Lines.Append('RQ: '+Que_CtrlReq.SQL.Text+' - CDLID = '+Que_CarnetCde.FieldByName('CDL_ID').asString);
    end;

    Inc(Compteur,1);
    Que_CarnetCde.Next;
  end;

  //Suppression de la procedure stock�
  Try
    Que_CarnetCde.SQL.Clear;
    Que_CarnetCde.SQL.Text  := 'drop procedure DIAG_CARNETCDE;';
    Que_CarnetCde.ExecSQL;
    Transaction.Commit;
  except
  End;

  //Fermeture des acc�s BdD et des ClientDataSet
  Que_carnetCde.Close;
  Que_CtrlReq.Close;
  Que_carnetCde.Free;
  Que_CtrlReq.Free;

  //Message d'information
  if stop then
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
      if Stop then break;
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
