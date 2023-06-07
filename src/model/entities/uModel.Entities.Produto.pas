unit uModel.Entities.Produto;

interface

uses
  uModel.Entities.Fornecedor;

type
  TProduto = class
  private
    FDescricao: String;
    FIdProduto: Integer;
    FPrecoUnitario: Double;
    FStatus: String;
    fFornecedor: TFornecedor;
    procedure SetDescricao(const Value: String);
    procedure SetIdProduto(const Value: Integer);
    procedure SetPrecoUnitario(const Value: Double);
    procedure SetStatus(const Value: String);
    procedure SetFornecedor(const Value: TFornecedor);
  public
    constructor Create;
    destructor Destroy; override;

    property IdProduto: Integer read FIdProduto write SetIdProduto;
    property Descricao: String read FDescricao write SetDescricao;
    property Fornecedor: TFornecedor read fFornecedor write SetFornecedor;
    property PrecoUnitario: Double read FPrecoUnitario write SetPrecoUnitario;
    property Status: String read FStatus write SetStatus;
  end;


implementation

uses
  System.SysUtils;

{ TProduto }

constructor TProduto.Create;
begin
  inherited Create;

  fFornecedor:= TFornecedor.Create;
end;

destructor TProduto.Destroy;
begin
  FreeAndNil(fFornecedor);

  inherited Destroy;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetFornecedor(const Value: TFornecedor);
begin
  fFornecedor := Value;
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
