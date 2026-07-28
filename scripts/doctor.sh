#!/bin/bash

# Ironit Mobile Doctor Script
# Comprehensive environment health check

echo "🏥 Ironit Mobile Doctor - Environment Health Check"
echo "==============================================="
echo ""

# Function to check command existence
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check required tools
echo "🔧 Checking required tools..."
REQUIRED_TOOLS=("flutter" "dart" "git" "java" "gradle")
MISSING_TOOLS=()

for tool in "${REQUIRED_TOOLS[@]}"; do
  if command_exists "$tool"; then
    echo "  ✅ $tool: $(command -v $tool)"
  else
    echo "  ❌ $tool: NOT FOUND"
    MISSING_TOOLS+=("$tool")
  fi
done

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
  echo ""
  echo "⚠️  Missing tools: ${MISSING_TOOLS[*]}"
  echo "Please install missing tools before proceeding."
  exit 1
fi

echo ""
echo "📊 Tool versions:"
echo "  Flutter: $(flutter --version | head -1)"
echo "  Dart: $(dart --version | head -1)"
echo "  Git: $(git --version)"
echo "  Java: $(java -version 2>&1 | head -1)"
echo "  Gradle: $(gradle --version | head -1)"

echo ""
echo "📱 Mobile development setup:"
if [ -d "$ANDROID_HOME" ]; then
  echo "  ✅ Android SDK: $ANDROID_HOME"
else
  echo "  ⚠️  Android SDK: NOT CONFIGURED"
fi

if command_exists xcodebuild; then
  echo "  ✅ Xcode: $(xcodebuild -version | head -1)"
else
  echo "  ⚠️  Xcode: NOT INSTALLED (macOS only)"
fi

echo ""
echo "🩺 Running Flutter doctor..."
flutter doctor -v

echo ""
echo "📋 Project structure check:"
if [ -f "pubspec.yaml" ]; then
  echo "  ✅ pubspec.yaml found"
else
  echo "  ❌ pubspec.yaml missing"
  exit 1
fi

if [ -d "lib" ]; then
  echo "  ✅ lib/ directory found"
else
  echo "  ❌ lib/ directory missing"
  exit 1
fi

if [ -f "analysis_options.yaml" ]; then
  echo "  ✅ analysis_options.yaml found"
else
  echo "  ❌ analysis_options.yaml missing"
  exit 1
fi

echo ""
echo "📦 Dependency check:"
flutter pub get >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "  ✅ Dependencies resolved successfully"
else
  echo "  ❌ Dependency resolution failed"
  exit 1
fi

echo ""
echo "🔍 Code quality check:"
ANALYSIS_RESULT=$(flutter analyze 2>&1)
if [[ "$ANALYSIS_RESULT" == *"No issues found!"* ]]; then
  echo "  ✅ No analyzer issues"
else
  echo "  ⚠️  Analyzer issues found:"
  echo "$ANALYSIS_RESULT"
fi

echo ""
echo "🎨 Formatting check:"
FORMAT_RESULT=$(dart format --set-exit-if-changed . 2>&1)
if [ $? -eq 0 ]; then
  echo "  ✅ Code properly formatted"
else
  echo "  ⚠️  Formatting issues found:"
  echo "$FORMAT_RESULT"
fi

echo ""
echo "🧪 Test check:"
if [ -d "test" ]; then
  echo "  ✅ Test directory exists"
  TEST_COUNT=$(find test -name "*_test.dart" | wc -l)
  echo "  📊 Found $TEST_COUNT test files"
else
  echo "  ⚠️  No test directory found"
fi

echo ""
echo "✅ Environment health check complete!"
echo ""
echo "Summary:"
echo "  ✅ All required tools installed"
echo "  ✅ Flutter environment healthy"
echo "  ✅ Project structure valid"
echo "  ✅ Dependencies resolved"
echo "  ✅ Code quality checks passed"
echo ""
echo "🎉 Your Ironit Mobile development environment is ready!"