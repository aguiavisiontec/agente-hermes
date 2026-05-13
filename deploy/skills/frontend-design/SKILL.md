---
name: frontend-design
description: "Use quando o usuario precisar criar interfaces visuais, prototipos HTML/CSS, landing pages, componentes de UI, design systems ou qualquer trabalho de design frontend."
version: 1.0.0
author: Aguiavision Solucoes Tecnologicas com IA
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [frontend, design, UI, UX, HTML, CSS, JavaScript, React, Next.js, Tailwind, responsivo, prototipo, landing-page, design-system, aguiavitech]
    related_skills: [skill-creator, plan]
---

# Frontend Design — Design e Desenvolvimento de Interfaces

## Visao Geral

Este skill guia o agente na criacao de interfaces visuais profissionais, desde prototipos rapidos ate sistemas de design completos. Abrange HTML/CSS/JavaScript, frameworks modernos (React, Next.js, Vue), sistemas de estilizacao (Tailwind CSS, CSS Modules, Styled Components) e princípios de design responsivo e acessivel.

O objetivo e produzir interfaces que sejam visualmente atraentes, funcionalmente solidas e tecnicamente bem construidas, seguindo as melhores praticas da industria e os padroes de acessibilidade WCAG.

## Quando Usar

Use este skill quando:
- O usuario pedir para criar uma landing page, site ou prototipo web
- O usuario quiser construir componentes de UI reutilizaveis
- O usuario precisar de um design system ou guia de estilo
- O usuario pedir melhorias visuais em uma interface existente
- O usuario quiser criar layouts responsivos para mobile e desktop
- O usuario descrever um design visual que precisa ser implementado em codigo
- O usuario quiser prototipar uma ideia de produto rapidamente

**Nao use para:**
- Logica de backend ou APIs (use skills de backend)
- Analise de dados ou visualizacoes complexas (use skills de data-science)
- Animacoes 3D ou WebGL avancado (use skills especificas de 3D)
- Aplicativos mobile nativos (este skill e focado em web)

## Processo de Design

### 1. Compreender o Briefing

Antes de escrever qualquer codigo, esclareça:

- **Objetivo**: Qual e o proposito da interface? (vendas, informacao, dashboard, portfolio)
- **Publico-alvo**: Quem vai usar? (empresas, consumidores, devs, criancas)
- **Tom visual**: Formal, casual, ludico, minimalista, corporativo?
- **Referencias**: Ha algum site ou marca que o usuario quer como inspiracao?
- **Funcionalidades**: Quais interacoes sao necessarias? (formularios, navegacao, filtros, modais)
- **Restricoes**: Orçamento, prazo, stack tecnico definido?

### 2. Planejar a Estrutura

Crie um esboco mental da arquitetura:

```
Layout:
├── Header (nav, logo, CTA)
├── Hero Section (titulo, subtitulo, imagem/botao)
├── Features Section (grid de 3-4 cards)
├── Testimonials (carrossel ou grid)
├── CTA Section (chamada para acao final)
└── Footer (links, redes sociais, copyright)
```

### 3. Escolher a Stack

| Stack | Quando Usar | Vantagem |
|-------|-------------|----------|
| **HTML + Tailwind CDN** | Prototipo rapido, landing page simples | Zero build, arquivo unico |
| **Next.js + Tailwind + shadcn/ui** | Aplicacao completa, dashboard, SaaS | Componentes robustos, SSR |
| **React + Vite + Tailwind** | SPA interativa, web app | Rapido desenvolvimento |
| **Vue + Nuxt + Tailwind** | Equipes Vue, projetos SEO-criticos | SSR nativo, ecossistema Vue |
| **HTML + CSS puro** | Email, documento estatico, maxima compatibilidade | Sem dependencias |

### 4. Implementar por Camadas

Siga esta ordem de implementacao:

1. **Estrutura HTML** — Semantica e acessibilidade primeiro
2. **Layout CSS** — Grid, flexbox, espacamento
3. **Tipografia e Cores** — Hierarquia visual
4. **Componentes** — Botoes, cards, formularios
5. **Interacoes** — Hover, focus, transicoes
6. **Responsividade** — Mobile-first breakpoints
7. **Animacoes** — Micro-interacoes e transicoes

## Princípios de Design

### Hierarquia Visual

Estabeleça uma hierarquia clara com:

- **Tamanho**: Elementos maiores = mais importancia
- **Cor**: Cores vivas para CTAs, tons neutros para fundo
- **Contraste**: Texto legivel sobre qualquer fundo (WCAG AA minimo 4.5:1)
- **Espacamento**: Mais espaco = mais destaque
- **Posicao**: Topo e esquerda recebem mais atencao

