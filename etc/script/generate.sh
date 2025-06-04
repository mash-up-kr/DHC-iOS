#!/bin/sh

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'
WORKSPACE_DIR="$(dirname "$(dirname "${SCRIPT_DIR}")")"

set -e

echo "${YELLOW}=== Generate Script ===${NC}"
echo ""

# Tuist install 실행
echo "\n[1] > Installing Tuist ...\n"
tuist install --path "${WORKSPACE_DIR}"

# Tuist generate 실행 및 프로젝트 open
echo "\n[2] > Generating Tuist ...\n"
TUIST_ROOT_DIR=$PWD tuist generate

echo "${GREEN}✅ Generate script finished!${NC}"
