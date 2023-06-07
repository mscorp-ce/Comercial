unit uConntoller.FornecedorContext;

interface

type
  TFornecedorContext = class
  public
    procedure List;
  end;

implementation

uses
  System.Generics.Collections, System.SysUtils;

{ TFornecedorContext }

procedure TFornecedorContext.List;
var
  List: TObjectList<TFornecedor>;

  SQL: String;

begin
  inherited;
  try
    SQL:= ctSQLFornecedores;
    Search(SQL, List);

  finally
    FreeAndNil(List);
  end;
end;

end.
