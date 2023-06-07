unit uConntoller.FornecedorContext;

interface

uses
  Datasnap.DBClient, System.Generics.Collections, uModel.Entities.Fornecedor;

type
  TFornecedorContext = class
  public
    procedure List(var Fornecedores: TObjectList<TFornecedor>; Data: TClientDataSet);
  end;

implementation

uses
  System.SysUtils, uModel.Abstraction, uController.DataConverter.Fornecedor,
  uController.RootFornecedor, uModel.ConstsStatement;

{ TFornecedorContext }

procedure TFornecedorContext.List(var Fornecedores: TObjectList<TFornecedor>; Data: TClientDataSet);
var
  ControllerRootProduto: IRootController<TFornecedor>;
  DataConverter: IDataConverter<TFornecedor>;
begin
  ControllerRootProduto:= TControllerRootFornecedor.Create;
  Data.Close;

  Data.CreateDataSet;

  Fornecedores:= ControllerRootProduto.FindAll(ctSQLFornecedores);

  DataConverter:= TDataConverterFornecedor.Create;
  DataConverter.Populate(Fornecedores, Data);

  Data.Open;
end;

end.
