unit uController.Venda;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Venda,
  uModel.Services.Venda, Data.DB;

type
  TControllerVenda = class(TInterfacedObject, IController<TVenda>)
  private
    VendaService: IService<TVenda>;
  public
    function GeneratedValue: Integer;
    function Fields: TStrings;
    function Save(Entity: TVenda): Boolean;
    function Update(Entity: TVenda): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TVenda): Boolean; overload;
    function DeleteById(Entity: TVenda): Boolean;
    function FindById(Id: Integer): TVenda;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement; overload;
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

{ TControllerVenda }

constructor TControllerVenda.Create;
begin
  inherited Create;

  VendaService:= TVendaService.Create;
end;

function TControllerVenda.DeleteById(Entity: TVenda): Boolean;
begin
  Result:= VendaService.DeleteById(Entity);
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

function TControllerVenda.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= VendaService.FindExists(CommadSQL, Parameter, ParameterType, Value);
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
  Result:= VendaService.GeneratedValue;
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

function TControllerVenda.Update(CommandSQL, Parameter: String;
  Entity: TVenda): Boolean;
begin
  Result:= VendaService.Update(CommandSQL,Parameter, Entity);
end;

function TControllerVenda.Update(Entity: TVenda): Boolean;
begin
  Result:= VendaService.Update(Entity);
end;

function TControllerVenda.FindAll(CommadSQL: String;
  Entity: TVenda): TObjectList<TVenda>;
begin
  Result:= nil;
end;

end.
