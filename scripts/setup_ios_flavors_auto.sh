#!/bin/bash

# Автоматическая настройка iOS flavors (mock и prod) в Xcode проекте
# Этот скрипт автоматически создает build configurations и схемы

set -e

PROJECT_DIR="ios"
PROJECT_FILE="$PROJECT_DIR/Runner.xcodeproj/project.pbxproj"
SCHEMES_DIR="$PROJECT_DIR/Runner.xcodeproj/xcshareddata/xcschemes"

echo "🚀 Автоматическая настройка iOS flavors..."

# Проверяем наличие проекта
if [ ! -f "$PROJECT_FILE" ]; then
    echo "❌ Ошибка: Файл проекта не найден: $PROJECT_FILE"
    exit 1
fi

# Проверяем наличие Ruby (нужен для работы с project.pbxproj)
if ! command -v ruby &> /dev/null; then
    echo "❌ Ошибка: Ruby не установлен. Установите Ruby для работы скрипта."
    exit 1
fi

# Создаем директорию для схем если её нет
mkdir -p "$SCHEMES_DIR"

echo "📝 Создание build configurations через xcodebuild..."

# Используем xcodebuild для добавления build configurations
# Сначала получаем список существующих конфигураций
EXISTING_CONFIGS=$(xcodebuild -project "$PROJECT_DIR/Runner.xcodeproj" -list 2>/dev/null | grep -A 10 "Build Configurations:" | tail -n +2 | awk '{print $1}' | grep -v "^$" || echo "")

# Проверяем, существуют ли уже конфигурации
if echo "$EXISTING_CONFIGS" | grep -q "Debug-mock"; then
    echo "⚠️  Build configurations уже существуют. Пропускаем создание."
else
    echo "⚠️  Автоматическое создание build configurations через xcodebuild не поддерживается."
    echo "📋 Необходимо создать build configurations вручную в Xcode:"
    echo ""
    echo "1. Откройте проект в Xcode:"
    echo "   open ios/Runner.xcworkspace"
    echo ""
    echo "2. Создайте Build Configurations:"
    echo "   - Выберите проект 'Runner' в навигаторе"
    echo "   - Перейдите на вкладку 'Info'"
    echo "   - В разделе 'Configurations' нажмите '+' и выберите 'Duplicate Debug Configuration'"
    echo "   - Переименуйте в 'Debug-mock'"
    echo "   - Повторите для 'Release' -> 'Release-mock'"
    echo "   - Повторите для 'Debug' -> 'Debug-prod'"
    echo "   - Повторите для 'Release' -> 'Release-prod'"
    echo ""
    read -p "Нажмите Enter после создания build configurations..."
fi

echo "📝 Создание схем mock и prod..."

# Создаем схему mock на основе Runner
cat > "$SCHEMES_DIR/mock.xcscheme" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1500"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "97C146ED1CF9000F007C117D"
               BuildableName = "Runner.app"
               BlueprintName = "Runner"
               ReferencedContainer = "container:Runner.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug-mock"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES"
      shouldAutocreateTestHost = "YES">
      <Testables>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug-mock"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "97C146ED1CF9000F007C117D"
            BuildableName = "Runner.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Release-mock"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "97C146ED1CF9000F007C117D"
            BuildableName = "Runner.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug-mock">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release-mock"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
EOF

# Создаем схему prod
cat > "$SCHEMES_DIR/prod.xcscheme" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1500"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "97C146ED1CF9000F007C117D"
               BuildableName = "Runner.app"
               BlueprintName = "Runner"
               ReferencedContainer = "container:Runner.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug-prod"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES"
      shouldAutocreateTestHost = "YES">
      <Testables>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug-prod"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "97C146ED1CF9000F007C117D"
            BuildableName = "Runner.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Release-prod"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "97C146ED1CF9000F007C117D"
            BuildableName = "Runner.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug-prod">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release-prod"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
EOF

echo "✅ Схемы mock и prod созданы!"

echo ""
echo "📋 Следующие шаги (выполните в Xcode):"
echo ""
echo "1. Откройте проект в Xcode:"
echo "   open ios/Runner.xcworkspace"
echo ""
echo "2. Если build configurations еще не созданы:"
echo "   - Выберите проект 'Runner' в навигаторе"
echo "   - Перейдите на вкладку 'Info'"
echo "   - В разделе 'Configurations' создайте:"
echo "     * Debug-mock (дубликат Debug)"
echo "     * Release-mock (дубликат Release)"
echo "     * Debug-prod (дубликат Debug)"
echo "     * Release-prod (дубликат Release)"
echo ""
echo "3. Настройте Bundle Identifier для каждого flavor (опционально):"
echo "   - Выберите Target 'Runner' > General > Signing & Capabilities"
echo "   - Для mock можно использовать: com.mosstroinform.mosstroinformMobile.mock"
echo ""
echo "4. Выполните pod install:"
echo "   cd ios && pod install"
echo ""
echo "✅ После этого вы сможете использовать:"
echo "   flutter run --flavor mock"
echo "   flutter run --flavor prod"
echo ""

