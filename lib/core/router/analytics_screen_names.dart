import 'package:flutter/widgets.dart';

/// تحويل اسم مسار `auto_route` إلى اسم الشاشة كما تعرفه لوحة Firebase Analytics.
///
/// ## لماذا هذا الملف موجود
///
/// قبل الترحيل كان `RouteSettings.name` يُشتقّ من صنف الودجت المدفوعة
/// (`page.runtimeType.toString()` في `screenRouteSettings`)، فكانت الأسماء
/// المسجَّلة مثل «PrayerTimeScreen».
///
/// بعد الترحيل صار `auto_route` هو من يضع الاسم، وهو يسمّي المسار
/// «PrayerTimeRoute». لو تُرك الأمر هكذا لتغيّر اسم **كل** شاشة في لوحة
/// التحليلات دفعةً واحدة، ولانقطعت كل التقارير التاريخية عن سابقاتها.
///
/// فنعيد الاشتقاق هنا: نحذف اللاحقة `Route` ونضع مكانها `Screen`، ونُبقي
/// [_aliases] للحالات التي كان اسمها المسجَّل مختلفًا عن اسم صنفها.
///
/// تنبيه: أسماء الأصناف تبقى مقروءة في بناء release **ما لم** يُستعمل
/// `--obfuscate`.
String? tamaneenaScreenNameExtractor(RouteSettings settings) {
  final name = settings.name;
  if (name == null || name.isEmpty) {
    return null;
  }

  final alias = _aliases[name];
  if (alias != null) {
    return alias;
  }

  if (name.endsWith(_routeSuffix)) {
    final base = name.substring(0, name.length - _routeSuffix.length);
    if (base.isNotEmpty) {
      return '$base$_screenSuffix';
    }
  }

  return name;
}

const String _routeSuffix = 'Route';
const String _screenSuffix = 'Screen';

/// الشاشات التي كان اسمها في التحليلات لا يطابق «<اسم الصنف>».
///
/// كانت تُدفع ملفوفة بـ `BlocProvider.value`، فمُرِّر لها `screenName` يدويًا
/// لأن اسم صنف الغلاف («BlocProvider<…>») لا يدلّ على شيء. نحافظ على نفس
/// الأسماء حتى لا تنقطع التقارير.
const Map<String, String> _aliases = <String, String>{
  // sabih: شاشة التحليلات عامّة الاسم، وسُجّلت دائمًا باسم مخصّص.
  'AnalyticsRoute': 'TasbeehAnalyticsScreen',

  // أغلفة تُوفّر البلوك لشاشتها — سُجّلت باسم الغلاف نفسه قبل الترحيل.
  'TasbeehProviderRoute': 'TasbeehProvider',
  'MuDoaProviderRoute': 'MuDoaProvider',
  'FloatingAdhkarProviderRoute': 'FloatingAdhkarProvider',
  'YoungMuslimProviderRoute': 'YoungMuslimProvider',
};
