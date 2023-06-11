unit uModel.Repository.RepositoryContext;

interface

uses
  Data.DB, uModel.Abstraction;

type
  TRepositoryContext = class
  public
    function FindExists(CommadSQL: String; Parameter: String;
      ParameterType: TFieldType; Value: Variant): IStatement;
  end;

implementation

uses
  uModel.Repository.DataManager, uModel.Repository.StatementFactory,
  uModel.ConstsStatement, uModel.FireDACEngineException, FireDAC.Stan.Error,
  System.SysUtils, FireDAC.Stan.Param;

{ RepositoryContext }

function TRepositoryContext.FindExists(CommadSQL, Parameter: String;
  ParameterType: TFieldType; Value: Variant): IStatement;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Add(CommadSQL);
    case ParameterType of
      ftString: Statement.Query.Params.ParamByName(Parameter).AsString:= Value;
      ftInteger: Statement.Query.Params.ParamByName(Parameter).AsInteger:= Value;
      ftDate: Statement.Query.Params.ParamByName(Parameter).AsDate:= Value;
      ftDateTime: Statement.Query.Params.ParamByName(Parameter).AsDateTime:= Value;
      ftTimeStamp: Statement.Query.Params.ParamByName(Parameter).AsDateTime:= Value;
      ftTime: Statement.Query.Params.ParamByName(Parameter).AsTime:= Value;
      ftFloat: Statement.Query.Params.ParamByName(Parameter).AsFloat:= Value;
    end;

    Statement.Query.Open;

    Result:= Statement;

  except
    on E: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(E));
      end;
  end;
end;

end.
