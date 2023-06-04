unit uModel.Services.Venda;

interface

uses
   uModel.Abstraction, uModel.Entities.Venda, System.Classes, Data.DB, System.Generics.Collections,
   uModel.Repository.Venda;

type
  TVendaService = class(TInterfacedObject, IService<TVenda>)
  private
    VendaRepository: IRepository<TVenda>;
  public
    function Fields: TStrings;
    function GeneratedValue: Integer;
    function CurrentGeneratedValue: Integer;
    function IsValid(Entity: TVenda): Boolean;
    function Save(Entity: TVenda): Boolean;
    procedure AfterSave(Entity: TVenda);
    function Update(Id: Integer; Entity: TVenda): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function FindById(Id: Integer): TVenda;
    function FindExists: Boolean;
    function FindAll: TObjectList<TVenda>; overload;
    function FindAll(CommadSQL: String): TObjectList<TVenda>; overload;
    function Frist: TVenda;
    function Previous(Id: Integer): TVenda;
    function Next(Id: Integer): TVenda;
    function Last: TVenda;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TVendaService }

procedure TVendaService.AfterSave(Entity: TVenda);
begin
  Entity.IdVenda:= CurrentGeneratedValue;
end;

constructor TVendaService.Create;
begin
  inherited Create;

  VendaRepository:= TVendaRepository.Create;
end;

function TVendaService.CurrentGeneratedValue: Integer;
begin
  Result:= VendaRepository.CurrentGeneratedValue;
end;

function TVendaService.DeleteById(Id: Integer): Boolean;
begin
  Result:= VendaRepository.DeleteById(Id);
end;

destructor TVendaService.Destroy;
begin
  inherited Destroy;
end;

function TVendaService.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= VendaRepository.Fields;

  Result:= Items;
end;

function TVendaService.FindAll: TObjectList<TVenda>;
begin
  Result:= nil;
end;

function TVendaService.FindAll(CommadSQL: String): TObjectList<TVenda>;
begin
  Result:= VendaRepository.FindAll(CommadSQL);
end;

function TVendaService.FindById(Id: Integer): TVenda;
begin
  Result:= VendaRepository.FindById(Id);
end;

function TVendaService.FindExists: Boolean;
begin
  Result:= False;
end;

function TVendaService.Frist: TVenda;
begin
  Result:= VendaRepository.Frist;
end;

function TVendaService.GeneratedValue: Integer;
begin
  Result:= VendaRepository.GeneratedValue;
end;

function TVendaService.IsValid(Entity: TVenda): Boolean;
begin
  Result:= False;

  if Entity.IdVenda <= 0 then
    Exit;

  if Entity.DataHoraVenda = 0 then
    Exit;

  if Entity.Cliente.IdCliente <= 0 then
    Exit;

  //if ( Entity.Total > Entity.Subtotal) then
  //  Exit;

  if Length( Entity.Status) = 0 then
    Exit;

  Result:= True;
end;

function TVendaService.Last: TVenda;
begin
  Result:= VendaRepository.Last;
end;

function TVendaService.Next(Id: Integer): TVenda;
begin
  Result:= VendaRepository.Next(Id);
end;

function TVendaService.Previous(Id: Integer): TVenda;
begin
  Result:= VendaRepository.Previous(Id);
end;

function TVendaService.Save(Entity: TVenda): Boolean;
var
  Return: Boolean;
begin
  Return:= VendaRepository.Save(Entity);
  if Return then
    AfterSave(Entity);

  Result:= Return;
end;

function TVendaService.Update(Id: Integer; Entity: TVenda): Boolean;
begin
  Entity.IdVenda:= Id;
  Result:= VendaRepository.Update(Entity);
end;

end.
