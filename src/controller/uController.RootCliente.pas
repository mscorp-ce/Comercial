unit uController.RootCliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente;

type
  TControllerRootCliente = class(TInterfacedObject, IRootController<TCliente>)
  private
    ClienteService: IService<TCliente>;
  public
    function Fields: TStrings;
    function FindAll(CommadSQL: String): TObjectList<TCliente>; overload;
    function FindAll(CommadSQL: String; Entity: TCliente): TObjectList<TCliente>; overload;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerRootCliente }

uses uModel.Services.Cliente;

constructor TControllerRootCliente.Create;
begin
  inherited Create;

  ClienteService:= TClienteService.Create;
end;

destructor TControllerRootCliente.Destroy;
begin
  inherited;
end;

function TControllerRootCliente.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= ClienteService.Fields;

  Result:= Items;
end;

function TControllerRootCliente.FindAll(CommadSQL: String;
  Entity: TCliente): TObjectList<TCliente>;
begin
  Result:= nil;
end;

function TControllerRootCliente.FindAll(CommadSQL: String): TObjectList<TCliente>;
begin
  Result:= ClienteService.FindAll(CommadSQL);
end;

end.
