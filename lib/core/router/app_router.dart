import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_route_transitions.dart';
// ignore: unused_import — يوفّر أصناف المسارات المولَّدة لهذا الملف.
import 'package:quran_app/core/router/app_router.gr.dart';
import 'package:quran_app/features/allh_name/allh_name_routes.dart';
import 'package:quran_app/features/another_screen/another_screen_routes.dart';
import 'package:quran_app/features/audios/audios_routes.dart';
import 'package:quran_app/features/bookmark/bookmark_routes.dart';
import 'package:quran_app/features/books/books_routes.dart';
import 'package:quran_app/features/categories/categories_routes.dart';
import 'package:quran_app/features/daily_wird/daily_wird_routes.dart';
import 'package:quran_app/features/download/download_routes.dart';
import 'package:quran_app/features/floating_adhkar/floating_adhkar_routes.dart';
import 'package:quran_app/features/hadith_40/hadith_40_routes.dart';
import 'package:quran_app/features/home/home_routes.dart';
import 'package:quran_app/features/home_widgets/home_widgets_routes.dart';
import 'package:quran_app/features/language/language_routes.dart';
import 'package:quran_app/features/my_adia/my_adia_routes.dart';
import 'package:quran_app/features/notification_schedules/notification_schedules_routes.dart';
import 'package:quran_app/features/onboarding/onboarding_routes.dart';
import 'package:quran_app/features/prayer_time/prayer_time_routes.dart';
import 'package:quran_app/features/qiblah/qiblah_routes.dart';
import 'package:quran_app/features/quran_audio/quran_audio_routes.dart';
import 'package:quran_app/features/quran_plan/quran_plan_routes.dart';
import 'package:quran_app/features/radio/radio_routes.dart';
import 'package:quran_app/features/read_quran/read_quran_routes.dart';
import 'package:quran_app/features/ruqia_shareia/ruqia_shareia_routes.dart';
import 'package:quran_app/features/sabih/sabih_routes.dart';
import 'package:quran_app/features/setting/setting_routes.dart';
import 'package:quran_app/features/setting_notification/setting_notification_routes.dart';
import 'package:quran_app/features/smart_outreach/smart_outreach_routes.dart';
import 'package:quran_app/features/thikr/thikr_routes.dart';
import 'package:quran_app/features/traveler/traveler_routes.dart';
import 'package:quran_app/features/wird/wird_routes.dart';
import 'package:quran_app/features/young_muslim/young_muslim_routes.dart';
import 'package:quran_app/features/zkar_after_pray/zkar_after_pray_routes.dart';

/// جذر موجّه التطبيق.
///
/// **هذا الملف يركّب ولا يُعرّف.** كل مسار يُعلَن داخل ملف ميزته
/// (`lib/features/<feature>/<feature>_routes.dart`)، فإضافة شاشة جديدة لا
/// تمرّ من هنا إطلاقًا — إلا إن كانت الميزة نفسها جديدة.
///
/// الترتيب مهم: `auto_route` يطابق المسارات بالترتيب، فأوّل تطابق يفوز.
/// لذلك تُنشر [HomeRoutes.fallbackRoutes] آخر شيء — لأن `path: '*'` يلتقط أي
/// عنوان ويبتلع كل ما بعده.
///
/// راجع `docs/ROUTING.md` قبل أي تعديل هنا.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  /// الانتقال الافتراضي: تلاشٍ 250ms — نفس سلوك `fadeNavigation` قبل الترحيل.
  ///
  /// تركه على قيمة `auto_route` الافتراضية يعني تحوّل التطبيق كلّه إلى
  /// انتقالات Material المفاجئة، وهو تدهور بصري صامت لا يظهر في أي اختبار.
  @override
  RouteType get defaultRouteType => AppRouteTransitions.fade;

  @override
  List<AutoRoute> get routes => [
        // الرئيسية أوّلًا — فيها المسار الابتدائي `/`.
        ...HomeRoutes.routes,

        // القرآن والوسائط
        ...ReadQuranRoutes.routes,
        ...QuranAudioRoutes.routes,
        ...AudiosRoutes.routes,
        ...RadioRoutes.routes,
        ...BooksRoutes.routes,
        ...BookmarkRoutes.routes,
        ...CategoriesRoutes.routes,
        ...AnotherScreenRoutes.routes,

        // الصلاة والموقع
        ...PrayerTimeRoutes.routes,
        ...QiblahRoutes.routes,
        ...TravelerRoutes.routes,

        // الأذكار والأدعية
        ...ThikrRoutes.routes,
        ...WirdRoutes.routes,
        ...ZkarAfterPrayRoutes.routes,
        ...MyAdiaRoutes.routes,
        ...SabihRoutes.routes,
        ...FloatingAdhkarRoutes.routes,
        ...AllhNameRoutes.routes,
        ...Hadith40Routes.routes,
        ...RuqiaShareiaRoutes.routes,

        // الخطط والأوراد
        ...DailyWirdRoutes.routes,
        ...QuranPlanRoutes.routes,

        // أقسام أخرى
        ...YoungMuslimRoutes.routes,
        ...SmartOutreachRoutes.routes,

        // النظام والإعدادات
        ...SettingRoutes.routes,
        ...SettingNotificationRoutes.routes,
        ...NotificationSchedulesRoutes.routes,
        ...DownloadRoutes.routes,
        ...HomeWidgetsRoutes.routes,
        ...LanguageRoutes.routes,
        ...OnboardingRoutes.routes,

        // يبقى آخر شيء على الإطلاق.
        ...HomeRoutes.fallbackRoutes,
      ];
}
