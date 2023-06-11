unit uView.FormRelatorioVendasPorCliente;

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
  TfrmFormFormRelatorioVendasPorCliente = class(TForm)
    sqlVendas: TFDQuery;
    sqlDatail: TFDQuery;
    btnPreview: TButton;
    qrReport: TQuickRep;
    EmpresaTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel4: TQRLabel;
    QRSysData2: TQRSysData;
    dsVendas: TDataSource;
    sqlDatailidvenda_item: TIntegerField;
    sqlDatailitem: TIntegerField;
    sqlDatailidproduto: TIntegerField;
    sqlDataildescricao: TStringField;
    sqlDatailquantidade: TBCDField;
    sqlDatailpreco_unitario: TBCDField;
    sqlDatailtotal_item: TBCDField;
    sqlVendasidvenda: TIntegerField;
    sqlVendasdthr_venda: TSQLTimeStampField;
    sqlVendasidcliente: TIntegerField;
    sqlVendasnome: TStringField;
    sqlVendastotal: TBCDField;
    sqlVendasstatus: TStringField;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRSubDetail1: TQRSubDetail;
    QRShape3: TQRShape;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRShape4: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape5: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRShape2: TQRShape;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRGroup1: TQRGroup;
    QRLabel8: TQRLabel;
    QRDBText1: TQRDBText;
    QRBand1: TQRBand;
    lblSumQuantidade: TQRLabel;
    lblSumTotal: TQRLabel;
    QRBand4: TQRBand;
    lblSumSumaryQuantidade: TQRLabel;
    lblSumSumaryTotal: TQRLabel;
    btnFechar: TButton;
    procedure btnPreviewClick(Sender: TObject);
    procedure QRSubDetail1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    fSumQuantidade: Double;
    fSumTotal: Double;
    fSumSumaryQuantidade: Double;
    fSumSumaryTotal: Double;
    procedure Preview;
  protected
    procedure DoShow; override;
  public
    { Public declarations }
  end;

var
  frmFormFormRelatorioVendasPorCliente: TfrmFormFormRelatorioVendasPorCliente;

implementation

{$R *.dfm}

uses uModel.ConstsStatement, uModel.Repository.DataManager;

procedure TfrmFormFormRelatorioVendasPorCliente.Preview;
begin
  sqlVendas.Open;
  sqlDatail.Open;
  qrReport.Preview;
end;

procedure TfrmFormFormRelatorioVendasPorCliente.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFormFormRelatorioVendasPorCliente.btnPreviewClick(Sender: TObject);
begin
  Preview;
end;

procedure TfrmFormFormRelatorioVendasPorCliente.DoShow;
begin
  inherited;
  sqlVendas.Connection:= TFDConnection(DataManager.Connection);
  sqlDatail.Connection:= TFDConnection(DataManager.Connection);

  fSumQuantidade:= 0.00;
  fSumTotal:= 0.00;

  fSumSumaryQuantidade:= 0.00;
  fSumSumaryTotal:= 0.00;
end;

procedure TfrmFormFormRelatorioVendasPorCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  sqlDatail.Close;
  sqlVendas.Close;
end;

procedure TfrmFormFormRelatorioVendasPorCliente.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblSumQuantidade.Caption:= FormatFloat('0.00', fSumQuantidade);
  lblSumTotal.Caption:= FormatFloat('0.00', fSumTotal);

  fSumSumaryQuantidade:= fSumSumaryQuantidade + fSumQuantidade;
  fSumSumaryTotal:= fSumSumaryTotal + fSumTotal;

  fSumQuantidade:= 0.00;
  fSumTotal:= 0.00;
end;

procedure TfrmFormFormRelatorioVendasPorCliente.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblSumSumaryQuantidade.Caption:= FormatFloat('0.00', fSumSumaryQuantidade);
  lblSumSumaryTotal.Caption:= FormatFloat('0.00', fSumSumaryTotal);
end;

procedure TfrmFormFormRelatorioVendasPorCliente.QRSubDetail1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  fSumQuantidade:= fSumQuantidade + sqlDatailquantidade.AsFloat;
  fSumTotal:= fSumTotal + sqlDatailtotal_item.AsFloat;
end;

end.
