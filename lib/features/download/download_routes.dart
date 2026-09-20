import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// شاشة التنزيلات.
abstract final class DownloadRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/downloads', page: DownloadRoute.page),
      ];
}
