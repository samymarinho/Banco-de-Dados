-- ATIVIDADE VIEWS
-- UTILIZE ESSE BANCO DE DADOS E RESOLVA O QUE SE PEDE.


create database Industria;
go

use Industria;
go

create table Projeto(
id_projeto int identity(10,10) primary key not null,
orcamento float not null,
data_inicio date,
horas_trabalhadas int
);
insert into Projeto values(5000.00, GETDATE(), 125);
insert into Projeto values (10000.00, '2024-05-15', 300);

create table Departamento(
id_departamento int identity(10,10) not null primary key,
setor varchar(30) not null
);
insert into Departamento values('Administrativo');
insert into Departamento values('Recepção');
insert into Departamento values('Manutenção');
insert into Departamento values('Logistica');


Create table Funcionario(
id_funcionario int identity(10,10) primary key not null,
id_departamento int foreign key references Departamento(id_departamento),
nome varchar(30) not null,
salario float not null,
telefone varchar(14)
);
insert into Funcionario values ( 10,'Pedro', 14000.00, '63992056035');
insert into Funcionario values ( 30,'Augusto', 25000.00, '63992627895');
insert into Funcionario values ( 40,'José', 14000.00, '63992123589');
select*from Funcionario

create table projeto_funcionario(
id_projeto_funcionario int identity(10,10) not null,
id_projeto int foreign key references Projeto(id_projeto),
id_funcinario int foreign key references Funcionario(id_funcionario)
);
insert into projeto_funcionario values(20, 10);
insert into projeto_funcionario values(20, 30);
insert into projeto_funcionario values(10, 20);
insert into projeto_funcionario values(10, 30);
select*from projeto_funcionario

create table Fornecedor(
id_fornecedor int identity(10,10) primary key not null,
nome varchar(50) not null,
endereco varchar(50)
);
insert into Fornecedor values('Auto Peças', 'Rua 15, numero 16');
insert into Fornecedor values('Peças Araguaina', 'Rua 20, numero 74');
insert into Fornecedor values('Ferramentas Simão', 'Rua 25, numero 30');


create table projeto_fornecedor(
id_projeto_fornecedor int identity(10,10) not null,
id_projeto int foreign key references Projeto(id_projeto),
id_fornecedor int foreign key references Fornecedor(id_fornecedor)
);
insert into projeto_fornecedor values(20, 10);
insert into projeto_fornecedor values(20, 20);
insert into projeto_fornecedor values(10, 30);


create table Deposito(
id_deposito int identity(10,10) primary key not null,
endereco varchar(80)
);
insert into Deposito values('Endereço 50, numero 259');
insert into Deposito values('Endereço 49, numero 20');


create table Peças(
id_peca int identity(10,10) not null primary key,
id_deposito int foreign key references Deposito(id_deposito),
peso float not null,
cor varchar(20) 
);
insert into Peças values( 10,50, 'preto');
insert into Peças values(10, 30, 'vermelho' );
insert into Peças values( 10, 45, 'azul');


create table projeto_pecas(
id_projeto_pecas int identity(10,10) not null,
id_projeto int foreign key references Projeto(id_projeto),
id_peca int foreign key references Peças(id_peca)
);
insert into projeto_pecas values(20, 30);
insert into projeto_pecas values(20, 20);
insert into projeto_pecas values(10, 30);


create table fornecedor_pecas(
id_fornecedor_pecas int identity(10,10) primary key,
id_fornecedor int foreign key references Fornecedor(id_fornecedor),
id_peca int foreign key references Peças(id_peca)
);

insert into fornecedor_pecas values(20, 20);
insert into fornecedor_pecas values(20, 30);
insert into fornecedor_pecas values(10, 30);
insert into fornecedor_pecas values(30, 30);
insert into fornecedor_pecas values(30, 20);
insert into fornecedor_pecas values(30, 20);


--Criando Views

--1 - Crie uma VIEW que informe: O nome do fornecedor,
--o endereço do Fornecedor e o ID das peças que esse fornecedor fornece.
create view VW_FornecedorPecas as
select f.nome, f.endereco, p.id_peca from Fornecedor f, Peças p, fornecedor_pecas fp
where f.id_fornecedor = fp.id_fornecedor and p.id_peca = fp.id_peca;
select * from VW_FornecedorPecas

--2 - Crie uma VIEW que informe: O ID de uma peça, O peso da Peça, O ID do deposito em 
--que ela está guardada e o endereço desse deposito.
create view VW_PecaDeposito as
select p.id_peca, p.peso, d.id_deposito, d.endereco from Peças p, Deposito d
where p.id_deposito = d.id_deposito;
--para alterar é só usar o alter view VW_PecaDeposito as... ai você altera.
select*from VW_PecaDeposito

--3 - Crie uma VIEW que informe: O nome de um Funcionário, O valor do salario do 
--Funcionário e o Setor do Departamento que esse funcionário trabalha.
create view VW_FuncionarioDepartamento as
select nome, salario, setor from Funcionario f, Departamento d
where f.id_departamento = d.id_departamento
select*from VW_FuncionarioDepartamento
-- só vai ter as letras e o ponto quando a mesma coluna tiver nas duas ou mais tabela. Ex: p.id_deposito, 
--essa coluna ta na tabela peca e na tabela deposito, e para diferencia eu vou usar a letra p paras mostrar
--que eu quero a conula da tavbela peca

--4 - Crie uma VIEW que informe: O ID de uma peça, O nome do Fornecedor que fornece essa Peça e qual o Endereço
--do Deposito que essa Peça está guardada.
create view VW_FornecedorPeçaDeposito as
select p.id_peca, f.nome, d.endereco from Deposito d, Peças p, Fornecedor f, fornecedor_pecas fp
where p.id_deposito = d.id_deposito and fp.id_fornecedor = f.id_fornecedor and p.id_peca = fp.id_peca
select*from VW_FornecedorPeçaDeposito

--5 -Crie uma VIEW que informe: O ID de um Projeto, O nome do Funcionário que está em um projeto e o 
--Setor do Departamento do Funcionário.

create view VW_ProjetoFuncionariSetor as
select  p.id_projeto, nome, setor from Projeto p, Funcionario f, Departamento d, projeto_funcionario pf
where pf.id_funcinario= f.id_funcionario and pf.id_projeto = p.id_projeto and f.id_departamento = d.id_departamento
select*from VW_ProjetoFuncionariSetor

-- INNER JOIN - LEFT JOIN - RIGHT JOIN

~--INNER JOIN
select f.nome, d.setor from Funcionario f inner join Departamento d
on f.id_departamento = d.id_departamento;

--LEFT JOIN

select d.setor, f.nome from Departamento d left join Funcionario f
on f.id_departamento = d.id_departamento;

-- RIGHT JOIN

select d.setor, f.nome from Departamento d right join Funcionario f
on f.id_departamento = d.id_departamento;



