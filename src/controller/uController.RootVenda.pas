unit uController.RootVenda;

interface

uses
  System.Classes, Data.DB, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Venda;

type
  TControllerRootVenda = class(TInterfacedObject, IRootController<TVenda>)
  private
    VendaService: IService<TVenda>;
  public
    function Fields: TStrings;
    function FindAll(CommadSQL: String): TObjectList<TVenda>;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  uModel.Services.Venda;

{ TRootController }

constructor TControllerRootVenda.Create;
begin
  inherited Create;

  VendaService:= TVendaService.Create;
end;

destructor TControllerRootVenda.Destroy;
begin
  inherited Destroy;
end;

function TControllerRootVenda.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= VendaService.Fields;

  Result:= Items;
end;

function TControllerRootVenda.FindAll(CommadSQL: String): TObjectList<TVenda>;
begin
  Result:= VendaService.FindAll(CommadSQL);
end;

end.
