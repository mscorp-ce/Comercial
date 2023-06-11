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
    cdsConsultadthr_venda: TDateTimeField;
    cdsConsultaidcliente: TIntegerField;
    cdsConsultanome_cliente: TStringField;
    cdsConsultatotal: TFloatField;
    cdsConsultastatus: TStringField;
    procedure grdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ControllerVenda: IController<TVenda>;

    //procedure RemoverIens;
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
  uModel.ConstsStatement, uController.Venda, uView.Vendas, uModel.Entities.VendaItem;

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
var
  Statement: IStatement;
begin
  inherited;

  if cdsConsulta.IsEmpty then
    begin
      ShowMessage('A listagem esta vazia. Faça uma constula primeiro para poder alterar um registro.');
      Exit;
    end;

  State:= dsEdit;

  Statement:= ControllerVenda.FindExists(ctSQLVendaFindEfetivada, 'idvenda', ftInteger, cdsConsultaidvenda.AsInteger);

  if Statement.Query.FieldByName('status').AsString = 'E' then
    begin
      ShowMessage('Venda efetivada não é possível alterar.');
      Exit;
    end;

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
var
  Venda: TVenda;
  Statement: IStatement;
begin
  inherited;

  if cdsConsulta.IsEmpty then
    begin
      ShowMessage('Não existe nenhum registro para ser deletado.');
      Exit;
    end;

  Statement:= ControllerVenda.FindExists(ctSQLVendaFindEfetivada, 'idvenda', ftInteger, cdsConsultaidvenda.AsInteger);

  if Statement.Query.FieldByName('status').AsString = 'E' then
    begin
      ShowMessage('Venda efetivada não é possível excluir.');
      Exit;
    end;

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      Venda:= TVenda.Create;
      try
        Venda.IdVenda:= cdsConsultaidvenda.AsInteger;
        //RemoverIens;
        if ControllerVenda.DeleteById(Venda) then
          begin
            ShowMessage('Registro deletado com sucesso.');
            All;
          end;
      finally
        FreeAndNil(Venda);
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
  CustomFormFilter: TCustomFormFilterVenda;
  List: TObjectList<TVenda>;

  SQL: String;
begin
  inherited;

  CustomFormFilter:= TCustomFormFilterVenda.Create;
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

    //ShowMessage(SQL);
  finally
    FreeAndNil(CustomFormFilter);
    FreeAndNil(List);
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
    FromVenda.Editing:= True;
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

{procedure TfrmConsultaVenda.RemoverIens;
var
  Itens: TObjectList<TVendaItem>;
  ControllerVendaItem: IController<TVendaItem>;
  VendaItem: TVendaItem;
  i: Integer;
begin
  VendaItem:= TVendaItem.Create;
  try
    VendaItem.IdVenda:= cdsConsultaidvenda.AsInteger;
    Itens:= ControllerVendaItem.FindAll(ctSQLVendaItemFindID, VendaItem);

    for i:= 0 to Itens.Count -1 do
      begin
        ControllerVendaItem.DeleteById(VendaItem);
      end;

  finally
    FreeAndNil(VendaItem);
    FreeAndNil(Itens);
  end;
end;}

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
