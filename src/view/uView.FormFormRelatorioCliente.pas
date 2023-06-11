unit uView.FormFormRelatorioCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, QuickRpt,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, QRCtrls, FireDAC.Phys.ODBCBase,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmFormFormRelatorioCliente = class(TForm)
    sqlClientes: TFDQuery;
    btnPreview: TButton;
    qrReport: TQuickRep;
    EmpresaTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel4: TQRLabel;
    QRSysData2: TQRSysData;
    QRBand2: TQRBand;
    QRShape3: TQRShape;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRShape4: TQRShape;
    sqlClientesidcliente: TIntegerField;
    sqlClientesnome: TStringField;
    sqlClientesstatus: TStringField;
    QRDBText1: TQRDBText;
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel11: TQRLabel;
    btnFechar: TButton;
    procedure btnPreviewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure Preview;
  protected
    procedure DoShow; override;
  public
    { Public declarations }
  end;

var
  frmFormFormRelatorioCliente: TfrmFormFormRelatorioCliente;

implementation

{$R *.dfm}

uses uModel.ConstsStatement, uModel.Repository.DataManager;

procedure TfrmFormFormRelatorioCliente.Preview;
begin
  sqlClientes.Open;
  qrReport.Preview;
end;

procedure TfrmFormFormRelatorioCliente.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFormFormRelatorioCliente.btnPreviewClick(Sender: TObject);
begin
  Preview;
end;

procedure TfrmFormFormRelatorioCliente.DoShow;
begin
  inherited;
  sqlClientes.Connection:= TFDConnection(DataManager.Connection);
end;

procedure TfrmFormFormRelatorioCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  sqlClientes.Close;
end;

end.
