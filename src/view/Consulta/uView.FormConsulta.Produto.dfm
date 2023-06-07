inherited frmConsultaProduto: TfrmConsultaProduto
  Caption = 'Consulta de Produtos'
  ExplicitWidth = 786
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdConsulta: TDBGrid
    OnKeyDown = grdConsultaKeyDown
  end
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaidproduto: TIntegerField
      FieldName = 'idproduto'
    end
    object cdsConsultadescricao: TStringField
      FieldName = 'descricao'
      Size = 50
    end
    object cdsConsultaidfornecedor: TIntegerField
      FieldName = 'idfornecedor'
    end
    object cdsConsultapreco_unitario: TFloatField
      FieldName = 'preco_unitario'
    end
    object cdsConsultastatus: TStringField
      FieldName = 'status'
      Size = 1
    end
  end
end
