#!/bin/bash
# ────────────────────────────────────────────────────
# Agente Hermes — Entrypoint
# Aguiavision Tecnologia
# ────────────────────────────────────────────────────
set -e

HERMES_HOME="${HERMES_HOME:-/data/hermes}"
HERMES_REPO="${HERMES_REPO:-/opt/hermes}"

# Lista de variáveis de API para mesclar do docker-compose para o .env do Hermes
API_ENV_VARS=(
    "OPENROUTER_API_KEY"
    "ANTHROPIC_API_KEY"
    "OPENAI_API_KEY"
    "GOOGLE_API_KEY"
    "GROQ_API_KEY"
    "DEEPSEEK_API_KEY"
    "NVIDIA_API_KEY"
    "EXA_API_KEY"
    "TAVIL_API_KEY"
    "FAL_KEY"
    "API_SERVER_KEY"
    "ANTHROPIC_BASE_URL"
    "GATEWAY_ALLOW_ALL_USERS"
)

# ── Função: mescla chaves API do ambiente (docker-compose) para o .env do Hermes ──
merge_api_keys_to_env() {
    local env_file="${HERMES_HOME}/.env"
    local changed=false

    for var_name in "${API_ENV_VARS[@]}"; do
        # Obtém o valor da variável do ambiente atual
        var_value="${!var_name:-}"

        # Se a variável tem valor no ambiente (veio do docker-compose)
        if [ -n "$var_value" ]; then
            # Verifica se já existe no .env (descomentada)
            if grep -q "^${var_name}=" "$env_file" 2>/dev/null; then
                # Atualiza o valor existente
                existing_value=$(grep "^${var_name}=" "$env_file" | cut -d'=' -f2-)
                if [ "$existing_value" != "$var_value" ]; then
                    sed -i "s|^${var_name}=.*|${var_name}=${var_value}|" "$env_file"
                    echo "   🔑 ${var_name} atualizado no .env"
                    changed=true
                fi
            else
                # Verifica se existe comentada
                if grep -q "^#${var_name}=" "$env_file" 2>/dev/null; then
                    # Descomenta e atualiza o valor
                    sed -i "s|^#${var_name}=.*|${var_name}=${var_value}|" "$env_file"
                    echo "   🔑 ${var_name} descomentado e configurado no .env"
                    changed=true
                else
                    # Adiciona ao final do arquivo
                    echo "" >> "$env_file"
                    echo "${var_name}=${var_value}" >> "$env_file"
                    echo "   🔑 ${var_name} adicionado ao .env"
                    changed=true
                fi
            fi
        fi
    done

    if [ "$changed" = true ]; then
        echo "✅ Chaves API mescladas do docker-compose para o .env do Hermes"
    fi
}

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
            echo "📝 Criando modelo .env..."
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

    # ── Mescla chaves API do docker-compose para o .env do Hermes ──
    echo "🔑 Verificando chaves API do docker-compose..."
    merge_api_keys_to_env

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
provider: local
model: "moonshotai/kimi-k2.6"

# Provedores configurados
providers:
  google:
    api_key: "${GOOGLE_API_KEY}"
  nvidia:
    api_key: "${NVIDIA_API_KEY}"
    base_url: "https://integrate.api.nvidia.com/v1"

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

    # Garante que config.yaml e .env são legíveis pelo hermes
    if [ -f "${HERMES_HOME}/config.yaml" ]; then
        chown hermes:hermes "${HERMES_HOME}/config.yaml" 2>/dev/null || true
        chmod 640 "${HERMES_HOME}/config.yaml" 2>/dev/null || true
    fi
    if [ -f "${HERMES_HOME}/.env" ]; then
        chown hermes:hermes "${HERMES_HOME}/.env" 2>/dev/null || true
        chmod 640 "${HERMES_HOME}/.env" 2>/dev/null || true
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

    # ── Diagnóstico: verifica provedores de API disponíveis ──
    if [ -n "${GOOGLE_API_KEY:-}" ]; then
        echo "✅ GOOGLE_API_KEY configurada (${#GOOGLE_API_KEY} caracteres)"
    fi
    if [ -n "${NVIDIA_API_KEY:-}" ]; then
        echo "✅ NVIDIA_API_KEY configurada (${#NVIDIA_API_KEY} caracteres)"
    fi
    if [ -n "${OPENROUTER_API_KEY:-}" ]; then
        echo "✅ OPENROUTER_API_KEY configurada (${#OPENROUTER_API_KEY} caracteres)"
    fi
    if [ -z "${GOOGLE_API_KEY:-}" ] && [ -z "${OPENROUTER_API_KEY:-}" ] && [ -z "${ANTHROPIC_API_KEY:-}" ] && [ -z "${OPENAI_API_KEY:-}" ] && [ -z "${NVIDIA_API_KEY:-}" ]; then
        echo "⚠️  NENHUMA chave API configurada — configure no .env ou docker-compose"
    fi

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

# Exporta variáveis do .env para o ambiente (também como hermes)
if [ -f "${HERMES_HOME}/.env" ]; then
    set -a
    source "${HERMES_HOME}/.env"
    set +a
fi

echo "🚀 Iniciando Agente IA Aguiavitech..."
echo "   Modo: ${1:-gateway}"
echo "   HERMES_HOME: ${HERMES_HOME}"
echo "   API Server: 0.0.0.0:8642"
echo "   MCP: Playwright (headless Chromium)"
echo "   Usuário: $(whoami) ($(id -u))"
if [ -n "${NVIDIA_API_KEY:-}" ]; then
    echo "   Provedor: NVIDIA NIM (Kimi K2.6) ✅"
elif [ -n "${GOOGLE_API_KEY:-}" ]; then
    echo "   Provedor: Google AI Studio (Gemini) ✅"
elif [ -n "${OPENROUTER_API_KEY:-}" ]; then
    echo "   Provedor: OpenRouter ✅"
elif [ -n "${ANTHROPIC_API_KEY:-}" ]; then
    echo "   Provedor: Anthropic ✅"
elif [ -n "${OPENAI_API_KEY:-}" ]; then
    echo "   Provedor: OpenAI ✅"
else
    echo "   Provedor: ⚠️ NENHUM configurado"
fi
echo "─────────────────────────────────────────────"

cd "${HERMES_REPO}"

# Executa o comando passado (default: gateway)
export PATH="/opt/hermes-venv/bin:${PATH}"
exec hermes "$@"
