unit uModel.Services.Cliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente,
  Data.DB;

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
    function Update(Entity: TCliente): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TCliente): Boolean; overload;
    function DeleteById(Entity: TCliente): Boolean;
    function FindById(Id: Integer): TCliente;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String;
      ParameterType: TFieldType; Value: Variant): IStatement; overload;
    function FindAll: TObjectList<TCliente>; overload;
    function FindAll(CommadSQL: String): TObjectList<TCliente>; overload;
    function FindAll(CommadSQL: String; Entity: TCliente): TObjectList<TCliente>; overload;
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
  System.SysUtils, uModel.Repository.Cliente, Vcl.Dialogs, uModel.ConstsStatement;

constructor TClienteService.Create;
begin
  inherited Create;

  ClienteRepository:= TClienteRepository.Create;
end;

function TClienteService.CurrentGeneratedValue: Integer;
begin
  Result:= 0;
end;

function TClienteService.DeleteById(Entity: TCliente): Boolean;
begin
  Result:= ClienteRepository.DeleteById(Entity);
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

function TClienteService.FindAll(CommadSQL: String;
  Entity: TCliente): TObjectList<TCliente>;
begin
  Result:= nil;
end;

function TClienteService.FindById(Id: Integer): TCliente;
begin
  Result:= ClienteRepository.FindById(Id);
end;

function TClienteService.FindExists(CommadSQL: String; Parameter: String;
  ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= ClienteRepository.FindExists(CommadSQL, Parameter, ParameterType, Value);
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
  Statement: IStatement;
begin
  Result:= False;

  if Entity.IdCliente = 0 then
    begin
      MessageContext:= 'IdCliente n�o informado.';
      Exit;
    end;

  if Length( Entity.Nome ) = 0 then
    begin
      MessageContext:= 'Nome n�o informado.';
      Exit;
    end;

  if Length( Entity.Cpf ) = 0 then
    begin
      MessageContext:= 'Cpf n�o informado.';
      Exit;
    end;

  if DateToStr(Entity.DtNascimento) = '00/00/0000' then
    begin
      MessageContext:= 'Data de Nascimento n�o informada.';
      Exit;
    end;

  if Length( Entity.Status ) = 0 then
    begin
      MessageContext:= 'Status n�o informado.';
      Exit;
    end;

  Statement:= FindExists(ctSQLClienteFindExistsCpf, 'cpf', ftString, Entity.Cpf);

  if (Statement.Query.FieldByName('idcliente').AsInteger > 0) and (Entity.IdCliente <> Statement.Query.FieldByName('idcliente').AsInteger) then
    begin
      MessageContext:= 'Cpf j� cadastrado.';
      Exit;
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
end;

function TClienteService.Update(CommandSQL, Parameter: String;
  Entity: TCliente): Boolean;
begin
  Result:= False;
end;

function TClienteService.Update(Entity: TCliente): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= ClienteRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
