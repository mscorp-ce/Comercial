unit uConntoller.ProdutoContext;

interface

uses
  Datasnap.DBClient, System.Generics.Collections, uModel.Entities.Produto;

type
  TProdutoContext = class
  private
    procedure Execute(CommadSQL: String; var Produtos: TObjectList<TProduto>; Data: TClientDataSet);
  public
    procedure List(CommadSQL: String; var Produtos: TObjectList<TProduto>; Data: TClientDataSet); overload;
    procedure List(var Produtos: TObjectList<TProduto>; Data: TClientDataSet); overload;
  end;

implementation

uses
  System.SysUtils, uModel.Abstraction, uController.DataConverter.Produto,
  uController.RootProduto, uModel.ConstsStatement;

{ TProdutoContext }

procedure TProdutoContext.Execute(CommadSQL: String; var Produtos: TObjectList<TProduto>; Data: TClientDataSet);
var
  ControllerRootProduto: IRootController<TProduto>;
  DataConverter: IDataConverter<TProduto>;
begin
  ControllerRootProduto:= TControllerRootProduto.Create;
  Data.Close;

  Data.CreateDataSet;

  Produtos:= ControllerRootProduto.FindAll(CommadSQL);

  DataConverter:= TDataConverterProduto.Create;
  DataConverter.Populate(Produtos, Data);

  Data.Open;
end;

procedure TProdutoContext.List(var Produtos: TObjectList<TProduto>; Data: TClientDataSet);
begin
  Execute(ctSQLProdutos, Produtos, Data);
end;

procedure TProdutoContext.List(CommadSQL: String;
  var Produtos: TObjectList<TProduto>; Data: TClientDataSet);
begin
  Execute(ctSQLProdutos, Produtos, Data);
end;

end.
