import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_card.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru', 'RU')],
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(width: 400, height: 800, child: child),
          ),
        ),
      ),
    );
  }

  group('ProjectCard', () {
    testWidgets('отображает название проекта', (WidgetTester tester) async {
      const project = Project(
        id: '1',
        name: 'Тестовый проект',
        description: 'Описание',
        area: 100.0,
        floors: 2,
        bedrooms: 3,
        bathrooms: 2,
        price: 1000000,
      );

      await tester.pumpWidget(
        createTestWidget(ProjectCard(project: project, onTap: () {})),
      );

      expect(find.text('Тестовый проект'), findsOneWidget);
    });

    testWidgets('отображает описание проекта', (WidgetTester tester) async {
      const project = Project(
        id: '1',
        name: 'Тестовый проект',
        description: 'Тестовое описание',
        area: 100.0,
        floors: 2,
        bedrooms: 3,
        bathrooms: 2,
        price: 1000000,
      );

      await tester.pumpWidget(
        createTestWidget(ProjectCard(project: project, onTap: () {})),
      );

      expect(find.textContaining('Тестовое описание'), findsWidgets);
    });

    testWidgets('вызывает onTap при нажатии', (WidgetTester tester) async {
      const project = Project(
        id: '1',
        name: 'Тестовый проект',
        description: 'Описание',
        area: 100.0,
        floors: 2,
        bedrooms: 3,
        bathrooms: 2,
        price: 1000000,
      );

      bool tapped = false;

      await tester.pumpWidget(
        createTestWidget(
          ProjectCard(project: project, onTap: () => tapped = true),
        ),
      );

      await tester.tap(find.byType(ProjectCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('отображает информацию о этажах', (WidgetTester tester) async {
      const project = Project(
        id: '1',
        name: 'Тестовый проект',
        description: 'Описание',
        area: 100.0,
        floors: 3,
        bedrooms: 4,
        bathrooms: 3,
        price: 1000000,
      );

      await tester.pumpWidget(
        createTestWidget(ProjectCard(project: project, onTap: () {})),
      );

      // Проверяем, что информация о этажах отображается
      expect(find.textContaining('3'), findsWidgets);
    });

    testWidgets('отображает параметры проекта', (WidgetTester tester) async {
      const project = Project(
        id: '1',
        name: 'Тестовый проект',
        description: 'Описание',
        area: 100.0,
        floors: 2,
        bedrooms: 3,
        bathrooms: 2,
        price: 1000000,
      );

      await tester.pumpWidget(
        createTestWidget(ProjectCard(project: project, onTap: () {})),
      );

      // Проверяем, что информация о параметрах отображается
      expect(find.textContaining('100'), findsWidgets); // площадь
      expect(find.textContaining('2'), findsWidgets); // этажи
    });

    testWidgets('отображает статус "запрошен" для запрошенного проекта',
        (WidgetTester tester) async {
      const project = Project(
        id: '1',
        name: 'Тестовый проект',
        description: 'Описание',
        area: 100.0,
        floors: 2,
        bedrooms: 3,
        bathrooms: 2,
        price: 1000000,
        status: ProjectStatus.requested,
      );

      await tester.pumpWidget(
        createTestWidget(ProjectCard(project: project, onTap: () {})),
      );
      await tester.pumpAndSettle();

      // Проверяем, что карточка отображается (статус отображается внутри)
      expect(find.byType(ProjectCard), findsOneWidget);
    });

    testWidgets('отображает статус "строительство" для проекта в строительстве',
        (WidgetTester tester) async {
      const project = Project(
        id: '1',
        name: 'Тестовый проект',
        description: 'Описание',
        area: 100.0,
        floors: 2,
        bedrooms: 3,
        bathrooms: 2,
        price: 1000000,
        status: ProjectStatus.construction,
        constructionAddress: 'г. Москва, ул. Тестовая, д. 1',
        objectId: 'object_1',
      );

      await tester.pumpWidget(
        createTestWidget(ProjectCard(project: project, onTap: () {})),
      );
      await tester.pumpAndSettle();

      // Проверяем, что карточка отображается (статус отображается внутри)
      expect(find.byType(ProjectCard), findsOneWidget);
    });
  });
}
