import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// اختيار لغة الواجهة.
///
/// الرابط العميق `/language` يفتح وجه الإعدادات (`isOnboarding = false`)، وهو
/// الوجه الوحيد الذي يصحّ الوصول إليه من خارج التطبيق؛ وجه البداية يُدفع من
/// داخل التطبيق بـ `LanguagePickerRoute(isOnboarding: true)`.
abstract final class LanguageRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/language', page: LanguagePickerRoute.page),
      ];
}
