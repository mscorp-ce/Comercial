unit uModel.Entities.Fornecedor;

interface

uses System.SysUtils, System.Math;

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
    function IsCnpj(Value: String): Boolean;

    property IdFornecedor: Integer read FIdFornecedor write SetIdCliente;
    property NomeFantasia: String read FNomeFantasia write SetNomeFantasia;
    property RazaoSocial: String read FRazaoSocial write SetRazaoSocial;
    property Cnpj: String read FCnpj write SetCnpj;
    property Status: String read FStatus write SetStatus;
  end;


implementation

{ TFornecedor }

function TFornecedor.IsCnpj(Value: String): Boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(Value) <> 14 then
    Exit;

  { Conferindo se todos dígitos são iguais }
  if (Value = StringOfChar('0', 14)) or (Value = StringOfChar('1', 14)) or
     (Value = StringOfChar('2', 14)) or (Value = StringOfChar('3', 14)) or
     (Value = StringOfChar('4', 14)) or (Value = StringOfChar('5', 14)) or
     (Value = StringOfChar('6', 14)) or (Value = StringOfChar('7', 14)) or
     (Value = StringOfChar('8', 14)) or (Value = StringOfChar('9', 14))
  then
    Exit;

  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(Value[i]);

    //Nota: Calcula o primeiro dígito de verificação.
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    //Nota: Calcula o segundo dígito de verificação.
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);

    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));

  except on E: Exception do
    Result := False;
  end;
end;

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
