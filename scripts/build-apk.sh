#!/bin/bash

# Ironit Mobile Build APK Script
# Build APK with various options

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to show usage
usage() {
  echo "Usage: $0 [OPTION]"
  echo ""
  echo "Options:"
  echo "  debug       Build debug APK (default)"
  echo "  profile     Build profile APK"
  echo "  release     Build release APK"
  echo "  clean       Clean before building"
  echo "  help        Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 debug"
  echo "  $0 release"
  echo "  $0 clean debug"
}

# Parse arguments
BUILD_TYPE="debug"
CLEAN_FIRST=false

for arg in "$@"; do
  case $arg in
    debug)
      BUILD_TYPE="debug"
      ;;
    profile)
      BUILD_TYPE="profile"
      ;;
    release)
      BUILD_TYPE="release"
      ;;
    clean)
      CLEAN_FIRST=true
      ;;
    help|--help|-h)
      usage
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $arg${NC}"
      usage
      exit 1
      ;;
  esac
done

echo -e "${BLUE}📦 Ironit Mobile APK Builder${NC}"
echo "================================="
echo ""

# Clean if requested
if [ "$CLEAN_FIRST" = true ]; then
  echo -e "${YELLOW}🧹 Cleaning project...${NC}"
  flutter clean >/dev/null 2>&1
  echo -e "${GREEN}✅ Clean complete${NC}"
  echo ""
fi

# Get dependencies
echo -e "${YELLOW}📦 Getting dependencies...${NC}"
flutter pub get >/dev/null 2>&1
echo -e "${GREEN}✅ Dependencies resolved${NC}"
echo ""

# Build APK
echo -e "${YELLOW}🔨 Building ${BUILD_TYPE} APK...${NC}"
START_TIME=$(date +%s)

case $BUILD_TYPE in
  debug)
    flutter build apk --debug
    OUTPUT_DIR="build/app/outputs/flutter-apk/"
    APK_NAME="app-debug.apk"
    ;;
  profile)
    flutter build apk --profile
    OUTPUT_DIR="build/app/outputs/flutter-apk/"
    APK_NAME="app-profile.apk"
    ;;
  release)
    flutter build apk --release
    OUTPUT_DIR="build/app/outputs/flutter-apk/"
    APK_NAME="app-release.apk"
    ;;
esac

BUILD_STATUS=$?
END_TIME=$(date +%s)
BUILD_DURATION=$((END_TIME - START_TIME))

if [ $BUILD_STATUS -eq 0 ]; then
  echo -e "${GREEN}✅ Build successful!${NC}"
  echo ""

  # Show APK info
  APK_PATH="${OUTPUT_DIR}${APK_NAME}"
  if [ -f "$APK_PATH" ]; then
    APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
    echo -e "${BLUE}📁 APK Information:${NC}"
    echo "  Location: $APK_PATH"
    echo "  Size: $APK_SIZE"
    echo "  Type: $BUILD_TYPE"
    echo "  Duration: ${BUILD_DURATION}s"
    echo ""
    echo -e "${GREEN}🎉 Build complete!${NC}"
  else
    echo -e "${RED}❌ APK not found at expected location${NC}"
    exit 1
  fi
else
  echo -e "${RED}❌ Build failed${NC}"
  exit 1
fi