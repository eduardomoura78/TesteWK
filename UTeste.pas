unit UTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.Grids,
  Vcl.DBGrids, Data.FMTBcd, Data.SqlExpr, Datasnap.DBClient, Vcl.ExtCtrls,
  DMTeste;

type
  TfrmTeste = class(TForm)
    edtCliente: TEdit;
    lbcdCliente: TLabel;
    lbNome: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbPreco: TLabel;
    Label6: TLabel;
    edtNome: TEdit;
    edtCidade: TEdit;
    Label1: TLabel;
    cbUF: TComboBox;
    edtCdProduto: TEdit;
    edtDescricao: TEdit;
    edtPreco: TEdit;
    Label2: TLabel;
    edtQuantidade: TEdit;
    btnInserir: TButton;
    SGRID: TStringGrid;
    pnTotal: TPanel;
    btnGravarPedido: TButton;
    DBGrid: TDBGrid;
    DataSource1: TDataSource;
    btnPedidos: TButton;
    edtNumeroPedido: TEdit;
    lbNumeroPedido: TLabel;
    btnCancelaPedidos: TButton;
    procedure btnInserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SGRIDKeyPress(Sender: TObject; var Key: Char);
    procedure SGRIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnPedidosClick(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtCdProdutoChange(Sender: TObject);
    procedure btnCancelaPedidosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pCarregaInformacoesGrid();
    procedure pLimpaEdit();
    procedure pGravaTabelaPedidosProdutos(numero_pedido: Integer);
    procedure pGravaTabelaPedidosGerais;
    procedure pCarregaPedidos;
    procedure pCarregaCliente;
    procedure pCarregaProduto;
    procedure pLimpaEditTodos;
    procedure pApagaPedidos;

    function fGravaPedidosDadosGerais: boolean;
    function fNumeroPedido: Integer;

  end;

var
  frmTeste: TfrmTeste;
  Alterar : boolean;
  valor_total,total_compra : Float64;

implementation

{$R *.dfm}

procedure TfrmTeste.btnCancelaPedidosClick(Sender: TObject);
begin
 if edtNumeroPedido.Text <> '' then
  begin
    pApagaPedidos;
    edtNumeroPedido.Text := EmptyStr;
  end
  else
  begin
    Application.MessageBox('O campo n?o pode ser vazio.','Aviso',MB_OK);
    if edtNumeroPedido.CanFocus then
      edtNumeroPedido.SetFocus;
  end;
end;

procedure TfrmTeste.btnGravarPedidoClick(Sender: TObject);
begin
  if fGravaPedidosDadosGerais then
  begin
    Application.MessageBox('Dados salvos com sucesso.','Aviso',MB_OK);
    pLimpaEditTodos;
    lbNumeroPedido.Enabled    := true;
    edtNumeroPedido.Enabled   := true;
    btnPedidos.Enabled        := true;
    btnCancelaPedidos.Enabled := true;
    if edtCliente.CanFocus then
      edtCliente.SetFocus;
  end
  else
    Application.MessageBox('N?o foi poss?vel gravar os dados.','Aviso',MB_OK)
end;

procedure TfrmTeste.btnInserirClick(Sender: TObject);
var
  i : integer;
begin
  btnGravarPedido.Enabled:= true;
  valor_total := 0;
  total_compra:= 0;
  if not Alterar then
  begin
    valor_total := StrToFloat(edtPreco.Text) * StrtoInt(edtQuantidade.Text);
    with SGRID.Rows[SGRID.RowCount] do
    begin
      Add(edtCdProduto.Text);
      Add(edtDescricao.Text);
      Add(edtQuantidade.Text);
      Add(edtPreco.Text);
      Add(Floattostr(valor_total));
      SGRID.RowCount:= SGRID.RowCount+1;
    end;
  end
  else
  begin
    if Application.MessageBox('Deseja alterar os campos?','Confirma??o',MB_YESNO)= IDYES then
    begin
      valor_total := StrToInt(edtPreco.Text) * StrtoInt(edtQuantidade.Text);
      SGRID.cells[3,SGRID.Row]:= edtPreco.Text;
      SGRID.cells[2,SGRID.Row]:= edtQuantidade.Text;
      SGRID.cells[4,SGRID.Row]:= FloatToStr(valor_total);
    end;
    Alterar := false;
  end;
  edtCdProduto.Enabled:= true;
  edtDescricao.Enabled:= true;

  for i := 1 to SGRID.RowCount - 1 do
    total_compra := total_compra + strtoFloat(SGRID.Cells[4,i]);

  pnTotal.Caption:='O valor total da compra ?:'+FloatToStr(total_compra)+'';

//  pLimpaEdit();

  if edtCdProduto.CanFocus then
    edtCdProduto.SetFocus;

 end;

procedure TfrmTeste.btnPedidosClick(Sender: TObject);
begin
  if edtNumeroPedido.Text <> '' then
  begin
    pCarregaPedidos;
    edtNumeroPedido.Text := EmptyStr;
  end
  else
  begin
    Application.MessageBox('O campo n?o pode ser vazio.','Aviso',MB_OK);
    if edtNumeroPedido.CanFocus then
      edtNumeroPedido.SetFocus;
  end;
end;

procedure TfrmTeste.edtCdProdutoChange(Sender: TObject);
begin
  if edtCdProduto.Text <>'' then
    pCarregaProduto;
end;

procedure TfrmTeste.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text <> '' then
  begin
    lbNumeroPedido.Enabled    := false;
    edtNumeroPedido.Enabled   := false;
    btnPedidos.Enabled        := false;
    btnCancelaPedidos.Enabled := false;
    pCarregaCliente;
  end;
end;

function TfrmTeste.fGravaPedidosDadosGerais: boolean;
var
  numero_pedido : integer;

begin
  result := false;
  try
    pGravaTabelaPedidosGerais;
    numero_pedido := fNumeroPedido;
    pGravaTabelaPedidosProdutos(numero_pedido);
  finally
    Result := true;
  end;
end;

function TfrmTeste.fNumeroPedido: Integer;
begin
  result := 0;
  with DMTeste.DataModule1.FDQueryPedidosGerais do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select indice from pedidos_dados_gerais where cod_cliente =:cliente');
    ParamByName('cliente').AsInteger  := StrtoInt(edtCliente.Text);
    Open;
    result:= FieldByName('indice').AsInteger;
  end;
end;

procedure TfrmTeste.FormCreate(Sender: TObject);
begin
  pCarregaInformacoesGrid;
  Alterar := false;
end;

procedure TfrmTeste.pApagaPedidos;
begin
  with DMTeste.DataModule1.FDQueryGrid do
  begin
    close;
    SQL.Clear;
    SQL.Add('delete from pedidos_produtos using pedidos_dados_gerais where pedidos_dados_gerais.numero_pedido = pedidos_produtos.numero_pedido and pedidos_dados_gerais.numero_pedido =:nNumeroPedido');
    ParamByName('nNumeroPedido').AsInteger := StrToInt(edtNumeroPedido.Text);
    ExecSQL;
//    active := true;

    close;
    SQL.Clear;
    SQL.Add('delete from pedidos_dados_gerais where numero_pedido =:nNumeroPedido');
    ParamByName('nNumeroPedido').AsInteger := StrToInt(edtNumeroPedido.Text);
    ExecSQL;
//    active := true;

//    DBGrid.Refresh;
  end;


end;

procedure TfrmTeste.pCarregaCliente;
begin
  with DMTeste.DataModule1.FDQueryClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select nome,cidade,uf from clientes where codigo =:codigo');
    ParamByName('codigo').AsInteger  := StrtoInt(edtCliente.Text);
    Open;
    edtNome.Text   := FieldByName('nome').AsString;
    edtCidade.Text := FieldByName('cidade').AsString;
    cbUF.Text      := FieldByName('uf').AsString;
  end;
end;

procedure TfrmTeste.pCarregaInformacoesGrid;
begin
  with SGRID do
  begin
    cols[0].Text:= 'C?digo';
    ColWidths[0] :=50;
    cols[1].Text:= 'Descri??o';
    ColWidths[1] :=320;
    cols[2].Text:= 'Quantidade';
    ColWidths[2] :=70;
    cols[3].Text:= 'Valor Produto';
    ColWidths[3] :=97;
    cols[4].Text:= 'Valor Total';
    ColWidths[4] :=97;
  end;
end;

procedure TfrmTeste.pCarregaPedidos;
begin
//  with DMTeste.DataModule1.FDQueryPedidosGerais do
  with DMTeste.DataModule1.FDQueryGrid do
  begin
    close;
    SQL.Clear;
    SQL.Add('select pdg.cod_cliente, c.nome, pp.cod_produto, p.descricao from pedidos_dados_gerais pdg '+
            'inner join pedidos_produtos pp on (pdg.numero_pedido = pp.numero_pedido) inner join clientes c on (pdg.cod_cliente = c.codigo) '+
            'inner join produtos p on (pp.cod_produto = p.codigo) where pdg.numero_pedido =:nNumeroPedido');

    ParamByName('nNumeroPedido').AsInteger := StrToInt(edtNumeroPedido.Text);
    Open;
    active := true;
//    DBGrid.Refresh;
  end;
end;

procedure TfrmTeste.pCarregaProduto;
begin
  with DMTeste.DataModule1.FDQueryProdutos do
  begin
    close;
    SQL.Clear;
    SQL.Add('select descricao, preco from produtos where codigo =:codigo');
    ParamByName('codigo').AsInteger   := StrToInt(edtCdProduto.Text);
    open;
    edtDescricao.Text := FieldByName('descricao').AsString;
    edtPreco.Text     := FloatToStr(FieldByName('preco').AsFloat);
  end;
end;

procedure TfrmTeste.pGravaTabelaPedidosGerais;
begin
  with DMTeste.DataModule1.FDQueryPedidosGerais do
  begin
    close;
    SQL.Clear;
    SQL.Add('insert into pedidos_dados_gerais (cod_cliente,data_emissao,valor_total) values (:codigo,:data, :valor)');
    ParamByName('data').AsDate       := now;
    ParamByName('codigo').AsInteger  := StrtoInt(edtCliente.Text);
    ParamByName('valor').AsFloat     := valor_total;
    ExecSQL;
  end;
end;

procedure TfrmTeste.pGravaTabelaPedidosProdutos(numero_pedido: Integer);
var
  i : integer;
begin
   with DMTeste.DataModule1.FDQueryPedidosProdutos do
   begin
     close;
     SQL.Clear;
     SQL.Add('insert into pedidos_produtos (numero_pedido,cod_produto,quantidade,vl_unitario,vl_total) values (:pedido,:produto,:quantidade,:vl_uni,:vl_total)');
     ParamByName('pedido').AsInteger  := numero_pedido;
     for i := 1 to SGRID.RowCount-1 do
     begin
       ParamByName('produto').AsInteger    := strtoint(SGRID.Cells[0,i]);
       ParamByName('quantidade').AsInteger := strtoint(SGRID.Cells[2,i]);
       ParamByName('vl_uni').AsFloat       := strtoFloat(SGRID.Cells[3,i]);
       ParamByName('vl_total').AsFloat     := strtoFloat(SGRID.Cells[4,i]);
       ExecSQL;
     end;
   end;
end;

procedure TfrmTeste.pLimpaEdit;
begin
  edtCdProduto.Text := '';
  edtDescricao.Text := EmptyStr;
  edtQuantidade.Text:= EmptyStr;
  edtPreco.Text     := EmptyStr;
end;

procedure TfrmTeste.pLimpaEditTodos;
var
  i : integer;
begin
  edtCliente.Text:= EmptyStr;
  edtNome.Text   := EmptyStr;
  edtCidade.Text := EmptyStr;
  cbUF.Text      := EmptyStr;
  edtCdProduto.Text  := EmptyStr;
  edtDescricao.Text  := EmptyStr;
  edtPreco.Text      := EmptyStr;
  edtQuantidade.Text := EmptyStr;
  for i := 1 to SGRID.RowCount - 1 do
    SGRID.Rows[i] := SGRID.Rows[i + 1];
end;

procedure TfrmTeste.SGRIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
  total_compra : float64;

begin
  if Key = VK_DELETE then
  begin
   if Application.MessageBox('Deseja excluir a linha ?','Confirma??o',MB_YESNO)= IDYES then
    begin
      for i := SGRID.Row to SGRID.RowCount - 1 do
       SGRID.Rows[i] := SGRID.Rows[i + 1];
      SGRID.RowCount := SGRID.RowCount - 1;

      for i := 1 to SGRID.RowCount - 1 do
        total_compra := total_compra + strtoFloat(SGRID.Cells[4,i]);

       pnTotal.Caption:='O valor total da compra ?:'+FloatToStr(total_compra)+'';
    end;
  end;
end;

procedure TfrmTeste.SGRIDKeyPress(Sender: TObject; var Key: Char);
begin
  Alterar := true;

  if Key = #$D then
  begin
    edtCdProduto.Text := SGRID.cells[0,SGRID.Row];
    edtDescricao.Text := SGRID.cells[1,SGRID.Row];
    edtQuantidade.Text:= SGRID.cells[2,SGRID.Row];
    edtPreco.Text     := SGRID.cells[3,SGRID.Row];

    edtCdProduto.Enabled:= false;
    edtDescricao.Enabled:= false;
  end;
end;

end.
