unit uModel.Services.Fornecedor;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Fornecedor,
  Data.DB;

type
  TFornecedorService = class(TInterfacedObject, IService<TFornecedor>)
  private
    FornecedorRepository: IRepository<TFornecedor>;
  public
    function Fields: TStrings;
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function IsValid(Entity: TFornecedor; out MessageContext: String): Boolean;
    function Save(Entity: TFornecedor): Boolean;
    function Update(Entity: TFornecedor): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TFornecedor): Boolean; overload;
    function DeleteById(Entity: TFornecedor): Boolean;
    function FindById(Id: Integer): TFornecedor;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement; overload;
    function FindAll: TObjectList<TFornecedor>; overload;
    function FindAll(CommadSQL: String): TObjectList<TFornecedor>; overload;
    function FindAll(CommadSQL: String; Entity: TFornecedor): TObjectList<TFornecedor>; overload;
    function Frist: TFornecedor;
    function Previous(Id: Integer): TFornecedor;
    function Next(Id: Integer): TFornecedor;
    function Last: TFornecedor;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TFornecedorService }

uses
  Vcl.Dialogs, uModel.Repository.Fornecedor, uModel.ConstsStatement;

constructor TFornecedorService.Create;
begin
  inherited Create;

  FornecedorRepository:= TFornecedorRepository.Create;
end;

function TFornecedorService.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TFornecedorService.DeleteById(Entity: TFornecedor): Boolean;
begin
  Result:= FornecedorRepository.DeleteById(Entity);
end;

destructor TFornecedorService.Destroy;
begin
  inherited Destroy;
end;

function TFornecedorService.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= FornecedorRepository.Fields;

  Result:= Items;
end;

function TFornecedorService.FindAll: TObjectList<TFornecedor>;
begin
  Result:= nil;
end;

function TFornecedorService.FindAll(CommadSQL: String): TObjectList<TFornecedor>;
begin
  Result:= FornecedorRepository.FindAll(CommadSQL);
end;

function TFornecedorService.FindAll(CommadSQL: String;
  Entity: TFornecedor): TObjectList<TFornecedor>;
begin
  Result:= nil;
end;

function TFornecedorService.FindById(Id: Integer): TFornecedor;
begin
  Result:= FornecedorRepository.FindById(Id);
end;

function TFornecedorService.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= FornecedorRepository.FindExists(CommadSQL, Parameter, ParameterType, Value);
end;

function TFornecedorService.FindExists: Boolean;
begin
  Result:= False;
end;

function TFornecedorService.Frist: TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorService.GeneratedValue: Integer;
begin
  Result:= FornecedorRepository.GeneratedValue;
end;

function TFornecedorService.IsValid(Entity: TFornecedor; out MessageContext: String): Boolean;
var
  fIsValid: Boolean;
  Statement: IStatement;
begin
  Result:= False;

  if Entity.IdFornecedor = 0 then
    begin
      MessageContext:= 'IdFornecedor não informado.';
      Exit;
    end;

  if Length( Entity.NomeFantasia ) = 0 then
    begin
      MessageContext:= 'Nome Fantasia não informado.';
      Exit;
    end;

  if Length( Entity.RazaoSocial ) = 0 then
    begin
      MessageContext:= 'Razão Social não informada.';
      Exit;
    end;

  if Length( Entity.Cnpj ) = 0 then
    begin
      MessageContext:= 'Cpf não informado.';
      Exit;
    end;

  if Length( Entity.Status ) = 0 then
    begin
      MessageContext:= 'Status não informado.';
      Exit;
    end;

  {Statement:= FindExists(ctSQLFornecedorFindExistsIdFornecedor, 'idfornecedor', ftInteger, Entity.IdFornecedor);

  if Statement.Query.FieldByName('idfornecedor').AsInteger = 0  then
    begin
      MessageContext:= 'Fornecedor não cadstrado, informe um fornecedor válido.';
      Exit;
    end;}

  Statement:= FindExists(ctSQLFornecedorFindExistsCnpj, 'cnpj', ftString, Entity.Cnpj);

  if (Statement.Query.FieldByName('idfornecedor').AsInteger > 0) and (Statement.Query.FieldByName('idfornecedor').AsInteger <> Entity.IdFornecedor)  then
    begin
      MessageContext:= 'Cnpj já cadastrado.';
      Exit;
    end;

  fIsValid:= Entity.IsCnpj(Entity.Cnpj);

  if fIsValid then
    Result:= True
  else
    begin
      MessageContext:= 'Cnpj invalido.';
    end;
end;

function TFornecedorService.Last: TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorService.Next(Id: Integer): TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorService.Previous(Id: Integer): TFornecedor;
begin
  Result:= nil;
end;

function TFornecedorService.Save(Entity: TFornecedor): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= FornecedorRepository.Save(Entity)
  else ShowMessage(MessageContext);
  {if Return then
    AfterSave(Entity);}

  //Result:= Return;
end;

function TFornecedorService.Update(CommandSQL, Parameter: String;
  Entity: TFornecedor): Boolean;
begin
  Result:= False;
end;

function TFornecedorService.Update(Entity: TFornecedor): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= FornecedorRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
