import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات المواد الصوتية تحت البادئة `/audio`.
abstract final class AudiosRoutes {
  static List<AutoRoute> get routes => [
        // TODO(routing): `BaseAudioDetail` يستقبل كائنًا غير مُصنَّف (dynamic)،
        // فهذا المسار للدفع داخل التطبيق فقط ولا يُفتح برابط عميق حتى يُستبدَل
        // الوسيط بمعرّف سلسلة.
        // ويبقى قبل `/audio/:id` وإلّا ابتلعته المعلمة فصارت `detail` معرّفًا.
        AutoRoute(path: '/audio/detail', page: BaseAudioDetailRoute.page),
        AutoRoute(path: '/audio/:id', page: BaseAudioRoute.page),
      ];
}
