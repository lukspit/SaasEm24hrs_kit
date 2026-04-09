#!/bin/bash

set -e

# ─────────────────────────────────────────────
#  SaaS em 24h — O Kit
#  Instalador automático
# ─────────────────────────────────────────────

REPO="https://raw.githubusercontent.com/lukspit/SaasEm24hrs_kit/main"
TARGET_DIR="${1:-.}"  # instala na pasta atual por padrão

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${CYAN}  SaaS em 24h — O Kit  ${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# Verifica dependências
if ! command -v curl &> /dev/null; then
  echo "Erro: curl não encontrado. Instale o curl e tente novamente."
  exit 1
fi

# Cria estrutura de pastas
echo -e "${YELLOW}→ Criando estrutura de pastas...${RESET}"
mkdir -p "$TARGET_DIR/.claude/agents"
mkdir -p "$TARGET_DIR/.claude/commands"

# Download dos arquivos
echo -e "${YELLOW}→ Baixando o cérebro (CLAUDE.md)...${RESET}"
curl -fsSL "$REPO/CLAUDE.md" -o "$TARGET_DIR/CLAUDE.md"

echo -e "${YELLOW}→ Baixando o orquestrador (/saas)...${RESET}"
curl -fsSL "$REPO/.claude/commands/saas.md" -o "$TARGET_DIR/.claude/commands/saas.md"

echo -e "${YELLOW}→ Baixando configurações...${RESET}"
curl -fsSL "$REPO/.claude/settings.json" -o "$TARGET_DIR/.claude/settings.json"

echo -e "${YELLOW}→ Baixando agentes...${RESET}"
AGENTS=(planner db-architect builder designer monetizer debugger copywriter)
for agent in "${AGENTS[@]}"; do
  curl -fsSL "$REPO/.claude/agents/$agent.md" -o "$TARGET_DIR/.claude/agents/$agent.md"
  echo -e "   ${GREEN}✓${RESET} $agent"
done

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}  Instalação concluída!${RESET}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  O que foi instalado em ${CYAN}$TARGET_DIR${RESET}:"
echo ""
echo -e "  ${GREEN}✓${RESET} CLAUDE.md          — o cérebro"
echo -e "  ${GREEN}✓${RESET} /saas              — orquestrador (slash command)"
echo -e "  ${GREEN}✓${RESET} 7 agentes          — planner, db, builder, designer, stripe, debug, copy"
echo -e "  ${GREEN}✓${RESET} settings.json      — configurações e proteções"
echo ""
echo -e "  ${CYAN}Como usar:${RESET}"
echo -e "  1. Abra o Claude Code na pasta do seu projeto"
echo -e "  2. Digite: ${YELLOW}/saas${RESET}"
echo -e "  3. Siga o fluxo — o kit detecta onde você está e te guia"
echo ""
echo -e "  Dúvidas? github.com/lukspit/SaasEm24hrs_kit"
echo ""
