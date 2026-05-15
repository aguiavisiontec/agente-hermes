<p align="center">
  <img src="assets/banner.png" alt="Agente Hermes" width="100%">
</p>

# Agente Hermes ☤

<p align="center">
  <a href="https://github.com/aguiavisiontec/agente-hermes"><img src="https://img.shields.io/badge/Docs-GitHub-FFD700?style=for-the-badge" alt="Documentação"></a>
  <a href="https://discord.gg/NousResearch"><img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord"></a>
  <a href="https://github.com/aguiavisiontec/agente-hermes/blob/main/LICENSE"><img src="https://img.shields.io/badge/Licen%C3%A7a-MIT-green?style=for-the-badge" alt="Licença: MIT"></a>
  <a href="https://github.com/aguiavisiontec"><img src="https://img.shields.io/badge/Mantido%20por-Aguiavision%20Tecnologia-blueviolet?style=for-the-badge" alt="Mantido por Aguiavision Tecnologia"></a>
  <a href="README.zh-CN.md"><img src="https://img.shields.io/badge/Lang-中文-red?style=for-the-badge" alt="中文"></a>
</p>

**O agente de IA com auto-aprimoramento — cria habilidades a partir da experiência, melhora-as durante o uso, e roda em qualquer lugar**

> **Fork:** Este projeto é um fork do [hermes-agent](https://github.com/NousResearch/hermes-agent) v0.13.0, mantido pela [Aguiavision Tecnologia (Aguiavitech)](https://github.com/aguiavisiontec) com o português brasileiro como idioma nativo. O repositório original foi criado pela [Nous Research](https://nousresearch.com); esta versão adapta o projeto para a comunidade brasileira com documentação, suporte e identidade visual em pt-BR.

Use qualquer modelo que desejar — [Nous Portal](https://portal.nousresearch.com), [OpenRouter](https://openrouter.ai) (200+ modelos), [NVIDIA NIM](https://build.nvidia.com) (Nemotron), [Xiaomi MiMo](https://platform.xiaomimimo.com), [z.ai/GLM](https://z.ai), [Kimi/Moonshot](https://platform.moonshot.ai), [MiniMax](https://www.minimax.io), [Hugging Face](https://huggingface.co), OpenAI, ou seu próprio endpoint. Troque com `hermes model` — sem mudança de código, sem lock-in.

<table>
<tr><td><b>Interface de terminal de verdade</b></td><td>TUI completa com edição multilinha, autocompletar de comandos com barra, histórico de conversas, interrupção-e-redirecionamento e saída de ferramentas em streaming.</td></tr>
<tr><td><b>Vive onde você vive</b></td><td>Telegram, Discord, Slack, WhatsApp, Signal e CLI — tudo a partir de um único processo de gateway. Transcrição de memorandos de voz, continuidade de conversas entre plataformas.</td></tr>
<tr><td><b>Um ciclo fechado de aprendizado</b></td><td>Memória curada pelo agente com lembretes periódicos. Criação autônoma de habilidades após tarefas complexas. Habilidades se auto-aprimoram durante o uso. Busca de sessões FTS5 com sumarização via LLM para recuperação entre sessões. Modelagem de usuário dialética <a href="https://github.com/plastic-labs/honcho">Honcho</a>. Compatível com o padrão aberto <a href="https://agentskills.io">agentskills.io</a>.</td></tr>
<tr><td><b>Automações agendadas</b></td><td>Agendador cron integrado com entrega em qualquer plataforma. Relatórios diários, backups noturnos, auditorias semanais — tudo em linguagem natural, rodando sem supervisão.</td></tr>
<tr><td><b>Delega e paraleliza</b></td><td>Gere subagentes isolados para fluxos de trabalho paralelos. Escreva scripts Python que chamam ferramentas via RPC, colapsando pipelines de múltiplas etapas em turnos com custo de contexto zero.</td></tr>
<tr><td><b>Roda em qualquer lugar, não apenas no seu notebook</b></td><td>Sete backends de terminal — local, Docker, SSH, Singularity, Modal, Daytona e Vercel Sandbox. Daytona e Modal oferecem persistência serverless — o ambiente do seu agente hiberna quando ocioso e desperta sob demanda, custando quase nada entre sessões. Rode em uma VPS de US$ 5 ou em um cluster de GPU.</td></tr>
<tr><td><b>Pronto para pesquisa</b></td><td>Geração de trajetórias em lote, ambientes Atropos RL, compressão de trajetórias para treinar a próxima geração de modelos com chamada de ferramentas.</td></tr>
</table>

---

## Instalação Rápida

```bash
curl -fsSL https://raw.githubusercontent.com/aguiavisiontec/agente-hermes/main/scripts/install.sh | bash
```

Funciona no Linux, macOS, WSL2 e Android via Termux. O instalador cuida da configuração específica de cada plataforma.

> **Android / Termux:** O caminho manual testado está documentado no [guia Termux](https://github.com/aguiavisiontec/agente-hermes). No Termux, o Hermes instala a extensão curada `.[termux]` porque a extensão completa `.[all]` atualmente puxa dependências de voz incompatíveis com Android.
>
> **Windows:** Windows nativo não é suportado. Por favor, instale o [WSL2](https://learn.microsoft.com/pt-br/windows/wsl/install) e execute o comando acima.

Após a instalação:

```bash
source ~/.bashrc    # recarregue o shell (ou: source ~/.zshrc)
hermes              # comece a conversar!
```

---

## Primeiros Passos

```bash
hermes              # CLI interativo — inicie uma conversa
hermes model        # Escolha seu provedor e modelo LLM
hermes tools        # Configure quais ferramentas estão habilitadas
hermes config set   # Defina valores individuais de configuração
hermes gateway      # Inicie o gateway de mensagens (Telegram, Discord, etc.)
hermes setup        # Execute o assistente de configuração completo (configura tudo de uma vez)
hermes claw migrate # Migre do OpenClaw (se estiver vindo do OpenClaw)
hermes update       # Atualize para a versão mais recente
hermes doctor       # Diagnostique quaisquer problemas
```

📖 **[Documentação completa →](https://github.com/aguiavisiontec/agente-hermes)**

## Referência Rápida: CLI vs Mensageiros

O Hermes tem dois pontos de entrada: inicie a interface de terminal com `hermes`, ou rode o gateway e converse pelo Telegram, Discord, Slack, WhatsApp, Signal ou Email. Depois de entrar em uma conversa, muitos comandos com barra são compartilhados entre ambas as interfaces.

| Ação | CLI | Plataformas de mensagens |
|---------|-----|---------------------|
| Começar a conversar | `hermes` | Execute `hermes gateway setup` + `hermes gateway start`, então envie uma mensagem ao bot |
| Iniciar conversa nova | `/new` ou `/reset` | `/new` ou `/reset` |
| Trocar modelo | `/model [provider:model]` | `/model [provider:model]` |
| Definir personalidade | `/personality [name]` | `/personality [name]` |
| Retentar ou desfazer o último turno | `/retry`, `/undo` | `/retry`, `/undo` |
| Comprimir contexto / ver uso | `/compress`, `/usage`, `/insights [--days N]` | `/compress`, `/usage`, `/insights [days]` |
| Navegar habilidades | `/skills` ou `/<skill-name>` | `/<skill-name>` |
| Interromper trabalho atual | `Ctrl+C` ou envie uma nova mensagem | `/stop` ou envie uma nova mensagem |
| Status específico da plataforma | `/platforms` | `/status`, `/sethome` |

Para a lista completa de comandos, consulte o [guia CLI](https://github.com/aguiavisiontec/agente-hermes) e o [guia do Gateway de Mensagens](https://github.com/aguiavisiontec/agente-hermes).

---

## Documentação

Toda a documentação está disponível em **[github.com/aguiavisiontec/agente-hermes](https://github.com/aguiavisiontec/agente-hermes)**:

| Seção | O que é abordado |
|---------|---------------|
| [Início rápido](https://github.com/aguiavisiontec/agente-hermes) | Instalar → configurar → primeira conversa em 2 minutos |
| [Uso do CLI](https://github.com/aguiavisiontec/agente-hermes) | Comandos, atalhos de teclado, personalidades, sessões |
| [Configuração](https://github.com/aguiavisiontec/agente-hermes) | Arquivo de configuração, provedores, modelos, todas as opções |
| [Gateway de Mensagens](https://github.com/aguiavisiontec/agente-hermes) | Telegram, Discord, Slack, WhatsApp, Signal, Home Assistant |
| [Segurança](https://github.com/aguiavisiontec/agente-hermes) | Aprovação de comandos, emparelhamento DM, isolamento de container |
| [Ferramentas e Toolsets](https://github.com/aguiavisiontec/agente-hermes) | 40+ ferramentas, sistema de toolsets, backends de terminal |
| [Sistema de Habilidades](https://github.com/aguiavisiontec/agente-hermes) | Memória procedural, Skills Hub, criação de habilidades |
| [Memória](https://github.com/aguiavisiontec/agente-hermes) | Memória persistente, perfis de usuário, melhores práticas |
| [Integração MCP](https://github.com/aguiavisiontec/agente-hermes) | Conecte qualquer servidor MCP para capacidades estendidas |
| [Agendamento Cron](https://github.com/aguiavisiontec/agente-hermes) | Tarefas agendadas com entrega por plataforma |
| [Arquivos de Contexto](https://github.com/aguiavisiontec/agente-hermes) | Contexto de projeto que molda cada conversa |
| [Arquitetura](https://github.com/aguiavisiontec/agente-hermes) | Estrutura do projeto, loop do agente, classes principais |
| [Contribuindo](https://github.com/aguiavisiontec/agente-hermes) | Configuração de desenvolvimento, processo de PR, estilo de código |
| [Referência CLI](https://github.com/aguiavisiontec/agente-hermes) | Todos os comandos e flags |
| [Variáveis de Ambiente](https://github.com/aguiavisiontec/agente-hermes) | Referência completa de variáveis de ambiente |

---

## Migrando do OpenClaw

Se você está vindo do OpenClaw, o Hermes pode importar automaticamente suas configurações, memórias, habilidades e chaves de API.

**Durante a primeira configuração:** O assistente de configuração (`hermes setup`) detecta automaticamente `~/.openclaw` e oferece a migração antes que a configuração comece.

**A qualquer momento após a instalação:**

```bash
hermes claw migrate              # Migração interativa (preset completo)
hermes claw migrate --dry-run    # Pré-visualizar o que seria migrado
hermes claw migrate --preset user-data   # Migrar sem segredos
hermes claw migrate --overwrite  # Sobrescrever conflitos existentes
```

O que é importado:
- **SOUL.md** — arquivo de persona
- **Memórias** — entradas MEMORY.md e USER.md
- **Habilidades** — habilidades criadas pelo usuário → `~/.hermes/skills/openclaw-imports/`
- **Lista de comandos permitidos** — padrões de aprovação
- **Configurações de mensagens** — configurações de plataforma, usuários permitidos, diretório de trabalho
- **Chaves de API** — segredos permitidos (Telegram, OpenRouter, OpenAI, Anthropic, ElevenLabs)
- **Ativos de TTS** — arquivos de áudio do workspace
- **Instruções do workspace** — AGENTS.md (com `--workspace-target`)

Veja `hermes claw migrate --help` para todas as opções, ou use a habilidade `openclaw-migration` para uma migração interativa guiada pelo agente com pré-visualizações de dry-run.

---

## Contribuindo

Contribuições são bem-vindas! Veja o [Guia de Contribuição](https://github.com/aguiavisiontec/agente-hermes/blob/main/CONTRIBUTING.md) para configuração de desenvolvimento, estilo de código e processo de PR.

Início rápido para contribuidores — clone e execute com `setup-hermes.sh`:

```bash
git clone https://github.com/aguiavisiontec/agente-hermes.git
cd agente-hermes
./setup-hermes.sh     # instala uv, cria venv, instala .[all], cria symlink ~/.local/bin/hermes
./hermes              # auto-detecta o venv, não precisa de `source` antes
```

Caminho manual (equivalente ao acima):

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv venv .venv --python 3.11
source .venv/bin/activate
uv pip install -e ".[all,dev]"
scripts/run_tests.sh
```

> **Treinamento RL (opcional):** A integração RL/Atropos (`environments/`) — veja [`CONTRIBUTING.md`](https://github.com/aguiavisiontec/agente-hermes/blob/main/CONTRIBUTING.md) para a configuração completa.

---

## Comunidade

- 💬 [Discord](https://discord.gg/NousResearch)
- 📚 [Skills Hub](https://agentskills.io)
- 🐛 [Issues](https://github.com/aguiavisiontec/agente-hermes/issues)
- 🔌 [HermesClaw](https://github.com/AaronWong1999/hermesclaw) — Ponte WeChat da comunidade: rode o Agente Hermes e o OpenClaw na mesma conta WeChat.

---

## Licença

MIT — veja [LICENSE](LICENSE).

Mantido por [Aguiavision Tecnologia](https://github.com/aguiavisiontec). Fork do [hermes-agent](https://github.com/NousResearch/hermes-agent) da [Nous Research](https://nousresearch.com).
