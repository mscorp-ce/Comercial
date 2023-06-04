unit uModel.Entities.Produto;

interface

type
  TProduto = class
  private
    FDescricao: String;
    FIdProduto: Integer;
    FPrecoUnitario: Double;
    FStatus: String;
    procedure SetDescricao(const Value: String);
    procedure SetIdProduto(const Value: Integer);
    procedure SetPrecoUnitario(const Value: Double);
    procedure SetStatus(const Value: String);
  public
    property IdProduto: Integer read FIdProduto write SetIdProduto;
    property Descricao: String read FDescricao write SetDescricao;
    property PrecoUnitario: Double read FPrecoUnitario write SetPrecoUnitario;
    property Status: String read FStatus write SetStatus;
  end;


implementation

{ TProduto }

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetIdProduto(const Value: Integer);
begin
  FIdProduto := Value;
end;

procedure TProduto.SetPrecoUnitario(const Value: Double);
begin
  FPrecoUnitario := Value;
end;

procedure TProduto.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

end.
