unit uController.DataConverter.Produto;

interface

uses
  System.Generics.Collections, Datasnap.DBClient, uModel.Abstraction, uModel.Entities.Produto;

type
  TDataConverterProduto = class(TInterfacedObject, IDataConverter<TProduto>)
  public
    procedure Populate(Source: TObjectList<TProduto>; Target: TClientDataSet);

    destructor Destroy; override;
  end;

implementation

{ TDataConverterProduto }

destructor TDataConverterProduto.Destroy;
begin
  inherited Destroy;
end;

procedure TDataConverterProduto.Populate(Source: TObjectList<TProduto>;
  Target: TClientDataSet);
var
  i: Integer;
begin
  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('idproduto').AsInteger:= Source.Items[i].IdProduto;
      Target.FieldByName('descricao').AsString:= Source.Items[i].Descricao;
      Target.FieldByName('idfornecedor').AsInteger:= Source.Items[i].Fornecedor.IdFornecedor;
      Target.FieldByName('preco_unitario').AsFloat:= Source.Items[i].PrecoUnitario;
      Target.FieldByName('status').AsString:= Source.Items[i].Status;
      Target.Post;
    end;
end;

end.
