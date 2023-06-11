unit uView.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.BaseRegistrationForm,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBCtrls, Vcl.WinXCalendars, uModel.Abstraction, uModel.Entities.Produto,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmProduto = class(TfrmBaseRegistration)
    lblIdProduto: TLabel;
    edtIdProduto: TEdit;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    lblCnpj: TLabel;
    edtPrecoUnitario: TEdit;
    lblIdFornecedor: TLabel;
    cbxStatus: TComboBox;
    lblStatus: TLabel;
    lcbFornecedor: TDBLookupComboBox;
    dsFornecedores: TDataSource;
    cdsFornecedores: TClientDataSet;
    cdsFornecedoresidfornecedor: TIntegerField;
    cdsFornecedoresnome_fantasia: TStringField;
    cdsFornecedoresrazao_social: TStringField;
    cdsFornecedorescnpj: TStringField;
    cdsFornecedoresstatus: TStringField;
  protected
    procedure DoShow; override;
  private
    { Private declarations }
    ControllerProduto: IController<TProduto>;
    Produto: TProduto;
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
    procedure DisposeOf(var Source: TProduto);
  public
    { Public declarations }
    property Id: Integer read FId write SetId;
    destructor Destroy; override;
  end;

const
  ctAtivo = 0;
  ctInativo = 1;

var
  frmProduto: TfrmProduto;

implementation

{$R *.dfm}

uses
  System.Generics.Collections, uController.RootFornecedor, uModel.ConstsStatement,
  uController.DataConverter.Fornecedor, uController.Produto, uModel.Entities.Fornecedor,
  uConntoller.FornecedorContext, uController.Format;

procedure TfrmProduto.Save;
begin
  inherited;
  //tratameno para não da erro de EVariantTypeCastError variant of type (Null) into type (Integer)'.
  if lcbFornecedor.KeyValue = Null then
    begin
      ShowMessage('Informe um Fornecedor valido.');
      spbRestaurarClick(Self);
      Exit;
    end;

  SetProperty;

  case State of
    dsInsert:
      begin
        if ControllerProduto.Save(Produto) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Fornecedor gravado com sucesso.');
          end;
      end;

    dsEdit:
      begin
        if ControllerProduto.Update(Produto) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Fornecedor alterado com sucesso.');
          end;
      end;
    dsBrowse: Close;
  end;
end;

procedure TfrmProduto.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TfrmProduto.SetProperty;
begin
  inherited;
  Produto.IdProduto:= StrToIntDef(edtIdProduto.Text, 0);
  Produto.Descricao:= edtDescricao.Text;
  Produto.Fornecedor.IdFornecedor:= lcbFornecedor.KeyValue;
  Produto.PrecoUnitario:= TFormat.Execute(edtPrecoUnitario.Text);

  case cbxStatus.ItemIndex of
    ctAtivo: Produto.Status:= 'A';
    ctInativo: Produto.Status:= 'I';
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

procedure TfrmProduto.AddFocus;
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmProduto.Last;
begin
  inherited;
//  DisposeOf(Venda);

  Produto:= ControllerProduto.Last;

  GetProperty;
end;

procedure TfrmProduto.Next;
var
  IdProduto: Integer;
begin
  inherited;
  IdProduto:= Produto.IdProduto;
//  DisposeOf(Venda);

  Produto:= ControllerProduto.Next(IdProduto);

  GetProperty;
end;

procedure TfrmProduto.Previous;
var
  IdProduto: Integer;
begin
  inherited;
  IdProduto:= Produto.IdProduto;
//  DisposeOf(Venda);

  Produto:= ControllerProduto.Previous(IdProduto);

  GetProperty;
end;

procedure TfrmProduto.DisposeOf(var Source: TProduto);
begin
  if Source <> nil then
    FreeAndNil(Source);
end;

procedure TfrmProduto.Restaurar;
begin
  inherited;
  if State = dsEdit then
    begin
      Produto:= ControllerProduto.FindById(fId);
      GetProperty;
    end;
end;

procedure TfrmProduto.AfterSave;
begin
  inherited;
  edtIdProduto.Text:= IntToStr( Produto.IdProduto);
end;

destructor TfrmProduto.Destroy;
begin
  FreeAndNil(Produto);

  inherited Destroy;
end;

procedure TfrmProduto.DoShow;
var
  FornecedorContext: TFornecedorContext;
  Fornecedores: TObjectList<TFornecedor>;
begin
  inherited;
  try
    FornecedorContext:= TFornecedorContext.Create;
    ControllerProduto:= TControllerProduto.Create;

    FornecedorContext.List(Fornecedores, cdsFornecedores);

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
        Produto:= ControllerProduto.FindById(id);
        GetProperty;
      end
    else
      begin
        Produto:= TProduto.Create;
        edtIdProduto.Text:= IntToStr( ControllerProduto.GeneratedValue );
      end;
  finally
    FreeAndNil(FornecedorContext);
    FreeAndNil(Fornecedores);
  end;
end;

procedure TfrmProduto.Frist;
begin
  inherited;

//  DisposeOf(Venda);

  Produto:= ControllerProduto.Frist;

  GetProperty;
end;

procedure TfrmProduto.GetProperty;
begin
  inherited;

  edtIdProduto.Text:= IntToStr(Produto.IdProduto);
  edtDescricao.Text:= Produto.Descricao;
  lcbFornecedor.KeyValue:= Produto.Fornecedor.IdFornecedor;
  edtPrecoUnitario.Text:=  FloatToStr(Produto.PrecoUnitario);

  if Produto.Status = 'A' then
    cbxStatus.ItemIndex:= ctAtivo
  else cbxStatus.ItemIndex:= ctInativo;
end;

end.
