object frmTeste: TfrmTeste
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Teste t'#233'cnico WK'
  ClientHeight = 477
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbcdCliente: TLabel
    Left = 16
    Top = 8
    Width = 71
    Height = 13
    Caption = 'C'#243'digo cliente:'
  end
  object lbNome: TLabel
    Left = 114
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  object Label3: TLabel
    Left = 438
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Cidade:'
  end
  object Label4: TLabel
    Left = 16
    Top = 53
    Width = 74
    Height = 13
    Caption = 'C'#243'digo produto'
  end
  object lbPreco: TLabel
    Left = 437
    Top = 53
    Width = 43
    Height = 13
    Caption = 'Pre'#231'o R$'
  end
  object Label6: TLabel
    Left = 114
    Top = 53
    Width = 50
    Height = 13
    Caption = 'Descri'#231#227'o:'
  end
  object Label1: TLabel
    Left = 552
    Top = 8
    Width = 17
    Height = 13
    Caption = 'UF:'
  end
  object Label2: TLabel
    Left = 546
    Top = 53
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object lbNumeroPedido: TLabel
    Left = 8
    Top = 295
    Width = 72
    Height = 13
    Caption = 'N'#250'mero Pedido'
  end
  object edtCliente: TEdit
    Left = 16
    Top = 27
    Width = 65
    Height = 21
    TabOrder = 0
    OnChange = edtClienteChange
  end
  object edtNome: TEdit
    Left = 114
    Top = 27
    Width = 308
    Height = 21
    TabOrder = 1
  end
  object edtCidade: TEdit
    Left = 438
    Top = 27
    Width = 106
    Height = 21
    TabOrder = 2
  end
  object cbUF: TComboBox
    Left = 553
    Top = 27
    Width = 49
    Height = 21
    TabOrder = 3
    Items.Strings = (
      'RO'
      'AC'
      'AM'
      'RR'
      'PA'
      'AP'
      'TO'
      'MA'
      'PI'
      'CE'
      'RN'
      'PB'
      'PE'
      'AL'
      'SE'
      'BA'
      'MG'
      'ES'
      'RJ'
      'SP'
      'PR'
      'SC'
      'RS'
      'MS'
      'MT'
      'GO'
      'DF')
  end
  object edtCdProduto: TEdit
    Left = 16
    Top = 72
    Width = 65
    Height = 21
    TabOrder = 4
    OnChange = edtCdProdutoChange
  end
  object edtDescricao: TEdit
    Left = 114
    Top = 72
    Width = 308
    Height = 21
    TabOrder = 5
  end
  object edtPreco: TEdit
    Left = 437
    Top = 72
    Width = 73
    Height = 21
    TabOrder = 6
  end
  object edtQuantidade: TEdit
    Left = 552
    Top = 72
    Width = 50
    Height = 21
    TabOrder = 7
  end
  object btnInserir: TButton
    Left = 516
    Top = 99
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 8
    OnClick = btnInserirClick
  end
  object SGRID: TStringGrid
    Left = 8
    Top = 130
    Width = 594
    Height = 154
    DefaultColWidth = 80
    RowCount = 1
    FixedRows = 0
    TabOrder = 9
    OnKeyDown = SGRIDKeyDown
    OnKeyPress = SGRIDKeyPress
    RowHeights = (
      24)
  end
  object pnTotal: TPanel
    Left = 0
    Top = 454
    Width = 610
    Height = 23
    Align = alBottom
    BorderStyle = bsSingle
    TabOrder = 15
    ExplicitWidth = 657
  end
  object btnGravarPedido: TButton
    Left = 497
    Top = 288
    Width = 105
    Height = 25
    Caption = 'GRAVAR PEDIDO'
    Enabled = False
    TabOrder = 13
    OnClick = btnGravarPedidoClick
  end
  object DBGrid: TDBGrid
    Left = 8
    Top = 319
    Width = 594
    Height = 134
    DataSource = DataSource1
    TabOrder = 14
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnPedidos: TButton
    Left = 223
    Top = 288
    Width = 105
    Height = 25
    Caption = 'Carregar Pedidos'
    TabOrder = 11
    OnClick = btnPedidosClick
  end
  object edtNumeroPedido: TEdit
    Left = 83
    Top = 292
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object btnCancelaPedidos: TButton
    Left = 364
    Top = 288
    Width = 105
    Height = 25
    Caption = 'Cancelar Pedidos'
    TabOrder = 12
    OnClick = btnCancelaPedidosClick
  end
  object DataSource1: TDataSource
    DataSet = DataModule1.FDQueryGrid
    Left = 424
    Top = 104
  end
end
