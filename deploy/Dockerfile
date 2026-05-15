# ────────────────────────────────────────────────────
# Agente Hermes — Dockerfile
# Aguiavision Tecnologia
# ────────────────────────────────────────────────────
FROM python:3.11-slim AS base

# Evita prompts interativos e configura locale pt_BR
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    LANG=pt_BR.UTF-8 \
    LC_ALL=pt_BR.UTF-8 \
    HERMES_HOME=/data/hermes

# Instala dependências do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    locales \
    ffmpeg \
    ripgrep \
    gnupg2 \
    && sed -i '/pt_BR.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen pt_BR.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js 20.x (necessário para Playwright MCP e npx)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Instala uv (gerenciador de pacotes Python rápido)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"

# ── Stage de build ──
FROM base AS builder

WORKDIR /opt/hermes

# Clona e instala o hermes-agent
RUN git clone --depth 1 --branch v2026.5.7 https://github.com/NousResearch/hermes-agent.git . \
    && uv venv /opt/hermes-venv \
    && . /opt/hermes-venv/bin/activate \
    && uv pip install --no-cache -e ".[all]"

# ── Stage final ──
FROM base AS runtime

# Copia o ambiente virtual e o repo do builder
COPY --from=builder /opt/hermes-venv /opt/hermes-venv
COPY --from=builder /opt/hermes /opt/hermes

# Cria diretório de dados e skills
RUN mkdir -p /data/hermes/profiles /data/hermes/cron /data/hermes/skills

# Copia skills customizadas da Aguiavision
COPY deploy/skills/ /data/hermes-skills/

# Instala Playwright Chromium para o MCP server
RUN npx playwright install chromium --with-deps 2>&1 | tail -5 || true

# Script de entrada
COPY deploy/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Configura PATH para o venv + npx
ENV PATH="/opt/hermes-venv/bin:/usr/bin:${PATH}" \
    HERMES_REPO="/opt/hermes" \
    HERMES_HOME="/data/hermes" \
    DISPLAY=""

# Porta do API server do Hermes
EXPOSE 8642

# Volume para dados persistentes
VOLUME ["/data/hermes"]

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -f http://127.0.0.1:8642/health || exit 1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["gateway"]
