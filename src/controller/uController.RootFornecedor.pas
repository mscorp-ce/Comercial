unit uController.RootFornecedor;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Fornecedor;

type
  TControllerRootFornecedor = class(TInterfacedObject, IRootController<TFornecedor>)
  private
    FornecedorService: IService<TFornecedor>;
  public
    function Fields: TStrings;
    function FindAll(CommadSQL: String): TObjectList<TFornecedor>; overload;
    function FindAll(CommadSQL: String; Entity: TFornecedor): TObjectList<TFornecedor>; overload;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerRootFornecedor }

uses uModel.Services.Fornecedor;

constructor TControllerRootFornecedor.Create;
begin
  inherited Create;

  FornecedorService:= TFornecedorService.Create;
end;

destructor TControllerRootFornecedor.Destroy;
begin
  inherited;
end;

function TControllerRootFornecedor.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= FornecedorService.Fields;

  Result:= Items;
end;

function TControllerRootFornecedor.FindAll(CommadSQL: String;
  Entity: TFornecedor): TObjectList<TFornecedor>;
begin
  Result:= nil;
end;

function TControllerRootFornecedor.FindAll(CommadSQL: String): TObjectList<TFornecedor>;
begin
  Result:= FornecedorService.FindAll(CommadSQL);
end;

end.
