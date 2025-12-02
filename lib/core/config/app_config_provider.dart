import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';

part 'app_config_provider.g.dart';

/// Провайдер для конфигурации приложения
@riverpod
AppConfigSimple appConfigSimple(Ref ref) {
  final flavor = AppConfigSimple.getFlavor();
  return AppConfigSimple.fromFlavor(flavor);
}

