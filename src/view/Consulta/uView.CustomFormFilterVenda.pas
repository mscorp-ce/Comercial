unit uView.CustomFormFilterVenda;

interface

uses
  System.Classes, uView.FrmFiltros, System.Generics.Collections, uModel.Abstraction,
  uController.RootVenda, uModel.Entities.Venda;

type
  TCustomFormFilterVenda<T: class> = class(TfrmFiltros)
  private
    ControllerRootVenda: IRootController<TVenda>;
  protected
    { Protected declarations }
    procedure DoShow; override;
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  System.SysUtils;

{ TCustomFormFilter<T> }

constructor TCustomFormFilterVenda<T>.Create;
begin
  inherited Create(nil);

  ControllerRootVenda:= TControllerRootVenda.Create;
end;

procedure TCustomFormFilterVenda<T>.DoShow;
var
  Items: TStrings;
begin
  inherited;

  try
    Items:= ControllerRootVenda.Fields;

    Self.cbxFields.Items.AddStrings( Items );

    Self.cbxOrder.Items.AddStrings( Items );
    Self.cbxOrder.ItemIndex:= 0;
  finally
    FreeAndNil(Items);
  end;
end;

end.
