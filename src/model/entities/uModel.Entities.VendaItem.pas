unit uModel.Entities.VendaItem;

interface

uses
  uModel.Entities.Produto;

type
  TVendaItem = class
  private
    FTotal: Double;
    FPrecoUnitario: Double;
    FIdVenda: Integer;
    FItem: Integer;
    FQuantidade: Double;
    FProduto: TProduto;
    procedure SetIdVenda(const Value: Integer);
    procedure SetItem(const Value: Integer);
    procedure SetPrecoUnitario(const Value: Double);
    procedure SetQuantidade(const Value: Double);
    procedure SetTotal(const Value: Double);
    procedure SetProduto(const Value: TProduto);
  public
    constructor Create;
    destructor Destroy; override;

    property IdVenda: Integer read FIdVenda write SetIdVenda;
    property Item: Integer read FItem write SetItem;
    property Produto: TProduto read FProduto write SetProduto;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property PrecoUnitario: Double read FPrecoUnitario write SetPrecoUnitario;
    property Total: Double read FTotal write SetTotal;
  end;

implementation

uses
  System.SysUtils;

{ TVendaItem }

constructor TVendaItem.Create;
begin
  inherited Create;

  FProduto:= TProduto.Create;
end;

destructor TVendaItem.Destroy;
begin
  FreeAndNil(FProduto);

  inherited Destroy;
end;

procedure TVendaItem.SetIdVenda(const Value: Integer);
begin
  FIdVenda := Value;
end;

procedure TVendaItem.SetItem(const Value: Integer);
begin
  FItem := Value;
end;

procedure TVendaItem.SetPrecoUnitario(const Value: Double);
begin
  FPrecoUnitario := Value;
end;

procedure TVendaItem.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TVendaItem.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TVendaItem.SetTotal(const Value: Double);
begin
  FTotal := Value;
end;

end.
