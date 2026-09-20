import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// أقسام إضافية تُفتح من شبكة المميزات في الشاشة الرئيسية.
abstract final class AnotherScreenRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/sections/hisn-al-muslim', page: HisnMuslimRoute.page),
        AutoRoute(
          path: '/sections/surah-index',
          page: SurahWithAllDetailRoute.page,
        ),
      ];
}
