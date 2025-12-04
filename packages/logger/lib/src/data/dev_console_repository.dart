import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger/src/domain/domain.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class DevConsoleRepository implements IDevConsoleRepository {
  @override
  Future<DebugInfoEntity> fetchDebugInfo() async {
    final [packageInfo as PackageInfo, deviceInfo as BaseDeviceInfo] = await Future.wait([
      _fetchPackageInfo(),
      _fetchDeviceInfo(),
    ]);

    // Используем appFlavor из Flutter services или значение по умолчанию
    final flavor = appFlavor ?? 'unknown';

    return DebugInfoEntity.data(
      appVersion: packageInfo.version,
      appBuildNumber: packageInfo.buildNumber,
      flavor: flavor,
      deviceModel: switch (deviceInfo) {
        final IosDeviceInfo info => info.modelName,
        final AndroidDeviceInfo info => info.model,
        _ => null,
      },
      deviceOS: defaultTargetPlatform.name,
    );
  }

  Future<PackageInfo> _fetchPackageInfo() => PackageInfo.fromPlatform();

  Future<BaseDeviceInfo> _fetchDeviceInfo() => DeviceInfoPlugin().deviceInfo;
}
