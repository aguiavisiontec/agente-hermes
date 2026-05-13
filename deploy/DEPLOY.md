# 🚀 Deploy na VPS — Agente Hermes

Este diretório contém os arquivos para deploy do Agente Hermes na sua VPS usando Docker.

## Estrutura

```
deploy/
├── Dockerfile              # Imagem Docker do Agente Hermes
├── docker-compose.yml      # Compose integrado com a stack existente
├── entrypoint.sh           # Script de entrada do container
├── deploy-vps.sh           # Script de deploy automatizado
├── .env.example            # Modelo de variáveis de ambiente
└── DEPLOY.md               # Este arquivo
```

## Deploy Rápido

### 1. Clone o repositório na VPS

```bash
cd /infra/ia
git clone https://github.com/aguiavisiontec/agente-hermes.git
cd agente-hermes/deploy
```

### 2. Configure o .env

```bash
cp .env.example .env
nano .env
```

Preencha com suas chaves API. No mínimo, configure um provedor de inferência:

```env
API_SERVER_KEY=hermes-aguiavision-2026
OPENROUTER_API_KEY=sk-or-v1-sua-chave
```

### 3. Execute o deploy

```bash
bash deploy-vps.sh
```

Ou manualmente:

```bash
docker compose up -d --build
```

## Conectar o Desktop App

No app **Agente Hermes** no seu computador:

1. Selecione **"Conectar ao Hermes Remoto"**
2. URL: `http://IP_DA_VPS:8642`
3. API Key: valor de `API_SERVER_KEY` no `.env`
4. Clique em **"Conectar"**

## Integração com a Stack Existente

O Agente Hermes se integra automaticamente com:

| Serviço | Conexão |
|---------|---------|
| `proxy-anthropic` | `http://proxy-anthropic:4000` (se `ANTHROPIC_BASE_URL` configurado) |
| `agentes-postgres` | Disponível na rede `ia-network` |
| `agentes-gateway` | Disponível na rede `ia-network` |

## Comandos Úteis

```bash
# Ver logs
docker compose logs -f agente-hermes

# Reiniciar
docker compose restart agente-hermes

# Parar
docker compose down

# Atualizar (após git pull)
docker compose up -d --build

# Shell dentro do container
docker compose exec agente-hermes bash

# Verificar saúde
curl http://127.0.0.1:8642/health
```

## Segurança

- A porta `8642` fica exposta externamente para o Desktop App se conectar
- A autenticação é feita via `API_SERVER_KEY` (Bearer token)
- Para maior segurança, use um reverse proxy (nginx/caddy) com HTTPS
- **NUNCA** commite o arquivo `.env` com chaves reais
