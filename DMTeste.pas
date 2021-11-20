unit DMTeste;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    FDConexao: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDClientes: TFDTable;
    FDProdutos: TFDTable;
    FDPedidosGerais: TFDTable;
    FDPedidosProdutos: TFDTable;
    FDQueryClientes: TFDQuery;
    FDQueryProdutos: TFDQuery;
    FDQueryPedidosGerais: TFDQuery;
    FDQueryPedidosProdutos: TFDQuery;
    FDQueryGrid: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
