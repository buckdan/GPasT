unit Integration.Form.MotPasse;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFormMotPasse = class(TForm)
    LblTitre: TLabel;
    TxtMotPasse: TEdit;
    PnlBoutons: TPanel;
    BtnAnnuler: TBitBtn;
    BtnValider: TBitBtn;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormMotPasse: TFormMotPasse;

implementation

{$R *.dfm}

{ TFormMotPasse }

procedure TFormMotPasse.CreateParams(var Params: TCreateParams);
begin
  inherited;

  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

end.
