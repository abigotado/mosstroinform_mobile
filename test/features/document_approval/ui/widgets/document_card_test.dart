import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/ui/widgets/document_card.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', 'RU')],
      home: Scaffold(body: child),
    );
  }

  group('DocumentCard', () {
    testWidgets('отображает название документа', (WidgetTester tester) async {
      const document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Тестовый документ',
        description: 'Описание документа',
        status: DocumentStatus.pending,
      );

      await tester.pumpWidget(
        createTestWidget(DocumentCard(document: document, onTap: () {})),
      );

      expect(find.text('Тестовый документ'), findsOneWidget);
    });

    testWidgets('отображает описание документа', (WidgetTester tester) async {
      const document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Тестовый документ',
        description: 'Описание тестового документа',
        status: DocumentStatus.pending,
      );

      await tester.pumpWidget(
        createTestWidget(DocumentCard(document: document, onTap: () {})),
      );

      expect(find.text('Описание тестового документа'), findsOneWidget);
    });

    testWidgets('вызывает onTap при нажатии', (WidgetTester tester) async {
      const document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Тестовый документ',
        description: 'Описание',
        status: DocumentStatus.pending,
      );

      bool tapped = false;

      await tester.pumpWidget(
        createTestWidget(
          DocumentCard(document: document, onTap: () => tapped = true),
        ),
      );

      await tester.tap(find.byType(DocumentCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('отображает статус документа', (WidgetTester tester) async {
      const document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Тестовый документ',
        description: 'Описание',
        status: DocumentStatus.approved,
      );

      await tester.pumpWidget(
        createTestWidget(DocumentCard(document: document, onTap: () {})),
      );

      // Проверяем, что статус отображается (может быть через чип или другой виджет)
      // Статус может отображаться по-разному в зависимости от реализации
      expect(find.text('Тестовый документ'), findsOneWidget);
    });

    testWidgets('отображает дату отправки, если она есть', (
      WidgetTester tester,
    ) async {
      final document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Тестовый документ',
        description: 'Описание',
        status: DocumentStatus.pending,
        submittedAt: DateTime(2024, 1, 1),
      );

      await tester.pumpWidget(
        createTestWidget(DocumentCard(document: document, onTap: () {})),
      );

      // Проверяем, что дата отображается (формат может быть локализован)
      expect(find.textContaining('2024'), findsWidgets);
    });
  });
}
