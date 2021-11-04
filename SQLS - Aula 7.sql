-- SELECT normal
SELECT numero, nome, ativo
FROM banco;

-- CRIANDO UMA VIEW simples
CREATE OR REPLACE VIEW vw_bancos AS (
	SELECT numero, nome, ativo
	FROM banco
);

-- Executando um select numa view simples
SELECT numero, nome, ativo
FROM vw_bancos;

-- Criando uma segunda viu da mesma tabela com apelidos para as colunas

CREATE OR REPLACE VIEW vw_bancos_2 (banco_numero, banco_nome, banco_ativo) AS(
	SELECT numero, nome, ativo
	FROM banco
);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos_2;

-- Inserindo dados na tabela
INSERT INTO vw_bancos_2 (banco_numero, banco_nome, banco_ativo)
VALUES (51, 'Banco Boa Ideia', TRUE);

-- Conferindo se os dados foram inseridos corretamente através de uma view

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos_2
WHERE banco_numero = 51;

-- Conferindo se os dados foram inseridos corretamente diretamente no banco
SELECT numero, nome, ativo
FROM banco
WHERE numero = 51

-- Setando o banco como inativo
UPDATE vw_bancos_2 SET banco_ativo = false
WHERE banco_numero = 51

-- Conferindo se os dados foram inseridos corretamente diretamente no banco
SELECT numero, nome, ativo
FROM banco
WHERE ativo is false

-- Deletando o banco pela view pelo numero
DELETE FROM vw_bancos_2 
WHERE banco_numero = 51

-- Deletando o banco pela view pelo status

DELETE FROM vw_bancos_2 
WHERE banco_ativo is false;

-- Criando uma view temporaria
CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
	SELECT nome FROM agencia
);
-- Testando na mesma sessão deu certo e testado em uma nova e não funcionou.
SELECT nome 
FROM vw_agencia;

-- Criando uma view com a opção de WITH LOCAL CHECK OPTION (essa opção obriga a validação da condição TRUE dentro do create)
CREATE OR REPLACE VIEW vw_bancos_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo is TRUE
)WITH LOCAL CHECK OPTION;

-- Criando uma view sem a opção de WITH LOCAL CHECK OPTION, fazendo com que possa ser incluido um registro com o ativo FALSE.
CREATE OR REPLACE VIEW vw_bancos_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo is TRUE
);

-- Incluindo um dado com o Ativo FALSE (pra testar a view criada com a opção WITH LOCAL CHECK OPTION)
INSERT INTO vw_bancos_ativos (numero, nome, ativo) VALUES (51, 'Banco Boa Ideia', FALSE);

-- Criando uma view para buscar bancos iniciados com A
CREATE OR REPLACE VIEW vw_bancos_com_a AS (
	SELECT numero, nome, ativo
	FROM vw_bancos_ativos
	where NOME ILIKE 'a%'
) WITH LOCAL CHECK OPTION;

-- Select pra visualizar os bancos iniciados com A, mas não existe nenhum
SELECT numero, nome, ativo FROM vw_bancos_com_a;

-- Incluindo um dado com o campo ativo TRUE, foi incluido com sucesso
INSERT INTO vw_bancos_com_a (numero, nome, ativo) VALUES (10, 'American Express', TRUE)

-- Incluindo um dado com o campo ativo TRUE, não foi incluido com sucesso, pois a view foi criada com a opção WITH LOCAL CHECK OPTION, porem depois foi tirada a a opção e a inserção dos dados foi possivel
INSERT INTO vw_bancos_com_a (numero, nome, ativo) VALUES (130, 'American DINERS Club', TRUE)

-- Alterando uma view com a opção WITH CASCADE CHECK OPTION, pois ela valida todas as condições da view atual e das anteriores, não sendo possivel a inclusão de um banco com o campo ativo FALSE.
CREATE OR REPLACE VIEW vw_bancos_com_a AS (
	SELECT numero, nome, ativo
	FROM vw_bancos_ativos
	where NOME ILIKE 'a%'
) WITH CASCADED CHECK OPTION;

-- Criando uma view RECURSIVA

CREATE TABLE IF NOT EXISTS funcionarios (
	id SERIAL, 
	nome VARCHAR(50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES funcionarios (id)
);

-- Inserindo 
INSERT INTO funcionarios (nome, gerente) VALUES ('Anselmo', null);
INSERT INTO funcionarios (nome, gerente) VALUES ('Beatriz', 1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Magno', 1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Cremilda', 2);
INSERT INTO funcionarios (nome, gerente) VALUES ('Wagner', 4);

SELECT id, nome, gerente 
FROM funcionarios;

SELECT id, nome, gerente  FROM funcionarios WHERE gerente is null
UNION ALL
SELECT id, nome, gerente FROM funcionarios WHERE gerente = 999; -- apenas para exemplificar

CREATE OR REPLACE RECURSIVE VIEW vw_func (id, gerente, funcionario) AS(
	SELECT id, gerente, nome
	FROM funcionarios
	WHERE gerente IS NULL
	
	UNION ALL
	
	SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
	FROM funcionarios
	JOIN vw_func ON vw_func.id = funcionarios.gerente
);

SELECT id, gerente, funcionario
FROM vw_func;

