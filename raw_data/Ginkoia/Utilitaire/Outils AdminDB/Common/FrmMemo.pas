unit FrmMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmCustomGinkoiaBox, StdCtrls, cxPropertiesStore, Buttons, ExtCtrls;

type
  TMemoFrm = class(TCustomGinkoiaBoxFrm)
    Memo: TMemo;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  MemoFrm: TMemoFrm;

implementation

{$R *.dfm}

end.
