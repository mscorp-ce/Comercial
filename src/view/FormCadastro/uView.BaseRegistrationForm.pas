unit uView.BaseRegistrationForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmBaseRegistration = class(TForm)
    pnlControl: TPanel;
    spbRestaurar: TSpeedButton;
    spbOK: TSpeedButton;
    spbSair: TSpeedButton;
    spbFrist: TSpeedButton;
    spbPrevious: TSpeedButton;
    spbNext: TSpeedButton;
    spbLast: TSpeedButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure spbSairClick(Sender: TObject);
    procedure spbOKClick(Sender: TObject);
    procedure spbFristClick(Sender: TObject);
    procedure spbPreviousClick(Sender: TObject);
    procedure spbNextClick(Sender: TObject);
    procedure spbLastClick(Sender: TObject);
    procedure spbRestaurarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure GetProperty; virtual; abstract;
    procedure SetProperty; virtual; abstract;
    procedure Save; virtual; abstract;
    procedure AfterSave; virtual; abstract;
    procedure AddFocus; virtual; abstract;

    procedure Frist; virtual; abstract;
    procedure Previous; virtual; abstract;
    procedure Next; virtual; abstract;
    procedure Last; virtual; abstract;
    procedure Restaurar; virtual; abstract;
  public
    { Public declarations }
  end;

var
  frmBaseRegistration: TfrmBaseRegistration;

implementation

{$R *.dfm}

procedure TfrmBaseRegistration.FormKeyPress(Sender: TObject; var Key: Char);
const
  ctEsc = #27;
  ctEnter = #13;
begin
  case Key of
    ctEsc: Close;
    ctEnter:
      begin
        Key := #0;
        Perform(WM_NEXTDLGCTL, 0, 0);
      end;
  end;
end;

procedure TfrmBaseRegistration.spbFristClick(Sender: TObject);
begin
  Frist;
end;

procedure TfrmBaseRegistration.spbLastClick(Sender: TObject);
begin
  Last;
end;

procedure TfrmBaseRegistration.spbNextClick(Sender: TObject);
begin
  Next;
end;

procedure TfrmBaseRegistration.spbOKClick(Sender: TObject);
begin
  Save;
end;

procedure TfrmBaseRegistration.spbPreviousClick(Sender: TObject);
begin
  Previous;
end;

procedure TfrmBaseRegistration.spbRestaurarClick(Sender: TObject);
begin
  Restaurar;
end;

procedure TfrmBaseRegistration.spbSairClick(Sender: TObject);
begin
  Close;
end;

end.
