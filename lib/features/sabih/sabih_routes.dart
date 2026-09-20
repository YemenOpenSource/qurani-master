import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات المسبحة.
///
/// البادئة المحجوزة لهذه الميزة: `/tasbeeh`.
///
/// المُعلَّم للمسبحة هو الغلاف `TasbeehProvider` لا `TasbeehScreen`: هو ما كان
/// يُدفع قبل الترحيل، وهو الاسم المسجَّل في `analytics_screen_names.dart`
/// (`TasbeehProviderRoute`).
///
/// `AnalyticsRoute` يُسجَّل في التحليلات باسم `TasbeehAnalyticsScreen` عبر
/// جدول الأسماء المستعارة في `core/router/` — لا شيء يُفعل هنا بشأنه.
abstract final class SabihRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/tasbeeh', page: TasbeehProviderRoute.page),
        AutoRoute(path: '/tasbeeh/analytics', page: AnalyticsRoute.page),
      ];
}
