import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// انتقالات الصفحات الموحّدة للتطبيق.
///
/// قبل `auto_route` كان كل انتقال يمرّ عبر `fadeNavigation` في
/// `navigator_manager.dart`: تلاشٍ مدّته 250ms بمنحنى [Curves.easeInOut].
/// نعيد الشيء نفسه هنا حتى لا يتغيّر إحساس التطبيق بعد الترحيل — لو تُركت
/// القيم الافتراضية لتحوّل التطبيق كلّه إلى انتقالات Material المفاجئة.
abstract final class AppRouteTransitions {
  /// مدّة التلاشي الافتراضية — مطابقة لـ `fadeNavigation` السابقة.
  static const Duration fadeDuration = Duration(milliseconds: 250);

  /// مدّة انتقال «المسلم الصغير» ذهابًا.
  static const Duration youngMuslimDuration = Duration(milliseconds: 260);

  /// مدّة انتقال «المسلم الصغير» إيابًا.
  static const Duration youngMuslimReverseDuration =
      Duration(milliseconds: 220);

  /// الانتقال الافتراضي لكل مسارات التطبيق.
  static RouteType get fade => RouteType.custom(
        transitionsBuilder: fadeTransition,
        duration: fadeDuration,
        reverseDuration: fadeDuration,
      );

  /// انتقال قسم «المسلم الصغير»: تلاشٍ من 0.92 مع انزلاق خفيف لأعلى.
  ///
  /// يقابل `youngMuslimPageRoute` في `young_muslim_shared_widgets.dart`.
  static RouteType get youngMuslim => RouteType.custom(
        transitionsBuilder: youngMuslimTransition,
        duration: youngMuslimDuration,
        reverseDuration: youngMuslimReverseDuration,
      );

  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }

  static Widget youngMuslimTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.92, end: 1).animate(curved),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
