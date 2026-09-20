import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// إعدادات الإشعارات، وشاشة إشعارات النظام المتفرّعة عنها.
abstract final class SettingNotificationRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(
          path: '/settings/notifications',
          page: SettingNotificationRoute.page,
        ),
        AutoRoute(
          path: '/settings/notifications/system',
          page: SystemNotificationRoute.page,
        ),
      ];
}
