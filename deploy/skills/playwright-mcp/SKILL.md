---
name: playwright-mcp
description: "Use quando o usuario precisar automatizar navegacao web, extrair dados de sites, preencher formularios, tirar screenshots ou interagir com paginas web via Playwright MCP."
version: 1.0.0
author: Aguiavision Solucoes Tecnologicas com IA
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [playwright, MCP, browser, automation, web-scraping, testing, screenshots, aguiavitech]
    related_skills: [skill-creator, frontend-design]
---

# Playwright MCP — Automacao de Browser via MCP

## Visao Geral

Este skill permite que o agente controle um navegador web de forma autonoma usando o Playwright MCP (Model Context Protocol). Atraves do servidor MCP do Playwright, o agente pode navegar em paginas, clicar em elementos, preencher formularios, extrair dados, tirar screenshots e muito mais — tudo de forma programatica e reprodutivel.

O Playwright MCP expoe ferramentas de browser como ferramentas nativas do agente. Quando o servidor MCP esta configurado no `config.yaml`, as ferramentas do Playwright aparecem automaticamente com o prefixo `mcp_playwright_` e podem ser usadas como qualquer outra ferramenta do agente.

## Quando Usar

Use este skill quando:
- O usuario pedir para navegar em um site e extrair informacoes
- O usuario quiser automatizar preenchimento de formularios web
- O usuario precisar tirar screenshots de paginas web
- O usuario quiser testar uma interface web automaticamente
- O usuario pedir para monitorar mudancas em uma pagina
- O usuario quiser fazer web scraping de conteudo dinamico
- O usuario precisar interagir com SPAs (Single Page Applications)
- O usuario quiser gerar PDFs de paginas web
- O usuario pedir para comparar visualmente duas paginas

**Nao use para:**
- Requisicoes API simples (use `curl` ou `fetch` diretamente)
- Scraping de HTML estatico simples (use `web_search` ou `read_url` se disponivel)
- Download de arquivos diretos (use `wget` ou `curl`)

## Configuracao do MCP Server

O Playwright MCP server deve estar configurado no `~/.hermes/config.yaml`:

### Modo Stdio (recomendado para VPS/Docker)

```yaml
mcp_servers:
  playwright:
    command: "npx"
    args: ["-y", "@playwright/mcp@latest"]
    timeout: 120
    connect_timeout: 60
```

### Modo com Browser Headless (servidor/VPS)

```yaml
mcp_servers:
  playwright:
    command: "npx"
    args: ["-y", "@playwright/mcp@latest", "--headless"]
    timeout: 120
    connect_timeout: 60
```

### Modo com Browser Visivel (desktop local)

```yaml
mcp_servers:
  playwright:
    command: "npx"
    args: ["-y", "@playwright/mcp@latest", "--no-headless"]
    timeout: 300
    connect_timeout: 60
```

### Apos configurar

Reinicie o agente para que o MCP server seja carregado. No Docker:
```bash
docker restart agente-hermes
```

As ferramentas do Playwright serao registradas com o prefixo `mcp_playwright_` e estaram disponiveis em todas as conversas.

## Ferramentas Disponiveis

O Playwright MCP expoe as seguintes ferramentas (nomes exatos podem variar conforme versao):

### Navegacao
- `mcp_playwright_navigate` — Navega para uma URL
- `mcp_playwright_go_back` — Volta para pagina anterior
- `mcp_playwright_go_forward` — Avanca para proxima pagina
- `mcp_playwright_reload` — Recarrega a pagina atual

### Interacao
- `mcp_playwright_click` — Clica em um elemento (por seletor CSS ou texto)
- `mcp_playwright_type` — Digita texto em um campo de input
- `mcp_playwright_press_key` — Pressiona uma tecla (Enter, Tab, Escape, etc.)
- `mcp_playwright_select_option` — Seleciona opcao em dropdown
- `mcp_playwright_check` / `mcp_playwright_uncheck` — Marca/desmarca checkbox
- `mcp_playwright_hover` — Passa o mouse sobre um elemento
- `mcp_playwright_drag` — Arrasta um elemento para outro
- `mcp_playwright_upload_file` — Faz upload de arquivo

