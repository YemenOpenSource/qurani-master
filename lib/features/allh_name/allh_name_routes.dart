import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات أسماء الله الحسنى.
///
/// البادئة المحجوزة لهذه الميزة: `/names-of-allah`.
abstract final class AllhNameRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/names-of-allah', page: AllhNameRoute.page),
      ];
}
