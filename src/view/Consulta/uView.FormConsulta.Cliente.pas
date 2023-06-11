unit uView.FormConsulta.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormConsulta, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente;

type
  TfrmConsultaCliente = class(TfrmConsulta)
    cdsConsultaidcliente: TIntegerField;
    cdsConsultanome: TStringField;
    cdsConsultacpf: TStringField;
    cdsConsultadata_de_nascimento: TDateField;
    cdsConsultastatus: TStringField;
    procedure grdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ControllerCliente: IController<TCliente>;

    procedure Search(var CommandSQL: String; var Clientes: TObjectList<TCliente>);
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
  frmConsultaCliente: TfrmConsultaCliente;

implementation

{$R *.dfm}

uses
  System.UITypes, uModel.ConstsStatement, uController.RootCliente,
  uController.Cliente, uController.DataConverter.Cliente, uView.Clientes,
  uView.CustomFormFilterCliente;

{ TfrmConsulta2 }

procedure TfrmConsultaCliente.All;
var
  List: TObjectList<TCliente>;

  SQL: String;

begin
  inherited;
  try
    SQL:= ctSQLClientes;
    Search(SQL, List);

  finally
    FreeAndNil(List);
  end;
end;

procedure TfrmConsultaCliente.Change;
begin
  inherited;

  State:= dsEdit;

  ExecuteFrom(cdsConsulta.FieldByName('idcliente').AsInteger);
end;

procedure TfrmConsultaCliente.Consult;
begin
  inherited;

  State:= dsBrowse;

  ExecuteFrom;
end;

procedure TfrmConsultaCliente.Delete;
const
  Msg = 'Deseja realmente exluir o registro selecionado?';
var
  Cliente: TCliente;
begin
  inherited;

  if cdsConsulta.IsEmpty then
    begin
      ShowMessage('Não existe nenhum registro para ser deletado.');
      Exit;
    end;

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      Cliente:= TCliente.Create;
      try
        Cliente.IdCliente:= cdsConsulta.FieldByName('idcliente').AsInteger;
        if ControllerCliente.DeleteById(Cliente) then
          begin
            ShowMessage('Registro deletado com sucesso.');
            All;
          end;
      finally
        FreeAndNil(Cliente);
      end;
    end;
end;

procedure TfrmConsultaCliente.DoShow;
begin
  inherited;
  ControllerCliente:= TControllerCliente.Create;
  State:= dsBrowse;
end;

procedure TfrmConsultaCliente.Filter;
var
  CustomFormFilter: TCustomFormFilterCliente;
  List: TObjectList<TCliente>;

  SQL: String;
begin
  inherited;

  CustomFormFilter:= TCustomFormFilterCliente.Create;
  try
    CustomFormFilter.ShowModal;
    SQL:= ctSQLClientes;
    SQL:= SQL + CustomFormFilter.Confirmar('cli');

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

procedure TfrmConsultaCliente.grdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;
end;

procedure TfrmConsultaCliente.ExecuteFrom(Id: Integer);
var
  FromCliente: TfrmCliente;
begin
  FromCliente:= TfrmCliente.Create(Self);
  try
    FromCliente.Id:= Id;
    FromCliente.ShowModal;
  finally
    FreeAndNil(FromCliente);
  end;
end;

procedure TfrmConsultaCliente.Include;
begin
  inherited;
  State:= dsInsert;

  ExecuteFrom();
end;

procedure TfrmConsultaCliente.Search(var CommandSQL: String; var Clientes: TObjectList<TCliente>);
var
  ControllerRootCliente: IRootController<TCliente>;
  DataConverter: IDataConverter<TCliente>;
begin
  ControllerRootCliente:= TControllerRootCliente.Create;
  cdsConsulta.Close;

  cdsConsulta.CreateDataSet;

  Clientes:= ControllerRootCliente.FindAll(CommandSQL);

  DataConverter:= TDataConverterCliente.Create;
  DataConverter.Populate(Clientes, cdsConsulta);

  cdsConsulta.Open;
end;

end.
