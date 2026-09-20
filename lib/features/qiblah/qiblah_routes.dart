import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات القبلة تحت البادئة `/qiblah`.
abstract final class QiblahRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/qiblah', page: QiblahMainRoute.page),
      ];
}
