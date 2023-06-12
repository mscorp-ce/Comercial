unit uView.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.BaseRegistrationForm,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBCtrls, Vcl.WinXCalendars, uModel.Abstraction, uModel.Entities.Cliente,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmCliente = class(TfrmBaseRegistration)
    lblIdCliente: TLabel;
    edtIdCliente: TEdit;
    lblDtNascimento: TLabel;
    lblCliente: TLabel;
    cpDtNascimento: TCalendarPicker;
    edtNome: TEdit;
    lblCpf: TLabel;
    edtCpf: TEdit;
    cbxStatus: TComboBox;
    lblStatus: TLabel;
  protected
    procedure DoShow; override;
  private
    { Private declarations }
    ControllerCliente: IController<TCliente>;
    Cliente: TCliente;
    FId: Integer;
    //procedure SQLClientes;
    procedure SetId(const Value: Integer);
  protected
    { Protected declarations }
    procedure AddFocus; override;
    procedure GetProperty; override;
    procedure SetProperty; override;
    function Save: Boolean; override;
    procedure AfterSave; override;

    procedure Frist; override;
    procedure Previous; override;
    procedure Next; override;
    procedure Last; override;
    procedure Restaurar; override;
    procedure DisposeOf(var Source: TCliente);
  public
    { Public declarations }
    property Id: Integer read FId write SetId;
    destructor Destroy; override;
  end;

const
  ctAtivo = 0;
  ctInativo = 1;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

uses
  System.Generics.Collections, uController.RootCliente, uModel.ConstsStatement,
  uController.DataConverter.Cliente, uController.Venda, uController.Cliente;

function TfrmCliente.Save: Boolean;
begin
  inherited;
  SetProperty;
  case State of
    dsInsert:
      begin
        if ControllerCliente.Save(Cliente) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Cliente gravado com sucesso.');
          end;
      end;

    dsEdit:
      begin
        if ControllerCliente.Update(Cliente) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Cliente alterado com sucesso.');
          end;
      end;
    dsBrowse: Close;
  end;
  Result:= True;
end;

procedure TfrmCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TfrmCliente.SetProperty;
begin
  inherited;
  Cliente.IdCliente:= StrToIntDef(edtIdCliente.Text, 0);
  Cliente.Nome:= edtNome.Text;
  Cliente.Cpf:= edtCpf.Text;
  Cliente.DtNascimento:= cpDtNascimento.Date;

  case cbxStatus.ItemIndex of
    ctAtivo: Cliente.Status:= 'A';
    ctInativo: Cliente.Status:= 'I';
  end;
end;

{procedure TfrmCliente.SQLClientes;
var
  ControllerRootCliente: IRootController<TCliente>;
  Clientes: TObjectList<TCliente>;
begin
  ControllerRootCliente:= TControllerRootCliente.Create;

  try
    Clientes:= ControllerRootCliente.FindAll(ctSQLClientes);


  finally
    FreeAndNil(Clientes);
  end;
end;}

procedure TfrmCliente.AddFocus;
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCliente.Last;
begin
  inherited;
//  DisposeOf(Venda);

  Cliente:= ControllerCliente.Last;

  GetProperty;
end;

procedure TfrmCliente.Next;
var
  IdCliente: Integer;
begin
  inherited;
  IdCliente:= Cliente.IdCliente;
//  DisposeOf(Venda);

  Cliente:= ControllerCliente.Next(IdCliente);

  GetProperty;
end;

procedure TfrmCliente.Previous;
var
  IdCliente: Integer;
begin
  inherited;
  IdCliente:= Cliente.IdCliente;
//  DisposeOf(Venda);

  Cliente:= ControllerCliente.Previous(IdCliente);

  GetProperty;
end;

procedure TfrmCliente.DisposeOf(var Source: TCliente);
begin
  if Source <> nil then
    FreeAndNil(Source);
end;

procedure TfrmCliente.Restaurar;
begin
  inherited;
  if State = dsEdit then
    begin
      Cliente:= ControllerCliente.FindById(fId);
      GetProperty;
    end;
end;

procedure TfrmCliente.AfterSave;
begin
  inherited;
  edtIdCliente.Text:= IntToStr( Cliente.IdCliente );
end;

destructor TfrmCliente.Destroy;
begin
  FreeAndNil(Cliente);

  inherited Destroy;
end;

procedure TfrmCliente.DoShow;
begin
  inherited;
  ControllerCliente:= TControllerCliente.Create;

  spbRestaurar.Enabled:= State = dsEdit;
  spbRestaurar.Visible:= State = dsEdit;

  spbFrist.Enabled:= State = dsBrowse;
  spbFrist.Visible:= State = dsBrowse;
  spbPrevious.Enabled:= State = dsBrowse;
  spbPrevious.Visible:= State = dsBrowse;
  spbNext.Enabled:= State = dsBrowse;
  spbNext.Visible:= State = dsBrowse;
  spbLast.Enabled:= State = dsBrowse;
  spbLast.Visible:= State = dsBrowse;

  AddFocus;
  //SQLClientes;

  if id > 0 then
    begin
      Cliente:= ControllerCliente.FindById(id);
      GetProperty;
    end
  else
    begin
      Cliente:= TCliente.Create;
      edtIdCliente.Text:= IntToStr( ControllerCliente.GeneratedValue );
    end;
end;

procedure TfrmCliente.Frist;
begin
  inherited;

//  DisposeOf(Venda);

  Cliente:= ControllerCliente.Frist;

  GetProperty;
end;

procedure TfrmCliente.GetProperty;
begin
  inherited;

  edtIdCliente.Text:= IntToStr(Cliente.IdCliente);
  edtNome.Text:= Cliente.Nome;
  edtCpf.Text:= Cliente.Cpf;
  cpDtNascimento.Date:= Cliente.DtNascimento;

  if Cliente.Status = 'A' then
    cbxStatus.ItemIndex:= ctAtivo
  else cbxStatus.ItemIndex:= ctInativo;

end;

end.
