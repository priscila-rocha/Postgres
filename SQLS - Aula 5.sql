-- SELECT SIMPLES

SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome FROM cliente;
SELECT banco_numero, agencia_numero, numero, digito, cliente_numero FROM conta_corrente;
SELECT id, nome FROM tipo_transacao;
SELECT banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero, valor FROM cliente_transacoes;

SELECT count(1) FROM banco; -- 151 
/* é colocado o numero 1 dentro do counto, pois eu quero apenas contar a quantidade, se eu colocar de outra forma, ele trará todas as linhas da tabela e não apenas uma somatoria total dos campos / SELECT 1 FROM agencia; */
SELECT nome FROM banco;
SELECT count(1) FROM agencia; --296

SELECT * FROM agencia;

-- SELECT COM JOIN

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;

SELECT banco.numero
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;
-- traz todas a linhas

SELECT count (banco.numero), banco.nome
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero
GROUP BY banco.numero;
-- traz a quantidade de agencias, por banco

SELECT banco.numero, banco.nome
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero
GROUP BY banco.numero;
-- traz todos os banco que possuem agencia

SELECT count (distinct banco.numero)
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;
-- Traz a quantidade de banco que possuem agencia

-- SELECT COM LEFT JOIN

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
LEFT JOIN agencia ON agencia.banco_numero = banco.numero;
-- Traz todos os campos da tabela da esquerda (primeira tabela), junto com a relação na tabela da direita, caso não haja uma relação entre elas, traz o campo com a informação NULL

-- SELECT COM RIGHT JOIN

SELECT agencia.numero, agencia.nome, banco.numero, banco.nome
FROM agencia
RIGHT JOIN banco ON banco.numero = agencia.banco_numero;
-- Traz todos os campos da tabela da direita (segunda tabela), junto com a relação na tabela da esquerdda, caso não haja uma relação entre elas, traz o campo com a informação NULL

-- SELECT FULL JOIN

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
FULL JOIN agencia ON agencia.banco_numero = banco.numero;
-- Traz todas as linhas das duas tabelas.

-- SELECT CROSS JOIN

SELECT tbl_a.valor, tbl_b.valor -- tbl_a é um apelido pra a tabela A e tbl_b é um apelido para a tabela B
FROM teste_a tbl_a
CROSS JOIN teste_b tbl_b;
-- Traz todos os campos interligados com as duas tabelas, criando uma matriz.

-- CRIANDO UM JOIN COMPLETO

SELECT  banco.nome,
		agencia.nome,
		conta_corrente.numero,
		conta_corrente.digito,
		cliente.nome
FROM banco -- até aqui está informando quais campos serão exibidos
JOIN agencia ON agencia.banco_numero = banco.numero 
JOIN conta_corrente 
	-- ON conta_corrente.banco_numero = agencia.banco_numero -- pode ser dessa forma ou da de baixo, pois tem relação na tabela banco tbm
	ON conta_corrente.banco_numero = banco.numero
	AND conta_corrente.agencia_numero = agencia.numero
JOIN cliente
	ON cliente.numero = conta_corrente.cliente_numero;
	
/* ********* CAMPOS DAS TABELAS RELACIONADAS ACIMA  *********
** banco
id, numero, nome

**agencia
id, banco_numero, numero, nome

**conta_corrente
id, banco_numero, agencia_numero, numero, digito, cliente_numero

**cliente
id, numero, nome, email
*/

-- Criação de tabela pra teste CROSS JOIN
CREATE TABLE IF NOT EXISTS teste_a (id serial primary key, valor varchar(10))
CREATE TABLE IF NOT EXISTS teste_b (id serial primary key, valor varchar(10))


-- Populando tabela pra test do CROSS JOIN
INSERT INTO teste_a (valor) VALUES ('teste1');
INSERT INTO teste_a (valor) VALUES ('teste2');
INSERT INTO teste_a (valor) VALUES ('teste3');
INSERT INTO teste_a (valor) VALUES ('teste4');

INSERT INTO teste_b (valor) VALUES ('teste_a');
INSERT INTO teste_b (valor) VALUES ('teste_b');
INSERT INTO teste_b (valor) VALUES ('teste_c');
INSERT INTO teste_b (valor) VALUES ('teste_d'); 

-- Excluindo tabelas de teste do CROSS JOIN

DROP TABLE IF EXISTS teste_a;
DROP TABLE IF EXISTS teste_b;


-- 