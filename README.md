# SaaS em 24h — O Kit

> Instala o sistema que usei para construir o Garimpo em 24 horas direto no seu Claude Code.

---

## O que é isso

Um conjunto de arquivos que transforma o Claude Code numa equipe de elite para construir SaaS.

Não é curso. Não é teoria. É o sistema que uso todo dia — empacotado para você instalar em 60 segundos.

Você digita `/saas`, descreve o que quer construir, e o kit te guia da ideia até o produto no ar com pagamentos funcionando.

---

## O que está incluído

| Arquivo | Função |
|---|---|
| `CLAUDE.md` | O cérebro — stack, regras de segurança, mentalidade de builder |
| `/saas` | Orquestrador — detecta onde você está e chama o agente certo |
| `planner` | Define MVP e corta escopo antes de começar |
| `db-architect` | Schema Supabase + RLS + tipos TypeScript |
| `builder` | Implementa features em Next.js App Router |
| `designer` | UI/UX via shadcn/ui + Google Stitch |
| `monetizer` | Stripe completo — checkout, webhook, controle de acesso |
| `debugger` | Diagnóstico sistemático de bugs |
| `copywriter` | Copy da landing page e emails de onboarding |

---

## Instalação

```bash
curl -fsSL https://raw.githubusercontent.com/lukspit/SaasEm24hrs_kit/main/install.sh | bash
```

Pronto. Abre o Claude Code e digita `/saas`.

---

## Como funciona na prática

### Projeto do zero

```
Você: /saas

Kit: Projeto em branco detectado.
     Qual problema esse SaaS resolve? (1 frase)

Você: Quero um SaaS de agendamento para personal trainers

Kit: Entendido. Vou chamar o Planner para definir o MVP.
     [Planner entra em ação...]
     
     MVP definido. 3 features, modelo de assinatura R$97/mês.
     Posso criar o schema do banco agora?

Você: Sim

Kit: [DB Architect cria schema + RLS + tipos TypeScript]
     Schema pronto. Posso começar a implementar?
...
```

### Projeto que já existe

```
Você: /saas

Kit: Projeto detectado.
     Next.js ✓ | Supabase ✓ | Stripe ✗
     Você está na fase: MONETIZAÇÃO
     Próximo passo: configurar Stripe Checkout + webhook
     
     Posso começar agora?
```

---

## A stack

O kit é otimizado para:

- **Next.js 14+** com App Router e TypeScript
- **Supabase** (Auth, Postgres, RLS, Storage)
- **Stripe** (Checkout Sessions + Webhooks)
- **Vercel** (deploy)
- **shadcn/ui + Tailwind** (UI)
- **Google Stitch** (design system)

---

## Segurança embutida

O kit bloqueia ativamente padrões inseguros:

- Nunca escreve secrets no código — sempre `process.env`
- Cria RLS em todas as tabelas Supabase antes de qualquer operação
- Verifica assinatura em todo webhook Stripe
- Protege todas as rotas de API com verificação de sessão

---

## A jornada das 24h

```
DEFINE      →  MLP definido — 4 features na pirâmide, modelo de cobrança
FUNDAÇÃO    →  Next.js + Supabase configurados e seguros
CORE        →  Features funcionando (Functional + Reliable)
UI/UX       →  Experiência sem fricção + o momento "uau" (Usable + Delightful)
MONETIZA    →  Stripe rodando, pagamento testado
SHIP        →  No ar com copy que converte
```

### A pirâmide do MLP

Com IA, construir o básico é commodity. O kit te guia pelos 4 níveis:

```
        ★ Delightful   — o momento "uau" que gera indicação
       ★★★ Usable      — sem fricção, intuitivo
      ★★★★ Reliable    — não quebra, não frustra
    ★★★★★★ Functional  — faz o que promete
```

MVP tradicional para no primeiro nível. Com Claude Code, você sobe todos os 4 em 24h.

Cada fase tem um agente especializado. O orquestrador conduz o fluxo.

---

## Requisitos

- [Claude Code](https://claude.ai/code) instalado
- Conta no [Supabase](https://supabase.com) (free tier funciona)
- Conta no [Stripe](https://stripe.com) (test mode para começar)
- [Node.js](https://nodejs.org) 18+

---

## Estrutura após instalação

```
seu-projeto/
├── CLAUDE.md
└── .claude/
    ├── settings.json
    ├── commands/
    │   └── saas.md        ← /saas
    └── agents/
        ├── planner.md
        ├── db-architect.md
        ├── builder.md
        ├── designer.md
        ├── monetizer.md
        ├── debugger.md
        └── copywriter.md
```

---

## Licença

Uso pessoal e comercial liberado. Não redistribua o kit como produto próprio.

---

*Construído por [@lukspit](https://github.com/lukspit)*
