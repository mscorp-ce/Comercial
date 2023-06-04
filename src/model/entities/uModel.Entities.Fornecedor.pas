unit uModel.Entities.Fornecedor;

interface

type
  TFornecedor = class
  private
    FCnpj: String;
    FIdFornecedor: Integer;
    FStatus: String;
    FRazaoSocial: String;
    FNomeFantasia: String;
    procedure SetCnpj(const Value: String);
    procedure SetIdCliente(const Value: Integer);
    procedure SetNomeFantasia(const Value: String);
    procedure SetRazaoSocial(const Value: String);
    procedure SetStatus(const Value: String);
  public
    property IdFornecedor: Integer read FIdFornecedor write SetIdCliente;
    property NomeFantasia: String read FNomeFantasia write SetNomeFantasia;
    property RazaoSocial: String read FRazaoSocial write SetRazaoSocial;
    property Cnpj: String read FCnpj write SetCnpj;
    property Status: String read FStatus write SetStatus;
  end;


implementation

{ TFornecedor }

procedure TFornecedor.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TFornecedor.SetIdCliente(const Value: Integer);
begin
  FIdFornecedor := Value;
end;

procedure TFornecedor.SetNomeFantasia(const Value: String);
begin
  FNomeFantasia := Value;
end;

procedure TFornecedor.SetRazaoSocial(const Value: String);
begin
  FRazaoSocial := Value;
end;

procedure TFornecedor.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

end.
