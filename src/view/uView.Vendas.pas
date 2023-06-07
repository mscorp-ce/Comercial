unit uView.Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.BaseRegistrationForm,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBCtrls, Vcl.WinXCalendars, uModel.Abstraction, uModel.Entities.Venda,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmVenda = class(TfrmBaseRegistration)
    lblIdVenda: TLabel;
    edtIdVenda: TEdit;
    lblDtVenda: TLabel;
    lblCliente: TLabel;
    lblTotal: TLabel;
    edtTotal: TEdit;
    lcbCliente: TDBLookupComboBox;
    cdsClientes: TClientDataSet;
    cdsClientesIdCliente: TIntegerField;
    cdsClientesNome: TStringField;
    dsClientes: TDataSource;
    cpDtVenda: TCalendarPicker;
    cdsVendas: TClientDataSet;
    dsVendas: TDataSource;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    lblStatus: TLabel;
    cbxStatus: TComboBox;
  protected
    procedure DoShow; override;
  private
    { Private declarations }
    ControllerVenda: IController<TVenda>;
    Venda: TVenda;
    FId: Integer;
    procedure SQLClientes;
    procedure GetTotalizadores;
    procedure SetId(const Value: Integer);
  protected
    { Protected declarations }
    procedure AddFocus; override;
    procedure GetProperty; override;
    procedure SetProperty; override;
    procedure Save; override;
    procedure AfterSave; override;

    procedure Frist; override;
    procedure Previous; override;
    procedure Next; override;
    procedure Last; override;
    procedure Restaurar; override;
    procedure DisposeOf(var Source: TVenda); overload;
  public
    { Public declarations }
    property Id: Integer read FId write SetId;
    destructor Destroy; override;
  end;

const
  ctPendente = 0;
  ctEfetivada = 1;

var
  frmVenda: TfrmVenda;

implementation

{$R *.dfm}

uses
  System.Generics.Collections, uModel.Entities.Cliente, uController.RootCliente,
  uModel.ConstsStatement, uController.DataConverter.Cliente, uController.Venda;

procedure TfrmVenda.Save;
begin
  inherited;
  SetProperty;
  case State of
    dsInsert:
      begin
        if ControllerVenda.Save(Venda) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Venda gravada com sucesso.');
          end;
      end;

    dsEdit:
      begin
        if ControllerVenda.Update(fId, Venda) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Venda alterada com sucesso.');
          end;
      end;
    dsBrowse: Close;
  end;
end;

procedure TfrmVenda.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TfrmVenda.SetProperty;
begin
  inherited;
  Venda.IdVenda:= StrToIntDef(edtIdVenda.Text, 0);
  Venda.DataHoraVenda:= cpDtVenda.Date;
  Venda.Cliente.IdCliente:= lcbCliente.KeyValue;
  Venda.Total:= StrToFloatDef(edtTotal.Text, 0);

  case cbxStatus.ItemIndex of
    ctPendente: Venda.Status:= 'P';
    ctEfetivada: Venda.Status:= 'E';
  end;
end;

procedure TfrmVenda.SQLClientes;
var
  ControllerRootCliente: IRootController<TCliente>;
  DataConverter: IDataConverter<TCliente>;
  Clientes: TObjectList<TCliente>;
begin
  ControllerRootCliente:= TControllerRootCliente.Create;
  cdsClientes.Close;
  cdsClientes.CreateDataSet;

  try
    Clientes:= ControllerRootCliente.FindAll(ctSQLClientes);

    DataConverter:= TDataConverterCliente.Create;
    DataConverter.Populate(Clientes, cdsClientes);

    cdsClientes.Open;

  finally
    FreeAndNil(Clientes);
  end;
end;

procedure TfrmVenda.AddFocus;
begin
  inherited;
  cpDtVenda.SetFocus;
end;

procedure TfrmVenda.GetTotalizadores;
begin
  edtTotal.Text:= 'R$ ' + FormatFloat('###,###,##0.00', Venda.Total);
end;

procedure TfrmVenda.Last;
begin
  inherited;
//  DisposeOf(Venda);

  Venda:= ControllerVenda.Last;

  GetProperty;
end;

procedure TfrmVenda.Next;
var
  IdVenda: Integer;
begin
  inherited;
  IdVenda:= Venda.IdVenda;
//  DisposeOf(Venda);

  Venda:= ControllerVenda.Next(IdVenda);

  GetProperty;
end;

procedure TfrmVenda.Previous;
var
  IdVenda: Integer;
begin
  inherited;
  IdVenda:= Venda.IdVenda;
//  DisposeOf(Venda);

  Venda:= ControllerVenda.Previous(IdVenda);

  GetProperty;
end;

procedure TfrmVenda.DisposeOf(var Source: TVenda);
begin
  if Source <> nil then
    FreeAndNil(Source);
end;

procedure TfrmVenda.Restaurar;
begin
  inherited;
  if State = dsEdit then
    begin
      Venda:= ControllerVenda.FindById(fId);
      GetProperty;
    end;
end;

procedure TfrmVenda.AfterSave;
begin
  inherited;
  GetTotalizadores;
end;

destructor TfrmVenda.Destroy;
begin
  FreeAndNil(Venda);

  inherited Destroy;
end;

procedure TfrmVenda.DoShow;
begin
  inherited;
  ControllerVenda:= TControllerVenda.Create;
  //Venda:= TVenda.Create;

  spbRestaurar.Enabled:= State = dsEdit;
  spbRestaurar.Visible:= State = dsEdit;

  spbFrist.Enabled:= State = dsBrowse;
  spbFrist.Visible:= State = dsBrowse;
  spbPrevious.Enabled:= State = dsBrowse;
  spbPrevious.Visible:= State = dsBrowse;
  spbNext.Enabled:= State = dsBrowse;
  spbNext.Visible:= State = dsBrowse;
  spbLast.Enabled:= State = dsBrowse;
  spbLast.Visible:= State = dsBrowse;

  AddFocus;
  SQLClientes;

  Venda:= ControllerVenda.FindById(id);
  GetProperty;
end;

procedure TfrmVenda.Frist;
begin
  inherited;

//  DisposeOf(Venda);

  Venda:= ControllerVenda.Frist;

  GetProperty;
end;

procedure TfrmVenda.GetProperty;
begin
  inherited;
  edtIdVenda.Text:= IntToStr( Venda.IdVenda );
  cpDtVenda.Date:= Venda.DataHoraVenda;
  lcbCliente.KeyValue:= Venda.Cliente.IdCliente;
  edtTotal.Text:= FloatToStr(Venda.Total);

  if Venda.Status = 'P' then
    cbxStatus.ItemIndex:= ctPendente
  else cbxStatus.ItemIndex:= ctEfetivada;

  GetTotalizadores;
end;

end.