### Paleta de Cores

Use uma paleta limitada e coesa:

```
Cores Primarias:
- primary: #2563EB (azul — acao, links, CTAs)
- primary-dark: #1D4ED8 (hover)
- primary-light: #3B82F6 (fundo sutil)

Cores Neutras:
- gray-900: #111827 (texto principal)
- gray-600: #4B5563 (texto secundario)
- gray-400: #9CA3AF (bordas, divisores)
- gray-100: #F3F4F6 (fundo alternado)
- white: #FFFFFF (fundo principal)

Cores Semantica:
- success: #10B981 (verde — confirmacao)
- warning: #F59E0B (amarelo — alerta)
- error: #EF4444 (vermelho — erro)
- info: #3B82F6 (azul — informacao)
```

### Tipografia

Sistemas tipograficos recomendados:

```css
/* Sistema Moderno (sans-serif) */
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

/* Sistema Serif (editorial/elegante) */
font-family: 'Merriweather', Georgia, 'Times New Roman', serif;

/* Sistema Mono (tecnico/codigo) */
font-family: 'JetBrains Mono', 'Fira Code', 'Consolas', monospace;
```

Escala tipografica (Mobile-first):

```css
/* Base: 16px */
h1: clamp(2rem, 5vw, 3.5rem)    /* 32-56px */
h2: clamp(1.5rem, 4vw, 2.5rem)  /* 24-40px */
h3: clamp(1.25rem, 3vw, 1.75rem) /* 20-28px */
body: 1rem (16px)
small: 0.875rem (14px)
```

### Espacamento

Use uma escala consistente (4px base):

```
4px  — micro espacamento (icon-text gap)
8px  — pequeno (padding interno de badges)
12px — medio (gap entre items de lista)
16px — padrao (padding de botoes, margin de paragrafos)
24px — grande (spacing entre secoes mobile)
32px — secoes (spacing entre secoes desktop)
48px — hero (padding de hero sections)
64px — macro (spacing entre blocos grandes)
```

## Componentes Essenciais

### Botao (Tailwind)

```html
<!-- Primario -->
<button class="inline-flex items-center justify-center px-6 py-3 text-sm font-semibold text-white bg-blue-600 rounded-lg hover:bg-blue-700 focus:ring-4 focus:ring-blue-300 transition-colors">
  Call to Action
</button>

<!-- Secundario -->
<button class="inline-flex items-center justify-center px-6 py-3 text-sm font-semibold text-blue-600 bg-white border-2 border-blue-600 rounded-lg hover:bg-blue-50 focus:ring-4 focus:ring-blue-100 transition-colors">
  Secundario
</button>

<!-- Ghost -->
<button class="inline-flex items-center justify-center px-4 py-2 text-sm font-medium text-gray-700 hover:text-blue-600 hover:bg-gray-100 rounded-lg transition-colors">
  Ghost
</button>
```

### Card

```html
<div class="bg-white rounded-xl border border-gray-200 shadow-sm hover:shadow-md transition-shadow overflow-hidden">
  <img src="image.jpg" alt="" class="w-full h-48 object-cover">
  <div class="p-6">
    <h3 class="text-lg font-semibold text-gray-900 mb-2">Titulo do Card</h3>
    <p class="text-gray-600 text-sm leading-relaxed">Descricao concisa do conteudo.</p>
    <a href="#" class="inline-flex items-center mt-4 text-sm font-medium text-blue-600 hover:text-blue-700">
      Saiba mais &rarr;
    </a>
  </div>
</div>
```

### Navbar Responsiva

```html
<nav class="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-gray-200">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex items-center justify-between h-16">
      <!-- Logo -->
      <div class="flex items-center gap-2">
        <div class="w-8 h-8 bg-blue-600 rounded-lg"></div>
        <span class="font-bold text-gray-900">Marca</span>
      </div>
      <!-- Desktop Menu -->
      <div class="hidden md:flex items-center gap-8">
        <a href="#" class="text-sm font-medium text-gray-700 hover:text-blue-600 transition-colors">Produto</a>
        <a href="#" class="text-sm font-medium text-gray-700 hover:text-blue-600 transition-colors">Recursos</a>
        <a href="#" class="text-sm font-medium text-gray-700 hover:text-blue-600 transition-colors">Preco</a>
        <button class="px-4 py-2 text-sm font-semibold text-white bg-blue-600 rounded-lg hover:bg-blue-700 transition-colors">Comecar</button>
      </div>
      <!-- Mobile Toggle -->
      <button class="md:hidden p-2 text-gray-700 hover:bg-gray-100 rounded-lg" onclick="toggleMenu()">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
        </svg>
      </button>
    </div>
  </div>
</nav>
```

