import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات الورد (أذكار الصباح والمساء).
///
/// البادئة المحجوزة لهذه الميزة: `/wird`.
///
/// `WirdScreen.isMorning` وسيطُ مسارٍ من نوع `bool`، و`auto_route` لا يفكّ من
/// الوسائط المنطقية إلا `true`/`false`، فالمسار الذي يولّده `WirdRoute` هو
/// `/wird/true` أو `/wird/false`. ولأن الروابط العامّة يجب أن تُقرأ، نضع
/// `/wird/morning` و`/wird/evening` تحويلتين إليهما.
///
/// الترتيب مقصود: التحويلتان قبل المسار ذي الوسيط، وإلا ابتلع `:isMorning`
/// الكلمتين قبل أن تصلا إلى `RedirectRoute`.
//
// TODO(routing): جعل `:period` وسيطًا نصّيًا حقيقيًا (`morning`/`evening`)
// يقتضي تغيير نوع وسيط `WirdScreen` من `bool` إلى `String`، وهو تغيير يمسّ
// كل موضع نداء (`main_thikr_screen.dart`، `thikr_slider.dart`،
// `daily_wird_destination_resolver.dart`)، فتُرك خارج هذه الخطوة.
abstract final class WirdRoutes {
  static List<AutoRoute> get routes => [
        RedirectRoute(path: '/wird/morning', redirectTo: '/wird/true'),
        RedirectRoute(path: '/wird/evening', redirectTo: '/wird/false'),
        AutoRoute(path: '/wird/:isMorning', page: WirdRoute.page),
      ];
}
