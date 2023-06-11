unit uModel.Repository.VendaItem;

interface

uses
  uModel.Abstraction, uModel.Entities.VendaItem, System.Classes, Data.DB, System.Generics.Collections;

type
  TVendaItemRepository = class(TInterfacedObject, IRepository<TVendaItem>)
  private
    function Open(CommadSQL: String): TVendaItem;
  public
    function Fields: TStrings;
    procedure SetStatement(Statement: IStatement; Entity: TVendaItem);
    procedure SetProperty(Statement: IStatement; Entity: TVendaItem);
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function Save(Entity: TVendaItem): Boolean;
    procedure AfterSave(Entity: TVendaItem);
    function Update(Entity: TVendaItem): Boolean; overload;
    function Update(CommandSQL: String; Parameter: String; Entity: TVendaItem): Boolean; overload;
    function DeleteById(Entity: TVendaItem): Boolean;
    function FindById(Id: Integer): TVendaItem;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement; overload;
    function FindAll: TObjectList<TVendaItem>; overload;
    function FindAll(CommadSQL: String): TObjectList<TVendaItem>;overload;
    function FindAll(CommadSQL: String; Entity: TVendaItem): TObjectList<TVendaItem>; overload;
    function Frist: TVendaItem;
    function Previous(Id: Integer): TVendaItem;
    function Next(Id: Integer): TVendaItem;
    function Last: TVendaItem;

    destructor Destroy; override;
  end;

implementation

{ TVendaItemRepository }

uses
  System.SysUtils, FireDAC.Stan.Param, FireDAC.Stan.Error, uModel.Repository.DataManager,
  uModel.Repository.StatementFactory, uModel.FireDACEngineException,
  uModel.ConstsStatement;

procedure TVendaItemRepository.AfterSave(Entity: TVendaItem);
begin

end;

function TVendaItemRepository.CurrentGeneratedValue: Integer;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    Statement.Query.SQL.Add(ctSQLCurrentGeneratedValue);
    Statement.Query.Open;

    Result:= Statement.Query.FieldByName('currentID').AsInteger;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaItemRepository.DeleteById(Entity: TVendaItem): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaItemDelete);
    Statement.Query.Params.ParamByName('idvenda').AsInteger:= Entity.IdVenda;
    Statement.Query.Params.ParamByName('item').AsInteger:= Entity.Item;

    Statement.Query.ExecSQL;
    DataManager.Commit;

    Result:= Statement.Query.RowsAffected = ctRowsAffected;
  except
    on E: EFDDBEngineException do
      begin
        DataManager.Rollback;
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

destructor TVendaItemRepository.Destroy;
begin
  inherited Destroy;
end;

function TVendaItemRepository.Fields: TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEtity('VendaItens').GetFieldNames;

    Result:= Items;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaItemRepository.FindAll: TObjectList<TVendaItem>;
var
  Statement: IStatement;
  List: TObjectList<TVendaItem>;
  VendaItem: TVendaItem;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TVendaItem>.Create;

    Statement.SQL(ctSQLVendaItens)
      .Open
        .Query;

    Statement.Query.First;
    while not Statement.Query.Eof do
      begin
        VendaItem:= TVendaItem.Create;

        SetProperty(Statement, VendaItem);

        List.Add(VendaItem);

        Statement.Query.Next;
      end;

    Result:= List;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaItemRepository.FindAll(CommadSQL: String): TObjectList<TVendaItem>;
var
  Statement: IStatement;
  List: TObjectList<TVendaItem>;
  VendaItem: TVendaItem;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TVendaItem>.Create;

    Statement.SQL(CommadSQL)
      .Open
        .Query
          .First;

    while not Statement.Query.Eof do
      begin
        VendaItem:= TVendaItem.Create;
        VendaItem.IdVenda:= Statement.Query.FieldByName('idvenda').AsInteger;
        VendaItem.Item:= Statement.Query.FieldByName('item').AsInteger;
        VendaItem.Produto.IdProduto:= Statement.Query.FieldByName('idproduto').AsInteger;
        VendaItem.Produto.Descricao:= Statement.Query.FieldByName('descricao').AsString;
        VendaItem.Quantidade:= Statement.Query.FieldByName('quantidade').AsFloat;
        VendaItem.PrecoUnitario:= Statement.Query.FieldByName('preco_unitario').AsFloat;
        VendaItem.Total:= Statement.Query.FieldByName('total').AsFloat;
        List.Add(VendaItem);
        Statement.Query.Next;
      end;

    Result:= List;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaItemRepository.FindById(Id: Integer): TVendaItem;
var
  Statement: IStatement;
  VendaItem: TVendaItem;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaItemFindID);
    Statement.Query.Params.ParamByName('idVenda').AsInteger:= Id;
    Statement.Query.Open;

    VendaItem:= TVendaItem.Create;
    SetProperty(Statement, VendaItem);

    Result:= VendaItem;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaItemRepository.FindExists(CommadSQL: String; Parameter: String; ParameterType: TFieldType; Value: Variant): IStatement;
begin
  Result:= nil;
end;

function TVendaItemRepository.FindExists: Boolean;
begin
  Result:= False;
end;

function TVendaItemRepository.Frist: TVendaItem;
begin
  Result:= Open(ctSQLVendaItemFrist);
end;

function TVendaItemRepository.GeneratedValue: Integer;
begin
  Result:= 0;
end;

function TVendaItemRepository.Last: TVendaItem;
begin
  Result:= nil ; //Open(ctSQLVendaItemLast);
