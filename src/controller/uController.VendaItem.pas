unit uController.VendaItem;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.VendaItem,
  uModel.Services.VendaItem, Data.DB;

type
  TControllerVendaItem = class(TInterfacedObject, IController<TVendaItem>)
  private
    VendaItemService: IService<TVendaItem>;
  public
    function GeneratedValue: Integer;
    function Fields: TStrings;
    function Save(Entity: TVendaItem): Boolean;
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

{ TControllerVendaItem }

constructor TControllerVendaItem.Create;
begin
  inherited Create;

  VendaItemService:= TVendaItemService.Create;
end;

function TControllerVendaItem.DeleteById(Entity: TVendaItem): Boolean;
begin
  Result:= VendaItemService.DeleteById(Entity);
end;

destructor TControllerVendaItem.Destroy;
begin
  inherited Destroy;
end;

function TControllerVendaItem.Fields: TStrings;
begin
  Result:= nil;
end;

function TControllerVendaItem.FindAll: TObjectList<TVendaItem>;
begin
  Result:= nil;
end;

function TControllerVendaItem.FindAll(CommadSQL: String): TObjectList<TVendaItem>;
begin
  Result:= nil;
end;

function TControllerVendaItem.FindById(Id: Integer): TVendaItem;
begin
  Result:= VendaItemService.FindById(Id);
end;

function TControllerVendaItem.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= VendaItemService.FindExists(CommadSQL, Parameter, ParameterType, Value);
end;

function TControllerVendaItem.FindExists: Boolean;
begin
  Result:= False;
end;

function TControllerVendaItem.Frist: TVendaItem;
begin
  Result:= VendaItemService.Frist;
end;

function TControllerVendaItem.GeneratedValue: Integer;
begin
  Result:= VendaItemService.GeneratedValue;
end;

function TControllerVendaItem.Last: TVendaItem;
begin
  Result:= VendaItemService.Last;
end;

function TControllerVendaItem.Next(Id: Integer): TVendaItem;
begin
  Result:= VendaItemService.Next(Id);
end;

function TControllerVendaItem.Previous(Id: Integer): TVendaItem;
begin
  Result:= VendaItemService.Previous(Id);
end;

function TControllerVendaItem.Save(Entity: TVendaItem): Boolean;
begin
  Result:= VendaItemService.Save(Entity);
end;

function TControllerVendaItem.Update(CommandSQL, Parameter: String;
  Entity: TVendaItem): Boolean;
begin
  Result:= False;
end;

function TControllerVendaItem.Update(Entity: TVendaItem): Boolean;
begin
  Result:= VendaItemService.Update(Entity);
end;

function TControllerVendaItem.FindAll(CommadSQL: String;
  Entity: TVendaItem): TObjectList<TVendaItem>;
begin
  Result:= VendaItemService.FindAll(CommadSQL, Entity);
end;

end.
