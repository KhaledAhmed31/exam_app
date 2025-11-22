import '../../../../core/config/di/di.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../bloc/explore_bloc.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin {
  late AppLocalizations locale;
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    locale = AppLocalizations.of(context)!;

    return BlocProvider<GetallSubjectsBloc>.value(
      value: getIt<GetallSubjectsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 16,
          title: Text(
            locale.exploreTabLabel,
            style: FontStyleManager.interMedium(
              color: AppColors.blueBase,
              fontSize: FontSizesManager.s20,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(controller: searchController),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 16,
              ),
              child: Text(
                locale.subjectListTitle,
                style: FontStyleManager.interMedium(
                  color: AppColors.blackBase,
                  fontSize: FontSizesManager.s18,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<GetallSubjectsBloc, GetAllSubjectsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return SizedBox(
                      height: 500,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state.filteredSubjects != null &&
                      state.filteredSubjects!.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          SubjectCard(entity: state.filteredSubjects![index]),
                      itemCount: state.filteredSubjects!.length,
                    );
                  } else if (!state.isLoading &&
                      state.subjects.isNotEmpty &&
                      state.filteredSubjects == null) {
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          SubjectCard(entity: state.subjects[index]),
                      itemCount: state.subjects.length,
                    );
                  } else {
                    return Center(
                      child: Text(
                        locale.noSubjectsFound,
                        style: FontStyleManager.interRegular(
                          color: AppColors.blackBase,
                          fontSize: FontSizesManager.s16,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
