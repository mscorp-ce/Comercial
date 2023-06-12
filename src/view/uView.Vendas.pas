unit uView.Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.BaseRegistrationForm,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBCtrls, Vcl.WinXCalendars, System.Generics.Collections, Vcl.Grids, Vcl.DBGrids,
  uModel.Abstraction, uModel.Entities.Venda, uModel.Entities.VendaItem;

type
  TfrmVenda = class(TfrmBaseRegistration)
    lblIdVenda: TLabel;
    edtIdVenda: TEdit;
    lblDtVenda: TLabel;
    lblCliente: TLabel;
    lblTotal: TLabel;
    edtTotal: TEdit;
    lcbCliente: TDBLookupComboBox;
    cdsClientes: TClientDataSet;
    dsClientes: TDataSource;
    cpDtVenda: TCalendarPicker;
    cdsVendaItens: TClientDataSet;
    dsVendaItens: TDataSource;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    lblStatus: TLabel;
    cbxStatus: TComboBox;
    cdsClientesidcliente: TIntegerField;
    cdsClientesnome: TStringField;
    cdsClientescpf: TStringField;
    cdsClientesdata_de_nascimento: TDateField;
    cdsClientesstatus: TStringField;
    spbIncluir: TSpeedButton;
    cdsVendaItensidvenda: TIntegerField;
    cdsVendaItensitem: TIntegerField;
    cdsVendaItensidproduto: TIntegerField;
    cdsVendaItensdescricao: TStringField;
    cdsVendaItensquantidade: TFloatField;
    cdsVendaItenspreco_unitario: TFloatField;
    cdsVendaItenstotal: TFloatField;
    spbExcluir: TSpeedButton;
    spbAlterar: TSpeedButton;
    procedure spbIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spbExcluirClick(Sender: TObject);
    procedure spbAlterarClick(Sender: TObject);
  private
    { Private declarations }
    ControllerVenda: IController<TVenda>;
    Venda: TVenda;
    FId: Integer;
    FEditing: Boolean;
    procedure SQLClientes;
    procedure GetTotalizadores;
    procedure SetId(const Value: Integer);
    procedure AddItens;
    procedure SQLItens;
    procedure SetVendaItem(var VendaItem: TVendaItem);
    procedure SaveItens;
    procedure UpdateItem(IdVenda, Item: Integer);
    procedure RemoverItens;
    procedure RemoveItem(IdVenda, Item: Integer);
    procedure SetEditing(const Value: Boolean);
    function MountDtHrVenda(Value: TDate): TDateTime;
    procedure HabilitarControles(Value: array of Boolean);
    function GetItem: Integer;
  protected
    { Protected declarations }
    procedure DoShow; override;
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
    procedure DisposeOf(var Source: TVenda); overload;
  public
    { Public declarations }
    property Id: Integer read FId write SetId;
    property Editing: Boolean read FEditing write SetEditing;
    destructor Destroy; override;
  end;

const
  ctPendente = 0;
  ctEfetivada = 1;

var
  frmVenda: TfrmVenda;

implementation

{$R *.dfm}

uses
  uModel.Entities.Cliente, uController.RootCliente, uModel.ConstsStatement,
  uController.DataConverter.Cliente, uController.Venda, uView.VendasItens,
  uController.RootProduto, uController.DataConverter.Produto, uController.RootVendaItem,
  uController.DataConverter.VendaItem, uController.Format, uController.VendaItem,
  System.DateUtils;

procedure TfrmVenda.Save;
var
  IsSaved: Boolean;
begin
  inherited;

  HabilitarControles([True, True, True, False]);

  //tratameno para não da erro de EVariantTypeCastError variant of type (Null) into type (Integer)'.
  if lcbCliente.KeyValue = Null then
    begin
      ShowMessage('Informe um Cliente valido.');
      HabilitarControles([True, False, False, True]);
      Exit;
    end;

  SetProperty;

  if (Venda.Status = 'E') and (cdsVendaItens.IsEmpty) then
    begin
      ShowMessage('Não é possível gravar uma Venda sem itens.');
      HabilitarControles([True, False, False, True]);
      Exit;
    end;

  case State of
    dsInsert:
      begin
        StateItens:= dsInsert;
        IsSaved:= ControllerVenda.Save(Venda);
        if IsSaved then
          begin
            State:= dsBrowse;
            SaveItens;
            AfterSave;
            ShowMessage('Venda gravada com sucesso.');
          end
        else
          HabilitarControles([True, True, False, True]);
      end;

    dsEdit:
      begin
        StateItens:= dsEdit;
        IsSaved:= ControllerVenda.Update(Venda);
        if IsSaved then
          begin
            State:= dsBrowse;
            RemoverItens;
            SaveItens;
            AfterSave;

            Venda.Total:= TFormat.Execute(edtTotal.Text);
            ControllerVenda.Update(ctSQLToalVendaUpdate, 'idvenda', Venda);
            SQLItens;
            ShowMessage('Venda alterada com sucesso.');
          end
        else
          HabilitarControles([True, True, False, True]);
      end;
    dsBrowse: Close;
  end;
