unit uModel.ConstsStatement;

interface

const
  ctRowsAffected = 1;

  ctSQLCurrentGeneratedValue = 'SELECT COALESCE(@@IDENTITY, 0) AS currentID';

  ctSQLClientes = 'SELECT idcliente, nome, cpf, status FROM Clientes';

  ctSQLFornecedores = 'SELECT idfornecedor, nome_fantasia, razao_social, cnpj, status FROM Fornecedores';

  ctSQLVendas = 'SELECT ven.idvenda, ven.dthr_venda, ven.idcliente, cli.nome AS nome_cliente, '+
                '   ven.total, ven.status'+
                ' FROM' +
                '   vendas ven INNER JOIN clientes cli ON(ven.idcliente = cli.idcliente)';

  ctSQLVendaWhere = ' WHERE idvenda = :idvenda ';

  ctSQLVendaInsert = 'INSERT INTO vendas(idvenda, dthr_venda, idcliente, total, status)' +
                     ' VALUES(:idvenda, :dthr_venda, :idcliente, :total, :status)';


  ctSQLVendaUpdate = 'UPDATE vendas ' +
                   '   SET dthr_venda = :dthr_venda, idcliente = :idcliente, total = :total, status = status '+
                   ctSQLVendaWhere;

  ctSQLVendaFindID =  ctSQLVendas + ctSQLVendaWhere;

  ctSQLVendaDelete = 'DELETE FROM vendas ' +
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

implementation

end.

