# Banco de Dados SCTEC

Exercícios e desafios de banco de dados SQL Server desenvolvidos durante o curso.

## Estrutura do projeto

O repositório contém os scripts SQL de estudo e a modelagem da escola de jiu-jitsu usada como base do desafio.

## Exercícios

| Arquivo | Tema | Apontamento |
| --- | --- | --- |
| `exercicio1.sql` | Fundamentos de DDL | Cria e seleciona bancos (`CREATE DATABASE`/`USE`), cria tabelas com `PRIMARY KEY`, `FOREIGN KEY` e chave composta, e usa `ALTER TABLE` para adicionar e remover colunas. |

## Modelagem

| Arquivo | Formato | Apontamento |
| --- | --- | --- |
| `modelo_escola_jiu_jitsu.mmd` | Mermaid (renderizável) | Mesma modelagem em texto, com layout automático (sem linhas sobrepostas). Visualizar no [mermaid.live](https://mermaid.live/) ou no GitHub. |

Tabelas do modelo: `Faixa`, `Professor`, `Aluno`, `Turma`, `Aula`, `Matricula`, `Presenca`, `Exame`, `Mensalidade`, `Competicao`, `Inscricao_Competicao`. Relacionamentos N:N são resolvidos pelas tabelas associativas `Matricula`, `Presenca` e `Inscricao_Competicao`.

```mermaid
erDiagram

    FAIXA ||--o{ PROFESSOR : "possui (1 : N)"
    FAIXA ||--o{ ALUNO : "possui (1 : N)"
    FAIXA ||--o{ EXAME : "define (1 : N)"
    PROFESSOR ||--o{ TURMA : "ministra (1 : N)"
    PROFESSOR ||--o{ EXAME : "avalia (1 : N)"
    ALUNO ||--o{ MATRICULA : "registra (1 : N)"
    TURMA ||--o{ MATRICULA : "recebe (1 : N)"
    TURMA ||--o{ AULA : "gera (1 : N)"
    AULA ||--o{ PRESENCA : "registra (1 : N)"
    ALUNO ||--o{ PRESENCA : "frequenta (1 : N)"
    ALUNO ||--o{ EXAME : "presta (1 : N)"
    ALUNO ||--o{ MENSALIDADE : "paga (1 : N)"
    COMPETICAO ||--o{ INSCRICAO_COMPETICAO : "recebe (1 : N)"
    ALUNO ||--o{ INSCRICAO_COMPETICAO : "faz (1 : N)"

    FAIXA {
        int id PK
        varchar(50) nome UK
        int grau
    }

    PROFESSOR {
        int id PK
        varchar(100) nome
        char(11) cpf UK
        varchar(15) telefone
        varchar(100) email
        date data_contratacao
        int id_faixa FK
        bit ativo
    }

    ALUNO {
        int id PK
        varchar(100) nome
        char(11) cpf UK
        date data_nascimento
        varchar(15) telefone
        varchar(100) email
        date data_matricula
        int id_faixa FK
        bit ativo
    }

    MENSALIDADE {
        int id PK
        int id_aluno FK
        tinyint mes_referencia
        smallint ano
        decimal(8,2) valor
        date data_vencimento
        date data_pagamento
        bit status_pagamento
    }

    TURMA {
        int id PK
        varchar(50) nome
        time hora_inicio
        time hora_fim
        int id_professor FK
    }

    EXAME {
        int id PK
        int id_aluno FK
        int id_faixa_anterior FK
        int id_faixa_nova FK
        int id_professor FK
        date data_exame
        bit aprovado
    }

    MATRICULA {
        int id PK
        int id_aluno FK
        int id_turma FK
        date data_matricula
    }

    COMPETICAO {
        int id PK
        varchar(100) nome
        date data_competicao
        varchar(100) local_competicao
    }

    AULA {
        int id PK
        int id_turma FK
        date data_aula
    }

    PRESENCA {
        int id PK
        int id_aluno FK
        int id_aula FK
        bit presente
    }

    INSCRICAO_COMPETICAO {
        int id PK
        int id_competicao FK
        int id_aluno FK
        varchar(50) categoria
        int colocacao
    }
```

## Desafio

| Arquivo | Tema | Apontamento |
| --- | --- | --- |
| `desafio.sql` | Banco da escola de jiu-jitsu | Aplicar a modelagem da escola de jiu-jitsu (`modelo_escola_jiu_jitsu.drawio`/`.mmd`): criar as tabelas com chaves, `CHECK`, `DEFAULT`, `UNIQUE` e `FOREIGN KEY` conforme o planejamento. |
