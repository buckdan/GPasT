unit FrmMain;

interface

uses
  SysUtils, Classes, Forms, Controls, ExtCtrls;

type
  TMainFrm = class(TForm)
    PnlMain: TPanel;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  MainFrm: TMainFrm;

implementation

uses SockApp;

{$R *.dfm}

initialization
  TWebAppSockObjectFactory.Create('c_Maintenance')

end.
