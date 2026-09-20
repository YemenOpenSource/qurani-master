import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات المكتبة والتصنيفات تحت البادئة `/categories`.
///
/// المقاطع الثابتة تسبق `:id` وإلّا ابتلعتها المعلمة فصارت `detail` معرّفًا.
abstract final class CategoriesRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/categories', page: CategoryRoute.page),
        // TODO(routing): `CategoryViewAllScreen` يستقبل قائمة نماذج جاهزة،
        // فالمسار للدفع داخل التطبيق فقط حتى يُختصر الوسيط إلى معرّف قسم.
        AutoRoute(path: '/categories/section', page: CategoryViewAllRoute.page),
        // TODO(routing): `CategoryDetailScreen` يستقبل `CategoryDetailModel`
        // كاملًا، فالمسار للدفع داخل التطبيق فقط حتى يُختصر الوسيط إلى معرّف.
        AutoRoute(path: '/categories/detail', page: CategoryDetailRoute.page),
        // TODO(routing): `CategoryDetailOptionScreen` يستقبل
        // `CategorySectionModel` كاملًا، فالمسار للدفع داخل التطبيق فقط.
        AutoRoute(
          path: '/categories/options',
          page: CategoryDetailOptionRoute.page,
        ),
        // TODO(routing): البيانات تُحمَّل من `?url=`؛ الرابط العميق بلا هذا
        // الاستعلام يفتح شاشة فارغة حتى تُشتقّ نقطة الـ api من `:id` وحده.
        AutoRoute(path: '/categories/:id', page: CategoryDataRoute.page),
      ];
}
