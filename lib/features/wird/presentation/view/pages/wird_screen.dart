import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/extensions/request_state/request_state_sliver_extension.dart';
import 'package:quran_app/core/services/copy_service.dart';
import 'package:quran_app/core/services/json_loader_service.dart';
import 'package:quran_app/core/theme/app_skin.dart';
import 'package:quran_app/core/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:quran_app/core/widgets/generic_search_bar.dart';
import 'package:quran_app/features/wird/data/models/wird_model.dart';
import 'package:quran_app/features/wird/presentation/bloc/wird_bloc.dart';
import 'package:quran_app/features/wird/presentation/view/widgets/wird/wird_collection_view.dart';
import 'package:quran_app/features/wird/presentation/view/widgets/wird/wird_search_suggestion.dart';
import 'package:quran_app/l10n/l10n.dart';

/// ورد الصباح والمساء.
///
/// مسارٌ واحد (`WirdRoute`) يخدم الورد القياسي والمجموعات المخصّصة.
///
// TODO(routing): `isMorning` وسيط مسار من نوع `bool`، و`auto_route` لا يفكّ
// إلا 'true'/'false' (راجع `Parameters.optBool`)، فالمسار المولَّد هو
// `/wird/true`. الروابط الإنجليزية `/wird/morning` و`/wird/evening` مُعرَّفة
// في `wird_routes.dart` كـ `RedirectRoute`. لجعل `:period` وسيطًا نصّيًا
// حقيقيًا يلزم تغيير نوع الوسيط، وهو تغيير يمسّ كل موضع نداء.
@RoutePage()
class WirdScreen extends StatelessWidget {
  /// الباني الوحيد الذي يولّد منه `auto_route`.
  ///
  /// كان هناك بانيان: الافتراضي لورد الصباح/المساء، و`custom` لمجموعات أخرى
  /// (أذكار النوم، الجمعة، أدعية قرآنية…). `auto_route` يشتقّ المسار من باني
  /// واحد، فكانت كل استدعاءات `custom` عاجزة عن أن تصير مسارًا.
  ///
  /// فدُمجا: الوسائط الإضافية اختيارية، وغيابها يعني الورد القياسي. هكذا صار
  /// مسار واحد يخدم الحالتين ولم ينكسر أي موضع نداء.
  const WirdScreen({
    @PathParam('isMorning') required this.isMorning,
    @QueryParam('title') this.titleOverride,
    @QueryParam('asset') String? assetPath,
    @QueryParam('filterByPeriod') bool? filterByPeriod,
    super.key,
  })  : assetPath = assetPath ?? JsonLoaderService.wirdsPath,
        // الترشيح بالفترة (صباح/مساء) منطقيٌّ للورد القياسي وحده؛ المجموعات
        // المخصّصة تُعرض كاملة. تمرير القيمة صراحةً يتقدّم على هذا الاشتقاق.
        filterByPeriod = filterByPeriod ?? (assetPath == null);

  /// اختصارٌ لمجموعة أذكار مخصّصة. يوجّه إلى الباني الأساسي أعلاه.
  const WirdScreen.custom({
    required String title,
    required String assetPath,
    bool isMorning = true,
    bool filterByPeriod = false,
    Key? key,
  }) : this(
          isMorning: isMorning,
          titleOverride: title,
          assetPath: assetPath,
          filterByPeriod: filterByPeriod,
          key: key,
        );

  final bool isMorning;
  final String? titleOverride;
  final String assetPath;
  final bool filterByPeriod;

  bool _matchesQuery(WirdModel item, String query) {
    final q = query.trim();
    return item.title.contains(q) ||
        item.text.contains(q) ||
        item.virtue.contains(q) ||
        item.source.contains(q) ||
        item.hadithText.contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final skin = AppSkin.of(context);

    return BlocProvider(
      create: (context) => WirdBloc()
        ..add(
          LoadWirdEvent(
            isMorning: isMorning,
            assetPath: assetPath,
            filterByPeriod: filterByPeriod,
          ),
        ),
      // أرضية واحدة تمتدّ من الترويسة إلى آخر ذكر.
      child: Theme(
        data: Theme.of(context).copyWith(scaffoldBackgroundColor: skin.ground),
        child: AppScaffoldWidget(
          title: titleOverride ??
              (isMorning
                  ? context.l10n.wirdMorningTitle
                  : context.l10n.wirdEveningTitle),
          trailing: BlocBuilder<WirdBloc, WirdState>(
            builder: (context, state) {
              return GenericSearchAnchorAsync<WirdModel>(
                asyncSuggestions: (query) async {
                  if (query.trim().isEmpty) return state.data ?? [];
                  return state.data
                          ?.where((item) => _matchesQuery(item, query))
                          .toList() ??
                      [];
                },
                onSelected: (item) async {
                  await CopyService.copyToClipboard(item.text);
                },
                hintText: context.l10n.wirdSearchHint,
                suggestionBuilder: (context, item) =>
                    WirdSearchSuggestion(item: item),
              );
            },
          ),
          slivers: [
            BlocBuilder<WirdBloc, WirdState>(
              builder: (context, state) {
                return state.state.whenSliver<WirdModel>(
                  onSuccess: () {
                    return const SliverToBoxAdapter(
                      child: WirdCollectionView(),
                    );
                  },
                  context: context,
                  sliverList: state.data,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
