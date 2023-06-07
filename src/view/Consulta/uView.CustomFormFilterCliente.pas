unit uView.CustomFormFilterCliente;

interface

uses
  System.Classes, uView.FrmFiltros, System.Generics.Collections, uModel.Abstraction,
  uController.RootCliente, uModel.Entities.Cliente;
type
  TCustomFormFilterCliente = class(TfrmFiltros)
  private
    ControllerRootCliente: IRootController<TCliente>;
  protected
    { Protected declarations }
    procedure DoShow; override;
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  System.SysUtils;

{ TCustomFormFilterCliente }

constructor TCustomFormFilterCliente.Create;
begin
  inherited Create(nil);

  ControllerRootCliente:= TControllerRootCliente.Create;
end;

procedure TCustomFormFilterCliente.DoShow;
var
  Items: TStrings;
begin
  inherited;

  try
    Items:= ControllerRootCliente.Fields;

    Self.cbxFields.Items.AddStrings( Items );

    Self.cbxOrder.Items.AddStrings( Items );
    Self.cbxOrder.ItemIndex:= 0;
  finally
    FreeAndNil(Items);
  end;
end;

end.
