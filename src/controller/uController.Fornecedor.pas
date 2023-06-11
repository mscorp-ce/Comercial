unit uController.Fornecedor;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Fornecedor,
  uModel.Services.Venda, Data.DB;

type
  TControllerFornecedor = class(TInterfacedObject, IController<TFornecedor>)
  private
    FornecedorService: IService<TFornecedor>;
  public
    function GeneratedValue: Integer;
    function Fields: TStrings;
    function Save(Entity: TFornecedor): Boolean;
    function Update(Entity: TFornecedor): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TFornecedor): Boolean; overload;
    function DeleteById(Entity: TFornecedor): Boolean;
    function FindById(Id: Integer): TFornecedor;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement; overload;
    function FindAll: TObjectList<TFornecedor>; overload;
    function FindAll(CommadSQL: String): TObjectList<TFornecedor>; overload;
    function FindAll(CommadSQL: String; Entity: TFornecedor): TObjectList<TFornecedor>; overload;
    function Frist: TFornecedor;
    function Previous(Id: Integer): TFornecedor;
    function Next(Id: Integer): TFornecedor;
    function Last: TFornecedor;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerFornecedor }

uses uModel.Services.Fornecedor;

constructor TControllerFornecedor.Create;
begin
  inherited Create;

  FornecedorService:= TFornecedorService.Create;
end;

function TControllerFornecedor.DeleteById(Entity: TFornecedor): Boolean;
begin
  Result:= FornecedorService.DeleteById(Entity);
end;

destructor TControllerFornecedor.Destroy;
begin
  inherited Destroy;
end;

function TControllerFornecedor.Fields: TStrings;
begin
  Result:= nil;
end;

function TControllerFornecedor.FindAll: TObjectList<TFornecedor>;
begin
  Result:= nil;
end;

function TControllerFornecedor.FindAll(CommadSQL: String): TObjectList<TFornecedor>;
begin
  Result:= nil;
end;

function TControllerFornecedor.FindById(Id: Integer): TFornecedor;
begin
  Result:= FornecedorService.FindById(Id);
end;

function TControllerFornecedor.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= FornecedorService.FindExists(CommadSQL, Parameter, ParameterType, Value);
end;

function TControllerFornecedor.FindExists: Boolean;
begin
  Result:= False;
end;

function TControllerFornecedor.Frist: TFornecedor;
begin
  Result:= FornecedorService.Frist;
end;

function TControllerFornecedor.GeneratedValue: Integer;
begin
  Result:= FornecedorService.GeneratedValue;
end;

function TControllerFornecedor.Last: TFornecedor;
begin
  Result:= FornecedorService.Last;
end;

function TControllerFornecedor.Next(Id: Integer): TFornecedor;
begin
  Result:= FornecedorService.Next(Id);
end;

function TControllerFornecedor.Previous(Id: Integer): TFornecedor;
begin
  Result:= FornecedorService.Previous(Id);
end;

function TControllerFornecedor.Save(Entity: TFornecedor): Boolean;
begin
  Result:= FornecedorService.Save(Entity);
end;

function TControllerFornecedor.Update(CommandSQL, Parameter: String;
  Entity: TFornecedor): Boolean;
begin
  Result:= False;
end;

function TControllerFornecedor.Update(Entity: TFornecedor): Boolean;
begin
  Result:= FornecedorService.Update(Entity);
end;

function TControllerFornecedor.FindAll(CommadSQL: String;
  Entity: TFornecedor): TObjectList<TFornecedor>;
begin
  Result:= nil;
end;

end.