end;

function TVendaItemRepository.Next(Id: Integer): TVendaItem;
{var
  Statement: IStatement;
  VendaItem: TVendaItem;
  fId: Integer;}
begin
  Result:= nil;
  {try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaItemNext);
    VendaItem:= Last;
    if VendaItem.IdVendaItem = Id then
      begin
        Result:= FindById(Id);
        Exit;
      end;

    fId:= Id + 1;
    while Statement.Query.IsEmpty do
      begin
        Statement.Query.Close;
        Statement.Query.Params.ParamByName('idVendaItem').AsInteger:= fId;
        Statement.Query.Open;
        Inc(fId);
      end;

    SetProperty(Statement, VendaItem);

    Result:= VendaItem;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end; }
end;

function TVendaItemRepository.Open(CommadSQL: String): TVendaItem;
var
  Statement: IStatement;
  VendaItem: TVendaItem;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(CommadSQL);
    Statement.Query.Open;

    VendaItem:= TVendaItem.Create;
    SetProperty(Statement, VendaItem);

    Result:= VendaItem;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaItemRepository.Previous(Id: Integer): TVendaItem;
{var
  Statement: IStatement;
  VendaItem: TVendaItem;
  fId: Integer;}
begin
   Result:= nil;
  {try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaItemPrevious);
    VendaItem:= Frist;
    if (VendaItem.IdVendaItem = Id) or (Id = 0) then
      begin
        Result:= FindById(Id);
        Exit;
      end;

    fId:= Id - 1;

    while Statement.Query.IsEmpty do
      begin
        Statement.Query.Close;
        Statement.Query.Params.ParamByName('idVendaItem').AsInteger:= fId;
        Statement.Query.Open;
        Dec(fId);
      end;

    SetProperty(Statement, VendaItem);

    Result:= VendaItem;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;}
end;

function TVendaItemRepository.Save(Entity: TVendaItem): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaItemInsert);
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL;

    DataManager.Commit;

    Result:= Statement.Query.RowsAffected = ctRowsAffected;
  except
    on E: EFDDBEngineException do
      begin
        DataManager.Rollback;
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

procedure TVendaItemRepository.SetProperty(Statement: IStatement; Entity: TVendaItem);
begin
  try
    Entity.IdVenda:= Statement.Query.FieldByName('idvenda').AsInteger;
    Entity.Item:= Statement.Query.FieldByName('item').AsInteger;
    Entity.Produto.IdProduto:= Statement.Query.FieldByName('idproduto').AsInteger;
    Entity.Quantidade:= Statement.Query.FieldByName('quantidade').AsFloat;
    Entity.PrecoUnitario:= Statement.Query.FieldByName('preco_unitario').AsFloat;
    Entity.Total:= Statement.Query.FieldByName('total').AsFloat;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

procedure TVendaItemRepository.SetStatement(Statement: IStatement; Entity: TVendaItem);
begin
  try
    Statement.Query.Params.ParamByName('idvenda').AsInteger:= Entity.IdVenda;
    Statement.Query.Params.ParamByName('item').AsInteger:= Entity.Item;
    Statement.Query.Params.ParamByName('idproduto').AsInteger:= Entity.Produto.IdProduto;
    Statement.Query.Params.ParamByName('quantidade').AsFloat:= Entity.Quantidade;
    Statement.Query.Params.ParamByName('preco_unitario').AsFloat:= Entity.PrecoUnitario;
    Statement.Query.Params.ParamByName('total').AsFloat:= Entity.Total;

  except
    on E: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(E));
  end;
end;

function TVendaItemRepository.Update(CommandSQL, Parameter: String;
  Entity: TVendaItem): Boolean;
begin
  Result:= False;
end;

function TVendaItemRepository.Update(Entity: TVendaItem): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaItemUpdate);
    Statement.Query.Params.ParamByName('idvenda').AsInteger:= Entity.IdVenda;
    Statement.Query.Params.ParamByName('item').AsInteger:= Entity.Item;
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL;
    DataManager.Commit;

    Result:= Statement.Query.RowsAffected = ctRowsAffected;
  except
    on E: EFDDBEngineException do
      begin
        DataManager.Rollback;
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaItemRepository.FindAll(CommadSQL: String;
  Entity: TVendaItem): TObjectList<TVendaItem>;
var
  Statement: IStatement;
  List: TObjectList<TVendaItem>;
  VendaItem: TVendaItem;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TVendaItem>.Create;

    Statement.Query.SQL.Add(CommadSQL);
    Statement.Query.Params.ParamByName('idVenda').AsInteger:= Entity.IdVenda;
    Statement.Query.Open;

    Statement.Query.First;

    while not Statement.Query.Eof do
      begin
        VendaItem:= TVendaItem.Create;
        VendaItem.IdVenda:= Statement.Query.FieldByName('idvenda').AsInteger;
        VendaItem.Item:= Statement.Query.FieldByName('item').AsInteger;
        VendaItem.Produto.IdProduto:= Statement.Query.FieldByName('idproduto').AsInteger;
        VendaItem.Produto.Descricao:= Statement.Query.FieldByName('descricao').AsString;
        VendaItem.Quantidade:= Statement.Query.FieldByName('quantidade').AsFloat;
        VendaItem.PrecoUnitario:= Statement.Query.FieldByName('preco_unitario').AsFloat;
        VendaItem.Total:= Statement.Query.FieldByName('total').AsFloat;
        List.Add(VendaItem);
        Statement.Query.Next;
      end;

    Result:= List;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

end.

