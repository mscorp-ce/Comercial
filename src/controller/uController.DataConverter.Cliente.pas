unit uController.DataConverter.Cliente;

interface

uses
  System.Generics.Collections, Datasnap.DBClient, uModel.Abstraction, uModel.Entities.Cliente;

type
  TDataConverterCliente = class(TInterfacedObject, IDataConverter<TCliente>)
  public
    procedure Populate(Source: TObjectList<TCliente>; Target: TClientDataSet);

    destructor Destroy; override;
  end;

implementation

{ TDataConverterCliente }

destructor TDataConverterCliente.Destroy;
begin
  inherited Destroy;
end;

procedure TDataConverterCliente.Populate(Source: TObjectList<TCliente>;
  Target: TClientDataSet);
var
  i: Integer;
begin
  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('idcliente').AsInteger:= Source.Items[i].IdCliente;
      Target.FieldByName('nome').AsString:= Source.Items[i].Nome;
      Target.FieldByName('cpf').AsString:= Source.Items[i].Cpf;
      Target.FieldByName('data_de_nascimento').AsDateTime:= Source.Items[i].DtNascimento;
      Target.FieldByName('status').AsString:= Source.Items[i].Status;
      Target.Post;
    end;
end;

end.