### Captura de Dados
- `mcp_playwright_screenshot` — Tira screenshot da pagina ou elemento
- `mcp_playwright_get_text` — Obtem texto de um elemento
- `mcp_playwright_get_attribute` — Obtem atributo de um elemento
- `mcp_playwright_evaluate` — Executa JavaScript na pagina
- `mcp_playwright_get_page_content` — Obtem HTML da pagina
- `mcp_playwright_get_page_title` — Obtem titulo da pagina
- `mcp_playwright_get_page_url` — Obtem URL atual

### Aguarde e Sincronizacao
- `mcp_playwright_wait_for_selector` — Aguarda elemento aparecer
- `mcp_playwright_wait_for_navigation` — Aguarda navegacao completar
- `mcp_playwright_wait_for_load_state` — Aguarda estado de carregamento

### Gerenciamento
- `mcp_playwright_close` — Fecha o browser/tab atual
- `mcp_playwright_new_tab` — Abre nova aba
- `mcp_playwright_list_tabs` — Lista abas abertas
- `mcp_playwright_switch_tab` — Troca para aba especifica

## Padroes de Automacao

### Padrao 1: Navegacao e Extracao Simples

```
1. navigate → "https://exemplo.com"
2. wait_for_selector → "h1"
3. get_text → "h1"
4. screenshot → (opcional, para documentar)
5. close
```

### Padrao 2: Preenchimento de Formulario

```
1. navigate → "https://exemplo.com/form"
2. wait_for_selector → "form"
3. click → "input[name='nome']"
4. type → "Joao Silva"
5. click → "input[name='email']"
6. type → "joao@email.com"
7. select_option → "select[name='estado']", value: "SP"
8. click → "button[type='submit']"
9. wait_for_navigation
10. screenshot → (confirmacao)
```

### Padrao 3: Login e Sessao Autenticada

```
1. navigate → "https://app.exemplo.com/login"
2. wait_for_selector → "form"
3. type → "#email", "usuario@email.com"
4. type → "#password", "senha123"
5. click → "button[type='submit']"
6. wait_for_navigation → (dashboard)
7. navigate → "https://app.exemplo.com/dados"
8. get_text → ".data-table"
```

### Padrao 4: Scraping com Paginacao

```
1. navigate → "https://exemplo.com/items?page=1"
2. Loop:
   a. get_text → ".item-list"
   b. screenshot → (opcional)
   c. click → ".next-page" (se existir)
   d. wait_for_navigation
   e. Repetir ate nao haver proxima pagina
3. Consolidar dados extraidos
```

### Padrao 5: Teste de Interface

```
1. navigate → "http://localhost:3000"
2. screenshot → "initial-load"
3. click → ".mobile-menu-toggle"
4. screenshot → "menu-open"
5. click → "nav a[href='/about']"
6. wait_for_navigation
7. screenshot → "about-page"
8. get_text → "h1" → verificar se titulo esta correto
9. evaluate → "document.querySelectorAll('a').length" → verificar links
```

## Seletores CSS — Guia Rapido

| Seletor | Quando Usar | Exemplo |
|---------|-------------|---------|
| `#id` | Elemento unico com ID | `#login-form` |
| `.class` | Elemento por classe | `.btn-primary` |
| `tag` | Elemento por tag HTML | `button`, `input`, `h1` |
| `[attr='val']` | Por atributo | `[name='email']`, `[data-test='submit']` |
| `tag.class` | Tag + classe | `button.primary` |
| `parent > child` | Filho direto | `nav > ul > li` |
| `:nth-child(n)` | Enesimo filho | `li:nth-child(2)` |
| `:first-child` | Primeiro filho | `tr:first-child` |
| `:last-child` | Ultimo filho | `tr:last-child` |
| `:has-text('txt')` | Contem texto (Playwright) | `button:has-text('Enviar')` |
| `text=Texto` | Por texto exato (Playwright) | `text=Login` |

## JavaScript Evaluation

Use `evaluate` para tarefas que nao sao cobertas pelas ferramentas nativas:

