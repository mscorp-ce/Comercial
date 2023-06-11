unit uController.RootVendaItem;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.VendaItem;

type
  TControllerRootVendaItem = class(TInterfacedObject, IRootController<TVendaItem>)
  private
    VendaItemService: IService<TVendaItem>;
  public
    function Fields: TStrings;
    function FindAll(CommadSQL: String): TObjectList<TVendaItem>; overload;
    function FindAll(CommadSQL: String; Entity: TVendaItem): TObjectList<TVendaItem>; overload;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerRootVendaItem }

uses uModel.Services.VendaItem;

constructor TControllerRootVendaItem.Create;
begin
  inherited Create;

  VendaItemService:= TVendaItemService.Create;
end;

destructor TControllerRootVendaItem.Destroy;
begin
  inherited;
end;

function TControllerRootVendaItem.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= VendaItemService.Fields;

  Result:= Items;
end;

function TControllerRootVendaItem.FindAll(CommadSQL: String;
  Entity: TVendaItem): TObjectList<TVendaItem>;
begin
  Result:= VendaItemService.FindAll(CommadSQL, Entity);
end;

function TControllerRootVendaItem.FindAll(CommadSQL: String): TObjectList<TVendaItem>;
begin
  Result:= VendaItemService.FindAll(CommadSQL);
end;

end.
