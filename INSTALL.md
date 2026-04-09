# SaaS em 24h — O Kit
### Instalação em 60 segundos

---

## Pré-requisitos

- [Claude Code](https://claude.ai/code) instalado
- Terminal aberto na pasta do seu projeto (ou numa pasta vazia)

---

## Instalação

Cole este comando no terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/[seu-usuario]/saas-24h-kit/main/install.sh | bash
```

O script vai:
1. Copiar o `CLAUDE.md` para a raiz do seu projeto
2. Copiar os agentes para `.claude/commands/` e `agents/`
3. Aplicar o `settings.json` com as configurações recomendadas

---

## Instalação manual (alternativa)

Se preferir fazer na mão:

```bash
# 1. Clone o kit
git clone https://github.com/[seu-usuario]/saas-24h-kit.git /tmp/kit

# 2. Copie os arquivos para o seu projeto
cp /tmp/kit/CLAUDE.md ./CLAUDE.md
cp -r /tmp/kit/.claude ./
cp -r /tmp/kit/agents ./

# 3. Pronto
```

---

## Como usar

Abra o Claude Code na pasta do projeto e digite:

```
/saas
```

Só isso. O kit detecta em que fase você está e te guia a partir daí.

---

## O que você tem agora

```
seu-projeto/
├── CLAUDE.md              ← O cérebro: regras, stack, segurança
├── .claude/
│   ├── settings.json      ← Configurações e proteções
│   └── commands/
│       └── saas.md        ← /saas: o orquestrador
└── agents/
    ├── planner.md         ← Define MVP e features
    ├── db-architect.md    ← Schema Supabase + RLS
    ├── builder.md         ← Implementa as features
    ├── designer.md        ← UI/UX via shadcn + Stitch
    ├── monetizer.md       ← Stripe completo
    ├── debugger.md        ← Resolve bugs sistemicamente
    └── copywriter.md      ← Copy da landing page
```

---

## Como os agentes funcionam

Você não precisa chamar os agentes diretamente. O orquestrador `/saas` faz isso automaticamente.

Mas se quiser chamar um agente específico, pode. Exemplos:

| Você quer | Digite |
|-----------|--------|
| Definir o MVP do zero | `/saas` (ele redireciona para o planner) |
| Só resolver um bug | `/saas` → descreve o bug |
| Só criar copy | `/saas` → "preciso da copy da landing page" |

---

## Perguntas frequentes

**Posso usar em projetos que já existem?**
Sim. O orquestrador lê o que já existe e entra na fase correta.

**Funciona sem a stack Next.js + Supabase + Stripe?**
O kit é otimizado para essa stack. Funciona parcialmente em outras, mas o resultado vai ser melhor na stack recomendada.

**Os agentes têm acesso ao meu código?**
Sim, dentro do Claude Code. Eles leem os arquivos do projeto para dar respostas contextuais. Nada sai da sua máquina — é o Claude Code local.

**Posso modificar os agentes?**
Sim, e é encorajado. Os arquivos `.md` são texto. Edita conforme seu contexto.

---

## Suporte

Dúvidas e feedbacks: [seu canal de suporte]

---

*Kit criado por [seu nome] — construído com a mesma stack que usou para fazer o Garimpo em 24h.*
