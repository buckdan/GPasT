unit DM_MONITOR;

{Tables originales de la base Monitor
Ordre d'importation :
1. GRP et SRV (ID r�utilis� dans FOLDER)
2. FOLDER (ID r�utilis� SENDER)
3. SENDER (ID r�utilis� HDB)
4. HDB
}
interface

uses
  SysUtils, Classes, IB_Components, DB, IBODataset;

type
  TDMMonitor = class(TDataModule)
    IBCNX_MONITOR: TIB_Connection;
    TBL_SRV: TIBOTable;
    TBL_GRP: TIBOTable;
    TBL_FOLDER: TIBOTable;
    TBL_SENDER: TIBOTable;
    TBL_HDB: TIBOTable;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  DMMonitor: TDMMonitor;

implementation

{$R *.dfm}

end.
