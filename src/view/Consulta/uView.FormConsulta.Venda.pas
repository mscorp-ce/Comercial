unit uView.FormConsulta.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormConsulta, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  System.Generics.Collections, uModel.Abstraction, uModel.Entities.Venda;

type
  TfrmConsultaVenda = class(TfrmConsulta)
    cdsConsultaidvenda: TIntegerField;
    cdsConsultadtvenda: TDateField;
    cdsConsultacliente: TStringField;
    cdsConsultavendedor: TStringField;
    cdsConsultaobservacao: TStringField;
    cdsConsultaobservacao_entrega: TMemoField;
    cdsConsultasubtotal: TFloatField;
    cdsConsultadesconto: TFloatField;
    cdsConsultatotal: TFloatField;
    procedure grdConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ControllerVenda: IController<TVenda>;

    procedure Search(var CommandSQL: String; var Vendas: TObjectList<TVenda>);
    procedure ExecuteFrom(Id: Integer = 0);
  protected
    procedure DoShow; override;
    procedure Filter; override;
    procedure All; override;
    procedure Include; override;
    procedure Change; override;
    procedure Delete; override;
    procedure Consult; override;
  public
    { Public declarations }
  end;

var
  frmConsultaVenda: TfrmConsultaVenda;

implementation

{$R *.dfm}

uses
  System.UITypes, uView.CustomFormFilterVenda, uController.RootVenda, uController.DataConverter.Venda,
  uModel.ConstsStatement, uController.Venda, uView.Sales;

{ TfrmConsulta2 }

procedure TfrmConsultaVenda.All;
var
  List: TObjectList<TVenda>;

  SQL: String;

begin
  inherited;
  try
    SQL:= ctSQLVendas;
    Search(SQL, List);

  finally
    FreeAndNil(List);
  end;
end;

procedure TfrmConsultaVenda.Change;
begin
  inherited;
  
  State:= dsEdit;

  ExecuteFrom(cdsConsultaidvenda.AsInteger);
end;

procedure TfrmConsultaVenda.Consult;
begin
  inherited;

  State:= dsBrowse;

  ExecuteFrom;
end;

procedure TfrmConsultaVenda.Delete;
const
  Msg = 'Deseja realmente exluir o registro selecionado?';
begin
  inherited;

  if cdsConsulta.IsEmpty then
    begin
      ShowMessage('N�o existe nenhum registro para ser deletado.');
      Exit;
    end;

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      if ControllerVenda.DeleteById(cdsConsultaidvenda.AsInteger) then
        begin
          ShowMessage('Registro deletado com sucesso.');
          All;
        end;
    end;
end;
procedure TfrmConsultaVenda.DoShow;
begin
  inherited;
  ControllerVenda:= TControllerVenda.Create;
  State:= dsBrowse;
end;

procedure TfrmConsultaVenda.Filter;
var
  CustomFormFilter: TCustomFormFilterVenda<TVenda>;
  List: TObjectList<TVenda>;

  SQL: String;
begin
  inherited;

  CustomFormFilter:= TCustomFormFilterVenda<TVenda>.Create;
  try
    CustomFormFilter.ShowModal;
    SQL:= ctSQLVendas;
    SQL:= SQL + CustomFormFilter.Confirmar('ven');

    if SQL.IsEmpty then
      begin
        ShowMessage('Nenhum filtro informado.');
        Exit;
      end;

    Search(SQL, List);

    ShowMessage(SQL);
  finally
    FreeAndNil(CustomFormFilter);
    FreeAndNil(List);
  end;
end;

procedure TfrmConsultaVenda.grdConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  R: TRect;
begin
  inherited;
  R := Rect;
  Dec(R.Bottom, 2);

  if Column.Field = cdsConsulta.FieldByName('Observacao_Entrega') then
    begin
      if not (gdSelected in State) then
        begin
          grdConsulta.Canvas.FillRect(Rect);
          grdConsulta.Canvas.TextRect(R,R.Left,R.Top,
          cdsConsulta.FieldByName('Observacao_Entrega').AsString);
        end;
    end;
end;

procedure TfrmConsultaVenda.grdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;
end;

procedure TfrmConsultaVenda.ExecuteFrom(Id: Integer);
var
  FromVenda: TfrmVenda;
begin
  FromVenda:= TfrmVenda.Create(Self);
  try
    FromVenda.Id:= Id;
    FromVenda.ShowModal;
  finally
    FreeAndNil(FromVenda);
  end;
end;

procedure TfrmConsultaVenda.Include;
begin
  inherited;
  State:= dsInsert;

  ExecuteFrom;
end;

procedure TfrmConsultaVenda.Search(var CommandSQL: String; var Vendas: TObjectList<TVenda>);
var
  ControllerRootVenda: IRootController<TVenda>;
  DataConverter: IDataConverter<TVenda>;
begin
  ControllerRootVenda:= TControllerRootVenda.Create;
    cdsConsulta.Close;
    cdsConsulta.CreateDataSet;

  Vendas:= ControllerRootVenda.FindAll(CommandSQL);

  DataConverter:= TDataConverterVenda.Create;
  DataConverter.Populate(Vendas, cdsConsulta);

  cdsConsulta.Open;
end;

end.
