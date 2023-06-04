unit uModel.Entities.Cliente;

interface

type
  TCliente = class
  private
    FIdCliente: Integer;
    FNome: String;
    FCpf: String;
    FDtNascimento: TDateTime;
    FStatus: String;
    procedure SetIdCliente(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetCpf(const Value: String);
    procedure SetDtNascimento(const Value: TDateTime);
    procedure SetStatus(const Value: String);
  public
    function IsCPF(Value: String): Boolean;

    property IdCliente: Integer read FIdCliente write SetIdCliente;
    property Nome: String read FNome write SetNome;
    property Cpf: String read FCpf write SetCpf;
    property Status: String read FStatus write SetStatus;
    property DtNascimento: TDateTime read FDtNascimento write SetDtNascimento;
  end;

implementation

uses
  System.SysUtils, System.Math;

{ TCliente }

procedure TCliente.SetCpf(const Value: String);
begin
  FCpf := Value;
end;

procedure TCliente.SetDtNascimento(const Value: TDateTime);
begin
  FDtNascimento := Value;
end;

procedure TCliente.SetIdCliente(const Value: Integer);
begin
  FIdCliente := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

function TCliente.IsCPF(Value: String): Boolean;
var
  v: array [0 .. 1] of Word;
  cpf: array [0 .. 10] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(Value) <> 11 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if (Value = StringOfChar('0', 11)) or (Value = StringOfChar('1', 11)) or
     (Value = StringOfChar('2', 11)) or (Value = StringOfChar('3', 11)) or
     (Value = StringOfChar('4', 11)) or (Value = StringOfChar('5', 11)) or
     (Value = StringOfChar('6', 11)) or (Value = StringOfChar('7', 11)) or
     (Value = StringOfChar('8', 11)) or (Value = StringOfChar('9', 11)) then
    begin
      Exit;
    end;

  try
    for I := 1 to 11 do
      cpf[I - 1] := StrToInt(Value[I]);
    // Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10 * cpf[0] + 9 * cpf[1] + 8 * cpf[2];
    v[0] := v[0] + 7 * cpf[3] + 6 * cpf[4] + 5 * cpf[5];
    v[0] := v[0] + 4 * cpf[6] + 3 * cpf[7] + 2 * cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] >= 10, 0, v[0]);
    // Nota: Calcula o segundo dígito de verificação.
    v[1] := 11 * cpf[0] + 10 * cpf[1] + 9 * cpf[2];
    v[1] := v[1] + 8 * cpf[3] + 7 * cpf[4] + 6 * cpf[5];
    v[1] := v[1] + 5 * cpf[6] + 4 * cpf[7] + 3 * cpf[8];
    v[1] := v[1] + 2 * v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    // Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except
    on E: Exception do
      Result := False;
  end;
end;

end.

