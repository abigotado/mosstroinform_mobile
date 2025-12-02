import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/widgets/camera_grid_item.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

void main() {
  Widget createWidget({required Camera camera, VoidCallback? onTap}) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', '')],
      locale: const Locale('ru'),
      home: Scaffold(
        body: SizedBox(
          width: 200,
          height: 300,
          child: CameraGridItem(camera: camera, onTap: onTap ?? () {}),
        ),
      ),
    );
  }

  testWidgets('отображает активную камеру', (WidgetTester tester) async {
    // Arrange
    final camera = Camera(
      id: '1',
      name: 'Камера 1',
      description: 'Описание камеры',
      isActive: true,
      streamUrl: 'https://example.com/stream.m3u8',
      thumbnailUrl: 'https://example.com/thumbnail.jpg',
    );

    // Act
    await tester.pumpWidget(createWidget(camera: camera));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Камера 1'), findsOneWidget);
    expect(find.text('Описание камеры'), findsOneWidget);
    expect(find.byIcon(Icons.videocam), findsWidgets);
  });

  testWidgets('отображает неактивную камеру', (WidgetTester tester) async {
    // Arrange
    final camera = Camera(
      id: '1',
      name: 'Камера 1',
      description: 'Описание камеры',
      isActive: false,
      streamUrl: 'https://example.com/stream.m3u8',
      thumbnailUrl: 'https://example.com/thumbnail.jpg',
    );

    // Act
    await tester.pumpWidget(createWidget(camera: camera));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Камера 1'), findsOneWidget);
    expect(find.text('Описание камеры'), findsOneWidget);
  });

  testWidgets('вызывает onTap при нажатии на активную камеру', (
    WidgetTester tester,
  ) async {
    // Arrange
    var tapped = false;
    final camera = Camera(
      id: '1',
      name: 'Камера 1',
      description: 'Описание камеры',
      isActive: true,
      streamUrl: 'https://example.com/stream.m3u8',
      thumbnailUrl: 'https://example.com/thumbnail.jpg',
    );

    // Act
    await tester.pumpWidget(
      createWidget(
        camera: camera,
        onTap: () {
          tapped = true;
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Assert
    expect(tapped, isTrue);
  });

  testWidgets('не вызывает onTap при нажатии на неактивную камеру', (
    WidgetTester tester,
  ) async {
    // Arrange
    var tapped = false;
    final camera = Camera(
      id: '1',
      name: 'Камера 1',
      description: 'Описание камеры',
      isActive: false,
      streamUrl: 'https://example.com/stream.m3u8',
      thumbnailUrl: 'https://example.com/thumbnail.jpg',
    );

    // Act
    await tester.pumpWidget(
      createWidget(
        camera: camera,
        onTap: () {
          tapped = true;
        },
      ),
    );
    await tester.pumpAndSettle();

    // Пытаемся тапнуть, но InkWell должен быть disabled
    final inkWell = tester.widget<InkWell>(find.byType(InkWell));
    expect(inkWell.onTap, isNull);

    // Assert
    expect(tapped, isFalse);
  });
}
