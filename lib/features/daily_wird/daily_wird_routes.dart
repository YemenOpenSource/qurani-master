import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات «زاد اليوم».
///
/// البادئة المحجوزة لهذه الميزة: `/daily-wird`.
abstract final class DailyWirdRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/daily-wird', page: DailyWirdRoute.page),

        // TODO(routing): the old call site in
        // `daily_wird_screen_items_part.dart` pushed this screen with a bespoke
        // `PageRouteBuilder` (fade + 5% slide, 360ms forward / 260ms reverse).
        // The shared `AppRouteTransitions` only defines `fade` (250ms) and
        // `youngMuslim` (260/220), so this route currently falls back to the
        // app-wide fade. Add a `dailyWirdFocus` transition to
        // `lib/core/router/app_route_transitions.dart` and switch this to a
        // `CustomRoute` if the original timing must be preserved exactly.
        AutoRoute(
          path: '/daily-wird/item/:itemId',
          page: DailyWirdFocusRoute.page,
        ),
      ];
}
