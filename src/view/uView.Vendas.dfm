inherited frmVenda: TfrmVenda
  Caption = 'Venda'
  ClientWidth = 922
  ExplicitWidth = 938
  ExplicitHeight = 365
  PixelsPerInch = 96
  TextHeight = 13
  object lblIdVenda: TLabel [0]
    Left = 8
    Top = 16
    Width = 47
    Height = 13
    Caption = 'IdVenda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDtVenda: TLabel [1]
    Left = 134
    Top = 16
    Width = 54
    Height = 13
    Caption = 'Dt. Venda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCliente: TLabel [2]
    Left = 251
    Top = 16
    Width = 39
    Height = 13
    Caption = 'Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotal: TLabel [3]
    Left = 524
    Top = 16
    Width = 29
    Height = 13
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtVenda: TEdit [4]
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object edtTotal: TEdit [5]
    Left = 524
    Top = 35
    Width = 99
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  inherited pnlControl: TPanel
    Left = 792
    TabOrder = 4
    ExplicitLeft = 792
  end
  object lcbCliente: TDBLookupComboBox
    Left = 251
    Top = 35
    Width = 267
    Height = 21
    KeyField = 'IdCliente'
    ListField = 'Nome'
    ListSource = dsClientes
    TabOrder = 2
  end
  object cpDtVenda: TCalendarPicker
    Left = 132
    Top = 35
    Width = 118
    Height = 21
    CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
    CalendarHeaderInfo.DaysOfWeekFont.Height = -13
    CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    CalendarHeaderInfo.DaysOfWeekFont.Style = []
    CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.Font.Color = clWindowText
    CalendarHeaderInfo.Font.Height = -20
    CalendarHeaderInfo.Font.Name = 'Segoe UI'
    CalendarHeaderInfo.Font.Style = []
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TextHint = 'select a date'
  end
  object Panel1: TPanel
    Left = 2
    Top = 62
    Width = 788
    Height = 262
    TabOrder = 5
    object DBGrid1: TDBGrid
      Left = 1
      Top = 3
      Width = 786
      Height = 258
      Align = alBottom
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object cdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 112
    object cdsClientesIdCliente: TIntegerField
      FieldName = 'IdCliente'
    end
    object cdsClientesNome: TStringField
      FieldName = 'Nome'
    end
  end
  object dsClientes: TDataSource
    DataSet = cdsClientes
    Left = 320
    Top = 136
  end
  object cdsVendas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 96
  end
  object dsVendas: TDataSource
    DataSet = cdsVendas
    Left = 592
    Top = 96
  end
end
