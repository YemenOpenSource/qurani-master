import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات مكتبة الأذكار.
///
/// البادئة المحجوزة لهذه الميزة: `/thikr`.
abstract final class ThikrRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/thikr', page: MainThikrRoute.page),
      ];
}
