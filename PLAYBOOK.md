# O Playbook das 24h

> O fluxo exato para construir e lançar um SaaS do zero em menos de 24 horas usando Claude Code + este kit.

Não é teoria. É a sequência que funcionou para construir o Garimpo — um SaaS de enriquecimento de leads — da ideia ao primeiro pagante em menos de um dia.

---

## Antes de começar

Tenha em mãos:
- Conta no [Supabase](https://supabase.com) criada (free tier funciona)
- Conta no [Stripe](https://stripe.com) criada (modo test para começar)
- Conta na [Vercel](https://vercel.com) criada
- Node.js 18+ instalado
- Claude Code instalado e rodando

Tempo estimado real: **8 a 16 horas** dependendo da complexidade. "24h" é o teto, não a média.

---

## Fase 1 — Define (1-2h)

**Objetivo:** Sair com MLP definido, nome, modelo de cobrança e a feature "uau" identificada.

**Como fazer:**
```
/saas
```

O Planner vai fazer 4 perguntas. Responde com objetividade. Não romantiza o produto — pensa no primeiro pagante, não no produto ideal.

**Sinais de que esta fase está completa:**
- Você consegue descrever o produto em 1 frase
- Sabe exatamente quem vai pagar e quanto
- Identificou o elemento Delightful (o "uau")
- Tem 4 features, não 10

**Erro comum:** querer definir tudo antes de construir qualquer coisa. O plano vai mudar — o objetivo aqui é ter uma âncora, não um mapa perfeito.

---

## Fase 2 — Fundação (1-2h)

**Objetivo:** Next.js + Supabase + Auth rodando localmente.

**O que acontece:**
```bash
npx create-next-app@latest nome-do-projeto --typescript --tailwind --app
cd nome-do-projeto
```

O DB Architect vai criar:
- Schema com RLS em todas as tabelas
- Tipos TypeScript gerados automaticamente
- Migration pronta para rodar no Supabase

**Variáveis de ambiente:**
Copia `.env.example` para `.env.local` e preenche as chaves do Supabase antes de continuar.

**Sinais de que esta fase está completa:**
- `npm run dev` roda sem erro
- Login e cadastro funcionam
- Você consegue criar um registro no banco autenticado

---

## Fase 3 — Core (4-8h)

**Objetivo:** A feature principal funcionando de ponta a ponta.

Esta é a fase mais longa. O Builder implementa seguindo esta ordem para cada feature:

1. Route handler (API) com autenticação
2. Busca de dados no servidor
3. Componente de interação no cliente
4. Loading skeleton
5. Empty state com call-to-action
6. Estado de erro útil

**Regra de ouro desta fase:** uma feature por vez, do backend para o frontend. Não começa a segunda sem a primeira estar funcionando e testada manualmente.

**Sinais de que esta fase está completa:**
- Você consegue usar a feature principal sem travar em nenhum passo
- Os dados aparecem e somem do banco corretamente
- Funciona no mobile (testa no browser com viewport 375px)

---

## Fase 4 — UI/UX (1-2h)

**Objetivo:** A interface parece premium. O momento "uau" está implementado.

O Designer aplica o design system via shadcn/ui e Stitch. O foco aqui não é perfeição visual — é coerência e o elemento Delightful que você definiu na Fase 1.

**O que o Designer prioriza:**
1. Design system consistente (cores, tipografia, espaçamento)
2. O elemento Delightful — este é o ponto de diferença
3. Empty states com identidade (não as telas cinzas genéricas)
4. Loading states que não frustram

**Sinais de que esta fase está completa:**
- Um amigo olha e não parece "feito em 1 dia"
- O elemento Delightful está implementado e funciona
- Tudo tem loading state

---

## Fase 5 — Monetização (1-2h)

**Objetivo:** Stripe rodando, checkout testado, acesso controlado por plano.

O Monetizer implementa:
- Checkout Session
- Webhook handler com verificação de assinatura
- Controle de acesso por status de assinatura

**Teste obrigatório antes de avançar:**
```bash
npx stripe listen --forward-to localhost:3000/api/webhooks/stripe
```

Usa o cartão de teste `4242 4242 4242 4242` e confirma que:
- A assinatura aparece no banco depois do checkout
- O usuário tem acesso à feature paga
- O cancelamento remove o acesso

**Sinais de que esta fase está completa:**
- Pagamento de ponta a ponta funcionando em test mode
- Webhook recebendo e processando corretamente
- Acesso à feature paga é bloqueado sem assinatura ativa

---

## Fase 6 — Ship (1h)

**Objetivo:** No ar, com domínio, copy e pronto para receber o primeiro pagante.

**Deploy:**
```bash
vercel --prod
```

O Copywriter escreve:
- Headline e subheadline do hero
- Seção de problema e solução
- Pricing com um plano claro
- FAQ que remove as 5 principais objeções

**Configurações finais:**
- [ ] Variáveis de ambiente configuradas na Vercel
- [ ] Modo live do Stripe ativado (troca as chaves test → live)
- [ ] Webhook do Stripe apontando para a URL de produção
- [ ] Domínio configurado
- [ ] URLs de redirect do Supabase Auth atualizadas para o domínio de produção

**O primeiro link que você posta:**
Não é o produto. É a landing page com o botão de compra funcionando.

---

## Depois das 24h

O produto no ar é o começo, não o fim. Na semana seguinte:

- **Dia 2:** Manda o link para 10 pessoas que você acredita que são o avatar. Não para amigos — para o avatar real.
- **Dia 3-7:** Faz chamadas de discovery com quem se cadastrou. O que eles tentaram fazer que não conseguiram?
- **Semana 2:** Implementa o feedback mais frequente. Só o mais frequente.

O kit te ajuda em cada uma dessas iterações. `/saas` continua funcionando quando você voltar para construir a próxima feature.

---

## Erros que vão acontecer (e como resolver)

| Erro | Causa provável | Solução |
|------|---------------|---------|
| RLS violation no Supabase | Policy não criada para a operação | `/saas` → debug → DB Architect revisa as policies |
| Webhook do Stripe não recebido | URL errada ou secret incorreto | Checa o `STRIPE_WEBHOOK_SECRET` — é diferente por endpoint |
| Sessão não persiste no Next.js | Middleware de refresh não configurado | Builder adiciona o `middleware.ts` do Supabase Auth Helpers |
| Build falha na Vercel | Variável de ambiente faltando | Checa se todas as vars do `.env.local` estão na Vercel |
| Componente server/client misturado | `use client` no lugar errado | Builder revisa a separação entre Server e Client Components |

---

*Este playbook é vivo. Cada SaaS que você construir vai adicionar novos aprendizados aqui.*
