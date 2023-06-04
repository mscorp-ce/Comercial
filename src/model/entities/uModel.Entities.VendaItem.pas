unit uModel.Entities.VendaItem;

interface

type
  TVenda = class
  private
    FTotal: Double;
    FIdProduto: Integer;
    FPrecoUnitario: Double;
    FIdVenda: Integer;
    FItem: Integer;
    FQuantidade: Double;
    procedure SetIdProduto(const Value: Integer);
    procedure SetIdVenda(const Value: Integer);
    procedure SetItem(const Value: Integer);
    procedure SetPrecoUnitario(const Value: Double);
    procedure SetQuantidade(const Value: Double);
    procedure SetTotal(const Value: Double);
  public
    property IdVenda: Integer read FIdVenda write SetIdVenda;
    property Item: Integer read FItem write SetItem;
    property IdProduto: Integer read FIdProduto write SetIdProduto;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property PrecoUnitario: Double read FPrecoUnitario write SetPrecoUnitario;
    property Total: Double read FTotal write SetTotal;
  end;

implementation

{ TVenda }

procedure TVenda.SetIdProduto(const Value: Integer);
begin
  FIdProduto := Value;
end;

procedure TVenda.SetIdVenda(const Value: Integer);
begin
  FIdVenda := Value;
end;

procedure TVenda.SetItem(const Value: Integer);
begin
  FItem := Value;
end;

procedure TVenda.SetPrecoUnitario(const Value: Double);
begin
  FPrecoUnitario := Value;
end;

procedure TVenda.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TVenda.SetTotal(const Value: Double);
begin
  FTotal := Value;
end;

end.
