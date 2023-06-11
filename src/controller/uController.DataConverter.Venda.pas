unit uController.DataConverter.Venda;

interface

uses
  System.Generics.Collections, Datasnap.DBClient, uModel.Abstraction, uModel.Entities.Venda;

type
  TDataConverterVenda = class(TInterfacedObject, IDataConverter<TVenda>)
  public
    procedure Populate(Source: TObjectList<TVenda>; Target: TClientDataSet);

    destructor Destroy; override;
  end;

implementation

uses
  Data.DB;

{ TDataConverterVenda }

destructor TDataConverterVenda.Destroy;
begin
  inherited Destroy;
end;

procedure TDataConverterVenda.Populate(Source: TObjectList<TVenda>;
  Target: TClientDataSet);
var
  i: Integer;
begin
  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('idvenda').AsInteger:= Source.Items[i].IdVenda;
      Target.FieldByName('dthr_venda').AsDateTime:= Source.Items[i].DataHoraVenda;
      Target.FieldByName('idcliente').AsInteger:= Source.Items[i].Cliente.IdCliente;
      Target.FieldByName('nome_cliente').AsString:= Source.Items[i].Cliente.Nome;
      Target.FieldByName('Total').AsFloat:= Source.Items[i].Total;
      Target.FieldByName('status').AsString:= Source.Items[i].Status;
      Target.Post;
    end;
end;

end.