```javascript
// Extrair todos os links da pagina
Array.from(document.querySelectorAll('a')).map(a => ({
  text: a.textContent.trim(),
  href: a.href
}))

// Contar elementos
document.querySelectorAll('.product-card').length

// Extrair dados de uma tabela
Array.from(document.querySelectorAll('table tbody tr')).map(row => {
  const cells = row.querySelectorAll('td');
  return {
    nome: cells[0]?.textContent.trim(),
    preco: cells[1]?.textContent.trim(),
    estoque: cells[2]?.textContent.trim()
  };
})

// Scroll ate o final da pagina (para conteudo lazy-load)
window.scrollTo(0, document.body.scrollHeight)

// Verificar se elemento esta visivel
const el = document.querySelector('.result');
el && el.offsetParent !== null

// Obter computed styles
const el = document.querySelector('.hero');
JSON.stringify({
  backgroundColor: getComputedStyle(el).backgroundColor,
  fontSize: getComputedStyle(el).fontSize,
  display: getComputedStyle(el).display
})
```

## Configuracao para Docker/VPS

Para usar o Playwright MCP em um container Docker, o Dockerfile precisa incluir Node.js:

```dockerfile
# Adicionar ao Dockerfile existente
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -     && apt-get install -y nodejs     && npm install -g npx

# Instalar dependencias do Playwright Chromium
RUN npx playwright install chromium --with-deps
```

Config.yaml para Docker (headless obrigatorio):

```yaml
mcp_servers:
  playwright:
    command: "npx"
    args: ["-y", "@playwright/mcp@latest", "--headless"]
    env:
      DISPLAY: ""
    timeout: 120
    connect_timeout: 60
```

## Erros Comuns

1. **MCP server nao conecta**: Verifique se Node.js e npx estao instalados e acessiveis no PATH do container. Teste com `npx @playwright/mcp@latest --help`.

2. **Timeout ao navegar**: Paginas pesadas podem precisar de mais tempo. Aumente `timeout` no config ou use `wait_for_load_state: "networkidle"` antes de interagir.

3. **Elemento nao encontrado**: O elemento pode ainda nao estar no DOM. Sempre use `wait_for_selector` antes de `click` ou `type`. Seletor pode estar errado — tire screenshot primeiro para debug.

4. **Browser nao abre em modo headless**: Em servidores/VPS, sempre use `--headless`. Browser visivel requer X11/display, que nao esta disponivel em containers.

5. **Chromium nao instalado**: Execute `npx playwright install chromium --with-deps` para instalar o browser e suas dependencias.

6. **Session perdida entre navegacoes**: Use `wait_for_navigation` apos cliques que causam redirecionamento. Cookies e estado sao mantidos na mesma tab.

7. **Seletores frageis**: Evite seletores baseados em classes CSS geradas automaticamente (ex: `.css-1a2b3c`). Prefira `data-testid`, `name`, `id`, ou `aria-label`.

8. **Bloqueado por anti-bot**: Sites com protecao anti-bot podem bloquear Playwright. Tente adicionar `--disable-blink-features=AutomationControlled` ou usar `evaluate` para modificar `navigator.webdriver`.

## Melhores Praticas

1. **Sempre aguarde**: Use `wait_for_selector` ou `wait_for_load_state` antes de interagir. Nunca assuma que a pagina carregou instantaneamente.

2. **Screenshots para debug**: Tire screenshot a cada passo importante. Isso ajuda a diagnosticar problemas e documenta o fluxo.

3. **Use seletores estaveis**: Prefira `[data-testid]`, `[name]`, `[id]`, e `text=` em vez de classes CSS que podem mudar.

4. **Feche o browser**: Sempre feche o browser/tab ao finalizar para liberar recursos. Use `close` no final do fluxo.

5. **Trate erros**: Se um clique falhar, tire screenshot e tente um seletor alternativo antes de desistir.

6. **Limite de tabs**: Nao abra muitas tabs simultaneamente. Cada tab consome memoria. Use e feche conforme necessario.

7. **Respeite os sites**: Adicione delays entre requisicoes (`evaluate: await new Promise(r => setTimeout(r, 1000))`) para nao sobrecarregar servidores. Siga robots.txt.

## Checklist de Verificacao

- [ ] MCP server do Playwright configurado em `config.yaml`
- [ ] Node.js e npx instalados no ambiente
- [ ] Chromium instalado (`npx playwright install chromium --with-deps`)
- [ ] Modo headless ativado em ambientes VPS/Docker
- [ ] Timeout adequado para paginas pesadas (120s+)
- [ ] Seletores estaveis (data-testid, name, id)
- [ ] Wait antes de cada interacao
- [ ] Screenshots para documentacao
- [ ] Browser fechado ao final do fluxo
- [ ] Tratamento de erros para elementos nao encontrados
