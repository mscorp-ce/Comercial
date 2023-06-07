unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus;

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
    procedure Clientes1Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  uView.FormConsulta.Cliente, uView.FormConsulta.Fornecedor, uView.FormConsulta.Venda,
  uView.FormConsulta.Produto;

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

end.
