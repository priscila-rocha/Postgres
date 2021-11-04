create role professores nocreatedb nocreaterole inherit nologin nobypassrls connection limit 10; -- criando uma role professores, com nenhuma permissão
alter role professores password 'priscila'; -- criando senha para role professores
create role priscila login password 'priscila'; -- criando uma role sem estar interligada com outra
drop role priscila; -- excluindo uma role
create role priscila login password 'priscila' role professores; -- criando uma role com as permissões da role professores
create table teste (nome varchar); -- cirando tabela com tipo de campo
grant all on table teste to professores; -- dando todas as permissões na tabela teste, para role professores
create role priscila login password 'priscila'; -- criando role sem nenhuma role associada
create role priscila inherit login password 'priscila' in role professores;
revoke professores from priscila; -- rirando as permissões da role

