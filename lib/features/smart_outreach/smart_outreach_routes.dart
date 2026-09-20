import 'package:auto_route/auto_route.dart';
import 'package:quran_app/core/router/app_router.gr.dart';

/// مسارات «التواصل الذكي».
///
/// البادئة المحجوزة لهذه الميزة: `/outreach`.
abstract final class SmartOutreachRoutes {
  static List<AutoRoute> get routes => [
        AutoRoute(path: '/outreach', page: SmartOutreachSchedulesRoute.page),
        AutoRoute(
          path: '/outreach/call-logs',
          page: SmartOutreachCallLogsRoute.page,
        ),
        AutoRoute(
          path: '/outreach/settings',
          page: SmartOutreachSettingsRoute.page,
        ),

        // TODO(routing): يخدم هذا المسار حالتَي الإنشاء والتعديل لأن
        // `initialBundle` كائن في الذاكرة لا يُسلسَل. الرابط العميق يعمل في
        // حالة الإنشاء فقط. بعد تضييق الوسيط إلى `scheduleId` يُضاف مسار
        // `/outreach/schedule/:scheduleId/edit`.
        AutoRoute(
          path: '/outreach/schedule/new',
          page: SmartOutreachUpsertScheduleRoute.page,
        ),
        AutoRoute(
          path: '/outreach/execution/:scheduleId',
          page: SmartOutreachExecutionRoute.page,
        ),
      ];
}
