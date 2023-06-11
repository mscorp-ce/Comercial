unit uModel.Services.Produto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto,
  Data.DB;

type
  TProdutoService = class(TInterfacedObject, IService<TProduto>)
  private
    ProdutoRepository: IRepository<TProduto>;
  public
    function Fields: TStrings;
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function IsValid(Entity: TProduto; out MessageContext: String): Boolean;
    function Save(Entity: TProduto): Boolean;
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
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TProdutoService }

uses
  uModel.Repository.Produto, Vcl.Dialogs, uModel.ConstsStatement;

constructor TProdutoService.Create;
begin
  inherited Create;

  ProdutoRepository:= TProdutoRepository.Create;
end;

function TProdutoService.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TProdutoService.DeleteById(Entity: TProduto): Boolean;
begin
  Result:= ProdutoRepository.DeleteById(Entity);
end;

destructor TProdutoService.Destroy;
begin
  inherited Destroy;
end;

function TProdutoService.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= ProdutoRepository.Fields;

  Result:= Items;
end;

function TProdutoService.FindAll: TObjectList<TProduto>;
begin
  Result:= nil;
end;

function TProdutoService.FindAll(CommadSQL: String): TObjectList<TProduto>;
begin
  Result:= ProdutoRepository.FindAll(CommadSQL);
end;

function TProdutoService.FindAll(CommadSQL: String;
  Entity: TProduto): TObjectList<TProduto>;
begin
  Result:= nil;
end;

function TProdutoService.FindById(Id: Integer): TProduto;
begin
  Result:= ProdutoRepository.FindById(Id);
end;

function TProdutoService.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= ProdutoRepository.FindExists(CommadSQL, Parameter, ParameterType, Value);
end;

function TProdutoService.FindExists: Boolean;
begin
  Result:= False;
end;

function TProdutoService.Frist: TProduto;
begin
  Result:= nil;
end;

function TProdutoService.GeneratedValue: Integer;
begin
  Result:= ProdutoRepository.GeneratedValue;
end;

function TProdutoService.IsValid(Entity: TProduto; out MessageContext: String): Boolean;
var
  Statement: IStatement;
begin
  Result:= False;

  if Entity.IdProduto = 0 then
    begin
      MessageContext:= 'IdProduto não informado.';
      Exit;
    end;

  if Length( Entity.Descricao ) = 0 then
    begin
      MessageContext:= 'Descrição não informada.';
      Exit;
    end;

  if Entity.Fornecedor.IdFornecedor = 0 then
    begin
      MessageContext:= 'IdFornecedor não informado.';
      Exit;
    end;

  Statement:= FindExists(ctSQLFornecedorFindExistsIdFornecedor, 'idfornecedor', ftInteger, Entity.Fornecedor.IdFornecedor);

  if Statement.Query.FieldByName('idfornecedor').AsInteger = 0 then
    begin
      MessageContext:= 'Esse fornecedor não esta cadastrado.';
      Exit;
    end;

  Statement:= FindExists(ctSQLFornecedorFindExistsInativo, 'idfornecedor', ftInteger, Entity.Fornecedor.IdFornecedor);

  if Statement.Query.FieldByName('status').AsString = 'I' then
    begin
      MessageContext:= 'O fornecedor esta inativo.';
      Exit;
    end;

  if Entity.PrecoUnitario = 0 then
    begin
      MessageContext:= 'Preço Unitário não informado.';
      Exit;
    end;

  if Length( Entity.Status ) = 0 then
    begin
      MessageContext:= 'Status não informado.';
      Exit;
    end;

  Result:= True;
end;

function TProdutoService.Last: TProduto;
begin
  Result:= nil;
end;

function TProdutoService.Next(Id: Integer): TProduto;
begin
  Result:= nil;
end;

function TProdutoService.Previous(Id: Integer): TProduto;
begin
  Result:= nil;
end;

function TProdutoService.Save(Entity: TProduto): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= ProdutoRepository.Save(Entity)
  else ShowMessage(MessageContext);
  {if Return then
    AfterSave(Entity);}

  //Result:= Return;
end;

function TProdutoService.Update(CommandSQL, Parameter: String;
  Entity: TProduto): Boolean;
begin
  Result:= False;
end;

function TProdutoService.Update(Entity: TProduto): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= ProdutoRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
