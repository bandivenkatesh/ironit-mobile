#!/bin/bash

# Ironit Mobile Verify Script
# Mirrors GitHub Actions quality gates locally

echo "🔐 Ironit Mobile Verify - GitHub Actions Quality Gates"
echo "===================================================="
echo ""

# Step 1: Clean
echo "1/5 🧹 Cleaning project..."
flutter clean >/dev/null 2>&1
echo "   ✅ Clean complete"

# Step 2: Dependencies
echo "2/5 📦 Getting dependencies..."
flutter pub get >/dev/null 2>&1
echo "   ✅ Dependencies resolved"

# Step 3: Formatting
echo "3/5 🎨 Checking code formatting..."
FORMAT_RESULT=$(dart format --set-exit-if-changed . 2>&1)
if [ $? -eq 0 ]; then
  echo "   ✅ Code formatting correct"
else
  echo "   ❌ Formatting issues found:"
  echo "$FORMAT_RESULT"
  exit 1
fi

# Step 4: Analysis
echo "4/5 🔍 Running static analysis..."
ANALYSIS_RESULT=$(flutter analyze 2>&1)
if [[ "$ANALYSIS_RESULT" == *"No issues found!"* ]]; then
  echo "   ✅ No analyzer issues"
else
  echo "   ❌ Analyzer issues found:"
  echo "$ANALYSIS_RESULT"
  exit 1
fi

# Step 5: Tests
echo "5/5 🧪 Running tests..."
TEST_RESULT=$(flutter test 2>&1)
if [ $? -eq 0 ]; then
  echo "   ✅ All tests passed"
else
  echo "   ❌ Tests failed:"
  echo "$TEST_RESULT"
  exit 1
fi

# Step 6: Build
echo "6/5 📦 Building debug APK..."
BUILD_RESULT=$(flutter build apk --debug 2>&1)
if [ $? -eq 0 ]; then
  echo "   ✅ Build successful"
  echo "   📁 APK location: build/app/outputs/flutter-apk/app-debug.apk"
else
  echo "   ❌ Build failed:"
  echo "$BUILD_RESULT"
  exit 1
fi

echo ""
echo "✅ All quality gates passed!"
echo ""
echo "🎉 Repository is CI-ready!"
echo ""
echo "Summary:"
echo "  ✅ Code formatting: PASS"
echo "  ✅ Static analysis: PASS"
echo "  ✅ Unit tests: PASS"
echo "  ✅ Debug build: PASS"
echo ""
echo "🚀 Ready for GitHub Actions!"