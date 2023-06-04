program Comercial;

uses
  Vcl.Forms,
  uPrincipal in 'view\uPrincipal.pas' {frmPrincipal},
  uLibary in 'uLibary.pas',
  uModel.Entities.Cliente in 'model\entities\uModel.Entities.Cliente.pas',
  uModel.Entities.Fornecedor in 'model\entities\uModel.Entities.Fornecedor.pas',
  uModel.Entities.Produto in 'model\entities\uModel.Entities.Produto.pas',
  uModel.Entities.Venda in 'model\entities\uModel.Entities.Venda.pas',
  uModel.Entities.VendaItem in 'model\entities\uModel.Entities.VendaItem.pas',
  uModel.Abstraction in 'model\uModel.Abstraction.pas',
  uModel.FireDACEngineException in 'model\uModel.FireDACEngineException.pas',
  uModel.ConstsStatement in 'model\uModel.ConstsStatement.pas',
  uModel.FireDAC in 'model\uModel.FireDAC.pas',
  uModel.Repository.DataManager in 'model\repository\uModel.Repository.DataManager.pas',
  uModel.DataManagerFactory in 'model\repository\uModel.DataManagerFactory.pas',
  uModel.Repository.Statement in 'model\repository\uModel.Repository.Statement.pas',
  uModel.Repository.StatementFactory in 'model\repository\uModel.Repository.StatementFactory.pas',
  uModel.Repository.Venda in 'model\repository\uModel.Repository.Venda.pas',
  Vcl.Themes,
  Vcl.Styles,
  uView.FormConsulta in 'view\Consulta\uView.FormConsulta.pas' {frmConsulta},
  uView.FormConsulta.Venda in 'view\Consulta\uView.FormConsulta.Venda.pas' {frmConsultaVenda},
  uController.DataConverter.Venda in 'controller\uController.DataConverter.Venda.pas',
  uController.Venda in 'controller\uController.Venda.pas',
  uModel.Services.Venda in 'model\services\uModel.Services.Venda.pas',
  uController.RootVenda in 'controller\uController.RootVenda.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown:= True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
