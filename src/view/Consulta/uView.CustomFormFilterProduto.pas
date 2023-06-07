unit uView.CustomFormFilterProduto;

interface

uses
  System.Classes, uView.FrmFiltros, System.Generics.Collections, uModel.Abstraction,
  uController.RootProduto, uModel.Entities.Produto;
type
  TCustomFormFilterProduto = class(TfrmFiltros)
  private
    ControllerRootProduto: IRootController<TProduto>;
  protected
    { Protected declarations }
    procedure DoShow; override;
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  System.SysUtils;

{ TCustomFormFilterProduto }

constructor TCustomFormFilterProduto.Create;
begin
  inherited Create(nil);

  ControllerRootProduto:= TControllerRootProduto.Create;
end;

procedure TCustomFormFilterProduto.DoShow;
var
  Items: TStrings;
begin
  inherited;

  try
    Items:= ControllerRootProduto.Fields;

    Self.cbxFields.Items.AddStrings( Items );

    Self.cbxOrder.Items.AddStrings( Items );
    Self.cbxOrder.ItemIndex:= 0;
  finally
    FreeAndNil(Items);
  end;
end;

end.
