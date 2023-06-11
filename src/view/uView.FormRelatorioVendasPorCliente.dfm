object frmFormFormRelatorioVendasPorCliente: TfrmFormFormRelatorioVendasPorCliente
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas por Cliente'
  ClientHeight = 152
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnPreview: TButton
    Left = 203
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 0
    OnClick = btnPreviewClick
  end
  object qrReport: TQuickRep
    Left = 8
    Top = 151
    Width = 1123
    Height = 794
    ShowingPreview = False
    DataSet = sqlVendas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.MemoryLimit = 1000000
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsMaximized
    PreviewWidth = 500
    PreviewHeight = 500
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stPDF
    PreviewLeft = 0
    PreviewTop = 0
    object EmpresaTitulo: TQRBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 69
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        182.562500000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRLabel1: TQRLabel
        Left = 193
        Top = 16
        Width = 665
        Height = 20
        Size.Values = (
          52.916666666666670000
          510.645833333333300000
          42.333333333333340000
          1759.479166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Relat'#243'rio de Vendas por Cliente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 11
      end
      object QRLabel3: TQRLabel
        Left = 15
        Top = 48
        Width = 26
        Height = 18
        Size.Values = (
          47.625000000000000000
          39.687500000000000000
          127.000000000000000000
          68.791666666666660000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRSysData1: TQRSysData
        Left = 52
        Top = 48
        Width = 100
        Height = 18
        Size.Values = (
          47.625000000000000000
          137.583333333333300000
          127.000000000000000000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
        Transparent = False
        ExportAs = exptText
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel4: TQRLabel
        Left = 941
        Top = 47
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          2489.729166666667000000
          124.354166666666700000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'P'#225'gina:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRSysData2: TQRSysData
        Left = 994
        Top = 47
        Width = 39
        Height = 19
        Size.Values = (
          49.609375000000000000
          2629.296875000000000000
          125.677083333333300000
          102.526041666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Data = qrsPageNumber
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
        Transparent = False
        ExportAs = exptText
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    object QRBand2: TQRBand
      Left = 38
      Top = 131
      Width = 1047
      Height = 58
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        153.458333333333300000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRShape3: TQRShape
        Left = 5
        Top = 55
        Width = 1038
        Height = 1
        Size.Values = (
          2.645833333333333000
          13.229166666666670000
          145.520833333333300000
          2746.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRDBText2: TQRDBText
        Left = 5
        Top = 34
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          89.958333333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlVendas
        DataField = 'idvenda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText3: TQRDBText
        Left = 111
        Top = 34
        Width = 200
        Height = 17
        Size.Values = (
          44.979166666666670000
          293.687500000000000000
          89.958333333333340000
          529.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlVendas
        DataField = 'dthr_venda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 315
        Top = 34
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          833.437500000000000000
          89.958333333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlVendas
        DataField = 'total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText5: TQRDBText
        Left = 420
        Top = 34
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1111.250000000000000000
          89.958333333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlVendas
        DataField = 'status'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRShape4: TQRShape
        Left = 5
        Top = 2
        Width = 1038
        Height = 1
        Size.Values = (
          2.645833333333333000
          13.229166666666670000
          5.291666666666667000
          2746.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel2: TQRLabel
        Left = 5
        Top = 8
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          21.166666666666670000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'IdVenda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel9: TQRLabel
        Left = 111
        Top = 8
        Width = 200
        Height = 17
        Size.Values = (
          44.979166666666670000
          293.687500000000000000
          21.166666666666670000
          529.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Dt. Hr. Venda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel10: TQRLabel
        Left = 315
        Top = 8
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          833.437500000000000000
          21.166666666666670000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel11: TQRLabel
        Left = 420
        Top = 8
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1111.250000000000000000
          21.166666666666670000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Status'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRShape5: TQRShape
        Left = 5
        Top = 29
        Width = 1038
        Height = 1
        Size.Values = (
          2.645833333333333000
          13.229166666666670000
          76.729166666666680000
          2746.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsRectangle
        VertAdjust = 0
      end
    end
    object QRBand3: TQRBand
      Left = 38
      Top = 189
      Width = 1047
      Height = 32
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.666666666666660000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupHeader
      object QRLabel5: TQRLabel
        Left = 5
        Top = 7
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          18.520833333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'IdVenda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 111
        Top = 7
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          293.687500000000000000
          18.520833333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Item'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel7: TQRLabel
        Left = 216
        Top = 7
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          571.500000000000000000
          18.520833333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'IdProduto'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel12: TQRLabel
        Left = 321
        Top = 7
        Width = 408
        Height = 17
        Size.Values = (
          44.979166666666670000
          849.312499999999900000
          18.520833333333340000
          1079.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel13: TQRLabel
        Left = 733
        Top = 7
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1939.395833333333000000
          18.520833333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel14: TQRLabel
        Left = 837
        Top = 7
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2214.562500000000000000
          18.520833333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pr. Unit'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel15: TQRLabel
        Left = 941
        Top = 7
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2489.729166666667000000
          18.520833333333340000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRShape2: TQRShape
        Left = 5
        Top = 28
        Width = 1038
        Height = 1
        Size.Values = (
          2.645833333333333000
          13.229166666666670000
          74.083333333333340000
          2746.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsRectangle
        VertAdjust = 0
      end
    end
    object QRSubDetail1: TQRSubDetail
      Left = 38
      Top = 221
      Width = 1047
      Height = 23
      AfterPrint = QRSubDetail1AfterPrint
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        60.854166666666660000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = qrReport
      DataSet = sqlDatail
      FooterBand = QRBand1
      HeaderBand = QRBand3
      PrintBefore = False
      PrintIfEmpty = True
      object QRDBText6: TQRDBText
        Left = 6
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          10.583333333333330000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlDatail
        DataField = 'idvenda_item'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText7: TQRDBText
        Left = 112
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          296.333333333333300000
          10.583333333333330000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlDatail
        DataField = 'item'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText8: TQRDBText
        Left = 217
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          574.145833333333300000
          10.583333333333330000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlDatail
        DataField = 'idproduto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText9: TQRDBText
        Left = 323
        Top = 4
        Width = 408
        Height = 17
        Size.Values = (
          44.979166666666670000
          854.604166666666600000
          10.583333333333330000
          1079.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = sqlDatail
        DataField = 'descricao'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText10: TQRDBText
        Left = 734
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1942.041666666667000000
          10.583333333333330000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        DataSet = sqlDatail
        DataField = 'quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText11: TQRDBText
        Left = 838
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2217.208333333333000000
          10.583333333333330000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        DataSet = sqlDatail
        DataField = 'preco_unitario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText12: TQRDBText
        Left = 942
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2492.375000000000000000
          10.583333333333330000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        DataSet = sqlDatail
        DataField = 'total_item'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRGroup1: TQRGroup
      Left = 38
      Top = 107
      Width = 1047
      Height = 24
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'sqlVendas.nome'
      Master = qrReport
      ReprintOnNewPage = False
      object QRLabel8: TQRLabel
        Left = 5
        Top = 5
        Width = 42
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          13.229166666666670000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText1: TQRDBText
        Left = 53
        Top = 6
        Width = 33
        Height = 17
        Size.Values = (
          44.979166666666670000
          140.229166666666700000
          15.875000000000000000
          87.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = sqlVendas
        DataField = 'nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 244
      Width = 1047
      Height = 23
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        60.854166666666660000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object lblSumQuantidade: TQRLabel
        Left = 733
        Top = 3
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1939.395833333333000000
          7.937500000000000000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object lblSumTotal: TQRLabel
        Left = 941
        Top = 3
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2489.729166666667000000
          7.937500000000000000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRBand4: TQRBand
      Left = 38
      Top = 267
      Width = 1047
      Height = 25
      AlignToBottom = False
      BeforePrint = QRBand4BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        66.145833333333340000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object lblSumSumaryQuantidade: TQRLabel
        Left = 733
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1939.395833333333000000
          10.583333333333330000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object lblSumSumaryTotal: TQRLabel
        Left = 941
        Top = 4
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2489.729166666667000000
          10.583333333333330000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
  end
  object btnFechar: TButton
    Left = 282
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = btnFecharClick
  end
  object sqlVendas: TFDQuery
    SQL.Strings = (
      
        '  SELECT VEN.idvenda, VEN.dthr_venda, VEN.idcliente, CLI.nome, V' +
        'EN.total,'
      '         VEN.status'
      '    FROM Vendas VEN'
      '    JOIN Clientes CLI ON(VEN.idcliente=CLI.idcliente)'
      '   WHERE VEN.status = '#39'E'#39
      'ORDER BY VEN.dthr_venda DESC')
    Left = 264
    Top = 16
    object sqlVendasidvenda: TIntegerField
      FieldName = 'idvenda'
      Origin = 'idvenda'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqlVendasdthr_venda: TSQLTimeStampField
      FieldName = 'dthr_venda'
      Origin = 'dthr_venda'
      Required = True
    end
    object sqlVendasidcliente: TIntegerField
      FieldName = 'idcliente'
      Origin = 'idcliente'
      Required = True
    end
    object sqlVendasnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 100
    end
    object sqlVendastotal: TBCDField
      FieldName = 'total'
      Origin = 'total'
      Precision = 15
      Size = 2
    end
    object sqlVendasstatus: TStringField
      FieldName = 'status'
      Origin = 'status'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object sqlDatail: TFDQuery
    IndexFieldNames = 'idvenda_item'
    MasterSource = dsVendas
    MasterFields = 'idvenda'
    DetailFields = 'idvenda_item'
    SQL.Strings = (
      
        '  SELECT VEI.idvenda idvenda_item, VEI.item, VEI.idproduto, PRO.' +
        'descricao,'
      
        '         VEI.quantidade, VEI.preco_unitario, VEI.total total_ite' +
        'm'
      '    FROM Vendaitens VEI'
      '    JOIN produtos PRO ON(VEI.idproduto=PRO.idproduto)'
      'ORDER BY VEI.idvenda,'
      '         VEI.item')
    Left = 320
    Top = 16
    object sqlDatailidvenda_item: TIntegerField
      FieldName = 'idvenda_item'
      Origin = 'idvenda_item'
      Required = True
    end
    object sqlDatailitem: TIntegerField
      FieldName = 'item'
      Origin = 'item'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqlDatailidproduto: TIntegerField
      FieldName = 'idproduto'
      Origin = 'idproduto'
      Required = True
    end
    object sqlDataildescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object sqlDatailquantidade: TBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
      Precision = 15
      Size = 2
    end
    object sqlDatailpreco_unitario: TBCDField
      FieldName = 'preco_unitario'
      Origin = 'preco_unitario'
      Required = True
      Precision = 15
      Size = 2
    end
    object sqlDatailtotal_item: TBCDField
      FieldName = 'total_item'
      Origin = 'total_item'
      Required = True
      Precision = 15
      Size = 2
    end
  end
  object dsVendas: TDataSource
    DataSet = sqlVendas
    Left = 264
    Top = 72
  end
end
