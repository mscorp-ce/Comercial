unit uController.DataConverter.VendaItem;

interface

uses
  System.Generics.Collections, Datasnap.DBClient, uModel.Abstraction, uModel.Entities.VendaItem;

type
  TDataConverterVendaItem = class(TInterfacedObject, IDataConverter<TVendaItem>)
  public
    procedure Populate(Source: TObjectList<TVendaItem>; Target: TClientDataSet);

    destructor Destroy; override;
  end;

implementation

{ TDataConverterVendaItem }

destructor TDataConverterVendaItem.Destroy;
begin
  inherited Destroy;
end;

procedure TDataConverterVendaItem.Populate(Source: TObjectList<TVendaItem>;
  Target: TClientDataSet);
var
  i: Integer;
begin
  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('idVenda').AsInteger:= Source.Items[i].IdVenda;
      Target.FieldByName('Item').AsInteger:= Source.Items[i].Item;
      Target.FieldByName('idproduto').AsInteger:= Source.Items[i].Produto.IdProduto;
      Target.FieldByName('descricao').AsString:= Source.Items[i].Produto.Descricao;
      Target.FieldByName('preco_unitario').AsFloat:= Source.Items[i].PrecoUnitario;
      Target.FieldByName('quantidade').AsFloat:= Source.Items[i].Quantidade;
      Target.FieldByName('total').AsFloat:= Source.Items[i].Total;
      Target.Post;
    end;
end;

end.
