program Comercial;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uView.Principal in 'view\uView.Principal.pas' {frmPrincipal},
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
  uController.DataConverter.Venda in 'controller\uController.DataConverter.Venda.pas',
  uController.Venda in 'controller\uController.Venda.pas',
  uModel.Services.Venda in 'model\services\uModel.Services.Venda.pas',
  uController.RootVenda in 'controller\uController.RootVenda.pas',
  uView.CustomFormFilterVenda in 'view\Consulta\uView.CustomFormFilterVenda.pas',
  uView.BaseRegistrationForm in 'view\FormCadastro\uView.BaseRegistrationForm.pas' {frmBaseRegistration},
  uView.Vendas in 'view\uView.Vendas.pas' {frmVenda},
  uModel.Repository.Cliente in 'model\repository\uModel.Repository.Cliente.pas',
  uView.FormConsulta in 'view\Consulta\uView.FormConsulta.pas' {frmConsulta},
  uView.FrmFiltros in 'view\Consulta\uView.FrmFiltros.pas' {frmFiltros},
  uView.FormConsulta.Venda in 'view\Consulta\uView.FormConsulta.Venda.pas' {frmConsultaVenda},
  uView.FormConsulta.Cliente in 'view\Consulta\uView.FormConsulta.Cliente.pas' {frmConsultaCliente},
  uController.Cliente in 'controller\uController.Cliente.pas',
  uModel.Services.Cliente in 'model\services\uModel.Services.Cliente.pas',
  uController.DataConverter.Cliente in 'controller\uController.DataConverter.Cliente.pas',
  uView.CustomFormFilterCliente in 'view\Consulta\uView.CustomFormFilterCliente.pas',
  uController.RootCliente in 'controller\uController.RootCliente.pas',
  uView.Clientes in 'view\uView.Clientes.pas' {frmCliente},
  uModel.Services.Fornecedor in 'model\services\uModel.Services.Fornecedor.pas',
  uController.Fornecedor in 'controller\uController.Fornecedor.pas',
  uController.DataConverter.Fornecedor in 'controller\uController.DataConverter.Fornecedor.pas',
  uController.RootFornecedor in 'controller\uController.RootFornecedor.pas',
  uView.FormConsulta.Fornecedor in 'view\Consulta\uView.FormConsulta.Fornecedor.pas' {frmConsultaFornecedor},
  uView.Fornecedor in 'view\uView.Fornecedor.pas' {frmFornecedor},
  uView.CustomFormFilterFornecedor in 'view\Consulta\uView.CustomFormFilterFornecedor.pas',
  uModel.Repository.Produto in 'model\repository\uModel.Repository.Produto.pas',
  uModel.Repository.Fornecedor in 'model\repository\uModel.Repository.Fornecedor.pas',
  uModel.Services.Produto in 'model\services\uModel.Services.Produto.pas',
  uController.Produto in 'controller\uController.Produto.pas',
  uController.DataConverter.Produto in 'controller\uController.DataConverter.Produto.pas',
  uController.RootProduto in 'controller\uController.RootProduto.pas',
  uView.CustomFormFilterProduto in 'view\Consulta\uView.CustomFormFilterProduto.pas',
  uView.Produto in 'view\uView.Produto.pas' {frmProduto},
  uConntoller.FornecedorContext in 'controller\uConntoller.FornecedorContext.pas',
  uView.FormConsulta.Produto in 'view\Consulta\uView.FormConsulta.Produto.pas' {frmConsultaProduto},
  uView.VendasItens in 'view\uView.VendasItens.pas' {frmVendasItens},
  uConntoller.ProdutoContext in 'controller\uConntoller.ProdutoContext.pas',
  uController.DataConverter.VendaItem in 'controller\uController.DataConverter.VendaItem.pas',
  uController.RootVendaItem in 'controller\uController.RootVendaItem.pas',
  uModel.Services.VendaItem in 'model\services\uModel.Services.VendaItem.pas',
  uModel.Repository.VendaItem in 'model\repository\uModel.Repository.VendaItem.pas',
  uController.Format in 'controller\uController.Format.pas',
  uModel.Repository.RepositoryContext in 'model\repository\uModel.Repository.RepositoryContext.pas',
  uController.VendaItem in 'controller\uController.VendaItem.pas',
  uView.FormRelatorioVendasPorCliente in 'view\uView.FormRelatorioVendasPorCliente.pas' {frmFormFormRelatorioVendasPorCliente},
  uView.FormFormRelatorioCliente in 'view\uView.FormFormRelatorioCliente.pas' {frmFormFormRelatorioCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown:= True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
