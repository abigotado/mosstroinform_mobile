import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';

/// Провайдер для управления режимом моков
final mockDataProvider = Provider<bool>((ref) {
  return AppConstants.useMocks;
});
