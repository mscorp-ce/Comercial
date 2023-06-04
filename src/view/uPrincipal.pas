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

procedure TfrmPrincipal.Clientes1Click(Sender: TObject);
begin
  //
end;

procedure TfrmPrincipal.Fornecedores1Click(Sender: TObject);
begin
  //
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  //
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
begin
  //
end;

end.