### Formulario

```html
<form class="max-w-md mx-auto space-y-6">
  <div>
    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
    <input type="email" id="email" name="email" required
      class="w-full px-4 py-3 border border-gray-300 rounded-lg text-gray-900 placeholder-gray-400 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors"
      placeholder="seu@email.com">
  </div>
  <div>
    <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Senha</label>
    <input type="password" id="password" name="password" required
      class="w-full px-4 py-3 border border-gray-300 rounded-lg text-gray-900 placeholder-gray-400 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors"
      placeholder="Sua senha">
  </div>
  <button type="submit"
    class="w-full px-4 py-3 text-sm font-semibold text-white bg-blue-600 rounded-lg hover:bg-blue-700 focus:ring-4 focus:ring-blue-300 transition-colors">
    Entrar
  </button>
</form>
```

## Landing Page Template Completa

Use este template como base para landing pages:

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Produto — Slogan Atraente</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-white text-gray-900 antialiased">
  <!-- Navbar -->
  <nav class="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-gray-100">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-between h-16">
      <span class="text-xl font-bold text-blue-600">Produto</span>
      <div class="hidden md:flex items-center gap-8">
        <a href="#features" class="text-sm text-gray-600 hover:text-blue-600">Recursos</a>
        <a href="#pricing" class="text-sm text-gray-600 hover:text-blue-600">Preco</a>
        <a href="#testimonials" class="text-sm text-gray-600 hover:text-blue-600">Depoimentos</a>
        <button class="px-5 py-2.5 text-sm font-semibold text-white bg-blue-600 rounded-lg hover:bg-blue-700 transition-all">Comecar Gratis</button>
      </div>
    </div>
  </nav>

  <!-- Hero -->
  <section class="relative overflow-hidden">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 lg:py-32 text-center">
      <div class="inline-flex items-center gap-2 px-4 py-1.5 bg-blue-50 text-blue-700 rounded-full text-sm font-medium mb-8">
        Novo: Recurso Incrivel
      </div>
      <h1 class="text-4xl sm:text-5xl lg:text-6xl font-extrabold tracking-tight text-gray-900 mb-6">
        Transforme seu <span class="text-blue-600">workflow</span> com inteligencia
      </h1>
      <p class="max-w-2xl mx-auto text-lg text-gray-600 mb-10">
        A plataforma que automatiza tarefas repetitivas e libera seu tempo para o que realmente importa.
      </p>
      <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
        <button class="w-full sm:w-auto px-8 py-4 text-base font-semibold text-white bg-blue-600 rounded-xl hover:bg-blue-700 shadow-lg shadow-blue-500/25 transition-all">
          Comecar Gratis &rarr;
        </button>
        <button class="w-full sm:w-auto px-8 py-4 text-base font-semibold text-gray-700 bg-white border border-gray-300 rounded-xl hover:bg-gray-50 transition-all">
          Ver Demo
        </button>
      </div>
    </div>
  </section>

  <!-- Features Grid -->
  <section id="features" class="py-24 bg-gray-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="text-center mb-16">
        <h2 class="text-3xl font-bold text-gray-900 mb-4">Tudo que voce precisa</h2>
        <p class="text-lg text-gray-600 max-w-2xl mx-auto">Recursos poderosos projetados para simplificar seu dia a dia.</p>
      </div>
      <div class="grid md:grid-cols-3 gap-8">
        <!-- Feature Card (replicar 3x) -->
        <div class="bg-white p-8 rounded-2xl border border-gray-200 hover:border-blue-200 hover:shadow-lg transition-all">
          <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center text-blue-600 mb-5">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
          </div>
          <h3 class="text-lg font-semibold text-gray-900 mb-2">Recurso 1</h3>
          <p class="text-gray-600 text-sm leading-relaxed">Descricao clara e concisa do que este recurso faz e como beneficia o usuario.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- CTA Final -->
  <section class="py-24">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center bg-blue-600 rounded-3xl py-16 px-8">
      <h2 class="text-3xl font-bold text-white mb-4">Pronto para comecar?</h2>
      <p class="text-blue-100 text-lg mb-8">Junte-se a milhares de usuarios que ja transformaram seu workflow.</p>
      <button class="px-8 py-4 text-base font-semibold text-blue-600 bg-white rounded-xl hover:bg-blue-50 shadow-lg transition-all">
        Criar Conta Gratuita
      </button>
    </div>
  </section>

  <!-- Footer -->
  <footer class="py-12 border-t border-gray-200">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col md:flex-row items-center justify-between gap-4">
      <span class="text-sm text-gray-500">&copy; 2026 Produto. Todos os direitos reservados.</span>
      <div class="flex items-center gap-6">
        <a href="#" class="text-sm text-gray-500 hover:text-gray-700">Privacidade</a>
        <a href="#" class="text-sm text-gray-500 hover:text-gray-700">Termos</a>
        <a href="#" class="text-sm text-gray-500 hover:text-gray-700">Contato</a>
      </div>
    </div>
  </footer>
