unit uView.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus,
  ExceptionLog;

type
  TfrmPrincipal = class(TForm)
    pnlControl: TPanel;
    mmMenu: TMainMenu;
    Cadatros1: TMenuItem;
    Pe1: TMenuItem;
    Clientes1: TMenuItem;
    Fornecedores1: TMenuItem;
    Produtos1: TMenuItem;
    Produto1: TMenuItem;
    Movimentaes1: TMenuItem;
    Vendas1: TMenuItem;
    Relatrios1: TMenuItem;
    Pessoas1: TMenuItem;
    Clientes2: TMenuItem;
    Movimentaes2: TMenuItem;
    Vendas2: TMenuItem;
    EurekaLog1: TEurekaLog;
    procedure Clientes1Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure Clientes2Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoShow; override;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  uView.FormConsulta.Cliente, uView.FormConsulta.Fornecedor, uView.FormConsulta.Venda,
  uView.FormConsulta.Produto, uView.FormRelatorioVendasPorCliente,
  uView.FormFormRelatorioCliente;

procedure TfrmPrincipal.Clientes1Click(Sender: TObject);
var
  ConsultaCliente: TfrmConsultaCliente;
begin
  ConsultaCliente:= TfrmConsultaCliente.Create(Self);
  try
    ConsultaCliente.ShowModal;
  finally
    FreeAndNil(ConsultaCliente);
  end;
end;

procedure TfrmPrincipal.Clientes2Click(Sender: TObject);
begin
  frmFormFormRelatorioCliente:= TfrmFormFormRelatorioCliente.Create(nil);
  try
    frmFormFormRelatorioCliente.ShowModal;

  finally
    FreeAndNil(frmFormFormRelatorioCliente);
  end;
end;

procedure TfrmPrincipal.DoShow;
begin
  inherited;
  Self.WindowState:= wsMaximized;
end;

procedure TfrmPrincipal.Fornecedores1Click(Sender: TObject);
var
  ConsultaFornecedor: TfrmConsultaFornecedor;
begin
  ConsultaFornecedor:= TfrmConsultaFornecedor.Create(Self);
  try
    ConsultaFornecedor.ShowModal;
  finally
    FreeAndNil(ConsultaFornecedor);
  end;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
var
  ConsultaProduto: TfrmConsultaProduto;
begin
  ConsultaProduto:= TfrmConsultaProduto.Create(Self);
  try
    ConsultaProduto.ShowModal;
  finally
    FreeAndNil(ConsultaProduto);
  end;
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
var
  ConsultaVenda: TfrmConsultaVenda;
begin
  ConsultaVenda:= TfrmConsultaVenda.Create(Self);
  try
    ConsultaVenda.ShowModal;
  finally
    FreeAndNil(ConsultaVenda);
  end;
end;

procedure TfrmPrincipal.Vendas2Click(Sender: TObject);
begin
  frmFormFormRelatorioVendasPorCliente:= TfrmFormFormRelatorioVendasPorCliente.Create(nil);
  try
    frmFormFormRelatorioVendasPorCliente.ShowModal;

  finally
    FreeAndNil(frmFormFormRelatorioVendasPorCliente);
  end;
end;

end.
