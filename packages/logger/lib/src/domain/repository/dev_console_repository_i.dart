import 'package:logger/src/domain/entity/debug_info_entity.dart';

abstract interface class IDevConsoleRepository {
  Future<DebugInfoEntity> fetchDebugInfo();
}
