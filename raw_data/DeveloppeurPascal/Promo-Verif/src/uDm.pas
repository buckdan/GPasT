unit uDm;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, FMX.ImgList;

type
  Tdm = class(TDataModule)
    Images: TImageList;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
