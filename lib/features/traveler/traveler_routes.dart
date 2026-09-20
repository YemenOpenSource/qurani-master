import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات المسافر تحت البادئة `/travel`.
abstract final class TravelerRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(
          path: '/travel/flight-prayer-times',
          page: FlightPrayerTimesRoute.page,
        ),
        AutoRoute(path: '/travel/athkar', page: TravelAthkarRoute.page),
        // `:placeType` قيمة من TravelerPlaceType: `mosque` أو `halalRestaurant`.
        AutoRoute(
          path: '/travel/places/:placeType',
          page: TravelPlacesMapRoute.page,
        ),
      ];
}
