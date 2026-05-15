#!/bin/bash
# ────────────────────────────────────────────────────
# Agente Hermes — Entrypoint
# Aguiavision Tecnologia
# ────────────────────────────────────────────────────
set -e

HERMES_HOME="${HERMES_HOME:-/data/hermes}"
HERMES_REPO="${HERMES_REPO:-/opt/hermes}"

# ── Drop de privilégios: se rodando como root, re-exec como usuário hermes ──
if [ "$(id -u)" = "0" ]; then
    echo "🇧🇷 Agente Hermes — Aguiavision Tecnologia"
    echo "─────────────────────────────────────────────"

    # Remapeia UID/GID se solicitado (para corresponder ao dono do volume no host)
    if [ -n "$HERMES_UID" ] && [ "$HERMES_UID" != "$(id -u hermes)" ]; then
        echo "🔐 Ajustando UID do hermes para $HERMES_UID"
        usermod -u "$HERMES_UID" hermes
    fi
    if [ -n "$HERMES_GID" ] && [ "$HERMES_GID" != "$(id -g hermes)" ]; then
        echo "🔐 Ajustando GID do hermes para $HERMES_GID"
        groupmod -o -g "$HERMES_GID" hermes 2>/dev/null || true
    fi

    # Cria diretórios necessários se não existirem (como root, antes do chown)
    mkdir -p "${HERMES_HOME}/profiles" "${HERMES_HOME}/cron" "${HERMES_HOME}/skills"

    # ── Copia skills customizadas da Aguiavision ──
    if [ -d "/data/hermes-skills" ]; then
        echo "📋 Copiando skills customizadas..."
        for skill_dir in /data/hermes-skills/*/; do
            skill_name=$(basename "${skill_dir}")
            if [ ! -d "${HERMES_HOME}/skills/${skill_name}" ]; then
                cp -r "${skill_dir}" "${HERMES_HOME}/skills/${skill_name}"
                echo "   ✅ ${skill_name} instalado"
            else
                echo "   ℹ️  ${skill_name} já existe — preservando"
            fi
        done
    fi

    # ── Cria .env se não existir ──
    if [ ! -f "${HERMES_HOME}/.env" ]; then
        if [ -f "/secrets/hermes.env" ]; then
            echo "📋 Copiando .env de /secrets/hermes.env"
            cp /secrets/hermes.env "${HERMES_HOME}/.env"
        else
            echo "⚠️  Nenhum arquivo .env encontrado. Criando modelo..."
            cat > "${HERMES_HOME}/.env" << 'ENVEOF'
# ─────────────────────────────────────────────
# Agente Hermes — Configuração de Ambiente
# Aguiavision Tecnologia
# ─────────────────────────────────────────────

# Provedor de inferência (descomente o que for usar)
# OPENROUTER_API_KEY=sk-or-v1-...
# OPENAI_API_KEY=sk-...
# ANTHROPIC_API_KEY=sk-ant-...
# GOOGLE_API_KEY=AIza...
# GROQ_API_KEY=gsk_...
# DEEPSEEK_API_KEY=sk-...

# Proxy Anthropic local (se usar o proxy-anthropic)
# ANTHROPIC_BASE_URL=http://proxy-anthropic:4000

# Pesquisa web
# EXA_API_KEY=...
# TAVIL_API_KEY=...

# Chave do servidor API (para o desktop app se conectar)
API_SERVER_KEY=hermes-aguiavision-2026
ENVEOF
            echo "📝 Modelo .env criado em ${HERMES_HOME}/.env"
        fi
    fi

    # ── Cria config.yaml se não existir ──
    if [ ! -f "${HERMES_HOME}/config.yaml" ]; then
        if [ -f "/secrets/hermes-config.yaml" ]; then
            echo "📋 Copiando config.yaml de /secrets/hermes-config.yaml"
            cp /secrets/hermes-config.yaml "${HERMES_HOME}/config.yaml"
        else
            echo "📝 Criando config.yaml padrão..."
            cat > "${HERMES_HOME}/config.yaml" << 'YAMLEOF'
# ─────────────────────────────────────────────
# Agente Hermes — Configuração
# Aguiavision Tecnologia
# ─────────────────────────────────────────────

# Provedor de inferência padrão
provider: openrouter
model: ""

# API Server (necessário para o desktop app remoto)
platforms:
  api_server:
    enabled: true
    extra:
      port: 8642
      host: "0.0.0.0"
      api_key: "${API_SERVER_KEY}"

# Ferramentas habilitadas
tools:
  web_search: true
  browser: false
  terminal: true
  file: true
  code_execution: true
  vision: true
  image_gen: false
  tts: false
  skills: true
  memory: true
  session_search: true
  clarify: true
  delegation: true
  cron: true
  moa: false
  todo: true

# Memória
memory:
  enabled: true

# MCP Servers — Automação de browser via Playwright
mcp_servers:
  playwright:
    command: "npx"
    args:
      - "-y"
      - "@playwright/mcp@latest"
      - "--headless"
    timeout: 120
    connect_timeout: 60
YAMLEOF
            echo "📝 Modelo config.yaml criado em ${HERMES_HOME}/config.yaml"
        fi
    fi

    # ── Cria SOUL.md se não existir ──
    if [ ! -f "${HERMES_HOME}/SOUL.md" ]; then
        echo "📝 Criando SOUL.md com persona Aguiavision..."
        cat > "${HERMES_HOME}/SOUL.md" << 'SOULEOF'
Você é o Agente de IA criado pela Aguiavision Soluções Tecnológicas com IA.

## Regras obrigatórias

1. **Idioma**: SEMPRE responda em português brasileiro (pt-BR). Todas as respostas, descrições, explicações e interações devem ser em português brasileiro.

2. **Identidade**: Quando perguntarem quem você é, responda: "Sou o Agente de IA criado pela Aguiavision Soluções Tecnológicas com IA. Estou aqui para ajudar com uma variedade de tarefas: responder perguntas, escrever e editar código, analisar informações, trabalho criativo, e executar ações através das minhas ferramentas."

3. **Tom**: Seja profissional, prestativo e claro. Use linguagem adequada ao contexto brasileiro.

4. **Honestidade**: Seja honesto sobre suas limitações. Peça esclarecimentos quando necessário.

5. **Segurança**: Respeite a privacidade do usuário e trate informações sensíveis com cuidado.

6. **Proatividade**: Pense passo a passo e explique seu raciocínio. Ofereça soluções completas e bem fundamentadas.

7. **Nome**: Seu nome é "Agente IA Aguiavitech". Nunca se apresente como Hermes, Hermes Agent, ou qualquer outro nome.

8. **Empresa**: Você foi criado pela Aguiavision Soluções Tecnológicas com IA. Nunca diga que foi criado pela Nous Research ou qualquer outra empresa.
SOULEOF
        echo "✅ SOUL.md criado em ${HERMES_HOME}/SOUL.md"
    else
        echo "ℹ️  SOUL.md já existe em ${HERMES_HOME}/SOUL.md — preservando"
    fi

    # ── Corrige permissões ──
    actual_hermes_uid=$(id -u hermes)
    needs_chown=false

    if [ -n "$HERMES_UID" ] && [ "$HERMES_UID" != "10000" ]; then
        needs_chown=true
    elif [ "$(stat -c %u "$HERMES_HOME" 2>/dev/null)" != "$actual_hermes_uid" ]; then
        needs_chown=true
    fi

    if [ "$needs_chown" = true ]; then
        echo "🔐 Corrigindo permissões de ${HERMES_HOME} para hermes (${actual_hermes_uid})"
        chown -R hermes:hermes "$HERMES_HOME" 2>/dev/null || \
            echo "⚠️  chown falhou (container rootless?) — continuando"
    fi

    # Garante que config.yaml é legível pelo hermes
    if [ -f "${HERMES_HOME}/config.yaml" ]; then
        chown hermes:hermes "${HERMES_HOME}/config.yaml" 2>/dev/null || true
        chmod 640 "${HERMES_HOME}/config.yaml" 2>/dev/null || true
    fi

    # ── Exporta variáveis do .env para o ambiente ──
    set -a
    source "${HERMES_HOME}/.env"
    set +a

    # Carrega API_SERVER_KEY para o config.yaml
    export API_SERVER_KEY="${API_SERVER_KEY:-hermes-aguiavision-2026}"

    # Substitui variáveis no config.yaml
    envsubst < "${HERMES_HOME}/config.yaml" > "${HERMES_HOME}/config.yaml.tmp" 2>/dev/null && \
        mv "${HERMES_HOME}/config.yaml.tmp" "${HERMES_HOME}/config.yaml" || \
        rm -f "${HERMES_HOME}/config.yaml.tmp"

    # Corrige permissões após envsubst
    chown hermes:hermes "${HERMES_HOME}/config.yaml" 2>/dev/null || true

    # ── Lista skills instaladas ──
    echo "📋 Skills instaladas:"
    for skill_dir in ${HERMES_HOME}/skills/*/; do
        if [ -f "${skill_dir}SKILL.md" ]; then
            skill_name=$(grep '^name:' "${skill_dir}SKILL.md" | head -1 | sed 's/name: *//' | tr -d '"')
            echo "   • ${skill_name}"
        fi
    done

    echo "🔐 Dropando privilégios de root → hermes"
    echo "─────────────────────────────────────────────"

    # Re-executa este script como o usuário hermes
    exec gosu hermes "$0" "$@"
fi

# ── Daqui em diante, rodando como usuário hermes (não-root) ──

echo "🇧🇷 Agente Hermes — Aguiavision Tecnologia"
echo "─────────────────────────────────────────────"

# Ativa o ambiente virtual
source /opt/hermes-venv/bin/activate

# Cria subdiretórios essenciais (como hermes, não root)
mkdir -p "${HERMES_HOME}"/{cron,sessions,logs,hooks,memories,skills,workspace,home}

echo "🚀 Iniciando Agente IA Aguiavitech..."
echo "   Modo: ${1:-gateway}"
echo "   HERMES_HOME: ${HERMES_HOME}"
echo "   API Server: 0.0.0.0:8642"
echo "   MCP: Playwright (headless Chromium)"
echo "   Usuário: $(whoami) ($(id -u))"
echo "─────────────────────────────────────────────"

cd "${HERMES_REPO}"

# Exporta variáveis do .env para o ambiente (também como hermes)
if [ -f "${HERMES_HOME}/.env" ]; then
    set -a
    source "${HERMES_HOME}/.env"
    set +a
fi

# Executa o comando passado (default: gateway)
export PATH="/opt/hermes-venv/bin:${PATH}"
exec hermes "$@"
