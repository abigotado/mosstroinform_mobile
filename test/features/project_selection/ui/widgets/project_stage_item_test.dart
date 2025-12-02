import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_stage_item.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

void main() {
  Widget createWidget(ConstructionStage stage) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', '')],
      locale: const Locale('ru'),
      home: Scaffold(body: ProjectStageItem(stage: stage)),
    );
  }

  testWidgets('отображает этап со статусом completed', (
    WidgetTester tester,
  ) async {
    // Arrange
    const stage = ConstructionStage(
      id: '1',
      name: 'Фундамент',
      status: StageStatus.completed,
    );

    // Act
    await tester.pumpWidget(createWidget(stage));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Фундамент'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('отображает этап со статусом inProgress', (
    WidgetTester tester,
  ) async {
    // Arrange
    const stage = ConstructionStage(
      id: '1',
      name: 'Стены',
      status: StageStatus.inProgress,
    );

    // Act
    await tester.pumpWidget(createWidget(stage));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Стены'), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
  });

  testWidgets('отображает этап со статусом pending', (
    WidgetTester tester,
  ) async {
    // Arrange
    const stage = ConstructionStage(
      id: '1',
      name: 'Крыша',
      status: StageStatus.pending,
    );

    // Act
    await tester.pumpWidget(createWidget(stage));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Крыша'), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
  });
}
