unit uModel.Repository.Fornecedor;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Fornecedor;

type
  TFornecedorRepository = class(TInterfacedObject, IRepository<TFornecedor>)
  public
    function Fields: TStrings;
    procedure SetStatement(Statement: IStatement; Entity: TFornecedor);
    procedure SetProperty(Statement: IStatement; Entity: TFornecedor);
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function Save(Entity: TFornecedor): Boolean;
    procedure AfterSave(Entity: TFornecedor);
    function Update(Entity: TFornecedor): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TFornecedor;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; Entity: TFornecedor): Boolean; overload;
    function FindAll: TObjectList<TFornecedor>; overload;
    function FindAll(CommadSQL: String): TObjectList<TFornecedor>;overload;
    function Frist: TFornecedor;
    function Previous(Id: Integer): TFornecedor;
    function Next(Id: Integer): TFornecedor;
    function Last: TFornecedor;

    destructor Destroy; override;
  end;

implementation

{ TFornecedorRepository }

uses
  System.SysUtils, FireDAC.Stan.Error, uModel.Repository.StatementFactory,
  uModel.DataManagerFactory, uModel.Repository.DataManager,
  uModel.FireDACEngineException, FireDAC.Stan.Param, uModel.ConstsStatement;

procedure TFornecedorRepository.AfterSave(Entity: TFornecedor);
begin

end;

function TFornecedorRepository.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TFornecedorRepository.DeleteById(Id: Integer): Boolean;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLFornecedorDeleteByID);
    Statement.Query.Params.ParamByName('idFornecedor').AsInteger:= Id;
    Statement.Query.ExecSQL;

    Result:=  Statement.Query.RowsAffected = ctRowsAffected;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

destructor TFornecedorRepository.Destroy;
begin
  inherited Destroy;
end;

function TFornecedorRepository.Fields: TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEtity('Fornecedores').GetFieldNames;

    Result:= Items;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TFornecedorRepository.FindAll(CommadSQL: String): TObjectList<TFornecedor>;
var
  Statement: IStatement;
  List: TObjectList<TFornecedor>;
  Fornecedor: TFornecedor;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TFornecedor>.Create;

    Statement.SQL(CommadSQL)
      .Open
        .Query
          .First;

    while not Statement.Query.Eof do
      begin
        Fornecedor:= TFornecedor.Create;
        Fornecedor.IdFornecedor:= Statement.Query.FieldByName('idfornecedor').AsInteger;
        Fornecedor.NomeFantasia:= Statement.Query.FieldByName('nome_fantasia').AsString;
        Fornecedor.RazaoSocial:= Statement.Query.FieldByName('razao_social').AsString;
        Fornecedor.Cnpj:= Statement.Query.FieldByName('cnpj').AsString;
        Fornecedor.Status:= Statement.Query.FieldByName('Status').AsString;
        List.Add(Fornecedor);
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

function TFornecedorRepository.FindAll: TObjectList<TFornecedor>;
var
  Statement: IStatement;
  List: TObjectList<TFornecedor>;
  Fornecedor: TFornecedor;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TFornecedor>.Create;

    Statement.SQL(ctSQLFornecedores)
      .Open
        .Query;

    Statement.Query.First;
    while not Statement.Query.Eof do
      begin
        Fornecedor:= TFornecedor.Create;

        SetProperty(Statement, Fornecedor);

        List.Add(Fornecedor);

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

function TFornecedorRepository.FindById(Id: Integer): TFornecedor;
var
  Statement: IStatement;
  Fornecedor: TFornecedor;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLFornecedorFindID);
    Statement.Query.Params.ParamByName('idfornecedor').AsInteger:= Id;
    Statement.Query.Open;

    Fornecedor:= TFornecedor.Create;
    SetProperty(Statement, Fornecedor);

    Result:= Fornecedor;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TFornecedorRepository.FindExists(CommadSQL: String; Parameter: String; Entity: TFornecedor): Boolean;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLFornecedorFindExistsCnpj);
    Statement.Query.Params.ParamByName('cnpj').AsString:= Entity.Cnpj;
    Statement.Query.Open;

    Result:= Statement.Query.FieldByName('OCORRENCIA').AsInteger = ctRowsAffected;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TFornecedorRepository.FindExists: Boolean;
begin
  Result:= False;
end;

function TFornecedorRepository.Frist: TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorRepository.GeneratedValue: Integer;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Result:= Statement.SQL(ctNextValueFornecedores)
      .Open
        .Query.FieldByName('currentID').AsInteger;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TFornecedorRepository.Last: TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorRepository.Next(Id: Integer): TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorRepository.Previous(Id: Integer): TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorRepository.Save(Entity: TFornecedor): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLFornecedorInsert);
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

procedure TFornecedorRepository.SetProperty(Statement: IStatement;
  Entity: TFornecedor);
begin
  try
    Entity.IdFornecedor:= Statement.Query.FieldByName('idfornecedor').AsInteger;
    Entity.NomeFantasia:= Statement.Query.FieldByName('nome_fantasia').AsString;
    Entity.RazaoSocial:= Statement.Query.FieldByName('razao_social').AsString;
    Entity.Cnpj:= Statement.Query.FieldByName('cnpj').AsString;
    Entity.Status:= Statement.Query.FieldByName('status').AsString;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

procedure TFornecedorRepository.SetStatement(Statement: IStatement;
  Entity: TFornecedor);
begin
  try
    Statement.Query.Params.ParamByName('idfornecedor').AsInteger:= Entity.IdFornecedor;
    Statement.Query.Params.ParamByName('nome_fantasia').AsString:= Entity.NomeFantasia;
    Statement.Query.Params.ParamByName('razao_social').AsString:= Entity.RazaoSocial;
    Statement.Query.Params.ParamByName('cnpj').AsString:= Entity.Cnpj;
    Statement.Query.Params.ParamByName('status').AsString:= Entity.Status;

  except
    on E: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(E));
  end;
end;

function TFornecedorRepository.Update(Entity: TFornecedor): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLFornecedorUpdate);
    Statement.Query.Params.ParamByName('idfornecedor').AsInteger:= Entity.IdFornecedor;
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
