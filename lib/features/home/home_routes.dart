import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات الشاشة الرئيسية.
///
/// [routes] تُنشر أوّل قائمة الجذر لأن فيها المسار الابتدائي `/`.
/// [fallbackRoutes] تُنشر **آخر** شيء على الإطلاق، لأن `path: '*'` يلتقط أي
/// عنوان ويبتلع كل ما يليه. الفصل بينهما مقصود: لولاه لتعارض الشرطان — أن
/// تكون الرئيسية أوّلًا وأن يكون الالتقاط الشامل أخيرًا.
abstract final class HomeRoutes {
  /// المسار الابتدائي للتطبيق.
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page, initial: true),
      ];

  /// مسار «صفحة غير موجودة». يجب أن يكون آخر عنصر في قائمة جذر الموجّه.
  static List<AutoRoute> get fallbackRoutes => [
        AutoRoute(path: '*', page: NotFoundRoute.page),
      ];
}
