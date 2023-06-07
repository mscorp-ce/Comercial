inherited frmFornecedor: TfrmFornecedor
  Caption = 'Fornecedor'
  ClientHeight = 186
  ClientWidth = 662
  ExplicitWidth = 678
  ExplicitHeight = 225
  PixelsPerInch = 96
  TextHeight = 13
  object lblIdFornecedor: TLabel [0]
    Left = 8
    Top = 16
    Width = 76
    Height = 13
    Caption = 'IdFornecedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNomeFamtasia: TLabel [1]
    Left = 135
    Top = 16
    Width = 87
    Height = 13
    Caption = 'Nome Famtasia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCnpj: TLabel [2]
    Left = 397
    Top = 64
    Width = 25
    Height = 13
    Caption = 'Cnpj'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblRazaoSocial: TLabel [3]
    Left = 8
    Top = 64
    Width = 71
    Height = 13
    Caption = 'Raz'#227'o Social'
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
  object edtIdFornecedor: TEdit [5]
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
  object edtNomeFamtasia: TEdit
    Left = 135
    Top = 35
    Width = 383
    Height = 21
    MaxLength = 100
    TabOrder = 1
  end
  object edtCnpj: TEdit
    Left = 397
    Top = 83
    Width = 101
    Height = 21
    MaxLength = 14
    TabOrder = 3
  end
  object edtRazaoSocial: TEdit
    Left = 8
    Top = 83
    Width = 383
    Height = 21
    MaxLength = 100
    TabOrder = 2
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
end
