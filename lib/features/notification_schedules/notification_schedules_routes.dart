import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مواعيد إشعار واحد؛ مفتاح الإشعار جزء من المسار ليكون الرابط عميقًا.
abstract final class NotificationSchedulesRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(
          path: '/settings/notifications/schedules/:notifKey',
          page: NotificationSchedulesRoute.page,
        ),
      ];
}
