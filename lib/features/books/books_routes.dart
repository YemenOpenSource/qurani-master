import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات الكتب تحت البادئة `/books`.
abstract final class BooksRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/books', page: BookRoute.page),
        // TODO(routing): `BookDetail` يستقبل كائنًا غير مُصنَّف (dynamic)، فهذا
        // المسار للدفع داخل التطبيق فقط ولا يُفتح برابط عميق حتى يُستبدَل
        // الوسيط بمعرّف كتاب.
        AutoRoute(path: '/books/detail', page: BookDetailRoute.page),
        // الرابط استعلام لا جزء من المسار: رابط الـ pdf يحوي شرطات مائلة
        // فلا يصلح مقطعًا في المسار — `/books/read?url=…`.
        AutoRoute(path: '/books/read', page: ReadBookRoute.page),
      ];
}
