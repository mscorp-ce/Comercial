object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema Comercial'
  ClientHeight = 364
  ClientWidth = 1036
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMenu
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControl: TPanel
    Left = 0
    Top = 0
    Width = 1036
    Height = 364
    Align = alClient
    BevelOuter = bvLowered
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    StyleElements = [seFont, seBorder]
  end
  object mmMenu: TMainMenu
    Left = 496
    Top = 72
    object Cadatros1: TMenuItem
      Caption = 'Cadastros'
      object Pe1: TMenuItem
        Caption = 'Pessoas'
        object Clientes1: TMenuItem
          Caption = 'Clientes'
          OnClick = Clientes1Click
        end
        object Fornecedores1: TMenuItem
          Caption = 'Fornecedores'
          OnClick = Fornecedores1Click
        end
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        object Produto1: TMenuItem
          Caption = 'Produtos'
          OnClick = Produto1Click
        end
      end
    end
    object Movimentaes1: TMenuItem
      Caption = 'Movimenta'#231#245'es'
      object Vendas1: TMenuItem
        Caption = 'Vendas'
        OnClick = Vendas1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Pessoas1: TMenuItem
        Caption = 'Pessoas'
        object Clientes2: TMenuItem
          Caption = 'Clientes'
          OnClick = Clientes2Click
        end
      end
      object Movimentaes2: TMenuItem
        Caption = 'Movimenta'#231#245'es'
        object Vendas2: TMenuItem
          Caption = 'Vendas por Cliente'
          OnClick = Vendas2Click
        end
      end
    end
  end
  object EurekaLog1: TEurekaLog
    Left = 136
    Top = 64
  end
end
