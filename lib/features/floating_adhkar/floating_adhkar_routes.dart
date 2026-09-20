import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات الأذكار العائمة.
///
/// البادئة المحجوزة لهذه الميزة: `/floating-athkar`.
///
/// المُعلَّم للشاشة الرئيسة هو الغلاف `FloatingAdhkarProvider` لا
/// `FloatingAdhkarScreen`: هو ما كان يُدفع قبل الترحيل، وهو الاسم المسجَّل في
/// `analytics_screen_names.dart` (`FloatingAdhkarProviderRoute`).
///
/// شاشتا «أذكاري» و«الإعدادات» كانتا تُدفعان ملفوفتين بـ `BlocProvider.value`،
/// فصار كلٌّ منهما يحلّ `FloatingAdhkarBloc` من `get_it` في `wrappedRoute`.
///
/// ما تحت `floating_adhkar/overlay/` عالمٌ آخر: عزلة مستقلّة بـ `MaterialApp`
/// خاصّة بها وبلا `Navigator`، فلا مسار لها هنا ولا `@RoutePage`.
abstract final class FloatingAdhkarRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(
          path: '/floating-athkar',
          page: FloatingAdhkarProviderRoute.page,
        ),
        AutoRoute(
          path: '/floating-athkar/my-athkar',
          page: FloatingAdhkarMyAdhkarRoute.page,
        ),
        AutoRoute(
          path: '/floating-athkar/settings',
          page: FloatingAdhkarSettingsRoute.page,
        ),
      ];
}
