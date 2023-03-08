unit UfrmOrcamentoCompletoCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListView, FMX.Layouts;

type
  TfrmOrcamentoCompletoCliente = class(TForm)
    lytPrincipal: TLayout;
    lytDadosOrcamento: TLayout;
    lstListaOrcamentos: TLayout;
    lytOrcamentoPecas: TLayout;
    lstItensPecas: TListView;
    lytHeaderPecas: TLayout;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    lytTituloPecas: TLayout;
    Label12: TLabel;
    Line1: TLine;
    lytTituloOrcamento: TLayout;
    lblTituloOrcamento: TLabel;
    lytStatus: TLayout;
    lytOrcamentosServicos: TLayout;
    lstItensServicos: TListView;
    lytHeaderServicos: TLayout;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    lytTituloServicos: TLayout;
    Label19: TLabel;
    Line2: TLine;
    lytValorTotal: TLayout;
    Label20: TLabel;
    Line3: TLine;
    lblValorTotal: TLabel;
    rectFundo: TRectangle;
    logoLamborhini: TImage;
    Label1: TLabel;
    lblStatusOrcamento: TLabel;
    rectAtualizarStatus: TRoundRect;
    Label13: TLabel;
    RoundRect1: TRoundRect;
    Label2: TLabel;
    Label4: TLabel;
    lblNomeCliente: TLabel;
    Label9: TLabel;
    lblCelular: TLabel;
    Label11: TLabel;
    lblCarro: TLabel;
    lblPlaca: TLabel;
    Label24: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    Line4: TLine;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOrcamentoCompletoCliente: TfrmOrcamentoCompletoCliente;

implementation

{$R *.fmx}

end.
