CREATE DATABASE NetCodersLadies

USE NetCodersLadies

-- CRIAÇÃO DE QUERYES DE UM SISTEMA DE ESTOQUE DE PRODUTOS

CREATE TABLE Produto(
 idProduto INT PRIMARY KEY IDENTITY,
 NomeProduto VARCHAR(100) NOT NULL,
 Preco DECIMAL(10) NOT NULL,

);

CREATE TABLE Estoque(
 idEstoque INT PRIMARY KEY IDENTITY,
 idProduto INT NOT NULL,
 PrecoProdutoComprado DECIMAL(10,2),
 QuantidadeEstoque INT  NOT NULL DEFAULT 0,
 FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

INSERT INTO Produto(NomeProduto,Preco) VALUES ('Lápis', 3.00);
INSERT INTO Estoque(idProduto,PrecoProdutoComprado,QuantidadeEstoque) VALUES (1, 1.50, 1000);

SELECT COUNT(*) FROM Produto
CREATE PROCEDURE AtualizaPreco
	AS BEGIN
-- DECLARE = DECLARAR VARIAVEL
-- NOME VARIAVEL, NORMALMENTE COM @
-- E O TIPO DA VARIAVEL NA FINAL
   DECLARE @idProduto INT;
-- SET
	SET @idProduto =1;
WHILE (SELECT COUNT(*)FROM Produto WHERE idProduto = @idProduto)>0
	BEGIN

	   UPDATE Produto
	   SET Preco = (SELECT PrecoProdutoComprado 
	   FROM Estoque  WHERE idProduto = @idProduto) * 2.0 

	   WHERE idProduto = @idProduto
	   SET @idProduto = @idProduto + 1;

	END

END

-- TRIGGER ATUALIZA PRECO PRODUTO
CREATE TRIGGER trg_AtualizaValorProduto
	ON Estoque AFTER UPDATE
	AS
	EXECUTE AtualizaPreco

UPDATE Estoque
SET PrecoProdutoComprado = 10.50

SELECT * FROM Produto

