-- Select simples
SELECT numero, nome, ativo FROM banco ORDER BY numero;

-- Update simples
UPDATE banco SET ativo = false WHERE numero = 0;


BEGIN; -- Iniciando uma transação
UPDATE banco SET ativo = TRUE WHERE numero = 0; -- Setando o campo ativo
SELECT numero, nome, ativo FROM banco WHERE numero = 0; -- Conferindo se alterou
ROLLBACK; -- Voltando ao estado original


BEGIN; -- Iniciando uma transação
UPDATE banco SET ativo = TRUE WHERE numero = 0; -- Setando o campo ativo
COMMIT; -- Confirmando a transação

SELECT id, gerente, nome FROM funcionarios;

BEGIN; -- Iniciando uma transação
UPDATE funcionarios SET gerente = 2 WHERE id = 3; -- Alterando o gerente do Magno de 1 para 2
SAVEPOINT sf_func; -- Criando um save point
UPDATE funcionarios SET gerente = null; -- Setando todas as linhas pro mesmo gerente (update sem where)
ROLLBACK TO sf_func; -- Retornando ao save point
UPDATE funcionarios SET gerente = 3 WHERE id = 5; -- Alterando o gerente do Wagner de 4 para 3
COMMIT; -- Confirmando a transação