unit uModel.Repository.Cliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente;

type
  TClienteRepository = class(TInterfacedObject, IRepository<TCliente>)
  public
    function Fields: TStrings;
    procedure SetStatement(Statement: IStatement; Entity: TCliente);
    procedure SetProperty(Statement: IStatement; Entity: TCliente);
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function Save(Entity: TCliente): Boolean;
    procedure AfterSave(Entity: TCliente);
    function Update(Entity: TCliente): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TCliente;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; Entity: TCliente): Boolean; overload;
    function FindAll: TObjectList<TCliente>; overload;
    function FindAll(CommadSQL: String): TObjectList<TCliente>;overload;
    function Frist: TCliente;
    function Previous(Id: Integer): TCliente;
    function Next(Id: Integer): TCliente;
    function Last: TCliente;

    destructor Destroy; override;
  end;

implementation

{ TClienteRepository }

uses
  System.SysUtils, FireDAC.Stan.Error, uModel.Repository.StatementFactory,
  uModel.DataManagerFactory, uModel.Repository.DataManager,
  uModel.FireDACEngineException, FireDAC.Stan.Param, uModel.ConstsStatement;

procedure TClienteRepository.AfterSave(Entity: TCliente);
begin

end;

function TClienteRepository.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TClienteRepository.DeleteById(Id: Integer): Boolean;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLClienteDeleteByID);
    Statement.Query.Params.ParamByName('idcliente').AsInteger:= Id;
    Statement.Query.ExecSQL;

    Result:=  Statement.Query.RowsAffected = ctRowsAffected;
    
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

destructor TClienteRepository.Destroy;
begin
  inherited Destroy;
end;

function TClienteRepository.Fields: TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEtity('clientes').GetFieldNames;

    Result:= Items;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TClienteRepository.FindAll(CommadSQL: String): TObjectList<TCliente>;
var
  Statement: IStatement;
  List: TObjectList<TCliente>;
  Cliente: TCliente;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TCliente>.Create;

    Statement.SQL(CommadSQL)
      .Open
        .Query
          .First;

    while not Statement.Query.Eof do
      begin
        Cliente:= TCliente.Create;
        Cliente.IdCliente:= Statement.Query.FieldByName('IdCliente').AsInteger;
        Cliente.Nome:= Statement.Query.FieldByName('Nome').AsString;
        Cliente.Cpf:= Statement.Query.FieldByName('Cpf').AsString;
        Cliente.DtNascimento:= Statement.Query.FieldByName('data_de_nascimento').AsDateTime;
        Cliente.Status:= Statement.Query.FieldByName('Status').AsString;
        List.Add(Cliente);
        Statement.Query.Next;
      end;

    Result:= List;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TClienteRepository.FindAll: TObjectList<TCliente>;
var
  Statement: IStatement;
  List: TObjectList<TCliente>;
  Cliente: TCliente;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TCliente>.Create;

    Statement.SQL(ctSQLClientes)
      .Open
        .Query;

    Statement.Query.First;
    while not Statement.Query.Eof do
      begin
        Cliente:= TCliente.Create;

        SetProperty(Statement, Cliente);

        List.Add(Cliente);

        Statement.Query.Next;
      end;

    Result:= List;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TClienteRepository.FindById(Id: Integer): TCliente;
var
  Statement: IStatement;
  Cliente: TCliente;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLClienteFindID);
    Statement.Query.Params.ParamByName('idcliente').AsInteger:= Id;
    Statement.Query.Open;

    Cliente:= TCliente.Create;
    SetProperty(Statement, Cliente);

    Result:= Cliente;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TClienteRepository.FindExists(CommadSQL: String; Parameter: String; Entity: TCliente): Boolean;
begin
  Result:= False;
end;

function TClienteRepository.FindExists: Boolean;
begin
  Result:= False;
end;

function TClienteRepository.Frist: TCliente;
begin
  Result:= nil;
end;

function TClienteRepository.GeneratedValue: Integer;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Result:= Statement.SQL(ctNextValueClientes)
      .Open
        .Query.FieldByName('currentID').AsInteger;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TClienteRepository.Last: TCliente;
begin
  Result:= nil;
end;

function TClienteRepository.Next(Id: Integer): TCliente;
begin
  Result:= nil;
end;

function TClienteRepository.Previous(Id: Integer): TCliente;
begin
  Result:= nil;
end;

function TClienteRepository.Save(Entity: TCliente): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLClienteInsert);
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL;

    DataManager.Commit;

    Result:= Statement.Query.RowsAffected = ctRowsAffected;
  except
    on E: EFDDBEngineException do
      begin
        DataManager.Rollback;
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

procedure TClienteRepository.SetProperty(Statement: IStatement;
  Entity: TCliente);
begin
  try
    Entity.IdCliente:= Statement.Query.FieldByName('idcliente').AsInteger;
    Entity.Nome:= Statement.Query.FieldByName('nome').AsString;
    Entity.Cpf:= Statement.Query.FieldByName('cpf').AsString;
    Entity.DtNascimento:= Statement.Query.FieldByName('data_de_nascimento').AsDateTime;
    Entity.Status:= Statement.Query.FieldByName('status').AsString;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

procedure TClienteRepository.SetStatement(Statement: IStatement;
  Entity: TCliente);
begin
  try
    Statement.Query.Params.ParamByName('idcliente').AsInteger:= Entity.IdCliente;
    Statement.Query.Params.ParamByName('nome').AsString:= Entity.Nome;
    Statement.Query.Params.ParamByName('cpf').AsString:= Entity.Cpf;
    Statement.Query.Params.ParamByName('data_de_nascimento').AsDate:= Entity.DtNascimento;
    Statement.Query.Params.ParamByName('status').AsString:= Entity.Status;

  except
    on E: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(E));
  end;
end;

function TClienteRepository.Update(Entity: TCliente): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLClienteUpdate);
    Statement.Query.Params.ParamByName('idcliente').AsInteger:= Entity.IdCliente;
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL;
    DataManager.Commit;

    Result:= Statement.Query.RowsAffected = ctRowsAffected;
  except
    on E: EFDDBEngineException do
      begin
        DataManager.Rollback;
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

end.
