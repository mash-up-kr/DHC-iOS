RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/template/DHComposableArchitecture"
TARGET_DIR="$HOME/Library/Developer/Xcode/Templates/File Templates"

echo -e "${YELLOW}=== Xcode Template 설치 스크립트 ===${NC}"
echo ""

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}❌ 오류: 템플릿 소스 디렉토리를 찾을 수 없습니다.${NC}"
    echo -e "   경로: $SOURCE_DIR"
    echo -e "   현재 디렉토리에 template/DHComposableArchitecture 폴더가 있는지 확인해주세요."
    exit 1
fi

echo -e "${YELLOW}📋 템플릿 복사 중...${NC}"
echo -e "   소스: $SOURCE_DIR"
echo -e "   대상: $TARGET_DIR"
echo ""

cp -R "$SOURCE_DIR" "$TARGET_DIR/"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ 템플릿 설치가 완료되었습니다!${NC}"
else
    echo -e "${RED}❌ 오류: 템플릿 복사에 실패했습니다.${NC}"
    exit 1
fi
