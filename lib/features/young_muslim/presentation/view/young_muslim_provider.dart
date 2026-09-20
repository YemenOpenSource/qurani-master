import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/services/service_locator.dart';
import 'package:quran_app/features/young_muslim/domain/repositories/young_muslim_repository.dart';
import 'package:quran_app/features/young_muslim/presentation/bloc/young_muslim_bloc.dart';
import 'package:quran_app/features/young_muslim/presentation/view/pages/young_muslim_home_screen.dart';

/// نقطة الدخول لقسم «المسلم الصغير».
///
/// تحلّ المستودع والـbloc من `get_it` ثم تغلّف [YoungMuslimHomeScreen] بـ
/// [YoungMuslimRouteScope]. هي المسار المعلَن على `/young-muslim`، واسم مساره
/// المولَّد `YoungMuslimProviderRoute` هو ما تتوقّعه
/// `lib/core/router/analytics_screen_names.dart`.
// اسم المسار صريح: اسم الصنف لا يحتوي «Page» ولا «Screen»، و
// replaceInRouteName استبدالٌ نصّي بلا احتياطي، فكان المولَّد يحمل اسم
// الودجت نفسه ويتصادم معها في app_router.gr.dart.
@RoutePage(name: 'YoungMuslimProviderRoute')
class YoungMuslimProvider extends StatelessWidget {
  const YoungMuslimProvider({super.key});

  // لا إغلاق هنا: `YoungMuslimBloc` مُسجّل كـ lazy singleton في `get_it`
  // وتتشاركه مسارات القسم الأربعة؛ إغلاقه عند مغادرة هذه الشاشة
  // يُعطِل بقيّة المسارات وكلّ عودة إلى القسم.
  @override
  Widget build(BuildContext context) {
    return YoungMuslimRouteScope(
      repository: sl<YoungMuslimRepository>(),
      bloc: sl<YoungMuslimBloc>(),
      child: const YoungMuslimHomeScreen(),
    );
  }
}

class YoungMuslimRouteScope extends StatelessWidget {
  const YoungMuslimRouteScope({
    required this.repository,
    required this.bloc,
    required this.child,
    super.key,
  });

  final YoungMuslimRepository repository;
  final YoungMuslimBloc bloc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<YoungMuslimRepository>.value(value: repository),
      ],
      child: BlocProvider<YoungMuslimBloc>.value(
        value: bloc,
        child: child,
      ),
    );
  }
}
