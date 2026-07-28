#!/bin/bash

# Ironit Mobile CI Local Script
# Run full CI pipeline locally

echo "🚀 Ironit Mobile CI Local - Full Pipeline"
echo "======================================"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to run command with error handling
run_command() {
  local step=$1
  local command=$2
  echo -e "${YELLOW}${step}${NC}"
  eval "$command"
  local status=$?
  if [ $status -ne 0 ]; then
    echo -e "${RED}❌ Command failed: ${command}${NC}"
    exit $status
  fi
  echo -e "${GREEN}✅ ${step} - SUCCESS${NC}"
  echo ""
}

# Step 1: Environment Info
echo -e "${YELLOW}📋 CI Pipeline Started: $(date)${NC}"
echo ""

# Step 2: Clean
run_command "1/7 🧹 Cleaning project" "flutter clean"

# Step 3: Dependencies
run_command "2/7 📦 Getting dependencies" "flutter pub get"

# Step 4: Formatting
run_command "3/7 🎨 Checking formatting" "dart format --set-exit-if-changed ."

# Step 5: Analysis
run_command "4/7 🔍 Running analysis" "flutter analyze"

# Step 6: Tests
run_command "5/7 🧪 Running tests" "flutter test"

# Step 7: Build
run_command "6/7 📦 Building APK" "flutter build apk --debug"

# Step 8: Verify APK exists
APK_PATH="build/app/outputs/flutter-apk/app-debug.apk"
if [ -f "$APK_PATH" ]; then
  APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
  echo -e "${GREEN}7/7 📁 APK verification${NC}"
  echo "   ✅ APK found: $APK_PATH"
  echo "   📏 Size: $APK_SIZE"
  echo ""
else
  echo -e "${RED}❌ APK not found at expected location${NC}"
  exit 1
fi

echo -e "${GREEN}🎉 CI Pipeline Completed Successfully!${NC}"
echo ""
echo "Summary:"
echo "  ✅ Environment: Ready"
echo "  ✅ Dependencies: Resolved"
echo "  ✅ Formatting: Correct"
echo "  ✅ Analysis: No issues"
echo "  ✅ Tests: All passing"
echo "  ✅ Build: Successful"
echo "  ✅ APK: Generated"
echo ""
echo "📊 Pipeline Duration: $(($SECONDS / 60)) minutes $(($SECONDS % 60)) seconds"
echo ""
echo "🚀 Repository is production-ready!"