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
    edtVenda: TEdit;
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
    procedure edtDescontoChange(Sender: TObject);
  protected
    procedure DoShow; override;
  private
    { Private declarations }
    ControllerVenda: IController<TVenda>;
    Venda: TVenda;
    FId: Integer;
    procedure SQLClientes;
    procedure SQLVendedores;
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

var
  frmVenda: TfrmVenda;

implementation

{$R *.dfm}

uses
  System.Generics.Collections, uModel.Entities.Cliente, uModel.Entities.Vendedor,
  uControllerRoot.Cliente, uModel.ConstsStatement, uController.DataConverter.Cliente,
  uController.RootVendedor, uController.DataConverter.Vendedor, uController.Venda;

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
  Venda.DtVenda:= cpDtVenda.Date;
  Venda.Cliente.IdCliente:= lcbCliente.KeyValue;
  Venda.Vendedor.IdVendedor:= lcbVendedor.KeyValue;
  Venda.Observacao:= edtObservacao.Text;
  Venda.ObservacaoEntrega:= mmObservacaoEntrega.Text;
  Venda.Subtotal:= StrToFloatDef(edtSubtotal.Text, 0);
  Venda.Desconto:= StrToFloatDef(edtDesconto.Text, 0);
  Venda.Total:= StrToFloatDef(edtTotal.Text, 0);
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

procedure TfrmVenda.SQLVendedores;
var
  ControllerRootVendedor: IRootController<TVendedor>;
  DataConverter: IDataConverter<TVendedor>;
  Vendedores: TObjectList<TVendedor>;
begin
  ControllerRootVendedor:= TControllerRootVendedor.Create;
  cdsVendedores.Close;
  cdsVendedores.CreateDataSet;

  try
    Vendedores:= ControllerRootVendedor.FindAll(ctSQLVendedores);

    DataConverter:= TDataConverterVendedor.Create;
    DataConverter.Populate(Vendedores, cdsVendedores);

    cdsVendedores.Open;
  finally
    FreeAndNil(Vendedores);
  end;
end;

procedure TfrmVenda.AddFocus;
begin
  inherited;
  cpDtVenda.SetFocus;
end;

procedure TfrmVenda.GetTotalizadores;
begin
  edtSubtotal.Text:= 'R$ ' + FormatFloat('###,###,##0.00', Venda.Subtotal);
  edtDesconto.Text:= 'R$ ' + FormatFloat('###,###,##0.00', Venda.Desconto);
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
  edtVenda.Text:= IntToStr( Venda.IdVenda );
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
  SQLVendedores;

  Venda:= ControllerVenda.FindById(id);
  GetProperty;
end;

procedure TfrmVenda.edtDescontoChange(Sender: TObject);
var
  Subtotal, Desconto: Double;
begin
  inherited;
  Subtotal:= StrToFloatDef( edtSubtotal.Text, 0 );
  Desconto:= StrToFloatDef( edtDesconto.Text, 0 );

  edtTotal.Text:= 'R$ ' + FormatFloat('###,###,##0.00', Subtotal - Desconto);
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
  edtVenda.Text:= IntToStr( Venda.IdVenda );
  cpDtVenda.Date:= Venda.DtVenda;
  lcbCliente.KeyValue:= Venda.Cliente.IdCliente;
  lcbVendedor.KeyValue:= Venda.Vendedor.IdVendedor;
  edtObservacao.Text:= Venda.Observacao;
  mmObservacaoEntrega.Text:= Venda.ObservacaoEntrega;

  GetTotalizadores;
end;

end.
