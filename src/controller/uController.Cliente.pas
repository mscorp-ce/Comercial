unit uController.Cliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente,
  uModel.Services.Venda;

type
  TControllerCliente = class(TInterfacedObject, IController<TCliente>)
  private
    ClienteService: IService<TCliente>;
  public
    function GeneratedValue: Integer;
    function Fields: TStrings;
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

{ TControllerCliente }

uses uModel.Services.Cliente;

constructor TControllerCliente.Create;
begin
  inherited Create;

  ClienteService:= TClienteService.Create;
end;

function TControllerCliente.DeleteById(Id: Integer): Boolean;
begin
  Result:= ClienteService.DeleteById(Id);
end;

destructor TControllerCliente.Destroy;
begin
  inherited Destroy;
end;

function TControllerCliente.Fields: TStrings;
begin
  Result:= nil;
end;

function TControllerCliente.FindAll: TObjectList<TCliente>;
begin
  Result:= nil;
end;

function TControllerCliente.FindAll(CommadSQL: String): TObjectList<TCliente>;
begin
  Result:= nil;
end;

function TControllerCliente.FindById(Id: Integer): TCliente;
begin
  Result:= ClienteService.FindById(Id);
end;

function TControllerCliente.FindExists(CommadSQL: String; Entity: TCliente): Boolean;
begin
  Result:= ClienteService.FindExists(CommadSQL, Entity);
end;

function TControllerCliente.FindExists: Boolean;
begin
  Result:= False;
end;

function TControllerCliente.Frist: TCliente;
begin
  Result:= ClienteService.Frist;
end;

function TControllerCliente.GeneratedValue: Integer;
begin
  Result:= ClienteService.GeneratedValue;
end;

function TControllerCliente.Last: TCliente;
begin
  Result:= ClienteService.Last;
end;

function TControllerCliente.Next(Id: Integer): TCliente;
begin
  Result:= ClienteService.Next(Id);
end;

function TControllerCliente.Previous(Id: Integer): TCliente;
begin
  Result:= ClienteService.Previous(Id);
end;

function TControllerCliente.Save(Entity: TCliente): Boolean;
begin
  Result:= ClienteService.Save(Entity);
end;

function TControllerCliente.Update(Id: Integer; Entity: TCliente): Boolean;
begin
  Result:= ClienteService.Update(Id, Entity);
end;

end.
