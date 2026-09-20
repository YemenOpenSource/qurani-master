import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_route_transitions.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات «المسلم الصغير».
///
/// البادئة المحجوزة لهذه الميزة: `/young-muslim`.
///
/// `YoungMuslimRouteScope` ليس صفحة ولا يُدفع كمسار: كل شاشة هنا تُنفّذ
/// `AutoRouteWrapper` وتعيد بناء النطاق من `get_it` بنفسها.
abstract final class YoungMuslimRoutes {
  static List<AutoRoute> get routes => [
        // نقطة الدخول. `YoungMuslimProvider` يبني المستودع والـbloc بنفسه
        // ويغلّف `YoungMuslimHomeScreen`، واسم المسار المولَّد
        // `YoungMuslimProviderRoute` هو ما تعتمد عليه خريطة التحليلات في
        // `lib/core/router/analytics_screen_names.dart`.
        //
        // يُدفع من الرئيسية بـ `context.push` العادي، فيبقى على التلاشي
        // الافتراضي دون `CustomRoute`.
        AutoRoute(path: '/young-muslim', page: YoungMuslimProviderRoute.page),

        // TODO(routing): `YoungMuslimHomeScreen` مُعلَّم بـ `@RoutePage()` لكنه
        // غير مُعلَن هنا عمدًا: مسار `/young-muslim` يُقدَّم عبر
        // `YoungMuslimProviderRoute` حفاظًا على اسم التحليلات. إن احتيج
        // للشاشة كمسار مستقل لاحقًا فَلها `/young-muslim/home`.

        // الشاشات الثلاث الداخلية كانت تُدفع عبر `youngMuslimPageRoute`
        // (تلاشٍ من 0.92 مع انزلاق، 260ms ذهابًا و220ms إيابًا).
        CustomRoute<void>(
          path: '/young-muslim/category/:categoryId',
          page: YoungMuslimCategoryRoute.page,
          transitionsBuilder: AppRouteTransitions.youngMuslimTransition,
          duration: AppRouteTransitions.youngMuslimDuration,
          reverseDuration: AppRouteTransitions.youngMuslimReverseDuration,
        ),
        CustomRoute<void>(
          path: '/young-muslim/video/:videoId',
          page: YoungMuslimVideoDetailsRoute.page,
          transitionsBuilder: AppRouteTransitions.youngMuslimTransition,
          duration: AppRouteTransitions.youngMuslimDuration,
          reverseDuration: AppRouteTransitions.youngMuslimReverseDuration,
        ),
        CustomRoute<void>(
          path: '/young-muslim/player/:videoId',
          page: YoungMuslimPlayerRoute.page,
          transitionsBuilder: AppRouteTransitions.youngMuslimTransition,
          duration: AppRouteTransitions.youngMuslimDuration,
          reverseDuration: AppRouteTransitions.youngMuslimReverseDuration,
        ),
      ];
}
