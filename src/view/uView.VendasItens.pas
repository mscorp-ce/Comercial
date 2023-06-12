unit uView.VendasItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient,
  uModel.Entities.VendaItem;

type
  TfrmVendasItens = class(TForm)
    dsProdutos: TDataSource;
    pnlControl: TPanel;
    spbRestaurar: TSpeedButton;
    spbOK: TSpeedButton;
    spbSair: TSpeedButton;
    spbFrist: TSpeedButton;
    spbPrevious: TSpeedButton;
    spbNext: TSpeedButton;
    spbLast: TSpeedButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    spbIncluir: TSpeedButton;
    pnlAtributes: TPanel;
    lblCnpj: TLabel;
    lblIdFornecedor: TLabel;
    edtPrecoUnitario: TEdit;
    lcbProduto: TDBLookupComboBox;
    lblIdVenda: TLabel;
    edtIdVenda: TEdit;
    lblItem: TLabel;
    edtItem: TEdit;
    lblQauntidade: TLabel;
    edtQauntidade: TEdit;
    lblTotal: TLabel;
    edtTotal: TEdit;
    dsItens: TDataSource;
    cdsProdutos: TClientDataSet;
    Itens: TClientDataSet;
    cdsProdutosidproduto: TIntegerField;
    cdsProdutosdescricao: TStringField;
    cdsProdutosidfornecedor: TIntegerField;
    cdsProdutospreco_unitario: TFloatField;
    cdsProdutosstatus: TStringField;
    Itensidvenda: TIntegerField;
    Itensitem: TIntegerField;
    Itensidproduto: TIntegerField;
    Itensdescricao: TStringField;
    Itensquantidade: TFloatField;
    Itenspreco_unitario: TFloatField;
    Itenstotal: TFloatField;
    procedure spbIncluirClick(Sender: TObject);
    procedure spbOKClick(Sender: TObject);
    procedure lcbProdutoExit(Sender: TObject);
    procedure edtQauntidadeChange(Sender: TObject);
    procedure spbSairClick(Sender: TObject);
  private
    { Private declarations }
    FIdVenda: Integer;
    fVendaItem: TVendaItem;
    FEditing: Boolean;
    FItem: Integer;
    procedure SetIdVenda(const Value: Integer);
    procedure AddItens;
    procedure SetPrecoUnitario;
    procedure CacularTotal;
    procedure LimparCampos;
    procedure AddIdentificadorVendaItem;
    procedure Incluir;
    function Valid(var Msg: String): Boolean;
    function ValidProduto: Boolean;
    procedure Loading;
    procedure SetEditing(const Value: Boolean);
    procedure SetItem(const Value: Integer);
    procedure SQLItens;
    procedure HabilitarControles(Value: array of Boolean);
  protected
    procedure DoShow; override;
  public
    { Public declarations }

    property IdVenda: Integer read FIdVenda write SetIdVenda;
    property Item: Integer read FItem write SetItem;
    property Editing: Boolean read FEditing write SetEditing;
    procedure SetVendaItem(var VendaItem: TVendaItem);
  end;

var
  frmVendasItens: TfrmVendasItens;

implementation

uses
  uModel.Abstraction, uModel.Entities.Produto, uController.Produto,
  uConntoller.ProdutoContext, System.Generics.Collections, uController.Format,
  uModel.ConstsStatement, uController.RootVendaItem,
  uController.DataConverter.VendaItem;

{$R *.dfm}

{ TfrmVendasItens }

procedure TfrmVendasItens.AddIdentificadorVendaItem;
begin
  edtIdVenda.Text:= IntToStr(FIdVenda);
  Inc(FItem);
  edtItem.Text:= IntToStr(FItem);
end;

procedure TfrmVendasItens.SQLItens;
var
  ControllerRootProduto: IRootController<TVendaItem>;
  DataConverter: IDataConverter<TVendaItem>;
  AItens: TObjectList<TVendaItem>;
  VendaItem: TVendaItem;
