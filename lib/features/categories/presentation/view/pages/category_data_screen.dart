import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/extensions/request_state_extension.dart';
import 'package:quran_app/core/router/app_router.gr.dart';
import 'package:quran_app/core/services/service_locator.dart';
import 'package:quran_app/core/theme/app_skin.dart';
import 'package:quran_app/core/widgets/app_icon.dart';
import 'package:quran_app/core/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:quran_app/features/categories/data/model/category_section_model.dart';
import 'package:quran_app/features/categories/data/model/category_video_model.dart';
import 'package:quran_app/features/categories/data/remote/category_repository_imp.dart';
import 'package:quran_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:quran_app/features/categories/presentation/view/widgets/category_skin_widgets.dart';
import 'package:quran_app/l10n/l10n.dart';

/// أبواب تصنيف واحد: بحث نحيل فوق قائمة صفوف تفصلها خطوط شعرة.
// TODO(routing): الرابط (`url`) هو مصدر البيانات الوحيد للشاشة، وهو اليوم
// يصل جاهزًا من الشاشة السابقة. فتحها برابط عميق يتطلّب تمريره في
// `?url=` حتى تُشتقّ نقطة الـ api من `id` وحده.
@RoutePage()
class CategoryDataScreen extends StatefulWidget {
  const CategoryDataScreen({
    @PathParam('id') required this.id,
    @QueryParam('title') this.title = '',
    @QueryParam('url') this.url = '',
    super.key,
  });

  final int id;
  final String url;
  final String title;

  @override
  State<CategoryDataScreen> createState() => _CategoryDataScreenState();
}

class _CategoryDataScreenState extends State<CategoryDataScreen> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<CategorySectionModel> _filter(List<CategorySectionModel> data) {
    final query = _search.text.trim().toLowerCase();
    if (query.isEmpty) return data;
    return data
        .where(
          (item) => (item.title ?? '').toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final skin = AppSkin.of(context);

    return BlocProvider(
      create: (context) => CategoryBloc(
        repositoryImpl: sl.get<CategoryRepositoryImpl>(),
      )..add(GetCategoriesEvent(widget.id, widget.url)),
      child: Theme(
        data: Theme.of(context).copyWith(scaffoldBackgroundColor: skin.ground),
        child: AppScaffoldWidget(
          title: widget.title,
          body: ColoredBox(
            color: skin.ground,
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return state.categoryState.handle<dynamic>(
                  onLoading: const CategoryThinLoader(),
                  onSuccess: () {
                    final items = _filter(state.categories);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategorySearchField(
                          controller: _search,
                          onChanged: (_) => setState(() {}),
                        ),
                        skin.divider(),
                        if (items.isEmpty)
                          CategoryNotice(
                            message: context.l10n.categoriesNoSearchResults,
                          )
                        else
                          for (var i = 0; i < items.length; i++)
                            CategoryRow(
                              title: items[i].title ?? '',
                              subtitle: items[i].itemsCount == null
                                  ? null
                                  : context.l10n.categoriesItemsCount(
                                      items[i].itemsCount!,
                                    ),
                              icon: AppIcons.bookOpen,
                              isLast: i == items.length - 1,
                              onTap: () => _onTap(items[i], context),
                            ),
                        SizedBox(height: 22.h),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(CategorySectionModel allData, BuildContext context) {
    if (allData.dataType == 'multicategories') {
      context.router.push(
        CategoryDataRoute(
          id: allData.id ?? 0,
          title: allData.title ?? widget.title,
          url: allData.apiUrl,
        ),
      );
      return;
    }

    if (allData.dataType != 'category') {
      if (allData.dataType == 'quran') {
        context.router.push(BaseAudioDetailRoute(data: allData));
      } else {
        context.router.push(
          CategoryDetailRoute(
            category: CategoryDetailModel(
              apiUrl: allData.apiUrl,
              title: allData.title,
            ),
          ),
        );
      }
      return;
    }

    context.router.push(
      CategoryDataRoute(
        id: allData.id ?? 0,
        title: widget.title,
        url: allData.apiUrl,
      ),
    );
  }
}
