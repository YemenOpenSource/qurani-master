import 'package:get_it/get_it.dart';
import 'package:quran_app/features/floating_adhkar/data/database/floating_adhkar_database_service.dart';
import 'package:quran_app/features/floating_adhkar/data/repo/floating_adhkar_repository.dart';
import 'package:quran_app/features/floating_adhkar/data/service/floating_adhkar_built_in_source.dart';
import 'package:quran_app/features/floating_adhkar/data/service/floating_adhkar_ios_reminder_service.dart';
import 'package:quran_app/features/floating_adhkar/data/service/floating_adhkar_overlay_controller.dart';
import 'package:quran_app/features/floating_adhkar/data/service/floating_adhkar_selector.dart';
import 'package:quran_app/features/floating_adhkar/presentation/bloc/floating_adhkar_bloc.dart';

Future<void> registerFloatingAdhkarDependencies(GetIt getIt) async {
  getIt
    ..registerLazySingleton<FloatingAdhkarDatabaseService>(
      FloatingAdhkarDatabaseService.new,
    )
    ..registerLazySingleton<FloatingAdhkarBuiltInSource>(
      FloatingAdhkarBuiltInSource.new,
    )
    ..registerLazySingleton<FloatingAdhkarSelector>(
      FloatingAdhkarSelector.new,
    )
    ..registerLazySingleton<FloatingAdhkarOverlayController>(
      FloatingAdhkarOverlayController.new,
    )
    ..registerLazySingleton<FloatingAdhkarRepository>(
      () => FloatingAdhkarRepository(
        databaseService: getIt<FloatingAdhkarDatabaseService>(),
        builtInSource: getIt<FloatingAdhkarBuiltInSource>(),
        selector: getIt<FloatingAdhkarSelector>(),
      ),
    )
    ..registerLazySingleton<FloatingAdhkarIosReminderService>(
      () => FloatingAdhkarIosReminderService(
        repository: getIt<FloatingAdhkarRepository>(),
        notificationService: getIt(),
      ),
    )
    // singleton لا factory: الشاشات المرتبطة تتشارك الحالة نفسها. كانت
    // تُمرَّر بينها عبر `BlocProvider.value`، وبعد الترحيل صار كل مسار يطلبها
    // من `get_it`. لو بقيت factory لفتحت كل شاشة نسخةً فارغة ولما عاد أي
    // تعديل إلى الشاشة التي استدعتها — عطلٌ صامت لا يظهر كخطأ.
    ..registerLazySingleton<FloatingAdhkarBloc>(
      () => FloatingAdhkarBloc(
        repository: getIt<FloatingAdhkarRepository>(),
        overlayController: getIt<FloatingAdhkarOverlayController>(),
        iosReminderService: getIt<FloatingAdhkarIosReminderService>(),
      ),
    );
}
