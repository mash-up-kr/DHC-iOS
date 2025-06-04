#!/bin/sh

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'
WORKSPACE_DIR="$(dirname "$(dirname "${SCRIPT_DIR}")")"

set -e

echo "${YELLOW}=== Generate Script ===${NC}"
echo ""

echo "\n[1] > mise install and use tuist ...\n"
mise install tuist
mise use tuist@4.50.0

# 템플릿 설치
echo "\n[2] > Installing template ...\n"
./etc/script/install_template.sh

# Tuist install 실행
echo "\n[3] > Installing Tuist ...\n"
tuist install --path "${WORKSPACE_DIR}"

# Tuist generate 실행 및 프로젝트 open
echo "\n[4] > Generating Tuist ...\n"
TUIST_ROOT_DIR=$PWD tuist generate

echo "${GREEN}✅ Generate script finished!${NC}"
