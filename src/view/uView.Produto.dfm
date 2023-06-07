inherited frmProduto: TfrmProduto
  Caption = 'Produto'
  ClientHeight = 186
  ClientWidth = 662
  ExplicitWidth = 678
  ExplicitHeight = 225
  PixelsPerInch = 96
  TextHeight = 13
  object lblIdProduto: TLabel [0]
    Left = 8
    Top = 16
    Width = 57
    Height = 13
    Caption = 'IdProduto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDescricao: TLabel [1]
    Left = 135
    Top = 16
    Width = 55
    Height = 13
    Caption = 'Descri'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCnpj: TLabel [2]
    Left = 377
    Top = 64
    Width = 80
    Height = 13
    Caption = 'Pre'#231'o Unit'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblIdFornecedor: TLabel [3]
    Left = 8
    Top = 64
    Width = 64
    Height = 13
    Caption = 'Fornecedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblStatus: TLabel [4]
    Left = 8
    Top = 112
    Width = 37
    Height = 13
    Caption = 'Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtIdProduto: TEdit [5]
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  inherited pnlControl: TPanel
    Left = 532
    Height = 186
    TabOrder = 5
    ExplicitLeft = 532
    ExplicitHeight = 186
    inherited spbOK: TSpeedButton
      Top = 92
      ExplicitTop = 92
    end
    inherited spbSair: TSpeedButton
      Top = 136
      ExplicitTop = 136
    end
  end
  object edtDescricao: TEdit
    Left = 135
    Top = 35
    Width = 383
    Height = 21
    MaxLength = 100
    TabOrder = 1
  end
  object edtPrecoUnitario: TEdit
    Left = 377
    Top = 83
    Width = 101
    Height = 21
    MaxLength = 14
    TabOrder = 3
  end
  object cbxStatus: TComboBox
    Tag = 4
    Left = 8
    Top = 131
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 4
    Items.Strings = (
      'Ativo'
      'Inativo')
  end
  object lcbFornecedor: TDBLookupComboBox
    Left = 8
    Top = 83
    Width = 361
    Height = 21
    KeyField = 'idfornecedor'
    ListField = 'nome_fantasia'
    ListSource = dsFornecedores
    TabOrder = 2
  end
  object dsFornecedores: TDataSource
    DataSet = cdsFornecedores
    Left = 256
    Top = 128
  end
  object cdsFornecedores: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 128
    object cdsFornecedoresidfornecedor: TIntegerField
      FieldName = 'idfornecedor'
    end
    object cdsFornecedoresnome_fantasia: TStringField
      FieldName = 'nome_fantasia'
      Size = 50
    end
    object cdsFornecedoresrazao_social: TStringField
      FieldName = 'razao_social'
      Size = 50
    end
    object cdsFornecedorescnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object cdsFornecedoresstatus: TStringField
      FieldName = 'status'
      Size = 1
    end
  end
end
