import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:home_widget/home_widget.dart';
import 'package:quran_app/core/router/app_router.gr.dart';
import 'package:quran_app/core/services/navigation_service.dart';
import 'package:quran_app/features/home_widgets/data/home_widget_ids.dart';

/// يفتح الشاشة المناسبة عند الضغط على ودجت.
///
/// روابط الودجات: `tamaneena://widget/<name>?homeWidget`
/// - `next-prayer` و`prayer-times` ← شاشة المواقيت.
/// - `daily-ayah` ← الرئيسية نفسها، وفيها آية اليوم؛ لا انتقال.
abstract final class HomeWidgetClickRouter {
  static StreamSubscription<Uri?>? _subscription;

  /// يُنادى مرّة بعد أوّل إطار، حين يكون الملاح جاهزًا.
  static void attach() {
    if (_subscription != null) return;

    // الإقلاع من ضغطة ودجت والتطبيق مغلق.
    unawaited(
      HomeWidget.initiallyLaunchedFromHomeWidget()
          .then(_open)
          .catchError((Object _) {}),
    );
    // الضغط والتطبيق يعمل في الخلفية.
    _subscription = HomeWidget.widgetClicked.listen(
      _open,
      onError: (Object _) {},
    );
  }

  static void _open(Uri? uri) {
    if (uri == null ||
        uri.scheme != HomeWidgetIds.linkScheme ||
        uri.host != HomeWidgetIds.linkHost) {
      return;
    }

    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;

    switch (uri.pathSegments.firstOrNull) {
      case 'next-prayer':
      case 'prayer-times':
        // `navigate` لا `push`: الضغط على الودجت مرارًا يجب ألّا يكدّس نسخًا
        // من الشاشة نفسها فوق بعضها.
        unawaited(context.router.navigate(const PrayerTimeRoute()));
      // 'daily-ayah' بلا وجهة عمدًا: الودجت يعرض الآية، والضغطة تفتح التطبيق
      // على الرئيسية فحسب.
    }
  }
}
