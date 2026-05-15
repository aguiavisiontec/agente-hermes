<img width="100%" alt="AGENTE IA AGUIAVITECH" src="https://github.com/user-attachments/assets/80585955-3bae-4aee-af90-a1e61757ccb8" />

<br/>
<p align="center">
  <a href="https://github.com/aguiavisiontec/agente-hermes/blob/main/LICENSE"><img src="https://img.shields.io/badge/Licen%C3%A7a-MIT-green?style=for-the-badge" alt="Licença: MIT"></a>
  <a href="https://github.com/aguiavisiontec/agente-hermes/releases/"><img src="https://img.shields.io/badge/Download-Releases-FF6600?style=for-the-badge" alt="Releases"></a>
<a href="https://github.com/aguiavisiontec/agente-hermes/stargazers">
  <img src="https://img.shields.io/github/stars/aguiavisiontec/agente-hermes?style=for-the-badge&color=FFD700&label=Estrelas" alt="Estrelas">
</a>
  <a href="https://github.com/aguiavisiontec/agente-hermes/releases/">
  <img src="https://img.shields.io/github/downloads/aguiavisiontec/agente-hermes/total?style=for-the-badge&color=00B496&label=Downloads%20Totais" alt="Downloads">
</a>
</p>

> **Este projeto está em desenvolvimento ativo.** Funcionalidades podem mudar e algumas coisas podem quebrar. Se você encontrar um problema ou tiver uma ideia, [abra uma issue](https://github.com/aguiavisiontec/agente-hermes/issues). Contribuições são bem-vindas!

## Idiomas

- Português Brasileiro: `README.md`

Agente IA Aguiavitech é um app desktop nativo para instalar, configurar e conversar com o [Agente Hermes](https://github.com/NousResearch/hermes-agent) — um assistente de IA com auto-aprimoramento, uso de ferramentas, mensageria multi-plataforma e ciclo de aprendizado fechado.

Em vez de gerenciar o CLI manualmente, o app guia você pela instalação, configuração de provedor e uso diário em um só lugar. Ele utiliza o script oficial de instalação do Hermes, armazena os arquivos em `~/.hermes`, e oferece uma interface gráfica para chat, sessões, perfis, memória, skills, ferramentas, agendamento, gateways de mensageria e muito mais.

## Instalação

Baixe a versão mais recente na página de [Releases](https://github.com/aguiavisiontec/agente-hermes/releases/).

| Plataforma     | Arquivo                  |
| -------------- | ------------------------ |
| macOS          | `.dmg`                   |
| Linux (qualquer) | `.AppImage`           |
| Linux (Debian) | `.deb`                   |
| Linux (Fedora) | `.rpm`                   |
| Windows        | `.exe` (instalador NSIS) |

> **Usuários Windows:** O instalador não é assinado com código. O Windows SmartScreen exibirá um aviso na primeira execução — clique em "Mais informações" → "Executar mesmo assim".

> **Usuários WSL:** Se o instalador travar em `Switching to root user to install dependencies...`, o Playwright está aguardando uma senha sudo sem TTY para ler. Conceda sudo sem senha para a instalação e reverta quando terminar:
>
> ```bash
> echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/hermes-install
> # …execute o instalador; quando terminar:
> sudo rm /etc/sudoers.d/hermes-install
> ```

### Fedora (RPM)

```bash
sudo dnf install ./agente-aguiavitech-<versao>.rpm
```

> **Usuários Fedora:** O `.rpm` não é assinado com GPG. Se o sistema exigir verificação de assinatura, adicione `--nogpgcheck` ao comando de instalação. Auto-update não é suportado para builds `.rpm` (limitação do `electron-updater`); reinstale o novo `.rpm` para atualizar.

### macOS

> **Usuários macOS:** O app não é assinado ou notarizado. O macOS vai bloqueá-lo na primeira execução. Para resolver, execute o seguinte após a instalação:
>
> ```bash
> xattr -cr "/Applications/Agente IA Aguiavitech.app"
> ```
>
> Ou clique com o botão direito no app → **Abrir** → clique em **Abrir** no diálogo de confirmação.

## Funcionalidades

- **Instalação guiada na primeira execução** do Agente Hermes com rastreamento de progresso e resolução de dependências
- **Backend local ou remoto** — execute o Hermes localmente em `127.0.0.1:8642`, ou conecte o app desktop a um servidor Hermes API remoto com URL + chave API
- **Suporte a múltiplos provedores** — OpenRouter, Anthropic, OpenAI, Google (Gemini), xAI (Grok), Nous Portal, Qwen, MiniMax, Hugging Face, Groq e endpoints locais compatíveis com OpenAI (LM Studio, Ollama, vLLM, llama.cpp)
- **Interface de chat com streaming** via SSE, indicadores de progresso de ferramentas, renderização markdown e destaque de sintaxe
- **Rastreamento de uso de tokens** — contagens em tempo real de tokens prompt/completion e exibição de custo no rodapé do chat, além do comando slash `/usage`
- **22 comandos slash** — `/new`, `/clear`, `/fast`, `/web`, `/image`, `/browse`, `/code`, `/shell`, `/usage`, `/help`, `/tools`, `/skills`, `/model`, `/memory`, `/persona`, `/version`, `/compact`, `/compress`, `/undo`, `/retry`, `/debug`, `/status` e mais
- **Gerenciamento de sessões** — busca full-text (SQLite FTS5), histórico agrupado por data, retomada e busca entre conversas
- **Troca de perfis** — crie, delete e alterne entre ambientes Hermes separados com configuração isolada
- **14 conjuntos de ferramentas** — web, navegador, terminal, arquivo, execução de código, visão, geração de imagem, TTS, skills, memória, busca de sessão, clarificação, delegação, MoA e planejamento de tarefas
- **Sistema de memória** — visualize/edite entradas de memória, memória de perfil de usuário, rastreamento de capacidade e provedores de memória (Honcho, Hindsight, Mem0, RetainDB, Supermemory, ByteRover)
- **Editor de persona** — edite e resete a personalidade SOUL.md do seu agente
- **Modelos salvos** — gerenciamento CRUD de configurações de modelos entre provedores
- **Tarefas agendadas** — construtor de cron jobs (minutos, horário, diário, semanal, cron customizado) com 15 destinos de entrega
- **16 gateways de mensageria** — Telegram, Discord, Slack, WhatsApp, Signal, Matrix, Mattermost, Email (IMAP/SMTP), SMS (Twilio/Vonage), iMessage (BlueBubbles), DingTalk, Feishu/Lark, WeCom, WeChat (iLink Bot), Webhooks, Home Assistant
- **Agente Hermes Office (Claw3d)** — interface visual 3D com servidor de desenvolvimento e gerenciamento de adaptadores
- **Backup, importação e dump de debug** — backup/restauração completa de dados e diagnósticos de sistema pelas Configurações
- **Visualizador de logs** — visualize logs de gateway e agente diretamente pela tela de Configurações
- **Auto-atualização** — verifique e instale atualizações via electron-updater
- **i18n pronto** — framework de internacionalização com locale pt-BR cobrindo todas as telas, pronto para traduções da comunidade
- **Suite de testes** — parser SSE, handlers IPC, superfície da API preload, utilitários do instalador e validação de constantes com Vitest

## Preview

<table>
<tr>
<td width="50%" align="center"><b>Office</b><br/><img width="100%" alt="Office" src="https://github.com/user-attachments/assets/214bfa60-48ec-4449-be40-370628205147" /></td>
<td width="50%" align="center"><b>Chat</b><br/><img width="100%" alt="Chat" src="https://github.com/user-attachments/assets/ca84a56c-4d14-4775-96bb-c725069988be" /></td>
</tr>
<tr>
<td width="50%" align="center"><b>Perfis</b><br/><img width="100%" alt="Profiles" src="https://github.com/user-attachments/assets/bd812e4a-bbdc-4141-b3a8-1ab5b0e561d4" /></td>
<td width="50%" align="center"><b>Ferramentas</b><br/><img width="100%" alt="Tools" src="https://github.com/user-attachments/assets/ad051fbe-055d-40d2-b6dd-959c522412d2" /></td>
</tr>
<tr>
<td width="50%" align="center"><b>Configurações</b><br/><img width="100%" alt="Settings" src="https://github.com/user-attachments/assets/b3f7e0d8-b087-4935-b57c-f8db30491f2e" /></td>
<td width="50%" align="center"><b>Skills</b><br/><img width="100%" alt="Skills" src="https://github.com/user-attachments/assets/508c3501-52eb-419d-8cfd-06268875ff62" /></td>
</tr>
</table>

## Como Funciona

Na primeira execução, o app:

1. Pergunta se você quer rodar o Hermes **localmente** ou conectar a um **servidor** Hermes API remoto.
2. **Modo local:** verifica se o Hermes já está instalado em `~/.hermes`; se não, executa o instalador oficial do Hermes com resolução de dependências (Git, uv, Python 3.11+).
3. **Modo remoto:** solicita a URL da API remota e a chave API, valida a conexão e pula a instalação local.
4. Solicita um provedor de API ou endpoint de modelo local.
5. Salva a configuração do provedor e as chaves API nos arquivos de configuração do Hermes.
6. Inicia o workspace principal após a conclusão da configuração.

No modo local, as requisições de chat passam por `http://127.0.0.1:8642` com streaming SSE. No modo remoto, o app se comunica com a URL remota configurada com o mesmo protocolo de streaming. O app desktop faz o parse do stream em tempo real, renderizando o progresso de ferramentas, conteúdo markdown e uso de tokens conforme chegam.

## Telas

| Tela           | Descrição                                                                        |
| -------------- | -------------------------------------------------------------------------------- |
| **Chat**       | Interface de conversação com streaming, comandos slash, progresso de ferramentas e rastreamento de tokens |
| **Sessões**    | Navegue, busque e retome conversas passadas                                      |
| **Agentes**    | Crie, delete e alterne entre perfis do Hermes                                    |
| **Skills**     | Navegue, instale e gerencie skills empacotadas e instaladas                      |
| **Modelos**    | Gerencie configurações de modelos salvos por provedor                            |
| **Memória**    | Visualize/edite entradas de memória, perfil de usuário e configure provedores de memória |
| **Soul**       | Edite a persona do perfil ativo (SOUL.md)                                        |
| **Ferramentas** | Ative ou desative conjuntos de ferramentas individuais                          |
| **Agendamentos** | Crie e gerencie cron jobs com destinos de entrega                              |
| **Gateway**    | Configure e controle integrações com plataformas de mensageria                   |
| **Office**     | Configuração e gerenciamento da interface visual Claw3d                          |
| **Configurações** | Configuração de provedor, pools de credenciais, backup/importação, visualizador de logs, configurações de rede, tema |

## Provedores Suportados

### Provedores LLM

| Provedor            | Observações                                    |
| ------------------- | ---------------------------------------------- |
| **OpenRouter**      | 200+ modelos via API única (recomendado)       |
| **Anthropic**       | Acesso direto ao Claude                        |
| **OpenAI**          | Acesso direto ao GPT                           |
| **Google (Gemini)** | Google AI Studio                               |
| **xAI (Grok)**      | Modelos Grok                                   |
| **Nous Portal**     | Plano gratuito disponível                      |
| **Qwen**            | Modelos QwenAI                                 |
| **MiniMax**         | Endpoints global e China                       |
| **Hugging Face**    | 20+ modelos abertos via HF Inference           |
| **Groq**            | Inferência rápida (voz/STT)                    |
| **Local/Custom**    | Qualquer endpoint compatível com OpenAI         |

Presets locais estão incluídos para LM Studio, Ollama, vLLM e llama.cpp.

### Plataformas de Mensageria

Telegram, Discord, Slack, WhatsApp, Signal, Matrix/Element, Mattermost, Email (IMAP/SMTP), SMS (Twilio & Vonage), iMessage (BlueBubbles), DingTalk, Feishu/Lark, WeCom, WeChat (iLink Bot), Webhooks e Home Assistant.

### Integrações de Ferramentas

Exa Search, Parallel API, Tavily, Firecrawl, FAL.ai (geração de imagem), Honcho, Browserbase, Weights & Biases e Tinker.

## Desenvolvimento

### Pré-requisitos

- Node.js e npm
- Um ambiente shell Unix-like para o instalador do Hermes
- Acesso à rede para download do Hermes durante a instalação inicial

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
```

### Executar testes

```bash
npm run test
npm run test:watch
```

### Build do app desktop

```bash
npm run build
```

Empacotamento por plataforma:

```bash
npm run build:mac
npm run build:win
npm run build:linux
npm run build:rpm    # Fedora/RHEL .rpm only
```

## Configuração Inicial

Quando o app abrir pela primeira vez, ele detectará uma instalação existente do Hermes ou oferecerá a instalação.

Caminhos de configuração suportados na interface:

- `OpenRouter`
- `Anthropic`
- `OpenAI`
- `LLM Local` via URL base compatível com OpenAI

Presets locais incluídos para:

- LM Studio
- Ollama
- vLLM
- llama.cpp

Arquivos do Hermes são gerenciados em:

- `~/.hermes`
- `~/.hermes/.env`
- `~/.hermes/config.yaml`
- `~/.hermes/hermes-agent`
- `~/.hermes/profiles/` — diretórios de perfis nomeados
- `~/.hermes/state.db` — banco de dados de histórico de sessões
- `~/.hermes/cron/jobs.json` — tarefas agendadas

## Deploy com Docker

O projeto inclui configuração Docker Compose para deploy em servidor:

```bash
cd deploy
docker compose up -d
```

Conecte o Desktop App via modo remoto:
- URL: `http://<IP_VPS>:8642`
- API Key: (valor de `API_SERVER_KEY` no `.env`)

## Stack Tecnológica

- **Electron** 39 — shell desktop multi-plataforma
- **React** 19 — framework de UI
- **TypeScript** 5.9 — segurança de tipos nos processos main e renderer
- **Tailwind CSS** 4 — estilização utility-first
- **Vite** 7 + electron-vite — servidor de desenvolvimento rápido e ferramentas de build
- **better-sqlite3** — armazenamento local de sessões com busca full-text FTS5
- **i18next** — framework de internacionalização
- **Vitest** — executor de testes

## Observações

- O app desktop depende do projeto upstream Agente Hermes para comportamento do agente e execução de ferramentas.
- O instalador embutido executa o script oficial de instalação do Hermes com `--skip-setup`, depois completa a configuração do provedor na interface gráfica.
- Provedores de modelos locais não exigem chave API, mas o servidor compatível já deve estar rodando.
- Rotas alternativas de registro npm são suportadas para ambientes com acesso de rede restrito.

## Contribuindo

Contribuições são bem-vindas! Confira o [Guia de Contribuição](CONTRIBUTING.md) para começar. Se não souber por onde começar, dê uma olhada nas [issues abertas](https://github.com/aguiavisiontec/agente-hermes/issues). Encontrou um bug ou tem uma sugestão? [Abra uma issue](https://github.com/aguiavisiontec/agente-hermes/issues/new).

## Projeto Relacionado

Para o agente core, documentação e workflows CLI, veja o repositório principal do Hermes Agent:

- https://github.com/NousResearch/hermes-agent

## Créditos

- Projeto original: [Hermes Desktop](https://github.com/fathah/hermes-desktop) por Nous Research
- Adaptação e customização: Aguiavision Tecnologia
