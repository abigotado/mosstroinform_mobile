#!/bin/bash

# Скрипт для настройки iOS flavors (mock и prod) в Xcode проекте
# Этот скрипт добавляет build configurations для mock и prod flavors

set -e

PROJECT_DIR="ios"
PROJECT_FILE="$PROJECT_DIR/Runner.xcodeproj/project.pbxproj"

echo "🚀 Настройка iOS flavors..."

# Проверяем наличие проекта
if [ ! -f "$PROJECT_FILE" ]; then
    echo "❌ Ошибка: Файл проекта не найден: $PROJECT_FILE"
    exit 1
fi

echo "⚠️  Внимание: Настройка iOS flavors требует ручного редактирования в Xcode."
echo ""
echo "📋 Инструкция по настройке iOS flavors:"
echo ""
echo "1. Откройте проект в Xcode:"
echo "   open ios/Runner.xcworkspace"
echo ""
echo "2. Создайте новые Build Configurations:"
echo "   - Выберите проект 'Runner' в навигаторе"
echo "   - Перейдите на вкладку 'Info'"
echo "   - В разделе 'Configurations' продублируйте 'Debug' и переименуйте в 'Debug-mock'"
echo "   - Продублируйте 'Release' и переименуйте в 'Release-mock'"
echo "   - Продублируйте 'Debug' и переименуйте в 'Debug-prod'"
echo "   - Продублируйте 'Release' и переименуйте в 'Release-prod'"
echo ""
echo "3. Создайте новые Schemes:"
echo "   - Product > Scheme > Manage Schemes..."
echo "   - Создайте схему 'mock' на основе 'Runner'"
echo "   - Создайте схему 'prod' на основе 'Runner'"
echo "   - Для схемы 'mock': Run -> Debug-mock, Archive -> Release-mock"
echo "   - Для схемы 'prod': Run -> Debug-prod, Archive -> Release-prod"
echo ""
echo "4. Настройте Bundle Identifier для каждого flavor:"
echo "   - Выберите Target 'Runner' > General"
echo "   - Для mock: com.mosstroinform.mosstroinformMobile.mock"
echo "   - Для prod: com.mosstroinform.mosstroinformMobile (основной)"
echo ""
echo "5. Обновите Podfile (если нужно):"
echo "   - Добавьте конфигурации в project 'Runner'"
echo ""
echo "6. Выполните pod install:"
echo "   cd ios && pod install"
echo ""
echo "✅ После настройки вы сможете использовать:"
echo "   flutter run --flavor mock --dart-define=FLAVOR=mock"
echo "   flutter run --flavor prod --dart-define=FLAVOR=prod"
echo ""

