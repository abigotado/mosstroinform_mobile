// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mosstroinform_mobile/app.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';

void main() {
  test('App widget can be instantiated', () {
    // Test that the app widget can be created without compilation errors
    final config = AppConfigSimple.mock();
    final app = MosstroinformApp(config: config);
    expect(app, isNotNull);
    expect(app.config, equals(config));
  });
}
