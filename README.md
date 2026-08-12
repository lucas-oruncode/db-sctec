# db-sctec

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
        int id_faixa PK
        varchar(50) nome UK
        int grau
    }
    PROFESSOR {
        int id_professor PK
        varchar(100) nome
        char(11) cpf UK
        varchar(15) telefone
        varchar(100) email
        date data_contratacao
        int id_faixa FK
        char(1) status
    }
    ALUNO {
        int id_aluno PK
        varchar(100) nome
        char(11) cpf UK
        date data_nascimento
        varchar(15) telefone
        varchar(100) email
        date data_matricula
        int id_faixa FK
        char(1) status
    }
    MENSALIDADE {
        int id_mensalidade PK
        int id_aluno FK
        tinyint mes_referencia
        smallint ano
        decimal(8,2) valor
        date data_vencimento
        date data_pagamento
        char(1) status
    }
    TURMA {
        int id_turma PK
        varchar(50) nome
        tinyint dia_semana
        time hora_inicio
        time hora_fim
        int id_professor FK
    }
    EXAME {
        int id_exame PK
        int id_aluno FK
        int id_faixa_anterior FK
        int id_faixa_nova FK
        int id_professor FK
        date data_exame
        decimal(5,2) nota
        bit aprovado
    }
    MATRICULA {
        int id_matricula PK
        int id_aluno FK
        int id_turma FK
        date data_matricula
    }
    COMPETICAO {
        int id_competicao PK
        varchar(100) nome
        date data
        varchar(100) local
    }
    AULA {
        int id_aula PK
        int id_turma FK
        date data
        varchar(100) assunto
    }
    PRESENCA {
        int id_presenca PK
        int id_aluno FK
        int id_aula FK
        bit presente
    }
    INSCRICAO_COMPETICAO {
        int id_inscricao PK
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

## Como executar

Abra os scripts no SQL Server Management Studio (SSMS) ou no Azure Data Studio e execute com `F5`. Para o desafio, crie as tabelas na ordem das dependências: `Faixa` -> `Professor` e `Aluno` -> `Turma` -> `Aula` -> `Matricula`, `Presenca` e `Exame` -> `Mensalidade` -> `Competicao` -> `Inscricao_Competicao`.
