unit uModel.Entities.Venda;

interface

uses
  uModel.Entities.Cliente;

type
  TVenda = class
  private
    FDataHoraVenda: TDateTime;
    FTotal: Double;
    FStatus: String;
    FIdVenda: Integer;
    FCliente: TCliente;
    procedure SetDataHoraVenda(const Value: TDateTime);
    procedure SetCliente(const Value: TCliente);
    procedure SetIdVenda(const Value: Integer);
    procedure SetStatus(const Value: String);
    procedure SetTotal(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;

    property IdVenda: Integer read FIdVenda write SetIdVenda;
    property DataHoraVenda: TDateTime read FDataHoraVenda write SetDataHoraVenda;
    property Cliente: TCliente read FCliente write SetCliente;
    property Total: Double read FTotal write SetTotal;
    property Status: String read FStatus write SetStatus;
  end;

implementation

uses
  System.SysUtils;

{ TVenda }

procedure TVenda.SetDataHoraVenda(const Value: TDateTime);
begin
  FDataHoraVenda := Value;
end;

constructor TVenda.Create;
begin
  inherited Create;

  FCliente:= TCliente.Create;
end;

destructor TVenda.Destroy;
begin
  FreeAndNil(FCliente);

  inherited Destroy;
end;

procedure TVenda.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TVenda.SetIdVenda(const Value: Integer);
begin
  FIdVenda := Value;
end;

procedure TVenda.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TVenda.SetTotal(const Value: Double);
begin
  FTotal := Value;
end;

end.
