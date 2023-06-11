unit uModel.Repository.Produto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto,
  Data.DB;

type
  TProdutoRepository = class(TInterfacedObject, IRepository<TProduto>)
  public
    function Fields: TStrings;
    procedure SetStatement(Statement: IStatement; Entity: TProduto);
    procedure SetProperty(Statement: IStatement; Entity: TProduto);
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function Save(Entity: TProduto): Boolean;
    procedure AfterSave(Entity: TProduto);
    function Update(Entity: TProduto): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TProduto): Boolean; overload;
    function DeleteById(Entity: TProduto): Boolean;
    function FindById(Id: Integer): TProduto;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement; overload;
    function FindAll: TObjectList<TProduto>; overload;
    function FindAll(CommadSQL: String): TObjectList<TProduto>; overload;
    function FindAll(CommadSQL: String; Entity: TProduto): TObjectList<TProduto>; overload;
    function Frist: TProduto;
    function Previous(Id: Integer): TProduto;
    function Next(Id: Integer): TProduto;
    function Last: TProduto;

    destructor Destroy; override;
  end;

implementation

{ TProdutoRepository }

uses
  System.SysUtils, FireDAC.Stan.Error, uModel.Repository.StatementFactory,
  uModel.DataManagerFactory, uModel.Repository.DataManager,
  uModel.FireDACEngineException, FireDAC.Stan.Param, uModel.ConstsStatement,
  uModel.Repository.RepositoryContext;

procedure TProdutoRepository.AfterSave(Entity: TProduto);
begin

end;

function TProdutoRepository.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TProdutoRepository.DeleteById(Entity: TProduto): Boolean;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLProdutoDeleteByID);
    Statement.Query.Params.ParamByName('idProduto').AsInteger:= Entity.IdProduto;
    Statement.Query.ExecSQL;

    Result:=  Statement.Query.RowsAffected = ctRowsAffected;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

destructor TProdutoRepository.Destroy;
begin
  inherited Destroy;
end;

function TProdutoRepository.Fields: TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEtity('Produtoes').GetFieldNames;

    Result:= Items;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TProdutoRepository.FindAll(CommadSQL: String): TObjectList<TProduto>;
var
  Statement: IStatement;
  List: TObjectList<TProduto>;
  Produto: TProduto;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TProduto>.Create;

    Statement.SQL(CommadSQL)
      .Open
        .Query
          .First;

    while not Statement.Query.Eof do
      begin
        Produto:= TProduto.Create;
        Produto.IdProduto:= Statement.Query.FieldByName('idProduto').AsInteger;
        Produto.Descricao:= Statement.Query.FieldByName('descricao').AsString;
        Produto.Fornecedor.IdFornecedor:= Statement.Query.FieldByName('idfornecedor').AsInteger;
        Produto.PrecoUnitario:= Statement.Query.FieldByName('preco_unitario').AsFloat;
        Produto.Status:= Statement.Query.FieldByName('Status').AsString;
        List.Add(Produto);
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

function TProdutoRepository.FindAll: TObjectList<TProduto>;
var
  Statement: IStatement;
  List: TObjectList<TProduto>;
  Produto: TProduto;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TProduto>.Create;

    Statement.SQL(ctSQLProdutos)
      .Open
        .Query;

    Statement.Query.First;
    while not Statement.Query.Eof do
      begin
        Produto:= TProduto.Create;

        SetProperty(Statement, Produto);

        List.Add(Produto);

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

function TProdutoRepository.FindById(Id: Integer): TProduto;
var
  Statement: IStatement;
  Produto: TProduto;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLProdutoFindID);
    Statement.Query.Params.ParamByName('idProduto').AsInteger:= Id;
    Statement.Query.Open;

    Produto:= TProduto.Create;
    SetProperty(Statement, Produto);

    Result:= Produto;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TProdutoRepository.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
var
  RepositoryContext: TRepositoryContext;
begin
  RepositoryContext:= TRepositoryContext.Create;
  try
    Result:= RepositoryContext.FindExists(CommadSQL, Parameter, ParameterType, Value);
  finally
    FreeAndNil(RepositoryContext);
  end;
end;

function TProdutoRepository.FindExists: Boolean;
begin
  Result:= False;
end;

function TProdutoRepository.Frist: TProduto;
begin
  Result:= nil;
end;

function TProdutoRepository.GeneratedValue: Integer;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Result:= Statement.SQL(ctNextValueProdutos)
      .Open
        .Query.FieldByName('currentID').AsInteger;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TProdutoRepository.Last: TProduto;
begin
  Result:= nil;
end;

function TProdutoRepository.Next(Id: Integer): TProduto;
begin
  Result:= nil;
end;

function TProdutoRepository.Previous(Id: Integer): TProduto;
begin
  Result:= nil;
end;

function TProdutoRepository.Save(Entity: TProduto): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLProdutoInsert);
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

procedure TProdutoRepository.SetProperty(Statement: IStatement;
  Entity: TProduto);
begin
  try
    Entity.IdProduto:= Statement.Query.FieldByName('idproduto').AsInteger;
    Entity.Descricao:= Statement.Query.FieldByName('descricao').AsString;
    Entity.Fornecedor.IdFornecedor:= Statement.Query.FieldByName('idfornecedor').AsInteger;
    Entity.PrecoUnitario:= Statement.Query.FieldByName('preco_unitario').AsFloat;
    Entity.Status:= Statement.Query.FieldByName('status').AsString;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

procedure TProdutoRepository.SetStatement(Statement: IStatement;
  Entity: TProduto);
begin
  try
    Statement.Query.Params.ParamByName('idproduto').AsInteger:= Entity.IdProduto;
    Statement.Query.Params.ParamByName('descricao').AsString:= Entity.Descricao;
    Statement.Query.Params.ParamByName('idfornecedor').AsInteger:= Entity.Fornecedor.IdFornecedor;
    Statement.Query.Params.ParamByName('preco_unitario').AsFloat:= Entity.PrecoUnitario;
    Statement.Query.Params.ParamByName('status').AsString:= Entity.Status;

  except
    on E: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(E));
  end;
end;

function TProdutoRepository.Update(CommandSQL, Parameter: String;
  Entity: TProduto): Boolean;
begin
  Result:= False;
end;

function TProdutoRepository.Update(Entity: TProduto): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLProdutoUpdate);
    Statement.Query.Params.ParamByName('idProduto').AsInteger:= Entity.IdProduto;
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

function TProdutoRepository.FindAll(CommadSQL: String;
  Entity: TProduto): TObjectList<TProduto>;
begin
  Result:= nil;
end;

end.
