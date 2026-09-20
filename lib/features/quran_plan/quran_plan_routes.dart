import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات «خطط الختمة».
///
/// البادئة المحجوزة لهذه الميزة: `/plans`.
abstract final class QuranPlanRoutes {
  static List<AutoRoute> get routes => [
        // `/plans` و `/plans/new` ثابتان، فيجب أن يسبقا `/plans/:planId`
        // وإلا التقط المسار المتغيّر كلمة `new` كمعرّف خطة.
        AutoRoute(path: '/plans', page: QuranPlanListRoute.page),
        AutoRoute(path: '/plans/new', page: QuranPlanAddRoute.page),
        AutoRoute(path: '/plans/:planId', page: QuranPlanSessionRoute.page),
      ];
}