end;

procedure TfrmVenda.SaveItens;
var
  ControllerVendaItem: IController<TVendaItem>;
  VendaItem: TVendaItem;
begin
  cdsVendaItens.DisableControls;
  cdsVendaItens.First;

  ControllerVendaItem:= TControllerVendaItem.Create;
  VendaItem:= TVendaItem.Create;
  try
    while not cdsVendaItens.Eof do
      begin
        SetVendaItem(VendaItem);

        ControllerVendaItem.Save(VendaItem);

        cdsVendaItens.Next;
      end;
  finally
    FreeAndNil(VendaItem);
  end;

  AfterSave;
  StateItens:=  dsBrowse;
  cdsVendaItens.EnableControls;
end;

procedure TfrmVenda.SetEditing(const Value: Boolean);
begin
  FEditing := Value;
end;

procedure TfrmVenda.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TfrmVenda.SetProperty;
begin
  inherited;
  Venda.IdVenda:= StrToIntDef(edtIdVenda.Text, 0);
  Venda.DataHoraVenda:= MountDtHrVenda(cpDtVenda.Date);
  Venda.Cliente.IdCliente:= lcbCliente.KeyValue;
  Venda.Total:= TFormat.Execute(edtTotal.Text);

  case cbxStatus.ItemIndex of
    ctPendente: Venda.Status:= 'P';
    ctEfetivada: Venda.Status:= 'E';
  end;
end;

procedure TfrmVenda.SetVendaItem(var VendaItem: TVendaItem);
begin
  VendaItem.IdVenda:= cdsVendaItensidvenda.AsInteger;
  VendaItem.Item:= cdsVendaItensitem.AsInteger;
  VendaItem.Produto.IdProduto:= cdsVendaItensidproduto.AsInteger;
  VendaItem.Quantidade:= cdsVendaItensquantidade.AsFloat;
  VendaItem.PrecoUnitario:= cdsVendaItenspreco_unitario.AsFloat;
  VendaItem.Total:= cdsVendaItenstotal.AsFloat;
end;

procedure TfrmVenda.spbAlterarClick(Sender: TObject);
begin
  inherited;
  State:= dsEdit;
  UpdateItem(cdsVendaItensidvenda.AsInteger, cdsVendaItensitem.AsInteger);
  HabilitarControles([True, True, True, True]);
end;

procedure TfrmVenda.spbExcluirClick(Sender: TObject);
begin
  inherited;
  RemoveItem(cdsVendaItensidvenda.AsInteger, cdsVendaItensitem.AsInteger);
  cdsVendaItens.Locate('item', cdsVendaItensitem.AsInteger, [loPartialKey]);
  cdsVendaItens.Delete;

  GetTotalizadores;

  State:= dsEdit;

  Save;
end;

procedure TfrmVenda.spbIncluirClick(Sender: TObject);
begin
  inherited;
  AddItens;
end;

procedure TfrmVenda.SQLClientes;
var
  ControllerRootCliente: IRootController<TCliente>;
  DataConverter: IDataConverter<TCliente>;
  Clientes: TObjectList<TCliente>;
begin
  ControllerRootCliente:= TControllerRootCliente.Create;
  cdsClientes.Close;
  cdsClientes.CreateDataSet;

  try
    Clientes:= ControllerRootCliente.FindAll(ctSQLClientes);

    DataConverter:= TDataConverterCliente.Create;
    DataConverter.Populate(Clientes, cdsClientes);

    cdsClientes.Open;

  finally
    FreeAndNil(Clientes);
  end;
end;

procedure TfrmVenda.SQLItens;
var
  ControllerRootProduto: IRootController<TVendaItem>;
  DataConverter: IDataConverter<TVendaItem>;
  Itens: TObjectList<TVendaItem>;
  VendaItem: TVendaItem;
