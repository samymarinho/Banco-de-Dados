
-- ATIVIDADE JOIN
-- DE ACORDO COM ESSE BANCO DE DADOS E RESOLVA O QUE SE PEDE.
create database Mercado;
go
use Mercado;
go

create table Cliente(
id_cliente int identity(10, 3) not null primary key,
Nome_cliente varchar(30),
telefone varchar(15)
);
insert into Cliente values('Joao', '63992856352');
insert into Cliente values('Augusto', '63992858596');
insert into Cliente values('Lucas', '63992854152');
insert into Cliente values('Pedro', '63992851263');
insert into Cliente values('Larissa', '63992852015');
insert into Cliente values('Bruce Wayne', '63992000000');


create table Produto(
id_produto int identity(10, 5) not null primary key,
nome_produto varchar(50),
preço float
);
insert into Produto values('Cuscuz', 5.99);
insert into Produto values('Feijao', 9.99);
insert into Produto values('Biscoito', 2.99);
insert into Produto values('Biscoito', 2.99);
insert into Produto values('Arroz', 24.99);
insert into Produto values('Oléo', 5.99);
insert into Produto values('Açucar', 6.99);
insert into Produto values('Kriptonita', 0.99);


create table Vendas(
id_vendas int identity(10,6) not null primary key,
id_cliente int foreign key references Cliente(id_cliente),
id_produto int foreign key references Produto(id_produto),
valor_total float not null,
quantidade int not null
);
insert into Vendas values(10, 10, 11.98, 2);
insert into Vendas values(13, 25, 2.99, 1);
insert into Vendas values(19, 35, 11.98, 2);
insert into Vendas values(16, 20, 5.98, 2);
insert into Vendas values(22, 40, 6.99, 1);
insert into Vendas values(25, 45, 14.85, 15);


select * from Cliente;
select * from Produto;
select * from Vendas;


-- 1 - Crie um comando select utilizando o right join, dando preferencia a tabela produto, que retorne o nome de todos os produtos, o id da venda e o valor total da compra realizada.
SELECT 
v.id_vendas,
p.nome_produto,
v.valor_total
FROM Produto p RIGHT JOIN Vendas v
on v.id_produto = p.id_produto; 

-- 2 - Crie um comando select utilizando o left join, dando prioridade a tabela Cliente, que retorne o nome de todos os clientes e o valor total da compra que eles já realizaram.
SELECT 
c.id_cliente,
c.nome_cliente,
v.valor_total
FROM Cliente c LEFT JOIN Vendas v
on v.id_cliente = c.id_cliente;

-- 3 - Crie um select utilizando o inner join que retorne o nome de todos os clientes, o nome dos produtos e o valor total das compras realizada.

SELECT 
c.nome_cliente,
p.nome_produto,
v.valor_total
FROM Cliente c INNER JOIN Vendas v
on v.id_cliente = c.id_cliente INNER JOIN Produto p
on p.id_produto = v.id_produto;
