YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

set -e

echo "${YELLOW}=== Bootstrap Script ===${NC}"
echo ""

# mise 설치
if ! command -v mise &> /dev/null; then
  echo "\n[1] > Installing mise ...\n"
  curl https://mise.run | sh
else
  echo "mise is already installed."
fi

# mise 활성화
echo "\n[2] > Activating mise ...\n"
if ! grep -q 'eval "$(~/.local/bin/mise activate zsh)"' ~/.zshrc; then
  echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
else
  echo "mise is already activated in ~/.zshrc"
fi

# fastlane match를 통한 development Cert, Provisioning 가져오기
echo "\n[3] > Getting development Cert and Provisioning ...\n"
fastlane match development --readonly
fastlane match appstore --readonly

echo -e "${GREEN}✅ Bootstrap script finished!${NC}"

