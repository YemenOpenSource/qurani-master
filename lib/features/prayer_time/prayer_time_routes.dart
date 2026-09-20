import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات مواقيت الصلاة تحت البادئة `/prayer`.
abstract final class PrayerTimeRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/prayer', page: PrayerTimeRoute.page),
        AutoRoute(path: '/prayer/settings', page: PrayerTimeSettingsRoute.page),
        // يُفتح من ضغطة إشعار الأذان، فلا بدّ أن يكون قابلًا للربط العميق:
        // `/prayer/athan/<اسم الصلاة>?time=<الوقت>`.
        AutoRoute(
          path: '/prayer/athan/:prayerName',
          page: PrayerAthanAlertRoute.page,
        ),
      ];
}
