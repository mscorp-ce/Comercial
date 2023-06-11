CREATE DATABASE Montreal;

USE Montreal;


CREATE TABLE Clientes(
idcliente int not null identity(1,1),
nome varchar(100) not null,
cpf varchar(11) not null,
status char(1) not null default 'A',
data_de_nascimento date not null,
CONSTRAINT UNQ_cpf UNIQUE(cpf),
CONSTRAINT CHK_status CHECK (status in('A', 'I')),
CONSTRAINT PK_Clientes PRIMARY KEY(idcliente)
);


CREATE SEQUENCE SEQ_CLIENTES 
 AS NUMERIC
 START WITH 1
 INCREMENT BY 1;


CREATE TABLE Fornecedores(
idfornecedor int not null,
nome_fantasia varchar(100) not null,
razao_social varchar(255) not null,
cnpj varchar(14) not null,
status char(1) not null default 'A',
CONSTRAINT UNQ_cnpj UNIQUE(cnpj),
CONSTRAINT CHK_status_For CHECK (status in('A', 'I')),
CONSTRAINT PK_Fornecedores PRIMARY KEY(idfornecedor)
);


CREATE SEQUENCE SEQ_FORNECEDORES 
 AS NUMERIC
 START WITH 1
 INCREMENT BY 1;


CREATE TABLE Produtos(
idproduto int not null,
descricao varchar(255) not null,
idfornecedor int not null,
preco_unitario numeric(15,2) not null,
status char(1) not null default 'A',
CONSTRAINT CHK_status_Pro CHECK (status in('A', 'I')),
CONSTRAINT FK_idfornecedor_Pro FOREIGN KEY(idfornecedor) REFERENCES Fornecedores(idfornecedor),
CONSTRAINT PK_Produtos PRIMARY KEY(idproduto)
);


CREATE SEQUENCE SEQ_PRODUTOS 
 AS NUMERIC
 START WITH 1
 INCREMENT BY 1;


CREATE TABLE Vendas(
idvenda int not null,
dthr_venda DateTime not null,
idcliente int not null,
total numeric(15,2) default 0,
status char(1) not null default 'P', 
CONSTRAINT FK_idcliente_Ven FOREIGN KEY(idcliente) REFERENCES Clientes(idcliente),
CONSTRAINT CHK_status_Ven CHECK (status in('P', 'E')),
CONSTRAINT PK_Vendas PRIMARY KEY(idvenda)
);


CREATE SEQUENCE SEQ_VENDAS 
 AS NUMERIC
 START WITH 1
 INCREMENT BY 1;


CREATE TABLE Vendaitens(
idvenda int not null,
item int not null,
idproduto int not null,
quantidade numeric(15,2) not null,
preco_unitario numeric(15,2) not null,
total numeric(15,2) not null,
CONSTRAINT FK_idproduto_Ven FOREIGN KEY(idproduto) REFERENCES produtos(idproduto),
CONSTRAINT FK_idvenda_Ven FOREIGN KEY(idvenda) REFERENCES vendas(idvenda),
CONSTRAINT PK_Vendaitens PRIMARY KEY(idvenda, item)
);

CREATE FUNCTION FUN_GET_PROXIMO_ITEM_Vendaitens(@idvenda INT) RETURNS INT
AS
BEGIN
  DECLARE @item INT;

  SELECT @item = COALESCE(MAX(ITEM), 0) + 1 
    FROM Vendaitens VEI
   WHERE VEI.idvenda = @idvenda;

  RETURN @item;
END
GO

