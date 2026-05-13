#!/bin/bash
# ────────────────────────────────────────────────────
# Agente Hermes — Entrypoint
# Aguiavision Tecnologia
# ────────────────────────────────────────────────────
set -e

HERMES_HOME="${HERMES_HOME:-/data/hermes}"
HERMES_REPO="${HERMES_REPO:-/opt/hermes}"

echo "🇧🇷 Agente Hermes — Aguiavision Tecnologia"
echo "─────────────────────────────────────────────"

# Cria diretórios necessários se não existirem
mkdir -p "${HERMES_HOME}/profiles" "${HERMES_HOME}/cron"

# Copia .env do volume mount se existir, senão cria um modelo
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
# ANTHROPIC_API_KEY=${API_SERVER_KEY}
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

# Copia config.yaml do volume mount se existir, senão cria um modelo
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
YAMLEOF
        echo "📝 Modelo config.yaml criado em ${HERMES_HOME}/config.yaml"
    fi
fi

# Exporta variáveis do .env para o ambiente
set -a
source "${HERMES_HOME}/.env"
set +a

# Carrega API_SERVER_KEY para o config.yaml
export API_SERVER_KEY="${API_SERVER_KEY:-hermes-aguiavision-2026}"

# Substitui variáveis no config.yaml
envsubst < "${HERMES_HOME}/config.yaml" > "${HERMES_HOME}/config.yaml.tmp" 2>/dev/null && \
    mv "${HERMES_HOME}/config.yaml.tmp" "${HERMES_HOME}/config.yaml" || \
    rm -f "${HERMES_HOME}/config.yaml.tmp"

echo "🚀 Iniciando Agente Hermes..."
echo "   Modo: ${1:-gateway}"
echo "   HERMES_HOME: ${HERMES_HOME}"
echo "   API Server: 0.0.0.0:8642"
echo "─────────────────────────────────────────────"

cd "${HERMES_REPO}"

# Executa o comando passado (default: gateway)
exec python -m hermes "$@"
