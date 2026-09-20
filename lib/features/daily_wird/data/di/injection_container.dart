import 'package:get_it/get_it.dart';
import 'package:quran_app/core/notification/notification_service.dart';
import 'package:quran_app/features/daily_wird/data/database/daily_wird_database_service.dart';
import 'package:quran_app/features/daily_wird/data/repo/daily_wird_repository.dart';
import 'package:quran_app/features/daily_wird/data/service/daily_wird_reminder_service.dart';
import 'package:quran_app/features/daily_wird/presentation/bloc/daily_wird_bloc.dart';

Future<void> registerDailyWirdDependencies(GetIt getIt) async {
  getIt
    ..registerLazySingleton<DailyWirdDatabaseService>(
      DailyWirdDatabaseService.new,
    )
    ..registerLazySingleton<DailyWirdReminderService>(
      () => DailyWirdReminderService(
        notificationService: getIt<NotificationService>(),
      ),
    )
    ..registerLazySingleton<DailyWirdRepository>(
      () => DailyWirdRepository(
        databaseService: getIt<DailyWirdDatabaseService>(),
        reminderService: getIt<DailyWirdReminderService>(),
      ),
    )
    // singleton لا factory: الشاشات المرتبطة تتشارك الحالة نفسها. كانت
    // تُمرَّر بينها عبر `BlocProvider.value`، وبعد الترحيل صار كل مسار يطلبها
    // من `get_it`. لو بقيت factory لفتحت كل شاشة نسخةً فارغة ولما عاد أي
    // تعديل إلى الشاشة التي استدعتها — عطلٌ صامت لا يظهر كخطأ.
    ..registerLazySingleton<DailyWirdBloc>(
      () => DailyWirdBloc(
        repository: getIt<DailyWirdRepository>(),
      ),
    );
}
