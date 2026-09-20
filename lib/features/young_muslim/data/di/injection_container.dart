import 'package:get_it/get_it.dart';
import 'package:quran_app/core/notification/notification_service.dart';
import 'package:quran_app/features/young_muslim/data/data_sources/young_muslim_asset_data_source.dart';
import 'package:quran_app/features/young_muslim/data/data_sources/young_muslim_local_data_source.dart';
import 'package:quran_app/features/young_muslim/data/repositories/young_muslim_repository_impl.dart';
import 'package:quran_app/features/young_muslim/data/services/young_muslim_reminder_service.dart';
import 'package:quran_app/features/young_muslim/domain/repositories/young_muslim_repository.dart';
import 'package:quran_app/features/young_muslim/presentation/bloc/young_muslim_bloc.dart';

/// تسجيل اعتماديات «المسلم الصغير».
///
/// قبل الترحيل إلى `auto_route` كان `YoungMuslimProvider` يبني هذه السلسلة
/// كاملةً في `initState` ويمرّرها للشاشات عبر `YoungMuslimRouteScope`. ذلك
/// يعمل ما دامت الشاشات تُدفع من داخل القسم، لكنه ينهار مع الروابط العميقة:
/// فتح `/young-muslim/video/x` مباشرةً لا يمرّ بالمزوّد أصلًا.
///
/// فنقلناها إلى `get_it` ليجدها كل مسار مهما كان مدخله.
Future<void> registerYoungMuslimDependencies(GetIt getIt) async {
  getIt
    ..registerLazySingleton<YoungMuslimAssetDataSource>(
      YoungMuslimAssetDataSource.new,
    )
    ..registerLazySingleton<YoungMuslimLocalDataSource>(
      YoungMuslimLocalDataSource.new,
    )
    ..registerLazySingleton<YoungMuslimReminderService>(
      () => YoungMuslimReminderService(
        notificationService: getIt<NotificationService>(),
        localDataSource: getIt<YoungMuslimLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<YoungMuslimRepository>(
      () => YoungMuslimRepositoryImpl(
        assetDataSource: getIt<YoungMuslimAssetDataSource>(),
        localDataSource: getIt<YoungMuslimLocalDataSource>(),
        reminderService: getIt<YoungMuslimReminderService>(),
      ),
    )
    // singleton لا factory: الشاشات الأربع تقرأ الحالة نفسها — الأقسام،
    // التقدّم، والمفضّلة. لو أعطى كلَّ مسار نسخةً جديدة لظهرت كل شاشة فارغة
    // ولما انعكس أي تغيير على غيرها.
    //
    // ولأنه singleton فلا يجوز لأي شاشة أن تُغلقه في `dispose`؛ يبقى حيًّا
    // مع التطبيق.
    ..registerLazySingleton<YoungMuslimBloc>(
      () => YoungMuslimBloc(repository: getIt<YoungMuslimRepository>())
        ..add(const YoungMuslimStarted()),
    );
}
