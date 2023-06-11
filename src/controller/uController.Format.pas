unit uController.Format;

interface

type
  TFormat = class
  public
    class function Execute(Value: String): Double;
  end;

implementation

uses
  System.SysUtils;

{ TFormat }

class function TFormat.Execute(Value: String): Double;
begin
  Result:= StrToFloatDef( StringReplace(Value, '.', '', [rfReplaceAll]),  0);
end;

end.
