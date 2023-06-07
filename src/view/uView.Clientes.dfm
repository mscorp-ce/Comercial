inherited frmCliente: TfrmCliente
  Caption = 'Cliente'
  ClientHeight = 186
  ClientWidth = 922
  ExplicitWidth = 938
  ExplicitHeight = 225
  PixelsPerInch = 96
  TextHeight = 13
  object lblIdCliente: TLabel [0]
    Left = 8
    Top = 16
    Width = 51
    Height = 13
    Caption = 'IdCliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDtNascimento: TLabel [1]
    Left = 609
    Top = 16
    Width = 85
    Height = 13
    Caption = 'Dt. Nascimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCliente: TLabel [2]
    Left = 135
    Top = 16
    Width = 32
    Height = 13
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCpf: TLabel [3]
    Left = 524
    Top = 16
    Width = 18
    Height = 13
    Caption = 'Cpf'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblStatus: TLabel [4]
    Left = 8
    Top = 64
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
  object edtIdCliente: TEdit [5]
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  inherited pnlControl: TPanel
    Left = 792
    Height = 186
    TabOrder = 5
    ExplicitLeft = 792
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
  object cpDtNascimento: TCalendarPicker
    Left = 607
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
    TabOrder = 3
    TextHint = 'select a date'
  end
  object edtNome: TEdit
    Left = 135
    Top = 35
    Width = 383
    Height = 21
    MaxLength = 100
    TabOrder = 1
  end
  object edtCpf: TEdit
    Left = 524
    Top = 35
    Width = 77
    Height = 21
    MaxLength = 11
    TabOrder = 2
  end
  object cbxStatus: TComboBox
    Left = 8
    Top = 83
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 4
    Items.Strings = (
      'Ativo'
      'Inativo')
  end
end
