unit uView.FrmFiltros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmFiltros = class(TForm)
    pnlControl: TPanel;
    grbFiltros: TGroupBox;
    cbxFields: TComboBox;
    edtFilterValue: TEdit;
    cbxOrder: TComboBox;
    rdgAttributes: TRadioGroup;
    lblOrder: TLabel;
    lblFilterBy: TLabel;
    lblFilterValue: TLabel;
    cbxOperator: TComboBox;
    lblOperator: TLabel;
    spbConfirmar: TSpeedButton;
    procedure spbConfirmarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FEntite: String;
    procedure SetEntite(const Value: String);
  public
    { Public declarations }
    function Confirmar(Alias: String): String; virtual;

    property Entite: String read FEntite write SetEntite;
  end;

var
  frmFiltros: TfrmFiltros;

implementation

uses
  uLibary;

{$R *.dfm}

{ TfrmFiltros }

function TfrmFiltros.Confirmar(Alias: String): String;
const
  ctCrescente = 0;
  ctDecrescente = 1;

  ctIgual_A = 0;
  ctMaior_Que = 1;
  ctMeor_Que = 2;
  ctMaior_Ou_Igual = 3;
  ctMeor_Ou_Igual = 4;
  ctDiferente = 5;
  ctComeca_Com = 6;
  ctTermina_Com = 7;
  ctContemm = 8;
var
  Attribute: String;
  Clause: String;
begin
  if cbxFields.ItemIndex < 0 then
    begin
      ShowMessage('Nenhum atributo foi informado para Filtar por.');
      Exit;
    end;

  if cbxOperator.ItemIndex < 0 then
    begin
      ShowMessage('Nenhum atributo foi informado para o Operator.');
      Exit;
    end;

  Clause:= ' WHERE ' + Alias + '.'+  cbxFields.Text + ' ';

  case cbxOperator.ItemIndex of
    ctIgual_A: Clause:= Clause + ' = ' + QuotedStr(edtFilterValue.Text);
    ctMaior_Que: Clause:= Clause + ' > ' + edtFilterValue.Text;
    ctMeor_Que: Clause:= Clause + ' < ' +edtFilterValue.Text;
    ctMaior_Ou_Igual: Clause:= Clause + ' >= ' + edtFilterValue.Text;
    ctMeor_Ou_Igual: Clause:= Clause + ' <= ' + edtFilterValue.Text;
    ctDiferente: Clause:= Clause + ' <> ' + edtFilterValue.Text;
    ctComeca_Com: Clause:= Clause + ' LIKE '+ QuotedStr(edtFilterValue.Text +'%');
    ctTermina_Com: Clause:= Clause + ' LIKE  ' + QuotedStr('%'+ edtFilterValue.Text );
    ctContemm: Clause:= Clause + ' LIKE  ' + QuotedStr('%'+ edtFilterValue.Text + '%');
  end;

  case rdgAttributes.ItemIndex of
    ctCrescente: Attribute:= ' ASC ';
    ctDecrescente: Attribute:= ' DESC ';
  end;

  Clause:= Clause + ' ORDER BY ' + Alias + '.' + cbxOrder.Text + Attribute;

  Result:= TLibary.iif(((cbxFields.ItemIndex >=0) and (cbxOperator.ItemIndex >=0) and (Length(edtFilterValue.Text) >=1)),
            Clause, '');

  Close;
end;

procedure TfrmFiltros.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) or (Key = #13) then
    Close;
end;

procedure TfrmFiltros.SetEntite(const Value: String);
begin
  FEntite := Value;
end;

procedure TfrmFiltros.spbConfirmarClick(Sender: TObject);
begin
  Close;
end;

end.