begin
  ControllerRootProduto:= TControllerRootVendaItem.Create;
  Itens.Close;

  Itens.CreateDataSet;
  VendaItem:= TVendaItem.Create;
  try
    VendaItem.IdVenda:= FIdVenda;
    AItens:= ControllerRootProduto.FindAll(ctSQLVendaItens + ctSQLVendaItemWhere, VendaItem );
    try
      DataConverter:= TDataConverterVendaItem.Create;
      DataConverter.Populate(AItens, Itens);

      Itens.Open;
    finally
      FreeAndNil(AItens);
    end;
  finally
    FreeAndNil(VendaItem);
  end;
end;

procedure TfrmVendasItens.AddItens;
begin
  //if not FEditing then

  SQLItens;

  if (FEditing) and (not Itens.IsEmpty) then
    begin
      Itens.Locate('item', StrToIntDef(edtItem.Text, 0), [loPartialKey]);
      Itens.Delete;
    end;

  Itens.Append;
  Itensidvenda.AsInteger:= StrToIntDef(edtIdVenda.Text, 0);
  Itensitem.AsInteger:= StrToIntDef(edtItem.Text, 0);
  Itensidproduto.AsInteger:= StrToIntDef(lcbProduto.KeyValue, 0);
  Itensdescricao.AsString:= lcbProduto.Text;
  Itenspreco_unitario.AsFloat:= StrToFloatDef(edtPrecoUnitario.Text, 0);
  Itensquantidade.AsFloat:= StrToFloatDef(edtQauntidade.Text, 0);
  Itenstotal.AsFloat:= StrToFloatDef(edtTotal.Text, 0);
  Itens.Post;
  Itens.Open;

  pnlAtributes.Enabled:= False;
  LimparCampos;
  spbIncluir.Enabled:= True;
end;

procedure TfrmVendasItens.CacularTotal;
begin
  edtTotal.Text:= FloatToStr(StrToFloatDef(edtPrecoUnitario.Text, 0) * StrToFloatDef(edtQauntidade.Text, 0));
end;

procedure TfrmVendasItens.Loading;
begin
  if fVendaItem <> nil then
    begin
      edtIdVenda.Text:= IntToStr(fVendaItem.IdVenda);
      edtItem.Text:= IntToStr(fVendaItem.Item);
      lcbProduto.KeyValue:= fVendaItem.Produto.IdProduto;
      edtPrecoUnitario.Text:= FloatToStr(fVendaItem.PrecoUnitario);
      edtQauntidade.Text:= FloatToStr(fVendaItem.Quantidade);
      edtTotal.Text:= FloatToStr(fVendaItem.Total);
    end;

  pnlAtributes.Enabled:= True;

  lcbProduto.SetFocus;
end;

procedure TfrmVendasItens.HabilitarControles(Value: array of Boolean);
begin
  spbIncluir.Enabled:= Value[0];
  spbOK.Enabled:= Value[1];
end;

procedure TfrmVendasItens.DoShow;
var
  ProdutoContext: TProdutoContext;
  Produtos: TObjectList<TProduto>;
begin
  inherited;
  if FEditing then
    Itens.CreateDataSet;
  Itens.Open;

  if Itens.IsEmpty then
    begin
      if FEditing then
        HabilitarControles([True, True])
      else
        HabilitarControles([True, False])
    end
  else
    HabilitarControles([False, True]);

  ProdutoContext:= TProdutoContext.Create;
  try
    ProdutoContext.List(Produtos, cdsProdutos);

  finally
    FreeAndNil(Produtos);
    FreeAndNil(ProdutoContext);
  end;

  if FEditing then
    Loading
  else
    pnlAtributes.Enabled:= False;
end;

procedure TfrmVendasItens.edtQauntidadeChange(Sender: TObject);
begin
  CacularTotal;
end;

procedure TfrmVendasItens.Incluir;
begin
  pnlAtributes.Enabled:= True;

  AddIdentificadorVendaItem;

  lcbProduto.OnExit:= nil;

  lcbProduto.SetFocus;

  lcbProduto.OnExit:= lcbProdutoExit;

  HabilitarControles([False, True])
end;

procedure TfrmVendasItens.lcbProdutoExit(Sender: TObject);
begin
  if not ValidProduto then
    begin
      ShowMessage('Informe um produuto válido.');
      Exit;
    end
  else
    begin
      SetPrecoUnitario;
      if pnlAtributes.Enabled then
        edtQauntidade.SetFocus;
    end;
