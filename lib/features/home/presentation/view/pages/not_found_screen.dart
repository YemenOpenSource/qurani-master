import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/router/app_router.gr.dart';
import 'package:quran_app/core/theme/app_skin.dart';
import 'package:quran_app/core/widgets/app_icon.dart';
import 'package:quran_app/features/setting/presentation/view/widgets/settings_skin.dart';
import 'package:quran_app/l10n/l10n.dart';

/// مسار غير معروف — بديل `RouterGenerator.unDefinedRoute` القديم.
///
/// يُسجَّل آخر المسارات بالمسار `*`، فيلتقط كل رابط عميق لا يطابق شيئًا.
/// لا يعرض زرّ رجوع: المكدّس قد يكون فارغًا تمامًا إذا دخل المستخدم من رابط،
/// فالفعل الوحيد هو إعادة البناء على الشاشة الرئيسية.
@RoutePage()
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = AppSkin.of(context);

    return Scaffold(
      backgroundColor: skin.ground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppIcon(
                  AppIcons.searchOff,
                  size: 34.sp,
                  color: skin.accent,
                ),
                SizedBox(height: 14.h),
                Text(
                  context.l10n.cleanupRouteNotFound,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: skin.ink,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 18.h),
                SettingsPrimaryButton(
                  label: context.l10n.homeNavHome,
                  icon: AppIcons.home,
                  onPressed: () =>
                      context.router.replaceAll([const HomeRoute()]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
