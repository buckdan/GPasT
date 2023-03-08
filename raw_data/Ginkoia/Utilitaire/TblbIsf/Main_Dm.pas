unit Main_Dm;

interface

uses
  Controls,
  Dialogs,
  Classes,
  Windows,
  SysUtils,
  UFindCmdLineSwitchEx,
  Forms,
  IBODataset,
  IB_Components,
  Db,
  MidasLib;
type

  TDm_Main = class(TDataModule)
    DatabaseStat: TIB_Connection;
    IbT_HorsK: TIB_Transaction;
    Database: TIB_Connection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    // pour ouvrir la base � partir du main module
    function IBOMajPkKey(DataSet: TIBODataSet; LeChamp: string): Boolean;
    procedure IBOUpDateCache(DataSet: TIBOQuery);
    function CheckAllowDelete(TableName, KeyValue: string;
      ShowErrorMessage: Boolean): Boolean;
    function CheckAllowEdit(TableName, KeyValue: string;
      ShowErrorMessage: Boolean): boolean;
    procedure IBOUpdateRecord(TableName: string; DataSet: TIBODataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    function OpenDatabase: boolean;
  end;

var
  Dm_Main: TDm_Main;


implementation

uses GinKoiaStd;

{$R *.DFM}


function _InitDatabase(aIbConnection: TIB_Connection; sDatabase, sUser, sPassword: string): boolean;
begin
 aIbConnection.Close;
 aIbConnection.DatabaseName := sDatabase;
 aIbConnection.Params.Values['user_name'] := sUser;
 aIbConnection.Params.Values['password'] := sPassword;
 Try
   aIbConnection.Open;
 Except
  On E: Exception do
   begin
     ShowMessage (E.Message);
   end;
 End;
end;

function TDm_Main.CheckAllowDelete(TableName, KeyValue: string;
  ShowErrorMessage: Boolean): Boolean;
begin
  Result := true;
end;

function TDm_Main.CheckAllowEdit(TableName, KeyValue: string;
  ShowErrorMessage: Boolean): boolean;
begin
  Result := true;
end;

procedure TDm_Main.DataModuleCreate(Sender: TObject);
begin
  OpenDatabase;
end;

function TDm_Main.IBOMajPkKey(DataSet: TIBODataSet; LeChamp: string): Boolean;
begin
  Result := true;
end;

procedure TDm_Main.IBOUpDateCache(DataSet: TIBOQuery);
begin

end;

procedure TDm_Main.IBOUpdateRecord(TableName: string; DataSet: TIBODataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin

end;

function Tdm_Main.OpenDatabase: boolean;
var
  lDataBaseFilename: string; 
  sDataBase, sUserName, sPassword, sSQLDialect: String;
  iSQLDialect: Integer;
begin;
  // Si le chemin de la base de donn�es a �t� pass� en param�tre, on l'utilise
  if FindCmdLineSwitchEx('DATABASE', sDataBase)
    and FindCmdLineSwitchEx('USERNAME', sUserName)
    and FindCmdLineSwitchEx('PASSWORD', sPassword)
    and FindCmdLineSwitchEx('SQLDIALECT', sSQLDialect) then
  begin
    if TryStrToInt(sSQLDialect, iSQLDialect) then
    begin
      if DataBase.Connected then
        DataBase.Close();
      DataBase.Database                         := sDataBase;  
      DataBase.DatabaseName                     := sDataBase;
      Database.SQLDialect                       := iSQLDialect;
      Database.Params.Values['USER NAME']       := sUserName;
      Database.Params.Values['PASSWORD']        := sPassword;
      Database.Connect();

      if DatabaseStat.Connected then
        DatabaseStat.Close();
      DatabaseStat.Database                     := sDataBase;
      DatabaseStat.DatabaseName                 := sDataBase;
      DatabaseStat.SQLDialect                   := iSQLDialect;
      DatabaseStat.Params.Values['USER NAME']   := sUserName;
      DatabaseStat.Params.Values['PASSWORD']    := sPassword;
      DatabaseStat.Connect();
    end
    else begin
      StdGinKoia.InfoMess('Attention', 'Le chemin d''acc�s � la base de donn�e n''existe pas.');
      Halt(2);
    end;
  end
  else begin
    // Sinon, on r�cup chemin de la base de donn�e � partir du fichier .ini
    lDataBaseFilename := StdGinkoia.IniCtrl.ReadString('DATABASE', 'PATH', '');

    if lDataBaseFilename = '' then
    begin;
      StdGinKoia.InfoMess('Attention', 'Le chemin d''acc�s � la base de donn�e n''est pas d�fini.');
      Halt(1);
    end;

   // D�sactive l'�valuation bool�enne rapide. Sinon, il n'y a que la premi�re fonction qui est ex�cut�e.
   {$BOOLEVAL ON}
   result := _InitDatabase(DataBase, lDataBaseFilename, 'ginkoia', 'ginkoia')
          and _InitDatabase(DataBaseStat, lDataBaseFilename, 'ginkoia', 'ginkoia');
   // R�active l'�valuation bool�enne rapide.
   {$BOOLEVAL OFF}
  end;
end;




end.

