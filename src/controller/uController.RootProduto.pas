unit uController.RootProduto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto;

type
  TControllerRootProduto = class(TInterfacedObject, IRootController<TProduto>)
  private
    ProdutoService: IService<TProduto>;
  public
    function Fields: TStrings;
    function FindAll(CommadSQL: String): TObjectList<TProduto>; overload;
    function FindAll(CommadSQL: String; Entity: TProduto): TObjectList<TProduto>; overload;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerRootProduto }

uses uModel.Services.Produto;

constructor TControllerRootProduto.Create;
begin
  inherited Create;

  ProdutoService:= TProdutoService.Create;
end;

destructor TControllerRootProduto.Destroy;
begin
  inherited;
end;

function TControllerRootProduto.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= ProdutoService.Fields;

  Result:= Items;
end;

function TControllerRootProduto.FindAll(CommadSQL: String;
  Entity: TProduto): TObjectList<TProduto>;
begin
  Result:= nil;
end;

function TControllerRootProduto.FindAll(CommadSQL: String): TObjectList<TProduto>;
begin
  Result:= ProdutoService.FindAll(CommadSQL);
end;

end.
