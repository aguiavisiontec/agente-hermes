---
name: skill-creator
description: "Use quando o usuario quiser criar, editar ou gerenciar skills do agente. Cria SKILL.md com frontmatter valido, estrutura de diretorio e validacao."
version: 1.0.0
author: Aguiavision Solucoes Tecnologicas com IA
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [skills, authoring, creation, meta, skill-management, aguiavitech]
    related_skills: [plan, writing-plans]
---

# Skill Creator — Criador de Skills do Agente

## Visao Geral

Este skill permite que o agente crie, edite e gerencie outras skills de forma autonoma. Uma skill e um arquivo SKILL.md que contem instrucoes procedurais reutilizaveis — conhecimento sobre *como fazer* um tipo especifico de tarefa. Skills sao a memoria procedural do agente: capturam fluxos de trabalho comprovados que podem ser reutilizados em conversas futuras.

O Skill Creator segue rigorosamente o formato padrao do hermes-agent, garantindo que toda skill criada seja valida, bem estruturada e pronta para uso imediato.

## Quando Usar

Use este skill quando:
- O usuario pedir para "criar uma skill" ou "adicionar uma skill" ao agente
- O usuario quiser automatizar um fluxo de trabalho recorrente como skill
- O usuario descrever um padrao de tarefa que merece ser preservado como skill
- O usuario quiser editar ou melhorar uma skill existente
- O usuario quiser organizar skills em categorias

**Nao use para:**
- Memoria declarativa geral (use MEMORY.md / USER.md)
- Comandos simples que nao precisam de instrucoes detalhadas
- Tarefas pontuais que nao se repetem

## Formato Obrigatorio do SKILL.md

Toda skill DEVE seguir este formato:

```markdown
---
name: nome-da-skill
description: "Descricao clara do que a skill faz e quando usar. Maximo 1024 caracteres."
version: 1.0.0
author: Nome do Autor
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [tag1, tag2, tag3]
    related_skills: [skill-relacionada]
---

# Titulo da Skill

## Visao Geral
Paragrafos explicando o que a skill faz e por que existe.

## Quando Usar
- Gatilhos que indicam quando esta skill deve ser ativada
- Contra-gatilhos: "Nao use para: ..."

## Topicos Especificos
- Tabelas de referencia rapida
- Blocos de codigo com comandos exatos
- Receitas e workflows passo a passo

## Erros Comuns
Lista numerada de erros tipicos e como evita-los.

## Checklist de Verificacao
- [ ] Lista de verificacoes pos-criacao
```

## Regras de Validacao

O validador do hermes-agent impoe estas regras obrigatorias:

1. **Frontmatter obrigatorio**: O arquivo DEVE comecar com `---` no byte 0 (sem linhas em branco antes)
2. **Fechamento obrigatorio**: O frontmatter DEVE fechar com `\n---\n` antes do corpo
3. **Campos obrigatorios**: `name` e `description` DEVEM estar presentes
4. **Limite do nome**: Maximo 64 caracteres, minusculas e hifens apenas
5. **Limite da descricao**: Maximo 1024 caracteres
6. **Corpo nao-vazio**: Deve haver conteudo apos o fechamento do frontmatter
7. **Tamanho total**: Maximo 100.000 caracteres (~36k tokens)
8. **Tamanho ideal**: Entre 8.000 e 15.000 caracteres para melhor equilibrio

## Estrutura de Diretorio

Skills do usuario ficam em:

```
~/.hermes/skills/
├── minha-skill/
│   ├── SKILL.md          # Arquivo principal (obrigatorio)
│   ├── references/       # Documentos de referencia adicionais
│   ├── templates/        # Templates reutilizaveis
│   ├── scripts/          # Scripts auxiliares
│   └── assets/           # Imagens e outros recursos
└── categoria/
    └── outra-skill/
        └── SKILL.md
```

Categorias existentes no repositorio: `autonomous-ai-agents`, `creative`, `data-science`, `devops`, `dogfood`, `email`, `gaming`, `github`, `mcp`, `media`, `mlops`, `note-taking`, `productivity`, `red-teaming`, `research`, `smart-home`, `social-media`, `software-development`.

Escolha a categoria mais proxima. Nao crie novas categorias de nivel superior sem necessidade.

## Workflow de Criacao de Skill

### Passo 1: Coletar Requisitos

Antes de criar, pergunte ao usuario:
- Qual e o proposito da skill?
- Quais situacoes devem ativa-la? (gatilhos)
- Quais situacoes NAO devem ativa-la? (contra-gatilhos)
- Ha alguma skill existente similar? (verificar com `skill_view` ou `skills_list`)
- Quais tags sao relevantes?

