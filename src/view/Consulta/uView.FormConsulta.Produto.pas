unit uView.FormConsulta.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormConsulta, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto;

type
  TfrmConsultaProduto = class(TfrmConsulta)
    cdsConsultaidproduto: TIntegerField;
    cdsConsultadescricao: TStringField;
    cdsConsultaidfornecedor: TIntegerField;
    cdsConsultapreco_unitario: TFloatField;
    cdsConsultastatus: TStringField;
    procedure grdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ControllerProduto: IController<TProduto>;

    procedure Search(var CommandSQL: String; var Produtos: TObjectList<TProduto>);
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
  frmConsultaProduto: TfrmConsultaProduto;

implementation

{$R *.dfm}

uses
  System.UITypes, uModel.ConstsStatement, uController.RootProduto,
  uController.Produto, uController.DataConverter.Produto, uView.Produto,
  uView.CustomFormFilterProduto, uConntoller.ProdutoContext;

{ TfrmConsulta2 }

procedure TfrmConsultaProduto.All;
var
  List: TObjectList<TProduto>;

  SQL: String;

begin
  inherited;
  try
    SQL:= ctSQLProdutos;
    Search(SQL, List);

  finally
    FreeAndNil(List);
  end;
end;

procedure TfrmConsultaProduto.Change;
begin
  inherited;

  State:= dsEdit;

  ExecuteFrom(cdsConsulta.FieldByName('idProduto').AsInteger);
end;

procedure TfrmConsultaProduto.Consult;
begin
  inherited;

  State:= dsBrowse;

  ExecuteFrom;
end;

procedure TfrmConsultaProduto.Delete;
const
  Msg = 'Deseja realmente exluir o registro selecionado?';
var
  Produto: TProduto;
begin
  inherited;

  if cdsConsulta.IsEmpty then
    begin
      ShowMessage('Não existe nenhum registro para ser deletado.');
      Exit;
    end;

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      Produto:= TProduto.Create;
      try
        Produto.IdProduto:= cdsConsulta.FieldByName('idProduto').AsInteger;
        if ControllerProduto.DeleteById(Produto) then
          begin
            ShowMessage('Registro deletado com sucesso.');
            All;
          end;
      finally
        FreeAndNil(Produto);
      end;
    end;
end;

procedure TfrmConsultaProduto.DoShow;
begin
  inherited;
  ControllerProduto:= TControllerProduto.Create;
  State:= dsBrowse;
end;

procedure TfrmConsultaProduto.Filter;
var
  CustomFormFilter: TCustomFormFilterProduto;
  List: TObjectList<TProduto>;

  SQL: String;
begin
  inherited;

  CustomFormFilter:= TCustomFormFilterProduto.Create;
  try
    CustomFormFilter.ShowModal;
    SQL:= ctSQLProdutos;
    SQL:= SQL + CustomFormFilter.Confirmar('pro');

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

procedure TfrmConsultaProduto.grdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;
end;

procedure TfrmConsultaProduto.ExecuteFrom(Id: Integer);
var
  FromProduto: TfrmProduto;
begin
  FromProduto:= TfrmProduto.Create(Self);
  try
    FromProduto.Id:= Id;
    FromProduto.ShowModal;
  finally
    FreeAndNil(FromProduto);
  end;
end;

procedure TfrmConsultaProduto.Include;
begin
  inherited;
  State:= dsInsert;

  ExecuteFrom();
end;

procedure TfrmConsultaProduto.Search(var CommandSQL: String; var Produtos: TObjectList<TProduto>);
var
  ProdutoContext: TProdutoContext;
begin
  inherited;

  ProdutoContext:= TProdutoContext.Create;
  try
    ProdutoContext.List(Produtos, cdsConsulta);
  finally
    FreeAndNil(ProdutoContext);
  end;

{var
  ControllerRootProduto: IRootController<TProduto>;
  DataConverter: IDataConverter<TProduto>;
begin
  ControllerRootProduto:= TControllerRootProduto.Create;
  cdsConsulta.Close;

  cdsConsulta.CreateDataSet;

  Produtos:= ControllerRootProduto.FindAll(CommandSQL);

  DataConverter:= TDataConverterProduto.Create;
  DataConverter.Populate(Produtos, cdsConsulta);

  cdsConsulta.Open;}
end;

end.
