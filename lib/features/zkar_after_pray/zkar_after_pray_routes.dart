import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات أذكار ما بعد الصلاة.
///
/// البادئة المحجوزة لهذه الميزة: `/post-prayer-athkar`.
abstract final class ZkarAfterPrayRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(
          path: '/post-prayer-athkar',
          page: ZkarAfterPrayRoute.page,
        ),
      ];
}
