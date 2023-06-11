unit uModel.Services.Venda;

interface

uses
   uModel.Abstraction, uModel.Entities.Venda, System.Classes, Data.DB, System.Generics.Collections,
   uModel.Repository.Venda;

type
  TVendaService = class(TInterfacedObject, IService<TVenda>)
  private
    VendaRepository: IRepository<TVenda>;
  public
    function Fields: TStrings;
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function IsValid(Entity: TVenda; out MessageContext: String): Boolean;
    function Save(Entity: TVenda): Boolean;
    procedure AfterSave(Entity: TVenda);
    function Update(Entity: TVenda): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TVenda): Boolean; overload;
    function DeleteById(Entity: TVenda): Boolean;
    function FindById(Id: Integer): TVenda;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String;
      ParameterType: TFieldType; Value: Variant): IStatement; overload;
    function FindAll: TObjectList<TVenda>; overload;
    function FindAll(CommadSQL: String): TObjectList<TVenda>; overload;
    function FindAll(CommadSQL: String; Entity: TVenda): TObjectList<TVenda>; overload;
    function Frist: TVenda;
    function Previous(Id: Integer): TVenda;
    function Next(Id: Integer): TVenda;
    function Last: TVenda;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TVendaService }

uses uModel.ConstsStatement, Vcl.Dialogs, System.SysUtils;

procedure TVendaService.AfterSave(Entity: TVenda);
begin

end;

constructor TVendaService.Create;
begin
  inherited Create;

  VendaRepository:= TVendaRepository.Create;
end;

function TVendaService.CurrentGeneratedValue: Integer;
begin
  Result:= VendaRepository.CurrentGeneratedValue;
end;

function TVendaService.DeleteById(Entity: TVenda): Boolean;
begin
  Result:= VendaRepository.DeleteById(Entity);
end;

destructor TVendaService.Destroy;
begin
  inherited Destroy;
end;

function TVendaService.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= VendaRepository.Fields;

  Result:= Items;
end;

function TVendaService.FindAll: TObjectList<TVenda>;
begin
  Result:= nil;
end;

function TVendaService.FindAll(CommadSQL: String): TObjectList<TVenda>;
begin
  Result:= VendaRepository.FindAll(CommadSQL);
end;

function TVendaService.FindAll(CommadSQL: String;
  Entity: TVenda): TObjectList<TVenda>;
begin
  Result:= nil;
end;

function TVendaService.FindById(Id: Integer): TVenda;
begin
  Result:= VendaRepository.FindById(Id);
end;

function TVendaService.FindExists(CommadSQL: String; Parameter: String;
  ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= VendaRepository.FindExists(CommadSQL, Parameter, ParameterType, Value);
end;

function TVendaService.FindExists: Boolean;
begin
  Result:= False;
end;

function TVendaService.Frist: TVenda;
begin
  Result:= VendaRepository.Frist;
end;

function TVendaService.GeneratedValue: Integer;
begin
  Result:= VendaRepository.GeneratedValue;
end;

function TVendaService.IsValid(Entity: TVenda; out MessageContext: String): Boolean;
var
  Statement: IStatement;
begin
  Result:= False;

  if Entity.IdVenda <= 0 then
    begin
      MessageContext:= 'IdVenda inválido.';
      Exit;
    end;

  if (DateToStr(Entity.DataHoraVenda) = '00/00/0000') or (Entity.DataHoraVenda = 0) then
    begin
      MessageContext:= 'Infome uma data válida.';
      Exit;
    end;

  if Entity.Cliente.IdCliente <= 0 then
    Exit;

  Statement:= FindExists(ctSQLClienteFindExists, 'idcliente', ftInteger, Entity.Cliente.IdCliente);

  if Statement.Query.FieldByName('idcliente').AsInteger = 0  then
    begin
      MessageContext:= 'Cliente não cadstrado, informe um cliente válido.';
      Exit;
    end;

  Statement:= FindExists(ctSQLClienteFindInativo, 'idcliente', ftInteger, Entity.Cliente.IdCliente);

  if (Entity.Status = 'E') and (Statement.Query.FieldByName('status').AsString = 'I') then
    begin
      MessageContext:= 'Não é possível efettivar uma venda para um cliente intativo, selecione um cliente que estaja ativo.';
      Exit;
    end;

  if Length( Entity.Status) = 0 then
    Exit;

  Result:= True;
end;

function TVendaService.Last: TVenda;
begin
  Result:= VendaRepository.Last;
end;

function TVendaService.Next(Id: Integer): TVenda;
begin
  Result:= VendaRepository.Next(Id);
end;

function TVendaService.Previous(Id: Integer): TVenda;
begin
  Result:= VendaRepository.Previous(Id);
end;

function TVendaService.Save(Entity: TVenda): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= VendaRepository.Save(Entity)
  else ShowMessage(MessageContext);
end;

function TVendaService.Update(CommandSQL, Parameter: String;
  Entity: TVenda): Boolean;
begin
  Result:= VendaRepository.Update(CommandSQL, Parameter, Entity);
end;

function TVendaService.Update(Entity: TVenda): Boolean;
var
  MessageContext: String;
begin
  Result:= False;

  if IsValid(Entity, MessageContext) then
    Result:= VendaRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
