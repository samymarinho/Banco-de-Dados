-- ATIVIDADE TRIGGER
--  UTILIZE O BANCO DE DADOS E RESOLVA O QUE SE PEDE.

CREATE DATABASE EmpresaDB;
GO

USE EmpresaDB;
GO

-- Cria��o da tabela Departamentos
CREATE TABLE Departamentos (
    DepartamentoID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL
);

INSERT INTO Departamentos VALUES ('Recursos Humanos'),
('Capta��o'),
('Ambulat�rio'),
('T.I'),
('Gest�o'),
('Ger�ncia');

SELECT * FROM Departamentos;

-- Cria��o da tabela Funcionarios
CREATE TABLE Funcionarios (
    FuncionarioID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Idade INT NOT NULL,
    Salario money NOT NULL,
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

INSERT INTO Funcionarios VALUES ('Ketlen', 25, 11000, 5),
('Sara', 20, 10000, 4),
('Beatriz', 23, 6000, 6),
('Fantasma', 80, 20000, 7);
SELECT*FROM Funcionarios;

-- Cria��o da tabela LogAlteracoes
CREATE TABLE LogAlteracoes (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    FuncionarioID INT NOT NULL,
    DataAlteracao DATETIME NOT NULL DEFAULT GETDATE(),
    SalarioAntigo money,
    SalarioNovo money,
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(FuncionarioID)
);

SELECT*FROM LogAlteracoes;

-- CRIE SUAS TRIGGERS AQUI 
-- Quest�o 1 - Crie uma trigger que registre na tabela LogAlteracoes toda vez que o sal�rio de um funcion�rio for alterado, salvando o sal�rio antigo e o novo. 
CREATE TRIGGER AlterarSalario
on Funcionarios
AFTER UPDATE
AS
BEGIN
DECLARE @id_funcionario int, @SalarioAntigo money, @SalarioNovo money;
select @id_funcionario =  FuncionarioID from inserted;
select @SalarioAntigo = Salario from deleted;
select @SalarioNovo = Salario from inserted;
INSERT INTO LogAlteracoes (FuncionarioID, SalarioAntigo, SalarioNovo) VALUES (@id_funcionario, @SalarioAntigo, @SalarioNovo);

END;

-- TESTE                                 
UPDATE Funcionarios SET Salario = 20000 WHERE FuncionarioID = 2;
select * from Funcionarios;
select * from LogAlteracoes;


-- Quest�o 2 - Crie uma trigger que impe�a a inser��o de funcion�rios com idade inferior a 18 anos e envie uma mensagem de erro personalizada ao usu�rio. 
CREATE TRIGGER TR_Menos18
on Funcionarios
FOR INSERT
AS 
BEGIN
DECLARE @Idade int, @id_funcionario int;
select @Idade = Idade from inserted;
select @id_funcionario = FuncionarioID from inserted;

if (@Idade < 18)
begin
	ROLLBACK TRANSACTION;
	RAISERROR('Erro! Funcion�rio menor de 18 anos! Cadastro n�o permitido.', 1,1);
end
END;
-- TESTE
INSERT INTO Funcionarios VALUES ('Marcos', 16, 1000, 4);
-- Quest�o 3 - Crie uma trigger que, ao excluir um funcion�rio, verifique se o departamento dele n�o possui mais nenhum funcion�rio vinculado e, se sim, exclua tamb�m o departamento.
CREATE TRIGGER ExclusaoFuncDepa
on Funcionarios
AFTER DELETE 
AS
BEGIN
DECLARE @id_departamento int;
select @id_departamento = DepartamentoID from deleted; 
IF NOT EXISTS (select 1 from Funcionarios where DepartamentoID = @id_departamento)
Begin
	RAISERROR ('O departamento foi exclu�do', 1,1);
delete from Departamentos where DepartamentoID = @id_departamento;
end

END;
-- TESTE
DELETE FROM Funcionarios WHERE FuncionarioID = 5;
select * FROM Funcionarios;
select * FROM Departamentos;