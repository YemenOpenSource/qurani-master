import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/services/service_locator.dart';
import 'package:quran_app/features/floating_adhkar/presentation/bloc/floating_adhkar_bloc.dart';
import 'package:quran_app/features/floating_adhkar/presentation/view/pages/floating_adhkar_screen.dart';

// اسم المسار صريح: اسم الصنف لا يحتوي «Page» ولا «Screen»، و
// replaceInRouteName استبدالٌ نصّي بلا احتياطي، فكان المولَّد يحمل اسم
// الودجت نفسه ويتصادم معها في app_router.gr.dart.
@RoutePage(name: 'FloatingAdhkarProviderRoute')
class FloatingAdhkarProvider extends StatelessWidget {
  const FloatingAdhkarProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FloatingAdhkarBloc>(
      create: (_) =>
          sl<FloatingAdhkarBloc>()..add(const FloatingAdhkarLoadEvent()),
      child: const FloatingAdhkarScreen(),
    );
  }
}
