inherited frmConsultaVenda: TfrmConsultaVenda
  Caption = 'Consulta de Vendas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdConsulta: TDBGrid
    OnDrawColumnCell = grdConsultaDrawColumnCell
    OnKeyDown = grdConsultaKeyDown
  end
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaidvenda: TIntegerField
      FieldName = 'idvenda'
    end
    object cdsConsultadtvenda: TDateField
      FieldName = 'dtvenda'
    end
    object cdsConsultacliente: TStringField
      FieldName = 'cliente'
    end
    object cdsConsultavendedor: TStringField
      FieldName = 'vendedor'
    end
    object cdsConsultaobservacao: TStringField
      FieldName = 'observacao'
    end
    object cdsConsultaobservacao_entrega: TMemoField
      FieldName = 'observacao_entrega'
      BlobType = ftMemo
    end
    object cdsConsultasubtotal: TFloatField
      FieldName = 'subtotal'
    end
    object cdsConsultadesconto: TFloatField
      FieldName = 'desconto'
    end
    object cdsConsultatotal: TFloatField
      FieldName = 'total'
    end
  end
end
