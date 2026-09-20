import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات قراءة المصحف تحت البادئة `/quran`.
abstract final class ReadQuranRoutes {
  static List<AutoRoute> get routes => [
        // الصفحة استعلام لا جزء من المسار: `/quran` وحده يفتح من حيث وقف
        // القارئ، و`/quran?page=3` يفتح صفحة بعينها. لو صارت `:page` لتعذّر
        // فتح المصحف بلا رقم.
        AutoRoute(path: '/quran', page: ReadQuranRoute.page),
      ];
}
