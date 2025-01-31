
-- ATIVIDADE SELECT
--  UTILIZE O BANCO DE DADOS E RESOLVA O QUE SE PEDE.

-- Comando para criar a database 
create database Dados;

-- Comando para usar Database selecionada
use Dados;

-- Comando para criar uma tabela
create table Pessoas(
id int not null identity(10,10),  
nome varchar(50) not null, 
cpf varchar(11) not null, 
endereco varchar(100), 
data_nasc date 
);


-- Insert das informações na tabela
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Joao Vitor','79288458069','Rua ciclano, numero 5','2008-12-29');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Pedro Lucas','79288454210','Rua ciclano, numero 21', '2010-05-30');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Pedro Lucas','79288457854','Rua ciclano, numero 10', '2001-12-24');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Rafael','79288451026','Rua ciclano, numero 20', '2001-08-30');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('José Fernando','25683451026','Rua Fulano, numero35', '2000-01-01');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Pedro Henrique','33358380092','Rua ciclano, numero 5','2014-03-06');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Antonio Ferreira','22637697067','Rua ciclano, numero 21', '1991-05-24');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('José lucas','52998168043','Rua ciclano, numero 10', '2023-07-25');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Rafaela Aquino','40413014088','Rua ciclano, numero 20', '2017-05-20');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Lara Cibele','37720272021','Rua Fulano, numero35', '2012-12-20');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Henrique Vitor','60929113020','Rua ciclano, numero 5','2021-08-30');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Clark Kent','66306970061','Rua ciclano, numero 21', '2010-05-30');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Nemias Santos','12177869021','Rua ciclano, numero 10', '2017-07-21');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Antonio Pereira','41665090049','Rua ciclano, numero 20', '1995-11-30');
insert into Pessoas(nome,cpf,endereco, data_nasc) values ('Kamilla Silva','44464542000','Rua Fulano, numero35', '2008-04-29');


-- Realize select das informações 

-- Utilizando do comando SELECT, realize o que é pedido a seguir: 

-- Escreva um comando select que retorne todos os registros ordenados por nome.
SELECT * FROM Pessoas order by nome asc; -- (A - Z)

-- Escreva um comando select que retorne todos os registros ordenados por data de nascimento em ordem decrescente.
SELECT * FROM Pessoas order by nome desc; -- (A - Z)

-- Escreva um comando select que retorne a contagem de quantos nomes diferentes tem cadastrado.
SELECT COUNT (distinct(nome)) FROM Pessoas;

-- Escreva um comando select que retorne todos os registros com datas de nascimento antes de 2000-01-01
SELECT * FROM Pessoas WHERE data_nasc < '2000-01-01';

-- Escreva um comando select que retorne todos os registros com datas de nascimento depois de 2000-01-01    
SELECT * FROM Pessoas WHERE data_nasc > '2000-01-01';

-- Escreva um comando select que retorne todos os registros com datas de nascimento depois de 2010-01-01 e que o nome comece com a letra A.
SELECT * FROM Pessoas WHERE data_nasc > '2010-01-01' and nome like 'A%';

-- Escreva um comando select que retorne todos os registros com datas de nascimento antes de 2010-01-01 ou que o nome comece com a letra C.
SELECT * FROM Pessoas WHERE data_nasc > '2010-01-01' or nome like 'C%';

-- Escreva um comando select que retorne todos os registros com o nome iniciado com a letra P.
SELECT * FROM Pessoas WHERE nome like 'P%';

-- Escreva um comando select que retorne todos os registros com a letra R em seu nome.
SELECT * FROM Pessoas WHERE nome like '%P%';

-- Escreva um comando select que retorne todos os registros com a data de nascimento entre 2005-01-01 e 2010-01-01.
SELECT * FROM Pessoas WHERE data_nasc between '2005-01-01' and '2010-01-01';

-- Escreva um comando select que retorne as seguintes colunas: nome, data_nasc e uma outra coluna que informe a idade do usuário em anos. Use o comando datediff() e nomeie a coluna para "idade".
SELECT
nome as 'Nome',
data_nasc as 'Nascimento', 
DATEDIFF (YY, data_nasc, GETDATE()) as 'idade' FROM Pessoas;

-- Escreva um comando select que retorne as seguintes colunas: nome, data_nasc e uma outra coluna que informe a idade do usuário em anos ordenados do maior para o menor. Use o comando datediff() e nomeie a coluna para "idade".
SELECT
nome as 'Nome',
data_nasc as 'Nascimento', 
DATEDIFF (YY, data_nasc, GETDATE()) as 'idade'
FROM Pessoas ORDER BY 'idade' desc;