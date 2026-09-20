import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';
import 'package:quran_app/core/services/json_loader_service.dart';
import 'package:quran_app/features/daily_wird/data/models/daily_wird_program_item_model.dart';
import 'package:quran_app/l10n/l10n.dart';

/// يحوّل عنصر الورد اليومي إلى المسار الذي يفتحه.
///
/// كان يعيد ودجت جاهزة تُدفع مباشرة. بعد الترحيل إلى `auto_route` صار يعيد
/// `PageRouteInfo`، فالوجهة تحمل عنوانًا يُسجَّل في التحليلات ويُفتح من رابط
/// أو إشعار، لا مجرّد شجرة ودجت بلا هوية.
class DailyWirdDestinationResolver {
  const DailyWirdDestinationResolver._();

  /// المسار المقابل للعنصر، أو `null` إن لم تكن له وجهةٌ خاصّة — وعندها يفتح
  /// المستدعي شاشة التركيز العامّة.
  static PageRouteInfo<dynamic>? resolve(DailyWirdItem item) {
    switch (item.type) {
      case 'quran':
      case 'surah':
        return ReadQuranRoute();
      case 'counted_dhikr':
        return const TasbeehProviderRoute();
      case 'dhikr_set':
        return _resolveDhikrSet(item);
      case 'dua':
        return _resolveDua(item);
      default:
        return null;
    }
  }

  static PageRouteInfo<dynamic> _resolveDhikrSet(DailyWirdItem item) {
    switch (item.timeCategory) {
      case 'morning':
        return WirdRoute(isMorning: true);
      case 'evening':
        return WirdRoute(isMorning: false);
      default:
        break;
    }

    if (item.id == 'post_prayer_dhikr') {
      return const ZkarAfterPrayRoute();
    }

    return const MainThikrRoute();
  }

  static PageRouteInfo<dynamic> _resolveDua(DailyWirdItem item) {
    if (item.id == 'sleep_dua' || item.timeCategory == 'night') {
      return WirdRoute(
        isMorning: true,
        titleOverride: L10nService.current.thikrSleepTitle,
        assetPath: JsonLoaderService.adhkarSleepDreamsPath,
        filterByPeriod: false,
      );
    }

    if (item.id == 'dua_of_day_1' || item.id == 'dua_of_day_2') {
      return WirdRoute(
        isMorning: true,
        titleOverride: L10nService.current.thikrComprehensiveDuasTitle,
        assetPath: JsonLoaderService.adhkarQuranDuasPath,
        filterByPeriod: false,
      );
    }

    return const MuDoaProviderRoute();
  }
}
