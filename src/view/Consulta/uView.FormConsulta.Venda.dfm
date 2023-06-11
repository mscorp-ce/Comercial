inherited frmConsultaVenda: TfrmConsultaVenda
  Caption = 'Consulta de Vendas'
  ExplicitWidth = 786
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdConsulta: TDBGrid
    OnKeyDown = grdConsultaKeyDown
  end
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaidvenda: TIntegerField
      FieldName = 'idvenda'
    end
    object cdsConsultadthr_venda: TDateTimeField
      FieldName = 'dthr_venda'
    end
    object cdsConsultaidcliente: TIntegerField
      FieldName = 'idcliente'
    end
    object cdsConsultanome_cliente: TStringField
      FieldName = 'nome_cliente'
      Size = 50
    end
    object cdsConsultatotal: TFloatField
      FieldName = 'total'
    end
    object cdsConsultastatus: TStringField
      FieldName = 'status'
      Size = 1
    end
  end
end
