inherited frmConsultaCliente: TfrmConsultaCliente
  Caption = 'Consulta de Clientes'
  ExplicitWidth = 786
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdConsulta: TDBGrid
    OnKeyDown = grdConsultaKeyDown
  end
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaidcliente: TIntegerField
      FieldName = 'idcliente'
    end
    object cdsConsultanome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object cdsConsultacpf: TStringField
      FieldName = 'cpf'
      Size = 15
    end
    object cdsConsultadata_de_nascimento: TDateField
      FieldName = 'data_de_nascimento'
    end
    object cdsConsultastatus: TStringField
      FieldName = 'status'
      Size = 1
    end
  end
end
