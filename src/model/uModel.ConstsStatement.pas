unit uModel.ConstsStatement;

interface

const
  ctRowsAffected = 1;

  ctSQLCurrentGeneratedValue = 'SELECT COALESCE(@@IDENTITY, 0) AS currentID';

  ctNextValueClientes = 'SELECT NEXT VALUE FOR SEQ_CLIENTES AS currentID';

  ctSQLClientes = 'SELECT cli.idcliente, cli.nome, cli.cpf, cli.data_de_nascimento, cli.status FROM Clientes cli';

  ctSQLClienteDeleteByID = 'DELETE FROM Clientes WHERE idcliente = :idcliente';

  ctSQLClienteWhere = ' WHERE cli.idcliente = :idcliente';

  ctSQLClienteInsert = 'INSERT INTO Clientes(idcliente, nome, cpf, data_de_nascimento, status)' +
                       ' VALUES(:idcliente, :nome, :cpf, :data_de_nascimento, :status)';

  ctSQLClienteUpdate = 'UPDATE Clientes' +
                       '   SET nome = :nome, cpf = :cpf, data_de_nascimento = :data_de_nascimento, status = :status'+
                       ' WHERE idcliente = :idcliente';

  ctSQLClienteFindID =  ctSQLClientes + ctSQLClienteWhere;

  ctSQLClienteFindExistsCpf = 'SELECT idcliente FROM Clientes WHERE cpf = :cpf';

  ctSQLClienteFindExists = 'SELECT idcliente FROM Clientes WHERE idcliente = :idcliente';

  ctSQLClienteFindInativo = 'SELECT status FROM Clientes WHERE idcliente = :idcliente AND status = ''I''';

  ctSQLFornecedorFindExistsCnpj = 'SELECT idfornecedor FROM Fornecedores WHERE cnpj = :cnpj';

  ctSQLFornecedorFindExistsInativo = 'SELECT status FROM Fornecedores WHERE idfornecedor = :idfornecedor and status = ''I''';

  ctSQLFornecedorFindExistsIdFornecedor = 'SELECT idfornecedor FROM Fornecedores WHERE idfornecedor = :idfornecedor';

  ctSQLFornecedores = 'SELECT frn.idfornecedor, frn.nome_fantasia, frn.razao_social, frn.cnpj, frn.status FROM Fornecedores frn';

  ctSQLFornecedorWhere = ' WHERE frn.idfornecedor = :idfornecedor';

  ctSQLFornecedorFindID = ctSQLFornecedores + ctSQLFornecedorWhere;

  ctNextValueFornecedores = 'SELECT NEXT VALUE FOR SEQ_FORNECEDORES AS currentID';

  ctSQLFornecedorInsert = 'INSERT INTO Fornecedores(idfornecedor, nome_fantasia, razao_social, cnpj, status)'+
                          ' VALUES(:idfornecedor, :nome_fantasia, :razao_social, :cnpj, :status)';

  ctSQLFornecedorUpdate = 'UPDATE Fornecedores' +
                          '   SET nome_fantasia = :nome_fantasia, razao_social = :razao_social, cnpj = :cnpj, status = :status' +
                          ' WHERE idfornecedor = :idfornecedor';

  ctSQLFornecedorDeleteByID = 'DELETE FROM Fornecedores WHERE idfornecedor = :idfornecedor';

  ctSQLProdutos = 'SELECT pro.idproduto, pro.descricao, pro.idfornecedor, pro.preco_unitario, pro.status FROM Produtos pro';

  ctSQLProdutoWhere = ' WHERE pro.idproduto = :idproduto';

  ctSQLProdutoFindID = ctSQLProdutos + ctSQLProdutoWhere;

  ctSQLProdutoFindInativo = 'SELECT status FROM Produtos WHERE idproduto = :idproduto AND status = ''I''';

  ctNextValueProdutos = 'SELECT NEXT VALUE FOR SEQ_PRODUTOS AS currentID';

  ctSQLProdutoInsert = 'INSERT INTO Produtos(idproduto, descricao, idfornecedor, preco_unitario, status)' +
                       ' VALUES(:idproduto, :descricao, :idfornecedor, :preco_unitario, :status)';

  ctSQLProdutoUpdate = 'UPDATE Produtos' +
                       '   SET descricao = :descricao, idfornecedor = :idfornecedor, preco_unitario = :preco_unitario, status = :status' +
                       ' WHERE idproduto = :idproduto';

  ctSQLProdutoDeleteByID = 'DELETE FROM Produtos WHERE idproduto = :idproduto';


  ctSQLVendas = 'SELECT ven.idvenda, ven.dthr_venda, ven.idcliente, cli.nome AS nome_cliente, '+
                '   ven.total, ven.status'+
                ' FROM' +
                '   vendas ven INNER JOIN clientes cli ON(ven.idcliente = cli.idcliente)';

  ctSQLVendaWhere = ' WHERE idvenda = :idvenda';

  ctNextValueVendas = 'SELECT NEXT VALUE FOR SEQ_VENDAS AS currentID';

  ctSQLVendaFindEfetivada = 'SELECT status FROM vendas WHERE idvenda = :idvenda AND status = ''E''';

  ctSQLVendaInsert = 'INSERT INTO vendas(idvenda, dthr_venda, idcliente, total, status)' +
                     ' VALUES(:idvenda, :dthr_venda, :idcliente, :total, :status)';

  ctSQLVendaUpdate = 'UPDATE vendas ' +
                   '   SET dthr_venda = :dthr_venda, idcliente = :idcliente, total = :total, status = :status '+
                   ctSQLVendaWhere;

  ctSQLToalVendaUpdate = 'UPDATE vendas ' +
                         '   SET total = :total'+
                         ctSQLVendaWhere;

  ctSQLVendaFindID =  ctSQLVendas + ctSQLVendaWhere;

  ctSQLVendaDelete = 'DELETE FROM vendas' +
                    ctSQLVendaWhere;

  ctSQLVendaLastOrderBy = ' ORDER BY idvenda DESC';

  ctSQLVendaFirstOrderBy = ' ORDER BY idvenda ASC';

  ctSQLVendaOne = 'SELECT TOP 1 idvenda, dthr_venda, idcliente, total, status'+
                   ' FROM '+
                   '   vendas';

  ctSQLVendaLast = ctSQLVendaOne + ctSQLVendaLastOrderBy;

  ctSQLVendaFrist = ctSQLVendaOne + ctSQLVendaFirstOrderBy;

  ctSQLVendaNext = ctSQLVendaOne + ctSQLVendaWhere;

  ctSQLVendaPrevious = ctSQLVendaOne + ctSQLVendaWhere;

  ctSQLVendaItens = 'SELECT VEI.idvenda, VEI.item, VEI.idproduto, PRO.descricao, VEI.quantidade, VEI.preco_unitario, VEI.total'+
                    '  FROM vendaitens VEI' +
                    '  JOIN Produtos PRO ON(VEI.idproduto=PRO.idproduto)';


  ctSQLVendaItemFirstOrderBy = ' ORDER BY VEI.idvenda, VEI.item ASC';

  ctSQLVendaItemOne = 'SELECT TOP 1 VEI.idvenda, VEI.item, VEI.idproduto, VEI.descricao, VEI.quantidade, VEI.preco_unitario, VEI.total'+
                       ' FROM vendas VEI' +
                       ' JOIN Produtos PRO ON(VEI.idproduto=PRO.idproduto)';

  ctSQLVendaItemFrist = ctSQLVendaItemOne + ctSQLVendaItemFirstOrderBy;

  ctSQLVendaItemWhere = ' WHERE VEI.idvenda=:idvenda'; // AND VEI.item=item';

  ctSQLVendaItemFindID = ctSQLVendaItens + ctSQLVendaItemWhere;

  ctSQLVendaItemInsert = 'INSERT INTO vendaitens(idvenda, item, idproduto, quantidade, preco_unitario, total)' +
                     ' VALUES(:idvenda, :item, :idproduto, :quantidade, :preco_unitario, :total)';

  ctSQLVendaItemUpdate = 'UPDATE vendaitens' +
                         '   SET idvenda = :idvenda, item = :item, idproduto = :idproduto, quantidade = :quantidade, preco_unitario = :preco_unitario, total = :total' +
                         ' WHERE idvenda=:idvenda AND item=:item';

  ctSQLVendaItemDelete = 'DELETE FROM vendaitens WHERE idvenda=:idvenda AND item=:item';

implementation

end.

