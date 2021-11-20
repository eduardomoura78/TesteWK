object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 378
  Width = 565
  object FDConexao: TFDConnection
    Params.Strings = (
      'Database=teste_wk'
      'User_Name=postgres'
      'Password=mariapaulina2014'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 184
    Top = 40
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Users\eduar\T_I\PostgreSQL\lib\psqlodbc\libpq.dll'
    Left = 376
    Top = 40
  end
  object FDClientes: TFDTable
    Active = True
    IndexFieldNames = 'codigo'
    Connection = FDConexao
    SchemaName = 'public'
    TableName = 'clientes'
    Left = 64
    Top = 144
  end
  object FDProdutos: TFDTable
    Connection = FDConexao
    SchemaName = 'public'
    TableName = 'produtos'
    Left = 160
    Top = 144
  end
  object FDPedidosGerais: TFDTable
    IndexFieldNames = 'numero_pedido'
    Connection = FDConexao
    SchemaName = 'public'
    TableName = 'pedidos_dados_gerais'
    Left = 264
    Top = 144
  end
  object FDPedidosProdutos: TFDTable
    Active = True
    IndexFieldNames = 'autoincrem'
    Connection = FDConexao
    SchemaName = 'public'
    TableName = 'pedidos_produtos'
    Left = 424
    Top = 136
  end
  object FDQueryClientes: TFDQuery
    Connection = FDConexao
    Left = 64
    Top = 200
  end
  object FDQueryProdutos: TFDQuery
    Connection = FDConexao
    Left = 160
    Top = 208
  end
  object FDQueryPedidosGerais: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'insert into pedidos_dados_gerais (data_emissao:data)')
    Left = 264
    Top = 208
  end
  object FDQueryPedidosProdutos: TFDQuery
    Connection = FDConexao
    Left = 424
    Top = 216
  end
  object FDQueryGrid: TFDQuery
    Connection = FDConexao
    Left = 264
    Top = 280
  end
end
