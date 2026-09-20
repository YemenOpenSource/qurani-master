import 'package:auto_route/auto_route.dart';

/// مسارات العلامات المرجعية تحت البادئة `/bookmarks`.
///
/// القائمة فارغة عمدًا: الميزة اليوم واجهاتها ألسنة داخل شاشة المصحف
/// (`book_mark_page_tab.dart` و`bookmark_aya_tab.dart`) وكلّها معطّلة
/// بالكامل، فليس فيها شاشة تُدفع كوجهة. البادئة محجوزة لحين عودتها.
abstract final class BookmarkRoutes {
  static List<AutoRoute> get routes => const <AutoRoute>[];
}
