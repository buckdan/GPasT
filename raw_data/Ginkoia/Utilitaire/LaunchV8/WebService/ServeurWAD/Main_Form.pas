unit Main_Form;

interface

uses
  SysUtils, Classes, Forms, Controls, StdCtrls;

type
  TForm5 = class(TForm)
    Btn_: TButton;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form5: TForm5;

implementation

uses SockApp;

{$R *.dfm}

initialization
  TWebAppSockObjectFactory.Create('JetonLaunch')

end.