begin
  ControllerRootProduto:= TControllerRootVendaItem.Create;
  cdsVendaItens.Close;

  cdsVendaItens.CreateDataSet;
  VendaItem:= TVendaItem.Create;
  try
    VendaItem.IdVenda:= FId;
    Itens:= ControllerRootProduto.FindAll(ctSQLVendaItens + ctSQLVendaItemWhere, VendaItem );
    try
      DataConverter:= TDataConverterVendaItem.Create;
      DataConverter.Populate(Itens, cdsVendaItens);

      cdsVendaItens.Open;
    finally
      FreeAndNil(Itens);
    end;
  finally
    FreeAndNil(VendaItem);
  end;
end;

procedure TfrmVenda.UpdateItem(IdVenda, Item: Integer);
var
  frmVendasItens: TfrmVendasItens;
  VendaItem: TVendaItem;
begin
  frmVendasItens:= TfrmVendasItens.Create(nil);
  try
    VendaItem:= TVendaItem.Create;
    try
      SetVendaItem(VendaItem);

      frmVendasItens.IdVenda:= Venda.IdVenda;
      frmVendasItens.Editing:= True;
      frmVendasItens.SetVendaItem(VendaItem);
      frmVendasItens.ShowModal;

      if not frmVendasItens.Itens.IsEmpty then
        begin
          cdsVendaItens.Data:= frmVendasItens.Itens.Data;
          cdsVendaItens.Open;
          GetTotalizadores;
          Save;
          //RemoverItens;
          //SaveItens;
          SQLItens;
        end;
    finally
      FreeAndNil(VendaItem);
    end;

  finally
    FreeAndNil(frmVendasItens);
  end;
end;

procedure TfrmVenda.AddFocus;
begin
  inherited;
  cpDtVenda.SetFocus;
end;

procedure TfrmVenda.GetTotalizadores;
var
  Total: Double;
begin
  Total:= 0;
  cdsVendaItens.DisableControls;
  cdsVendaItens.First;

  while not cdsVendaItens.Eof do
    begin
      Total:= Total + cdsVendaItenstotal.AsFloat;
      cdsVendaItens.Next;
    end;

  cdsVendaItens.First;
  cdsVendaItens.EnableControls;

  edtTotal.Text:= FormatFloat('###,###,##0.00', Total);
end;

procedure TfrmVenda.Last;
begin
  inherited;
//  DisposeOf(Venda);

  Venda:= ControllerVenda.Last;

  GetProperty;
end;

function TfrmVenda.MountDtHrVenda(Value: TDate): TDateTime;
var
  DtHrVenda: TDateTime;
  Time: TTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, Milli: Word;
begin
  DecodeDate(Value, Year, Month, Day);

  Time:= Now;

  DecodeTime(Time, Hour, Min, Sec, Milli);

  DtHrVenda:= EncodeDateTime(Year, Month, Day, Hour, Min, Sec, Milli);

  Result:= DtHrVenda;
end;

procedure TfrmVenda.Next;
var
  IdVenda: Integer;
begin
  inherited;
  IdVenda:= Venda.IdVenda;
//  DisposeOf(Venda);

  Venda:= ControllerVenda.Next(IdVenda);

  GetProperty;
end;

procedure TfrmVenda.Previous;
var
  IdVenda: Integer;
begin
  inherited;
  IdVenda:= Venda.IdVenda;
//  DisposeOf(Venda);

  Venda:= ControllerVenda.Previous(IdVenda);

  GetProperty;
end;

procedure TfrmVenda.DisposeOf(var Source: TVenda);
begin
  if Source <> nil then
    FreeAndNil(Source);
end;

procedure TfrmVenda.RemoveItem(IdVenda, Item: Integer);
var
  ControllerVendaItem: IController<TVendaItem>;
  VendaItem: TVendaItem;
begin
  ControllerVendaItem:= TControllerVendaItem.Create;
  try
    VendaItem:= TVendaItem.Create;
    VendaItem.IdVenda:= IdVenda;
    VendaItem.Item:= Item;

    ControllerVendaItem.DeleteById(VendaItem);
  finally
    FreeAndNil(VendaItem);
  end;
end;

