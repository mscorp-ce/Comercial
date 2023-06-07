unit uView.CustomFormFilterFornecedor;

interface

uses
  System.Classes, uView.FrmFiltros, System.Generics.Collections, uModel.Abstraction,
  uController.RootFornecedor, uModel.Entities.Fornecedor;
type
  TCustomFormFilterFornecedor = class(TfrmFiltros)
  private
    ControllerRootFornecedor: IRootController<TFornecedor>;
  protected
    { Protected declarations }
    procedure DoShow; override;
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  System.SysUtils;

{ TCustomFormFilterFornecedor }

constructor TCustomFormFilterFornecedor.Create;
begin
  inherited Create(nil);

  ControllerRootFornecedor:= TControllerRootFornecedor.Create;
end;

procedure TCustomFormFilterFornecedor.DoShow;
var
  Items: TStrings;
begin
  inherited;

  try
    Items:= ControllerRootFornecedor.Fields;

    Self.cbxFields.Items.AddStrings( Items );

    Self.cbxOrder.Items.AddStrings( Items );
    Self.cbxOrder.ItemIndex:= 0;
  finally
    FreeAndNil(Items);
  end;
end;

end.