end;

procedure TfrmVendasItens.LimparCampos;
begin
  edtIdVenda.Text:= '';
  edtItem.Text:= '';
  lcbProduto.KeyValue:= -1;
  edtPrecoUnitario.OnExit:= nil;
  edtPrecoUnitario.Text:= '';
  edtPrecoUnitario.OnExit:= lcbProdutoExit;
  edtQauntidade.Text:= '';
  edtTotal.Text:= '';
end;

procedure TfrmVendasItens.SetEditing(const Value: Boolean);
begin
  FEditing := Value;
end;

procedure TfrmVendasItens.SetIdVenda(const Value: Integer);
begin
  FIdVenda := Value;
end;

procedure TfrmVendasItens.SetItem(const Value: Integer);
begin
  FItem := Value;
end;

procedure TfrmVendasItens.SetPrecoUnitario;
var
  ControllerProduto: IController<TProduto>;
  Produto: TProduto;
begin
  ControllerProduto:= TControllerProduto.Create;
  try
    Produto:= ControllerProduto.FindById(lcbProduto.KeyValue);
    edtPrecoUnitario.Text:= FloatToStr( Produto.PrecoUnitario );
  finally
    FreeAndNil(Produto);
  end;
end;

procedure TfrmVendasItens.SetVendaItem(var VendaItem: TVendaItem);
begin
  fVendaItem:= VendaItem;
end;

procedure TfrmVendasItens.spbIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmVendasItens.spbOKClick(Sender: TObject);
var
  Msg: String;
begin
  if Valid(Msg) then
    begin
      AddItens;
      HabilitarControles([True, False]);
    end
  else
    begin
      ShowMessage(Msg);
      HabilitarControles([True, True]);
    end;
end;

procedure TfrmVendasItens.spbSairClick(Sender: TObject);
begin
  Close;
end;

function TfrmVendasItens.Valid(var Msg: String): Boolean;
var
  ControllerProduto: IController<TProduto>;
  Produto: TProduto;
  Statement: IStatement;
begin
  Result:= False;

  if not ValidProduto then
    begin
      Msg:= 'Informe um produuto válido.';
      Exit;
    end;

  try
    if (TFormat.Execute(edtPrecoUnitario.Text) = 0)  or (edtPrecoUnitario.Text = '') then
      begin
        Msg:= 'Informe um preço unitário válido.';
        Exit;
      end;
  except
    Msg:= 'Informe um preço unitário válido.';
    Exit;
  end;

  try
    if (TFormat.Execute(edtQauntidade.Text) = 0) or (edtQauntidade.Text = '') then
      begin
        Msg:= 'Informe uma quantidade válida.';
        Exit;
      end;
  except
    Msg:= 'Informe uma quantidade válida.';
    Exit;
  end;

  try
    if (TFormat.Execute(edtTotal.Text) = 0) or (edtTotal.Text = '') then
      begin
        Msg:= 'Informe um total válido.';
        Exit;
      end;
  except
    Msg:= 'Informe um total válido.';
    Exit;
  end;

  Produto:= TProduto.Create;
  try
    ControllerProduto:= TControllerProduto.Create;
    Produto.IdProduto:= lcbProduto.KeyValue;

    Statement:= ControllerProduto.FindExists(ctSQLProdutoFindInativo, 'idproduto', ftInteger, Produto.IdProduto);

    if Statement.Query.FieldByName('status').AsString = 'I' then
      begin
        Msg:= 'Produto intativo, selecione um produto que estaja ativo.';
        Exit;
      end;

  finally
    FreeAndNil(Produto);
  end;

  Itens.DisableControls;

  Itens.First;

  while not Itens.Eof do
    begin
      if lcbProduto.KeyValue = Itensidproduto.AsInteger then
        begin
          Msg:= 'Produto já adicinado nesse venda.';
          Exit;
        end;

      Itens.Next;
    end;

  Itens.First;
  Itens.EnableControls;
  Result:= True;
end;

function TfrmVendasItens.ValidProduto: Boolean;
begin
  Result:= False;

  if lcbProduto.KeyValue = Null then
    begin
      Exit;
    end;

  Result:= True;
end;

end.
