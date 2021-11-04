SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;


-- SELECT COM WITH STATEMENTS
WITH tbl_tmp_banco AS ( -- apelido para a tabela temporaria
	SELECT numero, nome FROM banco --pegando os campos da tabela original
)
SELECT numero, nome -- realizando um select dentro da tabela temporaria.
FROM tbl_tmp_banco;


WITH clientes_e_transacoes AS (
	SELECT  cliente.nome AS cliente_nome,
			tipo_transacao.nome AS tipo_transacoes_nome,
			cliente_transacoes.valor AS tipo_transacoes_valor
	FROM cliente_transacoes
	JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
) 

SELECT cliente_nome, tipo_transacoes_nome, tipo_transacoes_valor
FROM clientes_e_transacoes;

WITH clientes_e_transacoes AS (
	SELECT  cliente.nome AS cliente_nome,
			tipo_transacao.nome AS tipo_transacao_nome,
			cliente_transacoes.valor AS tipo_transacao_valor
	FROM cliente_transacoes
	JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	JOIN banco ON banco.numero = cliente_transacoes.banco_numero AND banco.nome ILIKE '%Itaú%'
	--WHERE banco.nome = '%itau%' -- pode ser usado dessa forma tbm
) 

SELECT cliente_nome, tipo_transacao_nome, tipo_transacao_valor
FROM clientes_e_transacoes;

select nome FROM banco;


-- Após os AS é o apelido dado a tabela ou nome da coluna.


-- SELECT COM WITH STATEMENTS - COM PARAMETRO

WITH params AS( -- apelido para tabela temporaria
	SELECT 213 AS banco_numero -- parametro para consulta (somente os bancos com numero 213)
), tbl_tmp_banco AS (
	SELECT numero, nome
	FROM banco
	JOIN params ON params.banco_numero = banco.numero
)
SELECT numero, nome 
FROM tbl_tmp_banco;



-- SELECT COM SUB SELECT

SELECT banco.numero, banco.nome
FROM banco
JOIN (
	SELECT 213 AS banco_numero
) params ON params.banco_numero = banco.numero;