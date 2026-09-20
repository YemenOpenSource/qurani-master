import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات الرقية الشرعية.
///
/// البادئة المحجوزة لهذه الميزة: `/ruqyah`.
///
// TODO(routing): `RuqiaShareiaScreen` لا يدفعها أحد في التطبيق اليوم — لا
// موضع نداء واحد خارج ملفّها. عُلّمت وسُجّل لها مسار حتى تبقى الميزة موصولة
// ويمكن بلوغها برابط عميق، لكن يلزم قرارٌ: إمّا وصلها من شاشة المكتبة وإمّا
// حذف الميزة.
abstract final class RuqiaShareiaRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/ruqyah', page: RuqiaShareiaRoute.page),
      ];
}
