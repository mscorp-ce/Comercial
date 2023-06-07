unit uModel.Repository.Venda;

interface

uses
  uModel.Abstraction, uModel.Entities.Venda, System.Classes, Data.DB, System.Generics.Collections;

type
  TVendaRepository = class(TInterfacedObject, IRepository<TVenda>)
  private
    function Open(CommadSQL: String): TVenda;
  public
    function Fields: TStrings;
    procedure SetStatement(Statement: IStatement; Entity: TVenda);
    procedure SetProperty(Statement: IStatement; Entity: TVenda);
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function Save(Entity: TVenda): Boolean;
    procedure AfterSave(Entity: TVenda);
    function Update(Entity: TVenda): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TVenda;
    function FindExists: Boolean; overload;
    function FindExists(CommadSQL: String; Parameter: String; Entity: TVenda): Boolean; overload;
    function FindAll: TObjectList<TVenda>; overload;
    function FindAll(CommadSQL: String): TObjectList<TVenda>;overload;
    function Frist: TVenda;
    function Previous(Id: Integer): TVenda;
    function Next(Id: Integer): TVenda;
    function Last: TVenda;

    destructor Destroy; override;
  end;

implementation

{ TVendaRepository }

uses
  System.SysUtils, FireDAC.Stan.Param, FireDAC.Stan.Error, uModel.Repository.DataManager,
  uModel.Repository.StatementFactory, uModel.FireDACEngineException,
  uModel.ConstsStatement;

procedure TVendaRepository.AfterSave(Entity: TVenda);
begin

end;

function TVendaRepository.CurrentGeneratedValue: Integer;
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

function TVendaRepository.DeleteById(Id: Integer): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaDelete);
    Statement.Query.Params.ParamByName('idvenda').AsInteger:= Id;

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

destructor TVendaRepository.Destroy;
begin
  inherited Destroy;
end;

function TVendaRepository.Fields: TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEtity('vendas').GetFieldNames;

    Result:= Items;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaRepository.FindAll: TObjectList<TVenda>;
var
  Statement: IStatement;
  List: TObjectList<TVenda>;
  Venda: TVenda;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TVenda>.Create;

    Statement.SQL(ctSQLVendas)
      .Open
        .Query;

    Statement.Query.First;
    while not Statement.Query.Eof do
      begin
        Venda:= TVenda.Create;

        SetProperty(Statement, Venda);

        List.Add(Venda);

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

function TVendaRepository.FindAll(CommadSQL: String): TObjectList<TVenda>;
var
  Statement: IStatement;
  List: TObjectList<TVenda>;
  Venda: TVenda;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TVenda>.Create;

    Statement.SQL(CommadSQL)
      .Open
        .Query
          .First;

    while not Statement.Query.Eof do
      begin
        Venda:= TVenda.Create;
        Venda.IdVenda:= Statement.Query.FieldByName('idvenda').AsInteger;
        Venda.DataHoraVenda:= Statement.Query.FieldByName('dthr_venda').AsDateTime;
        Venda.Cliente.IdCliente:= Statement.Query.FieldByName('idcliente').AsInteger;
        Venda.Cliente.Nome:= Statement.Query.FieldByName('nome_cliente').AsString;
        Venda.Total:= Statement.Query.FieldByName('total').AsFloat;
        Venda.Status:= Statement.Query.FieldByName('status').AsString;
        List.Add(Venda);
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

function TVendaRepository.FindById(Id: Integer): TVenda;
var
  Statement: IStatement;
  Venda: TVenda;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaFindID);
    Statement.Query.Params.ParamByName('idvenda').AsInteger:= Id;
    Statement.Query.Open;

    Venda:= TVenda.Create;
    SetProperty(Statement, Venda);

    Result:= Venda;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaRepository.FindExists(CommadSQL: String; Parameter: String; Entity: TVenda): Boolean;
begin
  Result:= False;
end;

function TVendaRepository.FindExists: Boolean;
begin
  Result:= False;
end;

function TVendaRepository.Frist: TVenda;
begin
  Result:= Open(ctSQLVendaFrist);
end;

function TVendaRepository.GeneratedValue: Integer;
begin
  Result:= 0;
end;

function TVendaRepository.Last: TVenda;
begin
  Result:= Open(ctSQLVendaLast);
end;

function TVendaRepository.Next(Id: Integer): TVenda;
var
  Statement: IStatement;
  Venda: TVenda;
  fId: Integer;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaNext);
    Venda:= Last;
    if Venda.IdVenda = Id then
      begin
        Result:= FindById(Id);
        Exit;
      end;

    fId:= Id + 1;
    while Statement.Query.IsEmpty do
      begin
        Statement.Query.Close;
        Statement.Query.Params.ParamByName('idvenda').AsInteger:= fId;
        Statement.Query.Open;
        Inc(fId);
      end;

    SetProperty(Statement, Venda);

    Result:= Venda;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaRepository.Open(CommadSQL: String): TVenda;
var
  Statement: IStatement;
  Venda: TVenda;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(CommadSQL);
    Statement.Query.Open;

    Venda:= TVenda.Create;
    SetProperty(Statement, Venda);

    Result:= Venda;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaRepository.Previous(Id: Integer): TVenda;
var
  Statement: IStatement;
  Venda: TVenda;
  fId: Integer;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaPrevious);
    Venda:= Frist;
    if (Venda.IdVenda = Id) or (Id = 0) then
      begin
        Result:= FindById(Id);
        Exit;
      end;

    fId:= Id - 1;

    while Statement.Query.IsEmpty do
      begin
        Statement.Query.Close;
        Statement.Query.Params.ParamByName('idvenda').AsInteger:= fId;
        Statement.Query.Open;
        Dec(fId);
      end;

    SetProperty(Statement, Venda);

    Result:= Venda;
  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

function TVendaRepository.Save(Entity: TVenda): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaInsert);
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

procedure TVendaRepository.SetProperty(Statement: IStatement; Entity: TVenda);
begin
  try
    Entity.IdVenda:= Statement.Query.FieldByName('idvenda').AsInteger;
    Entity.DataHoraVenda:= Statement.Query.FieldByName('dthr_venda').AsDateTime;
    Entity.Cliente.IdCliente:= Statement.Query.FieldByName('idcliente').AsInteger;
    Entity.Total:= Statement.Query.FieldByName('total').AsFloat;
    Entity.Status:= Statement.Query.FieldByName('status').AsString;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

procedure TVendaRepository.SetStatement(Statement: IStatement; Entity: TVenda);
begin
  try
    Statement.Query.Params.ParamByName('idvenda').AsDateTime:= Entity.IdVenda;
    Statement.Query.Params.ParamByName('dthr_venda').AsDateTime:= Entity.DataHoraVenda;
    Statement.Query.Params.ParamByName('idcliente').AsInteger:= Entity.Cliente.IdCliente;
    Statement.Query.Params.ParamByName('total').AsFloat:= Entity.Total;
    Statement.Query.Params.ParamByName('status').AsString:= Entity.Status;

  except
    on E: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(E));
  end;
end;

function TVendaRepository.Update(Entity: TVenda): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(ctSQLVendaUpdate);
    Statement.Query.Params.ParamByName('idvenda').AsInteger:= Entity.IdVenda;
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

end.

