import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// شاشة الإعدادات وصفحات التعريف المتفرّعة عنها.
abstract final class SettingRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/settings', page: SettingRoute.page),
        AutoRoute(path: '/settings/about', page: AboutAppRoute.page),
        AutoRoute(path: '/settings/developer', page: DeveloperAboutRoute.page),
        AutoRoute(
          path: '/settings/privacy-policy',
          page: PrivacyPolicyRoute.page,
        ),
        AutoRoute(path: '/settings/data-safety', page: DataSafetyRoute.page),
      ];
}
