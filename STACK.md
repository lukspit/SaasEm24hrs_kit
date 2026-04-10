# Referência Rápida da Stack

Comandos, snippets e URLs que você vai usar toda vez. Consulte aqui antes de perguntar para o agente.

---

## Comandos do Dia a Dia

```bash
# Desenvolvimento
npm run dev                          # sobe o servidor local

# Build
npm run build                        # verifica erros antes do deploy
npm run lint                         # checa problemas de código

# Supabase CLI
npx supabase start                   # sobe Supabase local (opcional)
npx supabase db diff                 # gera migration do schema atual
npx supabase gen types typescript    # atualiza tipos TypeScript

# Stripe CLI (test local de webhooks)
npx stripe listen --forward-to localhost:3000/api/webhooks/stripe
npx stripe trigger checkout.session.completed  # dispara evento de teste

# shadcn/ui (adicionar componentes)
npx shadcn@latest add [componente]   # ex: table, select, popover, calendar

# Deploy
npx vercel                           # preview deploy
npx vercel --prod                    # deploy de produção
```

---

## Links de Acesso Rápido

| Serviço | Painel | O que você faz lá |
|---------|--------|-------------------|
| Supabase | [supabase.com/dashboard](https://supabase.com/dashboard) | Schema, RLS, Auth, Logs |
| Stripe | [dashboard.stripe.com](https://dashboard.stripe.com) | Produtos, Preços, Webhooks, Pagamentos |
| Vercel | [vercel.com/dashboard](https://vercel.com/dashboard) | Deploy, Envs, Logs, Domínios |

---

## Supabase

### Chaves (Settings → API)
```
NEXT_PUBLIC_SUPABASE_URL          → Project URL
NEXT_PUBLIC_SUPABASE_ANON_KEY     → anon (public)
SUPABASE_SERVICE_ROLE_KEY         → service_role ← NUNCA no frontend
```

### Client por contexto
```typescript
// Client Component (browser)
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs'
const supabase = createClientComponentClient()

// Server Component
import { createServerComponentClient } from '@supabase/auth-helpers-nextjs'
import { cookies } from 'next/headers'
const supabase = createServerComponentClient({ cookies })

// Route Handler
import { createRouteHandlerClient } from '@supabase/auth-helpers-nextjs'
import { cookies } from 'next/headers'
const supabase = createRouteHandlerClient({ cookies })

// Operações admin server-side (webhook, scripts)
import { createClient } from '@supabase/supabase-js'
const supabase = createClient(url, process.env.SUPABASE_SERVICE_ROLE_KEY!)
```

### Pegar sessão
```typescript
// Server Component
const { data: { session } } = await supabase.auth.getSession()

// Client Component
const { data: { user } } = await supabase.auth.getUser()
```

### RLS — template de policy
```sql
-- Usuário só acessa os próprios dados
create policy "acesso_proprio" on public.tabela
  for all using (auth.uid() = user_id);

-- Verificar se usuário tem assinatura ativa
create policy "apenas_assinantes" on public.tabela
  for select using (
    exists (
      select 1 from public.subscriptions
      where user_id = auth.uid() and status = 'active'
    )
  );
```

---

## Stripe

### Chaves (Developers → API Keys)
```
pk_test_ / pk_live_   → NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY
sk_test_ / sk_live_   → STRIPE_SECRET_KEY (nunca no frontend)
whsec_               → STRIPE_WEBHOOK_SECRET (por endpoint)
```

### Cartões de teste
```
4242 4242 4242 4242   → pagamento aprovado
4000 0000 0000 9995   → pagamento recusado
4000 0025 0000 3155   → requer autenticação 3D
```
Qualquer data futura, qualquer CVC, qualquer CEP.

### Criar checkout session
```typescript
const session = await stripe.checkout.sessions.create({
  customer: stripeCustomerId,
  mode: 'subscription',           // ou 'payment' para pagamento único
  line_items: [{ price: priceId, quantity: 1 }],
  success_url: `${process.env.NEXT_PUBLIC_APP_URL}/dashboard?success=true`,
  cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/pricing`,
})
// redireciona para session.url
```

### Verificar webhook (obrigatório)
```typescript
const event = stripe.webhooks.constructEvent(
  await request.text(),           // body como texto, não JSON
  request.headers.get('stripe-signature')!,
  process.env.STRIPE_WEBHOOK_SECRET!
)
```

---

## Next.js App Router

### Proteção de rota (layout)
```typescript
// app/(dashboard)/layout.tsx
const { data: { session } } = await supabase.auth.getSession()
if (!session) redirect('/login')
```

### Route Handler com auth
```typescript
// app/api/[rota]/route.ts
export async function POST(request: Request) {
  const supabase = createRouteHandlerClient({ cookies })
  const { data: { session } } = await supabase.auth.getSession()
  if (!session) return Response.json({ error: 'Não autorizado' }, { status: 401 })
  // lógica aqui
}
```

### Invalidar cache após mutação
```typescript
import { revalidatePath } from 'next/cache'
revalidatePath('/dashboard')      // atualiza a página após inserção/update
```

---

## Componentes shadcn mais usados

```bash
# Adiciona quando precisar
npx shadcn@latest add table        # tabelas de dados
npx shadcn@latest add select       # dropdowns
npx shadcn@latest add calendar     # datas
npx shadcn@latest add popover      # popovers
npx shadcn@latest add sheet        # painéis laterais
npx shadcn@latest add tabs         # abas
npx shadcn@latest add avatar       # fotos de perfil
npx shadcn@latest add dropdown-menu # menus contextuais
```

---

## Erros Comuns e Solução Rápida

| Erro | Causa | Fix |
|------|-------|-----|
| `Error: No API key found` | Variável de env não carregou | Reinicia o `npm run dev` após mudar `.env.local` |
| `RLS policy violation` | Policy não existe para a operação | Verifica policies no Supabase Studio → Authentication → Policies |
| `Invalid webhook signature` | Secret errado ou body parseado como JSON | Usa `request.text()`, não `request.json()` antes do `constructEvent` |
| `cookies()` called outside request | Server Component sendo usado como Client | Adiciona `'use client'` ou move para Server Component |
| Hydration mismatch | Dado diferente entre server e cliente | Usa `useEffect` para dados que mudam só no cliente |
| Build falha em prod, funciona local | Variável de env não configurada na Vercel | Adiciona a variável no painel da Vercel e redeploya |