### Passo 2: Verificar Skills Existentes

Liste skills na categoria alvo:
```
ls ~/.hermes/skills/<categoria>/
```
Leia 2-3 skills similares para alinhar tom e estrutura.

### Passo 3: Criar o Diretorio

```
mkdir -p ~/.hermes/skills/<categoria>/<nome-da-skill>/
```

### Passo 4: Escrever o SKILL.md

Use `write_file` ou `skill_manage(action='create')` para criar o arquivo. Garanta que:
- O frontmatter comeca no byte 0 com `---`
- Todos os campos obrigatorios estao presentes
- A descricao e especifica e comeca com "Use quando..."
- O corpo segue a estrutura peer-matched
- O conteudo e substancial (minimo 3.000 caracteres)

### Passo 5: Validar

Execute a validacao:
```python
import yaml, re, pathlib
content = pathlib.Path("~/.hermes/skills/<categoria>/<nome>/SKILL.md").read_text()
assert content.startswith("---")
m = re.search(r'\n---\s*\n', content[3:])
fm = yaml.safe_load(content[3:m.start()+3])
assert "name" in fm and "description" in fm
assert len(fm["description"]) <= 1024
assert len(content) <= 100_000
```

### Passo 6: Confirmar com o Usuario

Apresente a skill criada e pergunte se precisa de ajustes.

## Boas Praticas para Descricoes

Descricoes eficazes comecam com "Use quando..." e descrevem a classe de gatilho:

| Ruim | Bom |
|------|-----|
| "Skill de design" | "Use quando o usuario precisar criar interfaces visuais, prototipos HTML ou componentes de UI." |
| "Skill para debug" | "Use quando o usuario relatar erros de codigo e precisar de diagnostico sistematico." |
| "Skill de automacao" | "Use quando o usuario quiser automatizar tarefas repetitivas no browser ou em APIs." |

## Erros Comuns

1. **Espaco em branco antes do `---`**: O validador verifica `content.startswith("---")`; qualquer linha em branco antes falha a validacao.

2. **Descricao generica demais**: "Skill para X" nao e suficiente. Descreva os gatilhos especificos.

3. **Esquecer o bloco metadata**: Nao e obrigatorio pelo validador, mas toda skill profissional tem. Omitir faz a skill parecer incompleta.

4. **Duplicar skill existente**: Antes de criar, verifique se ja existe uma skill similar. Prefira estender uma existente a criar uma nova limitada.

5. **Esperar que a sessao atual veja a nova skill**: O carregador de skills e inicializado no inicio da sessao. A nova skill so estara disponivel em sessoes futuras.

6. **Nome com espacos ou maiusculas**: Use apenas minusculas e hifens. `minha-skill` esta correto; `Minha Skill` falha.

7. **Descricao ultrapassando 1024 caracteres**: O validador rejeita. Seja conciso mas especifico.

## Checklist de Verificacao

- [ ] Arquivo esta em `~/.hermes/skills/<categoria>/<nome>/SKILL.md`
- [ ] Frontmatter comeca no byte 0 com `---`, fecha com `\n---\n`
- [ ] Campos `name`, `description`, `version`, `author`, `license`, `metadata.hermes.{tags, related_skills}` presentes
- [ ] Nome com ate 64 caracteres, minusculas e hifens
- [ ] Descricao com ate 1024 caracteres e comeca com "Use quando..."
- [ ] Arquivo total com ate 100.000 caracteres (ideal: 8.000-15.000)
- [ ] Estrutura: `# Titulo` → `## Visao Geral` → `## Quando Usar` → corpo → `## Erros Comuns` → `## Checklist de Verificacao`
- [ ] Tags relevantes no metadata
- [ ] Skills relacionadas referenciadas em related_skills

## Receitas Rapidas

### Criar skill de fluxo de trabalho
```
1. Identificar o fluxo recorrente
2. Documentar os passos exatos
3. Adicionar gatilhos e contra-gatilhos
4. Incluir exemplos de codigo/comandos
5. Adicionar erros comuns e verificacoes
```

### Criar skill de integracao
```
1. Documentar a API/ferramenta alvo
2. Incluir exemplos de autenticacao
3. Listar operacoes comuns com codigo
4. Adicionar tratamento de erros especifico
5. Referenciar documentacao externa em references/
```

### Criar skill de analise
```
1. Definir o tipo de analise
2. Documentar metodologia passo a passo
3. Incluir templates de saida
4. Adicionar criterios de qualidade
5. Referenciar ferramentas necessarias
```
