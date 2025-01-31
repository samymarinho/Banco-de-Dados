-- UTILIZE O BANCO DE DADOS DA ATIVIDADE PARA RESPONDER AS QUEST�ES A SEGUIR

-- ATIVIDADE PROCEDURE
CREATE DATABASE EmpresaDB;
GO

USE EmpresaDB;
GO

-- Cria��o da tabela Departamentos
CREATE TABLE Departamentos (
    DepartamentoID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL
);

-- Cria��o da tabela Funcionarios
CREATE TABLE Funcionarios (
    FuncionarioID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Idade INT NOT NULL,
    Salario money NOT NULL,
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

-- Cria��o da tabela LogAlteracoes
CREATE TABLE LogAlteracoes (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    FuncionarioID INT NOT NULL,
    DataAlteracao DATETIME NOT NULL DEFAULT GETDATE(),
    SalarioAntigo money,
    SalarioNovo money,
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(FuncionarioID)
);



-- 1 - Crie uma Stored procedure que receba o DepartamentoID como par�metro e retorne todos os funcion�rios pertencentes a esse departamento.  
CREATE PROCEDURE ST_RetornarFuncionarios
@DepartamendoID int
AS
BEGIN
	SELECT * FROM Funcionarios WHERE DepartamentoID = @DepartamendoID  
END;

EXEC ST_RetornarFuncionarios 6;
SELECT * FROM Departamentos

-- 2 -Crie uma procedure que receba o FuncionarioID e o novo sal�rio como par�metros e atualize o sal�rio do funcion�rio correspondente. -- 
CREATE PROCEDURE ST_SalarioFuncionario
@id_funcionario int,
@Salario money
as
begin
UPDATE Funcionarios SET Salario = @Salario WHERE FuncionarioID = @id_funcionario;
end;

EXEC ST_SalarioFuncionario 4,2000;
SELECT * FROM Funcionarios

-- 3 - Crie uma procedure que receba os seguintes par�metros: Nome, Idade, Salario e DepartamentoID.
-- A procedure deve verificar se o DepartamentoID informado existe antes de inserir o novo funcion�rio. Se o departamento n�o existir, 
-- a inser��o deve ser impedida, e uma mensagem de erro deve ser exibida.
CREATE PROCEDURE ST_VerificarDepartamento
@Nome VARCHAR (100),
@Idade int,
@Salario money,
@DepartamentoID int
as
begin
IF NOT EXISTS (SELECT * FROM Departamentos WHERE DepartamentoID like @DepartamentoID)
begin
	RAISERROR('Erro! Departamento n�o existe!', 16, 1);
		end
ELSE 
begin
INSERT INTO Funcionarios VALUES (@Nome, @Idade, @Salario, @DepartamentoID);
end
end;
EXEC ST_VerificarDepartamento 'Saraa', 90, 2888, 5;
SELECT * FROM Departamentos;
SELECT * FROM Funcionarios;
atividadeprocedure.sql
Exibindo atividadeprocedure.sql�
Atividade 7 - STORED PROCEDURE
JOAO VITOR PEREIRA MORAIS
�
Ontem
100 pontos
UTILIZE O BANCO DE DADOS DA ATIVIDADE ANTERIOR PARA RESPONDER AS QUEST�ES A SEGUIR
1 - Crie uma Stored procedure que receba o DepartamentoID como par�metro e retorne todos os funcion�rios pertencentes a esse departamento.  


2 -Crie uma procedure que receba o FuncionarioID e o novo sal�rio como par�metros e atualize o sal�rio do funcion�rio correspondente. 

3 - Crie uma procedure que receba os seguintes par�metros: Nome, Idade, Salario e DepartamentoID.
A procedure deve verificar se o DepartamentoID informado existe antes de inserir o novo funcion�rio. Se o departamento n�o existir, a inser��o deve ser impedida, e uma mensagem de erro deve ser exibida.
Coment�rios da turma
