import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات ودجات الشاشة الرئيسية تحت البادئة `/widgets`.
abstract final class HomeWidgetsRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/widgets', page: HomeWidgetsRoute.page),
      ];
}