procedure TfrmVenda.RemoverItens;
begin
  cdsVendaItens.DisableControls;
  cdsVendaItens.First;

  while not cdsVendaItens.Eof do
    begin
      RemoveItem(cdsVendaItensidvenda.AsInteger, cdsVendaItensitem.AsInteger);

      cdsVendaItens.Next;
    end;

  cdsVendaItens.First;
  cdsVendaItens.EnableControls;
end;

procedure TfrmVenda.Restaurar;
begin
  inherited;
  if State = dsEdit then
    begin
      Venda:= ControllerVenda.FindById(fId);
      GetProperty;
    end;
end;

procedure TfrmVenda.AddItens;
var
  VendasItens: TfrmVendasItens;
begin
  HabilitarControles([True, True, False, True]);

  VendasItens:= TfrmVendasItens.Create(nil);
  try
    VendasItens.IdVenda:= StrToIntDef(edtIdVenda.Text, 0);
    VendasItens.Item:= GetItem;
    VendasItens.Itens.Data:= cdsVendaItens.Data;
    VendasItens.ShowModal;

    if not VendasItens.Itens.IsEmpty then
      begin
        cdsVendaItens.Data:= VendasItens.Itens.Data;
        cdsVendaItens.Open;
        GetTotalizadores;
      end;

  finally
    FreeAndNil(VendasItens);
  end;
end;

procedure TfrmVenda.AfterSave;
begin
  inherited;
  GetTotalizadores;
end;

procedure TfrmVenda.HabilitarControles(Value: array of Boolean);
begin
  spbIncluir.Enabled:= Value[0];
  spbAlterar.Enabled:= Value[1];
  spbExcluir.Enabled:= Value[2];
  spbOK.Enabled:= Value[3];
end;

destructor TfrmVenda.Destroy;
begin
  FreeAndNil(Venda);

  inherited Destroy;
end;

procedure TfrmVenda.DoShow;
begin
  inherited;
  ControllerVenda:= TControllerVenda.Create;

  {spbRestaurar.Enabled:= State = dsEdit;
  spbRestaurar.Visible:= State = dsEdit;

  spbFrist.Enabled:= State = dsBrowse;
  spbFrist.Visible:= State = dsBrowse;
  spbPrevious.Enabled:= State = dsBrowse;
  spbPrevious.Visible:= State = dsBrowse;
  spbNext.Enabled:= State = dsBrowse;
  spbNext.Visible:= State = dsBrowse;
  spbLast.Enabled:= State = dsBrowse;
  spbLast.Visible:= State = dsBrowse;}

  SQLItens;

  //HabilitarControles([True, False, False, True]);

  if cdsVendaItens.IsEmpty then
    HabilitarControles([True, False, False, True])
  else
    HabilitarControles([True, True, True, True]);

  cpDtVenda.Date:= Now;

  AddFocus;
  SQLClientes;

  if id > 0 then
    begin
      Venda:= ControllerVenda.FindById(id);
      GetProperty;
    end
  else
    begin
      Venda:= TVenda.Create;
      edtIdVenda.Text:= IntToStr( ControllerVenda.GeneratedValue );
      cbxStatus.ItemIndex:= ctPendente;
    end;
end;

procedure TfrmVenda.FormActivate(Sender: TObject);
begin
  inherited;
  if not cdsVendaItens.IsEmpty then
    GetTotalizadores;
end;

procedure TfrmVenda.Frist;
begin
  inherited;
//  DisposeOf(Venda);

  Venda:= ControllerVenda.Frist;

  GetProperty;
end;

function TfrmVenda.GetItem: Integer;
var
  CurrencyItem: Integer;
begin
  cdsVendaItens.DisableControls;
  cdsVendaItens.Last;

  CurrencyItem:= cdsVendaItensitem.AsInteger;

  cdsVendaItens.First;

  cdsVendaItens.EnableControls;

  Result:= CurrencyItem;
end;

procedure TfrmVenda.GetProperty;
begin
  inherited;
  edtIdVenda.Text:= IntToStr( Venda.IdVenda );
  cpDtVenda.Date:= Venda.DataHoraVenda;
  lcbCliente.KeyValue:= Venda.Cliente.IdCliente;
  edtTotal.Text:= FloatToStr(Venda.Total);

  if Venda.Status = 'P' then
    cbxStatus.ItemIndex:= ctPendente
  else cbxStatus.ItemIndex:= ctEfetivada;

  if not cdsVendaItens.IsEmpty then
    GetTotalizadores;
end;

end.
