unit UMagasins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Inventoriste_Frm, Grids, DBGrids, StdCtrls;

type
  TFrmMagasins = class(TForm)
    Btn_OK: TButton;
    Btn_Cancel: TButton;
    DBGrid1: TDBGrid;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FrmMagasins: TFrmMagasins;

implementation

{$R *.dfm}

end.
