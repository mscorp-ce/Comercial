unit uController.Venda;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Venda,
  uModel.Services.Venda;

type
  TControllerVenda = class(TInterfacedObject, IController<TVenda>)
  private
    VendaService: IService<TVenda>;
  public
    function GeneratedValue: Integer;
    function Fields: TStrings;
    function Save(Entity: TVenda): Boolean;
    function Update(Id: Integer; Entity: TVenda): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TVenda;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; Entity: TVenda): Boolean; overload;
    function FindAll: TObjectList<TVenda>; overload;
    function FindAll(CommadSQL: String): TObjectList<TVenda>; overload;
    function Frist: TVenda;
    function Previous(Id: Integer): TVenda;
    function Next(Id: Integer): TVenda;
    function Last: TVenda;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerVenda }

constructor TControllerVenda.Create;
begin
  inherited Create;

  VendaService:= TVendaService.Create;
end;

function TControllerVenda.DeleteById(Id: Integer): Boolean;
begin
  Result:= VendaService.DeleteById(Id);
end;

destructor TControllerVenda.Destroy;
begin
  inherited Destroy;
end;

function TControllerVenda.Fields: TStrings;
begin
  Result:= nil;
end;

function TControllerVenda.FindAll: TObjectList<TVenda>;
begin
  Result:= nil;
end;

function TControllerVenda.FindAll(CommadSQL: String): TObjectList<TVenda>;
begin
  Result:= nil;
end;

function TControllerVenda.FindById(Id: Integer): TVenda;
begin
  Result:= VendaService.FindById(Id);
end;

function TControllerVenda.FindExists(CommadSQL: String; Parameter: String; Entity: TVenda): Boolean;
begin
  Result:= False;
end;

function TControllerVenda.FindExists: Boolean;
begin
  Result:= False;
end;

function TControllerVenda.Frist: TVenda;
begin
  Result:= VendaService.Frist;
end;

function TControllerVenda.GeneratedValue: Integer;
begin
  Result:= 0;
end;

function TControllerVenda.Last: TVenda;
begin
  Result:= VendaService.Last;
end;

function TControllerVenda.Next(Id: Integer): TVenda;
begin
  Result:= VendaService.Next(Id);
end;

function TControllerVenda.Previous(Id: Integer): TVenda;
begin
  Result:= VendaService.Previous(Id);
end;

function TControllerVenda.Save(Entity: TVenda): Boolean;
begin
  Result:= VendaService.Save(Entity);
end;

function TControllerVenda.Update(Id: Integer; Entity: TVenda): Boolean;
begin
  Result:= VendaService.Update(Id, Entity);
end;

end.
