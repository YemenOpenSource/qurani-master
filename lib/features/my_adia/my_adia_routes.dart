import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات «أدعيتي».
///
/// البادئة المحجوزة لهذه الميزة: `/duas`.
///
/// المُعلَّم هو الغلاف `MuDoaProvider` لا `MuDoaScreen`: هو ما كان يُدفع قبل
/// الترحيل، وهو الاسم المسجَّل في `analytics_screen_names.dart`
/// (`MuDoaProviderRoute`). الغلاف ينشئ `SabihBloc` بنفسه ويتخلّص منه، فلا
/// يحتاج `AutoRouteWrapper`.
abstract final class MyAdiaRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/duas', page: MuDoaProviderRoute.page),
      ];
}
