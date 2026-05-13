#!/bin/bash
# ────────────────────────────────────────────────────
# Agente Hermes — Script de Deploy na VPS
# Aguiavision Tecnologia
# ────────────────────────────────────────────────────
# Uso: bash deploy-vps.sh
#
# Pré-requisitos:
#   - Docker e Docker Compose instalados
#   - Git instalado
#   - Acesso à internet
# ────────────────────────────────────────────────────

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo ""
echo "🇧🇷 ${CYAN}Agente Hermes — Deploy${NC}"
echo "   ${YELLOW}Aguiavision Tecnologia${NC}"
echo "─────────────────────────────────────────────"
echo ""

# ── Verifica pré-requisitos ──
check_prereqs() {
    echo "🔍 Verificando pré-requisitos..."

    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Docker não encontrado. Instale com:${NC}"
        echo "   curl -fsSL https://get.docker.com | sh"
        exit 1
    fi
    echo -e "${GREEN}✅ Docker encontrado${NC}"

    if ! docker compose version &> /dev/null; then
        echo -e "${RED}❌ Docker Compose não encontrado${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Docker Compose encontrado${NC}"

    if ! command -v git &> /dev/null; then
        echo -e "${RED}❌ Git não encontrado${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Git encontrado${NC}"

    echo ""
}

# ── Detecta rede Docker existente ──
detect_network() {
    echo "🔍 Detectando infraestrutura existente..."

    # Verifica se os containers da stack existem
    if docker ps --format '{{.Names}}' | grep -q 'proxy-anthropic'; then
        echo -e "${GREEN}✅ proxy-anthropic encontrado${NC}"
        HAS_PROXY=true
        # Detecta a rede do proxy-anthropic
        PROXY_NETWORK=$(docker inspect proxy-anthropic --format '{{range $k, $v := .NetworkSettings.Networks}}{{$k}}{{end}}' 2>/dev/null || echo "")
        if [ -n "$PROXY_NETWORK" ]; then
            echo -e "${GREEN}✅ Rede detectada: $PROXY_NETWORK${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  proxy-anthropic não encontrado${NC}"
        HAS_PROXY=false
    fi

    if docker ps --format '{{.Names}}' | grep -q 'agentes-postgres'; then
        echo -e "${GREEN}✅ agentes-postgres encontrado${NC}"
        HAS_POSTGRES=true
    else
        HAS_POSTGRES=false
    fi

    echo ""
}

# ── Configura variáveis de ambiente ──
setup_env() {
    if [ ! -f .env ]; then
        echo "📝 Criando arquivo .env a partir do modelo..."
        cp .env.example .env
        echo -e "${YELLOW}⚠️  Edite o arquivo .env com suas chaves API antes de continuar!${NC}"
        echo "   nano .env"
        echo ""
        read -p "Já configurou o .env? (s/n) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Ss]$ ]]; then
            echo "Edite o .env e rode este script novamente."
            exit 0
        fi
    else
        echo -e "${GREEN}✅ Arquivo .env encontrado${NC}"
    fi
    echo ""
}

# ── Ajusta docker-compose para a rede existente ──
adjust_compose() {
    if [ -n "$PROXY_NETWORK" ]; then
        echo "🔧 Ajustando docker-compose para rede existente: $PROXY_NETWORK"
        # Cria um override que usa a rede existente
        cat > docker-compose.override.yml << OVERRIDEEOF
networks:
  ia-network:
    external: true
    name: ${PROXY_NETWORK}
OVERRIDEEOF
        echo -e "${GREEN}✅ docker-compose.override.yml criado${NC}"
    fi
    echo ""
}

# ── Build e deploy ──
deploy() {
    echo "🏗️  Construindo imagem do Agente Hermes..."
    docker compose build --no-cache 2>&1 | tail -5

    echo ""
    echo "🚀 Iniciando Agente Hermes..."
    docker compose up -d

    echo ""
    echo "⏳ Aguardando o serviço ficar disponível..."
    sleep 10

    # Health check
    for i in {1..30}; do
        if curl -sf http://127.0.0.1:8642/health > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Agente Hermes está rodando!${NC}"
            break
        fi
        if [ $i -eq 30 ]; then
            echo -e "${YELLOW}⚠️  O serviço ainda está iniciando. Verifique com:${NC}"
            echo "   docker compose logs -f agente-hermes"
        fi
        sleep 2
    done

    echo ""
}

# ── Mostra status ──
show_status() {
    echo "─────────────────────────────────────────────"
    echo "📊 Status dos containers:"
    docker compose ps
    echo ""
    echo "─────────────────────────────────────────────"
    echo "🌐 Conexão do Desktop App (Modo Remoto):"
    echo ""
    echo "   URL:     http://$(hostname -I | awk '{print $1}'):8642"
    echo "   API Key: $(grep API_SERVER_KEY .env | cut -d= -f2)"
    echo ""
    echo "📱 No Desktop App Agente Hermes:"
    echo "   1. Selecione 'Conectar ao Hermes Remoto'"
    echo "   2. Cole a URL acima"
    echo "   3. Cole a API Key acima"
    echo "   4. Clique em 'Conectar'"
    echo ""
    echo "─────────────────────────────────────────────"
    echo "🔧 Comandos úteis:"
    echo ""
    echo "   Ver logs:       docker compose logs -f agente-hermes"
    echo "   Reiniciar:      docker compose restart agente-hermes"
    echo "   Parar:          docker compose down"
    echo "   Atualizar:      git pull && docker compose up -d --build"
    echo "   Shell no container: docker compose exec agente-hermes bash"
    echo ""
    echo "🇧🇷 Agente Hermes — Aguiavision Tecnologia"
    echo "─────────────────────────────────────────────"
}

# ── Execução principal ──
check_prereqs
detect_network
setup_env
adjust_compose
deploy
show_status
