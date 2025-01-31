-- ATIVIDADE TRIGGER
--  UTILIZE O BANCO DE DADOS E RESOLVA O QUE SE PEDE.

CREATE DATABASE EmpresaDB;
GO

USE EmpresaDB;
GO

-- Criação da tabela Departamentos
CREATE TABLE Departamentos (
    DepartamentoID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL
);

INSERT INTO Departamentos VALUES ('Recursos Humanos'),
('Captação'),
('Ambulatório'),
('T.I'),
('Gestão'),
('Gerência');

SELECT * FROM Departamentos;

-- Criação da tabela Funcionarios
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

-- Criação da tabela LogAlteracoes
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
-- Questão 1 - Crie uma trigger que registre na tabela LogAlteracoes toda vez que o salário de um funcionário for alterado, salvando o salário antigo e o novo. 
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


-- Questão 2 - Crie uma trigger que impeça a inserção de funcionários com idade inferior a 18 anos e envie uma mensagem de erro personalizada ao usuário. 
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
	RAISERROR('Erro! Funcionário menor de 18 anos! Cadastro não permitido.', 1,1);
end
END;
-- TESTE
INSERT INTO Funcionarios VALUES ('Marcos', 16, 1000, 4);
-- Questão 3 - Crie uma trigger que, ao excluir um funcionário, verifique se o departamento dele não possui mais nenhum funcionário vinculado e, se sim, exclua também o departamento.
CREATE TRIGGER ExclusaoFuncDepa
on Funcionarios
AFTER DELETE 
AS
BEGIN
DECLARE @id_departamento int;
select @id_departamento = DepartamentoID from deleted; 
IF NOT EXISTS (select 1 from Funcionarios where DepartamentoID = @id_departamento)
Begin
	RAISERROR ('O departamento foi excluído', 1,1);
delete from Departamentos where DepartamentoID = @id_departamento;
end

END;
-- TESTE
DELETE FROM Funcionarios WHERE FuncionarioID = 5;
select * FROM Funcionarios;
select * FROM Departamentos;