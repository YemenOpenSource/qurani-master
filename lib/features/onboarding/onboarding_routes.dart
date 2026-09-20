import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// شاشات الصلاحيات في أوّل تشغيل.
abstract final class OnboardingRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(
          path: '/onboarding',
          page: PermissionsOnboardingRoute.page,
        ),
      ];
}
