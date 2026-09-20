import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات الإذاعة تحت البادئة `/radio`.
abstract final class RadioRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/radio', page: RadioRoute.page),
      ];
}
