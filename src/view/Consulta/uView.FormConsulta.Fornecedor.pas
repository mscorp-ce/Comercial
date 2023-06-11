unit uView.FormConsulta.Fornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormConsulta, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  System.Generics.Collections, uModel.Abstraction, uModel.Entities.Fornecedor;

type
  TfrmConsultaFornecedor = class(TfrmConsulta)
    cdsConsultaidfornecedor: TIntegerField;
    cdsConsultanome_fantasia: TStringField;
    cdsConsultarazao_social: TStringField;
    cdsConsultacnpj: TStringField;
    cdsConsultastatus: TStringField;
    procedure grdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ControllerFornecedor: IController<TFornecedor>;

    procedure Search(var CommandSQL: String; var Fornecedores: TObjectList<TFornecedor>);
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
  frmConsultaFornecedor: TfrmConsultaFornecedor;

implementation

{$R *.dfm}

uses
  System.UITypes, uModel.ConstsStatement, uController.RootFornecedor,
  uController.Fornecedor, uController.DataConverter.Fornecedor, uView.Fornecedor,
  uView.CustomFormFilterFornecedor, uConntoller.FornecedorContext;

{ TfrmConsultaFornecedor }

procedure TfrmConsultaFornecedor.All;
var
  List: TObjectList<TFornecedor>;

  SQL: String;

begin
  inherited;
  try
    SQL:= ctSQLFornecedores;
    Search(SQL, List);

  finally
    FreeAndNil(List);
  end;
end;

procedure TfrmConsultaFornecedor.Change;
begin
  inherited;

  State:= dsEdit;

  ExecuteFrom(cdsConsulta.FieldByName('idFornecedor').AsInteger);
end;

procedure TfrmConsultaFornecedor.Consult;
begin
  inherited;

  State:= dsBrowse;

  ExecuteFrom;
end;

procedure TfrmConsultaFornecedor.Delete;
const
  Msg = 'Deseja realmente exluir o registro selecionado?';
var
  Fornecedor: TFornecedor;
begin
  inherited;

  if cdsConsulta.IsEmpty then
    begin
      ShowMessage('Não existe nenhum registro para ser deletado.');
      Exit;
    end;

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      Fornecedor:= TFornecedor.Create;
      try
        Fornecedor.IdFornecedor:= cdsConsulta.FieldByName('idFornecedor').AsInteger;
        if ControllerFornecedor.DeleteById(Fornecedor) then
          begin
            ShowMessage('Registro deletado com sucesso.');
            All;
          end;
      finally
        FreeAndNil(Fornecedor);
      end;
    end;
end;

procedure TfrmConsultaFornecedor.DoShow;
begin
  inherited;
  ControllerFornecedor:= TControllerFornecedor.Create;
  State:= dsBrowse;
end;

procedure TfrmConsultaFornecedor.Filter;
var
  CustomFormFilter: TCustomFormFilterFornecedor;
  List: TObjectList<TFornecedor>;

  SQL: String;
begin
  inherited;

  CustomFormFilter:= TCustomFormFilterFornecedor.Create;
  try
    CustomFormFilter.ShowModal;
    SQL:= ctSQLFornecedores;
    SQL:= SQL + CustomFormFilter.Confirmar('frn');

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

procedure TfrmConsultaFornecedor.grdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;
end;

procedure TfrmConsultaFornecedor.ExecuteFrom(Id: Integer);
var
  FromFornecedor: TfrmFornecedor;
begin
  FromFornecedor:= TfrmFornecedor.Create(Self);
  try
    FromFornecedor.Id:= Id;
    FromFornecedor.ShowModal;
  finally
    FreeAndNil(FromFornecedor);
  end;
end;

procedure TfrmConsultaFornecedor.Include;
begin
  inherited;
  State:= dsInsert;

  ExecuteFrom();
end;

procedure TfrmConsultaFornecedor.Search(var CommandSQL: String; var Fornecedores: TObjectList<TFornecedor>);
var
  FornecedorContext: TFornecedorContext;
begin
  inherited;
  try
    FornecedorContext:= TFornecedorContext.Create;

    FornecedorContext.List(Fornecedores, cdsConsulta);
  finally
    FreeAndNil(FornecedorContext);
  end;

{var
  ControllerRootFornecedor: IRootController<TFornecedor>;
  DataConverter: IDataConverter<TFornecedor>;
begin
  ControllerRootFornecedor:= TControllerRootFornecedor.Create;
  cdsConsulta.Close;

  cdsConsulta.CreateDataSet;

  Fornecedores:= ControllerRootFornecedor.FindAll(CommandSQL);

  DataConverter:= TDataConverterFornecedor.Create;
  DataConverter.Populate(Fornecedores, cdsConsulta);

  cdsConsulta.Open;}
end;

end.
