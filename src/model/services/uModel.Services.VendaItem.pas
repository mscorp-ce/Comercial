unit uModel.Services.VendaItem;

interface

uses
   uModel.Abstraction, uModel.Entities.VendaItem, System.Classes, Data.DB, System.Generics.Collections,
   uModel.Repository.VendaItem;

type
  TVendaItemService = class(TInterfacedObject, IService<TVendaItem>)
  private
    VendaItemRepository: IRepository<TVendaItem>;
  public
    function Fields: TStrings;
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function IsValid(Entity: TVendaItem; out MessageContext: String): Boolean;
    function Save(Entity: TVendaItem): Boolean;
    procedure AfterSave(Entity: TVendaItem);
    function Update(Entity: TVendaItem): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TVendaItem): Boolean; overload;
    function DeleteById(Entity: TVendaItem): Boolean;
    function FindById(Id: Integer): TVendaItem;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement; overload;
    function FindAll: TObjectList<TVendaItem>; overload;
    function FindAll(CommadSQL: String): TObjectList<TVendaItem>; overload;
    function FindAll(CommadSQL: String; Entity: TVendaItem): TObjectList<TVendaItem>; overload;
    function Frist: TVendaItem;
    function Previous(Id: Integer): TVendaItem;
    function Next(Id: Integer): TVendaItem;
    function Last: TVendaItem;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TVendaItemService }

procedure TVendaItemService.AfterSave(Entity: TVendaItem);
begin

end;

constructor TVendaItemService.Create;
begin
  inherited Create;

  VendaItemRepository:= TVendaItemRepository.Create;
end;

function TVendaItemService.CurrentGeneratedValue: Integer;
begin
  Result:= VendaItemRepository.CurrentGeneratedValue;
end;

function TVendaItemService.DeleteById(Entity: TVendaItem): Boolean;
begin
  Result:= VendaItemRepository.DeleteById(Entity);
end;

destructor TVendaItemService.Destroy;
begin
  inherited Destroy;
end;

function TVendaItemService.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= VendaItemRepository.Fields;

  Result:= Items;
end;

function TVendaItemService.FindAll: TObjectList<TVendaItem>;
begin
  Result:= nil;
end;

function TVendaItemService.FindAll(CommadSQL: String): TObjectList<TVendaItem>;
begin
  Result:= VendaItemRepository.FindAll(CommadSQL);
end;

function TVendaItemService.FindAll(CommadSQL: String;
  Entity: TVendaItem): TObjectList<TVendaItem>;
begin
  Result:= VendaItemRepository.FindAll(CommadSQL, Entity);
end;

function TVendaItemService.FindById(Id: Integer): TVendaItem;
begin
  Result:= VendaItemRepository.FindById(Id);
end;

function TVendaItemService.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= nil;
end;

function TVendaItemService.FindExists: Boolean;
begin
  Result:= False;
end;

function TVendaItemService.Frist: TVendaItem;
begin
  Result:= VendaItemRepository.Frist;
end;

function TVendaItemService.GeneratedValue: Integer;
begin
  Result:= VendaItemRepository.GeneratedValue;
end;

function TVendaItemService.IsValid(Entity: TVendaItem; out MessageContext: String): Boolean;
begin
  Result:= False;

  if Entity.IdVenda<= 0 then
    Exit;

  if Entity.Item = 0 then
    Exit;

  if Entity.Produto.IdProduto <= 0 then
    Exit;

  if Entity.PrecoUnitario = 0 then
    Exit;

  if Entity.Quantidade = 0 then
    Exit;

  if Entity.Total = 0 then
    Exit;

  Result:= True;
end;

function TVendaItemService.Last: TVendaItem;
begin
  Result:= VendaItemRepository.Last;
end;

function TVendaItemService.Next(Id: Integer): TVendaItem;
begin
  Result:= VendaItemRepository.Next(Id);
end;

function TVendaItemService.Previous(Id: Integer): TVendaItem;
begin
  Result:= VendaItemRepository.Previous(Id);
end;

function TVendaItemService.Save(Entity: TVendaItem): Boolean;
var
  Return: Boolean;
begin
  Return:= VendaItemRepository.Save(Entity);
  if Return then
    AfterSave(Entity);

  Result:= Return;
end;

function TVendaItemService.Update(CommandSQL, Parameter: String;
  Entity: TVendaItem): Boolean;
begin
  Result:= False;
end;

function TVendaItemService.Update(Entity: TVendaItem): Boolean;
begin
  Result:= VendaItemRepository.Update(Entity);
end;

end.