</body>
</html>
```

## Design Responsivo

### Breakpoints Padrao (Tailwind)

| Breakpoint | Largura | Uso |
|------------|---------|-----|
| `sm` | 640px | Telefone em paisagem |
| `md` | 768px | Tablet |
| `lg` | 1024px | Laptop |
| `xl` | 1280px | Desktop |
| `2xl` | 1536px | Desktop grande |

### Regras Mobile-First

1. **Sempre comece com o design mobile** — adicione complexidade para telas maiores
2. **Touch targets minimo 44x44px** — botoes e links clicaveis
3. **Texto legivel sem zoom** — minimo 16px para body text
4. **Formularios com input grande** — minimo 44px de altura
5. **Navegacao colapsavel** — hamburger menu em mobile
6. **Imagens responsivas** — `max-width: 100%; height: auto;`

## Acessibilidade (WCAG 2.1 AA)

Toda interface DEVE seguir estas regras minimas:

1. **Contraste**: Texto normal 4.5:1, texto grande 3:1 (verifique com WebAIM Contrast Checker)
2. **Texto alternativo**: Toda imagem funcional deve ter `alt` descritivo
3. **Navegacao por teclado**: Todos os interativos devem ser acessiveis via Tab
4. **Focus visivel**: Sempre mostre outline em `:focus-visible`
5. **Labels**: Todo input deve ter `<label>` associado ou `aria-label`
6. **Semanticidade**: Use `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>`
7. **Skip link**: Inclua link "Pular para conteudo" no inicio

```html
<!-- Skip link (oculto visualmente, visivel para screen readers) -->
<a href="#main" class="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 focus:z-50 focus:px-4 focus:py-2 focus:bg-blue-600 focus:text-white focus:rounded">
  Pular para conteudo principal
</a>
```

## Animacoes e Transicoes

Use animacoes com moderacao — elas devem guiar o usuario, nao distrair:

```css
/* Transicao suave padrao */
.transition-all { transition: all 150ms ease; }

/* Hover em cards */
.card:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }

/* Fade in para conteudo */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
.fade-in { animation: fadeIn 0.3s ease-out; }

/* Respeitar preferencia de motion reduzido */
@media (prefers-reduced-motion: reduce) {
  * { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
```

## Erros Comuns

1. **Usar px fixos para tudo**: Use `rem`/`em` para tipografia e `clamp()` para fluid typography. Pixels fixos quebram em diferentes tamanhos de tela.

2. **Ignorar estados de foco**: Remover outline sem substituir por alternativa visivel prejudica acessibilidade. Use `focus-visible:ring` como alternativa.

3. **Cores sem contraste suficiente**: Cinza claro em fundo branco e ilegivel. Sempre verifique o ratio de contraste.

4. **Imagens sem alt text**: Screen readers nao podem descrever imagens sem `alt`. Imagens decorativas usam `alt=""`.

5. **Layout que quebra em mobile**: Teste sempre em viewport de 320px (iPhone SE). Use `overflow-x: hidden` como safety net.

6. **Fontes nao carregadas (FOIT/FOUT)**: Use `font-display: swap` e `preconnect` para Google Fonts. Tenha fallbacks adequados.

7. **Z-index descontrolado**: Defina uma escala de z-index (10, 20, 30, 40, 50) e documente cada nivel.

## Checklist de Verificacao

- [ ] Layout responsivo testado em mobile (320px), tablet (768px) e desktop (1280px)
- [ ] Contraste de cores atende WCAG AA (4.5:1 para texto normal)
- [ ] Todos os inputs tem labels associados
- [ ] Imagens funcionais tem alt text descritivo
- [ ] Navegacao funciona apenas com teclado (Tab, Enter, Escape)
- [ ] Focus states sao visiveis em todos os interativos
- [ ] Formularios tem validacao e mensagens de erro claras
- [ ] Animacoes respeitam `prefers-reduced-motion`
- [ ] HTML semantico (`<nav>`, `<main>`, `<section>`, etc.)
- [ ] Performance: imagens otimizadas, CSS nao-bloqueante, fonts com preload
- [ ] Skip link presente no inicio da pagina
- [ ] Meta viewport configurado corretamente
