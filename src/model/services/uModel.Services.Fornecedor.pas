unit uModel.Services.Fornecedor;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Fornecedor;

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
    function Update(Id: Integer; Entity: TFornecedor): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TFornecedor;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Entity: TFornecedor): Boolean; overload;
    function FindAll: TObjectList<TFornecedor>; overload;
    function FindAll(CommadSQL: String): TObjectList<TFornecedor>; overload;
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
  uModel.Repository.Fornecedor, Vcl.Dialogs, uModel.ConstsStatement;

constructor TFornecedorService.Create;
begin
  inherited Create;

  FornecedorRepository:= TFornecedorRepository.Create;
end;

function TFornecedorService.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TFornecedorService.DeleteById(Id: Integer): Boolean;
begin
  Result:= FornecedorRepository.DeleteById(Id);
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

function TFornecedorService.FindById(Id: Integer): TFornecedor;
begin
  Result:= FornecedorRepository.FindById(Id);
end;

function TFornecedorService.FindExists(CommadSQL: String; Entity: TFornecedor): Boolean;
begin
  Result:= FornecedorRepository.FindExists(CommadSQL, Entity);
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
begin
  Result:= False;

  if FindExists(ctSQLClienteFindExistsCpf, Entity) then
    begin
      MessageContext:= 'Cnpj já cadastrado.';
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

function TFornecedorService.Update(Id: Integer; Entity: TFornecedor): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= FornecedorRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
