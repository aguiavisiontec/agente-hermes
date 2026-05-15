<img width="100%" alt="AGENTE IA AGUIAVITECH" src="https://github.com/user-attachments/assets/80585955-3bae-4aee-af90-a1e61757ccb8" />

<br/>
<p align="center">
  <a href="https://aguiavisiontec.cloud"><img src="https://img.shields.io/badge/Site-Aguiavision_Tecnologia-FFD700?style=for-the-badge" alt="Aguiavision Tecnologia"></a>
  <a href="https://github.com/aguiavisiontec/agente-hermes/releases/"><img src="https://img.shields.io/badge/Download-Releases-FF6600?style=for-the-badge" alt="Releases"></a>
  <a href="https://github.com/aguiavisiontec/agente-hermes/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License: MIT"></a>
</p>

> **Agente IA Aguiavitech** — Versão brasileira do [Hermes Desktop](https://github.com/fathah/hermes-desktop) com idioma nativo pt-BR, branding personalizado e deploy Docker para VPS. Baseado no [Hermes Agent v0.13.0](https://github.com/NousResearch/hermes-agent/releases/tag/v2026.5.7) (The Tenacity Release).

## Idiomas

- Português (Brasil): `README.md` (este arquivo)
- 简体中文: `README.zh-CN.md`

O Agente IA Aguiavitech é um aplicativo desktop nativo para instalar, configurar e conversar com o [Hermes Agent](https://github.com/NousResearch/hermes-agent) — um assistente de IA com auto-aprimoramento, uso de ferramentas, mensageria multi-plataforma e ciclo de aprendizado fechado.

Em vez de gerenciar a CLI manualmente, o app guia você pela instalação, configuração de provedores e uso diário em um único lugar. Ele utiliza o script oficial de instalação do Hermes, armazena os dados em `~/.hermes`, e oferece uma GUI para chat, sessões, perfis, memória, habilidades, ferramentas, agendamentos, gateways de mensageria e mais.

### Diferenciais da Versão

- **Idioma pt-BR como padrão** — toda a interface em português brasileiro nativo
- **Branding Aguiavision Tecnologia** — identidade visual personalizada
- **Deploy Docker para VPS** — configuração completa com `docker-compose.yml` e `entrypoint.sh`
- **Skills customizadas** — skill-creator, frontend-design, playwright-mcp pré-instaladas
- **SOUL.md com persona Aguiavision** — personalidade do agente em pt-BR
- **Segurança atualizada** — todas as correções de segurança do upstream incluídas

## Instalação

Baixe a versão mais recente na página de [Releases](https://github.com/aguiavisiontec/agente-hermes/releases/).

| Plataforma     | Arquivo                 |
| -------------- | ----------------------- |
| macOS          | `.dmg`                  |
| Linux (any)    | `.AppImage`             |
| Linux (Debian) | `.deb`                  |
| Linux (Fedora) | `.rpm`                  |
| Windows        | `.exe` (NSIS installer) |

> **Usuários Windows:** O instalador não é assinado com código. O Windows SmartScreen avisará na primeira execução — clique em "Mais informações" → "Executar mesmo assim".

> **Usuários WSL:** Se o instalador travar em `Switching to root user to install dependencies...`, o Playwright está esperando uma senha sudo que não tem TTY para ler. Conceda sudo sem senha para a instalação e reverta quando terminar.

### Fedora (RPM)

```bash
sudo dnf install ./agente-aguiavitech-<version>.rpm
```

### macOS

```bash
xattr -cr "/Applications/Agente IA Aguiavitech.app"
```

## Deploy Docker para VPS

Para implantar em um servidor VPS com Docker:

```bash
# Clone o repositório
git clone https://github.com/aguiavisiontec/agente-hermes.git
cd agente-hermes/deploy

# Configure as variáveis de ambiente
cp .env.example .env
# Edite o .env com suas chaves de API

# Inicie os containers
docker-compose up -d
```

Consulte o [DEPLOY.md](deploy/DEPLOY.md) para instruções detalhadas.

## Funcionalidades

- **Instalação guiada** do Hermes Agent com rastreamento de progresso e resolução de dependências
- **Backend local ou remoto** — execute o Hermes localmente ou conecte a um servidor remoto
- **Suporte multi-provedor** — OpenRouter, Anthropic, OpenAI, Google (Gemini), xAI, Groq, Ollama e mais
- **Chat com streaming** — SSE streaming, indicadores de progresso de ferramentas, renderização markdown e syntax highlighting
- **Rastreamento de uso de tokens** — contagens de tokens e custo em tempo real
- **Comandos slash** — `/new`, `/clear`, `/fast`, `/web`, `/image`, `/browse`, `/code`, `/shell`, `/usage`, `/help` e mais
- **Gerenciamento de sessões** — busca full-text, histórico agrupado por data, retomada de conversas
- **Perfis isolados** — crie e alterne entre ambientes Hermes com configuração isolada
- **14 toolsets** — web, browser, terminal, arquivo, execução de código, visão, geração de imagem, TTS, skills, memória e mais
- **Sistema de memória** — visualize/edite entradas de memória, perfil do usuário, provedores de memória avançados
- **Editor de persona** — edite e resete a personalidade SOUL.md do agente
- **Tarefas agendadas** — construtor de cron jobs com 15 alvos de entrega
- **16 gateways de mensageria** — Telegram, Discord, Slack, WhatsApp, Signal, Matrix e mais
- **Backup, importação e debug** — backup/restauração completa e diagnósticos do sistema
- **Atualização automática** — verifique e instale atualizações via electron-updater
- **i18n** — interface traduzida em pt-BR, en, es, id, zh-CN
- **Segurança endurecida** — sandbox ativo, URL allowlisting, webview hardening, redaction ON por padrão

## Tela

| Tela           | Descrição                                                                      |
| -------------- | ------------------------------------------------------------------------------ |
| **Chat**       | Conversação com streaming, comandos slash, progresso de ferramentas e tokens   |
| **Sessões**    | Navegue, busque e retome conversas anteriores                                  |
| **Perfis**     | Crie, delete e alterne entre perfis do Hermes                                  |
| **Habilidades**| Navegue, instale e gerencie habilidades                                        |
| **Modelos**    | Gerencie configurações de modelo por provedor                                  |
| **Memória**    | Visualize/edite memória, perfil do usuário e configure provedores de memória   |
| **Persona**    | Edite a persona do perfil ativo (SOUL.md)                                      |
| **Ferramentas**| Ative ou desative toolsets individuais                                         |
| **Agendamentos**| Crie e gerencie cron jobs com alvos de entrega                                |
| **Gateway**    | Configure e controle integrações de plataformas de mensageria                  |
| **Escritório** | Interface visual Claw3d                                                        |
| **Configurações**| Config do provedor, pools de credenciais, backup/import, logs, tema           |

## Provedores Suportados

### Provedores LLM

| Provedor            | Observações                              |
| ------------------- | ---------------------------------------- |
| **OpenRouter**      | 200+ modelos via API única (recomendado) |
| **Anthropic**       | Acesso direto ao Claude                  |
| **OpenAI**          | Acesso direto ao GPT                     |
| **Google (Gemini)** | Google AI Studio                         |
| **xAI (Grok)**      | Modelos Grok                             |
| **Groq**            | Inferência rápida                        |
| **Local/Custom**    | Qualquer endpoint compatível com OpenAI  |

Presets locais incluídos para LM Studio, Ollama, vLLM e llama.cpp.

## Desenvolvimento

### Pré-requisitos

- Node.js e npm
- Ambiente shell Unix-like para o instalador do Hermes
- Acesso à rede para download do Hermes durante a primeira execução

### Instalar dependências

```bash
npm install
```

### Iniciar o app em desenvolvimento

```bash
npm run dev
```

### Executar verificações

```bash
npm run lint
npm run typecheck
npm run test
```

### Build do app desktop

```bash
npm run build
npm run build:mac
npm run build:win
npm run build:linux
```

## Stack Tecnológica

- **Electron** 39 — shell desktop multi-plataforma
- **React** 19 — framework UI
- **TypeScript** 5.9 — tipagem estática nos processos main e renderer
- **Tailwind CSS** 4 — estilização utility-first
- **Vite** 7 + electron-vite — dev server rápido e build tooling
- **better-sqlite3** — armazenamento local de sessões com FTS5 full-text search
- **i18next** — framework de internacionalização
- **Vitest** — test runner

## Notas

- O app desktop depende do projeto upstream Hermes Agent para comportamento do agente e execução de ferramentas.
- O instalador embutido executa o script oficial de instalação do Hermes com `--skip-setup`, depois completa a configuração do provedor na GUI.
- Provedores de modelos locais não exigem chave de API, mas o servidor compatível deve estar em execução.

## Créditos

- Baseado no [Hermes Desktop](https://github.com/fathah/hermes-desktop) por fathah
- Motor de agente: [Hermes Agent](https://github.com/NousResearch/hermes-agent) por NousResearch
- Adaptação e customização: [Aguiavision Tecnologia](https://aguiavisiontec.cloud)

## Licença

MIT — veja o arquivo [LICENSE](LICENSE) para detalhes.
