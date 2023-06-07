unit uController.DataConverter.Fornecedor;

interface

uses
  System.Generics.Collections, Datasnap.DBClient, uModel.Abstraction, uModel.Entities.Fornecedor;

type
  TDataConverterFornecedor = class(TInterfacedObject, IDataConverter<TFornecedor>)
  public
    procedure Populate(Source: TObjectList<TFornecedor>; Target: TClientDataSet);

    destructor Destroy; override;
  end;

implementation

{ TDataConverterFornecedor }

destructor TDataConverterFornecedor.Destroy;
begin
  inherited Destroy;
end;

procedure TDataConverterFornecedor.Populate(Source: TObjectList<TFornecedor>;
  Target: TClientDataSet);
var
  i: Integer;
begin
  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('idfornecedor').AsInteger:= Source.Items[i].IdFornecedor;
      Target.FieldByName('nome_fantasia').AsString:= Source.Items[i].NomeFantasia;
      Target.FieldByName('razao_social').AsString:= Source.Items[i].RazaoSocial;
      Target.FieldByName('cnpj').AsString:= Source.Items[i].Cnpj;
      Target.FieldByName('status').AsString:= Source.Items[i].Status;
      Target.Post;
    end;
end;

end.
