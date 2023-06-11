unit uView.Fornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.BaseRegistrationForm,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBCtrls, Vcl.WinXCalendars, uModel.Abstraction, uModel.Entities.Fornecedor,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmFornecedor = class(TfrmBaseRegistration)
    lblIdFornecedor: TLabel;
    edtIdFornecedor: TEdit;
    lblNomeFamtasia: TLabel;
    edtNomeFamtasia: TEdit;
    lblCnpj: TLabel;
    edtCnpj: TEdit;
    lblRazaoSocial: TLabel;
    edtRazaoSocial: TEdit;
    cbxStatus: TComboBox;
    lblStatus: TLabel;
  protected
    procedure DoShow; override;
  private
    { Private declarations }
    ControllerFornecedor: IController<TFornecedor>;
    Fornecedor: TFornecedor;
    FId: Integer;
    //procedure SQLClientes;
    procedure SetId(const Value: Integer);
  protected
    { Protected declarations }
    procedure AddFocus; override;
    procedure GetProperty; override;
    procedure SetProperty; override;
    procedure Save; override;
    procedure AfterSave; override;

    procedure Frist; override;
    procedure Previous; override;
    procedure Next; override;
    procedure Last; override;
    procedure Restaurar; override;
    procedure DisposeOf(var Source: TFornecedor);
  public
    { Public declarations }
    property Id: Integer read FId write SetId;
    destructor Destroy; override;
  end;

const
  ctAtivo = 0;
  ctInativo = 1;

var
  frmFornecedor: TfrmFornecedor;

implementation

{$R *.dfm}

uses
  System.Generics.Collections, uController.RootFornecedor, uModel.ConstsStatement,
  uController.DataConverter.Fornecedor, uController.Fornecedor;

procedure TfrmFornecedor.Save;
begin
  inherited;
  SetProperty;

  case State of
    dsInsert:
      begin
        if ControllerFornecedor.Save(Fornecedor) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Fornecedor gravado com sucesso.');
          end;
      end;

    dsEdit:
      begin
        if ControllerFornecedor.Update(Fornecedor) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Fornecedor alterado com sucesso.');
          end;
      end;
    dsBrowse: Close;
  end;
end;

procedure TfrmFornecedor.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TfrmFornecedor.SetProperty;
begin
  inherited;
  Fornecedor.IdFornecedor:= StrToIntDef(edtIdFornecedor.Text, 0);
  Fornecedor.NomeFantasia:= edtNomeFamtasia.Text;
  Fornecedor.RazaoSocial:= edtRazaoSocial.Text;
  Fornecedor.Cnpj:= edtCnpj.Text;

  case cbxStatus.ItemIndex of
    ctAtivo: Fornecedor.Status:= 'A';
    ctInativo: Fornecedor.Status:= 'I';
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

procedure TfrmFornecedor.AddFocus;
begin
  inherited;
  edtNomeFamtasia.SetFocus;
end;

procedure TfrmFornecedor.Last;
begin
  inherited;
//  DisposeOf(Venda);

  Fornecedor:= ControllerFornecedor.Last;

  GetProperty;
end;

procedure TfrmFornecedor.Next;
var
  IdFornecedor: Integer;
begin
  inherited;
  IdFornecedor:= Fornecedor.IdFornecedor;
//  DisposeOf(Venda);

  Fornecedor:= ControllerFornecedor.Next(IdFornecedor);

  GetProperty;
end;

procedure TfrmFornecedor.Previous;
var
  IdFornecedor: Integer;
begin
  inherited;
  IdFornecedor:= Fornecedor.IdFornecedor;
//  DisposeOf(Venda);

  Fornecedor:= ControllerFornecedor.Previous(IdFornecedor);

  GetProperty;
end;

procedure TfrmFornecedor.DisposeOf(var Source: TFornecedor);
begin
  if Source <> nil then
    FreeAndNil(Source);
end;

procedure TfrmFornecedor.Restaurar;
begin
  inherited;
  if State = dsEdit then
    begin
      Fornecedor:= ControllerFornecedor.FindById(fId);
      GetProperty;
    end;
end;

procedure TfrmFornecedor.AfterSave;
begin
  inherited;
  edtIdFornecedor.Text:= IntToStr( Fornecedor.IdFornecedor);
end;

destructor TfrmFornecedor.Destroy;
begin
  FreeAndNil(Fornecedor);

  inherited Destroy;
end;

procedure TfrmFornecedor.DoShow;
begin
  inherited;
  ControllerFornecedor:= TControllerFornecedor.Create;

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
      Fornecedor:= ControllerFornecedor.FindById(id);
      GetProperty;
    end
  else
    begin
      Fornecedor:= TFornecedor.Create;
      edtIdFornecedor.Text:= IntToStr( ControllerFornecedor.GeneratedValue );
    end;
end;

procedure TfrmFornecedor.Frist;
begin
  inherited;

//  DisposeOf(Venda);

  Fornecedor:= ControllerFornecedor.Frist;

  GetProperty;
end;

procedure TfrmFornecedor.GetProperty;
begin
  inherited;

  edtIdFornecedor.Text:= IntToStr(Fornecedor.IdFornecedor);
  edtNomeFamtasia.Text:= Fornecedor.NomeFantasia;
  edtRazaoSocial.Text:= Fornecedor.RazaoSocial;
  edtCnpj.Text:= Fornecedor.Cnpj;

  if Fornecedor.Status = 'A' then
    cbxStatus.ItemIndex:= ctAtivo
  else cbxStatus.ItemIndex:= ctInativo;
end;

end.
