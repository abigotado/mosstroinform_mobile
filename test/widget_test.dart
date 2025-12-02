// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';
import 'package:mosstroinform_mobile/main.dart';

void main() {
  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final config = AppConfigSimple.dev();
    await tester.pumpWidget(
      ProviderScope(
        child: MosstroinformApp(config: config),
      ),
    );

    // Verify that app title is displayed
    expect(find.text('Стройконтроль Онлайн'), findsWidgets);
  });
}
