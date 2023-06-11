unit uView.FormConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient;

type
  TfrmConsulta = class(TForm)
    pnlControl: TPanel;
    sbFiltar: TSpeedButton;
    spbTodos: TSpeedButton;
    spbIncluir: TSpeedButton;
    spbAlterar: TSpeedButton;
    spbExcluir: TSpeedButton;
    spbSair: TSpeedButton;
    grdConsulta: TDBGrid;
    dsConsulta: TDataSource;
    cdsConsulta: TClientDataSet;
    procedure sbFiltarClick(Sender: TObject);
    procedure spbTodosClick(Sender: TObject);
    procedure spbIncluirClick(Sender: TObject);
    procedure spbAlterarClick(Sender: TObject);
    procedure spbExcluirClick(Sender: TObject);
    procedure spbSairClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure Filter; virtual; abstract;
    procedure All; virtual; abstract;
    procedure Include; virtual; abstract;
    procedure Change; virtual; abstract;
    procedure Delete; virtual; abstract;
    procedure Consult; virtual; abstract;
  public
    { Public declarations }
  end;

var
  frmConsulta: TfrmConsulta;

implementation

{$R *.dfm}

procedure TfrmConsulta.sbFiltarClick(Sender: TObject);
begin
  Filter;
end;

procedure TfrmConsulta.spbAlterarClick(Sender: TObject);
begin
  Change;
end;

procedure TfrmConsulta.spbExcluirClick(Sender: TObject);
begin
  Delete;
end;

procedure TfrmConsulta.spbIncluirClick(Sender: TObject);
begin
  Include;
end;

procedure TfrmConsulta.spbSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsulta.spbTodosClick(Sender: TObject);
begin
  All;
end;

end.
