-- Criar as tabelas do desafio
-- Aplicar conforme o planejamento de banco feito na semana

CREATE DATABASE desafio
USE desafio

CREATE TABLE faixa  (
    id INT PRIMARY KEY IDENTITY(1,1),
    cor VARCHAR(20) NOT NULL UNIQUE,
    grau INT
)


CREATE TABLE professor (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    data_contratacao DATE DEFAULT GETDATE(),
    id_faixa INT FOREIGN KEY REFERENCES faixa(id),
    ativo BIT DEFAULT 1
)

CREATE TABLE aluno (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    data_matricula DATE DEFAULT GETDATE(),
    id_faixa INT FOREIGN KEY REFERENCES faixa(id),
    ativo BIT DEFAULT 1
)

CREATE TABLE mensalidade (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_aluno INT FOREIGN KEY REFERENCES aluno(id),
    mes_referencia TINYINT NOT NULL,
    ano SMALLINT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    status_pagamento BIT DEFAULT 0
)

CREATE TABLE turma (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(50) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    id_professor INT FOREIGN KEY REFERENCES professor(id)
)

CREATE TABLE exame (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_aluno INT FOREIGN KEY REFERENCES aluno(id),
    id_faixa_atual INT FOREIGN KEY REFERENCES faixa(id),
    id_faixa_nova INT FOREIGN KEY REFERENCES faixa(id),
    id_professor INT FOREIGN KEY REFERENCES professor(id),
    data_exame DATE NOT NULL,
    aprovado BIT NOT NULL
)

CREATE TABLE matricula (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_aluno INT FOREIGN KEY REFERENCES aluno(id),
    id_turma INT FOREIGN KEY REFERENCES turma(id),
    data_matricula DATE DEFAULT GETDATE()
)

CREATE TABLE competicao (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    data DATE NOT NULL,
    local VARCHAR(100) NOT NULL
)

CREATE TABLE aula (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_turma INT FOREIGN KEY REFERENCES turma(id),
    data DATE NOT NULL,
)

CREATE TABLE presenca (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_aluno INT FOREIGN KEY REFERENCES aluno(id),
    id_aula INT FOREIGN KEY REFERENCES aula(id),
    presente BIT NOT NULL
)

CREATE TABLE inscricao_competicao (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_competicao INT FOREIGN KEY REFERENCES competicao(id),
    id_aluno INT FOREIGN KEY REFERENCES aluno(id),
    categoria VARCHAR(50) NOT NULL,
    colocacao INT,
)