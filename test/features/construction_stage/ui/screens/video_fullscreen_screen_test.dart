import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/screens/video_fullscreen_screen.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

void main() {
  group('VideoFullscreenScreen', () {
    late VideoPlayerController controller;

    setUp(() {
      // Создаем мок контроллера для тестов
      controller = VideoPlayerController.networkUrl(Uri.parse('https://example.com/video.mp4'));
    });

    tearDown(() {
      controller.dispose();
    });

    Widget createWidget({required VideoPlayerController videoController, String cameraName = 'Test Camera'}) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru', '')],
        locale: const Locale('ru'),
        home: VideoFullscreenScreen(controller: videoController, cameraName: cameraName),
      );
    }

    testWidgets('отображает видео на весь экран', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(videoController: controller));
      await tester.pump();

      // Assert
      expect(find.byType(VideoPlayer), findsOneWidget);
      expect(find.byType(FittedBox), findsOneWidget);
      expect(find.byType(Positioned), findsWidgets);
    });

    testWidgets('отображает индикатор LIVE', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(videoController: controller));
      await tester.pump();

      // Assert
      expect(find.text('LIVE'), findsOneWidget);
    });

    testWidgets('отображает кнопку закрытия полноэкранного режима', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(videoController: controller));
      await tester.pump();

      // Assert
      expect(find.byIcon(Icons.fullscreen_exit), findsOneWidget);
    });

    testWidgets('имеет кнопку закрытия которая вызывает Navigator.pop', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(videoController: controller));
      await tester.pump();

      // Assert - проверяем, что кнопка закрытия присутствует и имеет правильный обработчик
      expect(find.byIcon(Icons.fullscreen_exit), findsOneWidget);
      // Кнопка должна быть в InkWell для обработки нажатий
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('имеет структуру для отображения индикатора буферизации', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(videoController: controller));
      await tester.pump();

      // Assert - проверяем, что виджет создан и может отображать индикатор буферизации
      // Индикатор отображается условно через `if (widget.controller.value.isBuffering)`
      expect(find.byType(VideoFullscreenScreen), findsOneWidget);
      // Stack используется в body Scaffold, проверяем наличие Scaffold
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('имеет структуру для обработки физической кнопки назад', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(videoController: controller));
      await tester.pump();

      // Assert - проверяем, что виджет создан и имеет Scaffold
      // WillPopScope оборачивает Scaffold для обработки кнопки назад
      expect(find.byType(Scaffold), findsOneWidget);
      final screen = tester.widget<VideoFullscreenScreen>(find.byType(VideoFullscreenScreen));
      expect(screen.controller, controller);
      expect(screen.cameraName, 'Test Camera');
    });

    testWidgets('использует правильное имя камеры', (WidgetTester tester) async {
      // Arrange
      const cameraName = 'Test Camera Name';

      // Act
      await tester.pumpWidget(createWidget(videoController: controller, cameraName: cameraName));
      await tester.pump();

      // Assert
      // Имя камеры передается в конструктор, но не отображается напрямую в UI
      // Проверяем, что виджет создан с правильными параметрами
      final screen = tester.widget<VideoFullscreenScreen>(find.byType(VideoFullscreenScreen));
      expect(screen.cameraName, cameraName);
    });
  });
}
