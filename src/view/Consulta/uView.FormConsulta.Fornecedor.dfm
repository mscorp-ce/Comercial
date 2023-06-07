inherited frmConsultaFornecedor: TfrmConsultaFornecedor
  Caption = 'Consulta de Clientes'
  ExplicitWidth = 786
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdConsulta: TDBGrid
    OnKeyDown = grdConsultaKeyDown
  end
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaidfornecedor: TIntegerField
      FieldName = 'idfornecedor'
    end
    object cdsConsultanome_fantasia: TStringField
      FieldName = 'nome_fantasia'
      Size = 50
    end
    object cdsConsultarazao_social: TStringField
      FieldName = 'razao_social'
      Size = 50
    end
    object cdsConsultacnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object cdsConsultastatus: TStringField
      FieldName = 'status'
      Size = 1
    end
  end
end
