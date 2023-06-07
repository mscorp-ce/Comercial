unit uModel.Services.Cliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente;

type
  TClienteService = class(TInterfacedObject, IService<TCliente>)
  private
    ClienteRepository: IRepository<TCliente>;
  public
    function Fields: TStrings;
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function IsValid(Entity: TCliente; out MessageContext: String): Boolean;
    function Save(Entity: TCliente): Boolean;
    function Update(Id: Integer; Entity: TCliente): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TCliente;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Entity: TCliente): Boolean; overload;
    function FindAll: TObjectList<TCliente>; overload;
    function FindAll(CommadSQL: String): TObjectList<TCliente>; overload;
    function Frist: TCliente;
    function Previous(Id: Integer): TCliente;
    function Next(Id: Integer): TCliente;
    function Last: TCliente;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TClienteService }

uses
  uModel.Repository.Cliente, Vcl.Dialogs, uModel.ConstsStatement;

constructor TClienteService.Create;
begin
  inherited Create;

  ClienteRepository:= TClienteRepository.Create;
end;

function TClienteService.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TClienteService.DeleteById(Id: Integer): Boolean;
begin
  Result:= ClienteRepository.DeleteById(Id);
end;

destructor TClienteService.Destroy;
begin
  inherited Destroy;
end;

function TClienteService.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= ClienteRepository.Fields;

  Result:= Items;
end;

function TClienteService.FindAll: TObjectList<TCliente>;
begin
  Result:= nil;
end;

function TClienteService.FindAll(CommadSQL: String): TObjectList<TCliente>;
begin
  Result:= ClienteRepository.FindAll(CommadSQL);
end;

function TClienteService.FindById(Id: Integer): TCliente;
begin
  Result:= ClienteRepository.FindById(Id);
end;

function TClienteService.FindExists(CommadSQL: String; Entity: TCliente): Boolean;
begin
  Result:= ClienteRepository.FindExists(CommadSQL, Entity);
end;

function TClienteService.FindExists: Boolean;
begin
  Result:= False;
end;

function TClienteService.Frist: TCliente;
begin
  Result:= nil;
end;

function TClienteService.GeneratedValue: Integer;
begin
  Result:= ClienteRepository.GeneratedValue;
end;

function TClienteService.IsValid(Entity: TCliente; out MessageContext: String): Boolean;
var
  fIsValid: Boolean;
begin
  Result:= False;

  if FindExists(ctSQLClienteFindExistsCpf, Entity) then
    begin
      MessageContext:= 'Cpf já cadastrado.';
    end;

  fIsValid:= Entity.IsCPF(Entity.Cpf);

  if fIsValid then
    Result:= True
  else
    begin
      MessageContext:= 'Cpf invalido.';
    end;
end;

function TClienteService.Last: TCliente;
begin
  Result:= nil;
end;

function TClienteService.Next(Id: Integer): TCliente;
begin
  Result:= nil;
end;

function TClienteService.Previous(Id: Integer): TCliente;
begin
  Result:= nil;
end;

function TClienteService.Save(Entity: TCliente): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= ClienteRepository.Save(Entity)
  else ShowMessage(MessageContext);
  {if Return then
    AfterSave(Entity);}

  //Result:= Return;
end;

function TClienteService.Update(Id: Integer; Entity: TCliente): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= ClienteRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
