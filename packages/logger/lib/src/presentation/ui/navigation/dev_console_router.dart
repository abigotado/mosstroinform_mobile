import 'package:auto_route/auto_route.dart';

import 'package:logger/src/presentation/ui/navigation/dev_console_router.gr.dart';

export 'dev_console_router.gr.dart';

@AutoRouterConfig()
class DevConsoleRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(path: '/dev-console', page: DevConsoleRoute.page)];
}
