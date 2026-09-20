import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات الأربعين النووية.
///
/// البادئة المحجوزة لهذه الميزة: `/hadith-40`.
abstract final class Hadith40Routes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/hadith-40', page: Hadith40Route.page),
      ];
}
