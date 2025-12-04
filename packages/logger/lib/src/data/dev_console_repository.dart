import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/src/domain/domain.dart';
import 'package:package_info_plus/package_info_plus.dart';

@LazySingleton(as: IDevConsoleRepository)
final class DevConsoleRepository implements IDevConsoleRepository {
  @override
  Future<DebugInfoEntity> fetchDebugInfo() async {
    final [packageInfo as PackageInfo, deviceInfo as BaseDeviceInfo] = await Future.wait([
      _fetchPackageInfo(),
      _fetchDeviceInfo(),
    ]);

    return DebugInfoEntity.data(
      appVersion: packageInfo.version,
      appBuildNumber: packageInfo.buildNumber,
      flavor: appFlavor ?? '-',
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
