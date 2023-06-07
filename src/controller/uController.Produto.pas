unit uController.Produto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto,
  uModel.Services.Venda;

type
  TControllerProduto = class(TInterfacedObject, IController<TProduto>)
  private
    ProdutoService: IService<TProduto>;
  public
    function GeneratedValue: Integer;
    function Fields: TStrings;
    function Save(Entity: TProduto): Boolean;
    function Update(Id: Integer; Entity: TProduto): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TProduto;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; Entity: TProduto): Boolean; overload;
    function FindAll: TObjectList<TProduto>; overload;
    function FindAll(CommadSQL: String): TObjectList<TProduto>; overload;
    function Frist: TProduto;
    function Previous(Id: Integer): TProduto;
    function Next(Id: Integer): TProduto;
    function Last: TProduto;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerProduto }

uses uModel.Services.Produto;

constructor TControllerProduto.Create;
begin
  inherited Create;

  ProdutoService:= TProdutoService.Create;
end;

function TControllerProduto.DeleteById(Id: Integer): Boolean;
begin
  Result:= ProdutoService.DeleteById(Id);
end;

destructor TControllerProduto.Destroy;
begin
  inherited Destroy;
end;

function TControllerProduto.Fields: TStrings;
begin
  Result:= nil;
end;

function TControllerProduto.FindAll: TObjectList<TProduto>;
begin
  Result:= nil;
end;

function TControllerProduto.FindAll(CommadSQL: String): TObjectList<TProduto>;
begin
  Result:= nil;
end;

function TControllerProduto.FindById(Id: Integer): TProduto;
begin
  Result:= ProdutoService.FindById(Id);
end;

function TControllerProduto.FindExists(CommadSQL: String; Parameter: String; Entity: TProduto): Boolean;
begin
  Result:= ProdutoService.FindExists(CommadSQL, Parameter, Entity);
end;

function TControllerProduto.FindExists: Boolean;
begin
  Result:= False;
end;

function TControllerProduto.Frist: TProduto;
begin
  Result:= ProdutoService.Frist;
end;

function TControllerProduto.GeneratedValue: Integer;
begin
  Result:= ProdutoService.GeneratedValue;
end;

function TControllerProduto.Last: TProduto;
begin
  Result:= ProdutoService.Last;
end;

function TControllerProduto.Next(Id: Integer): TProduto;
begin
  Result:= ProdutoService.Next(Id);
end;

function TControllerProduto.Previous(Id: Integer): TProduto;
begin
  Result:= ProdutoService.Previous(Id);
end;

function TControllerProduto.Save(Entity: TProduto): Boolean;
begin
  Result:= ProdutoService.Save(Entity);
end;

function TControllerProduto.Update(Id: Integer; Entity: TProduto): Boolean;
begin
  Result:= ProdutoService.Update(Id, Entity);
end;

end.
