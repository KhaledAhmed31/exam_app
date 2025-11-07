import 'package:exam_app/core/shared/presentation/bloc/localization/localization_bloc.dart';
import 'package:exam_app/core/shared/presentation/bloc/localization/localization_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/localization/l10n/app_localizations.dart';
import 'core/config/di/di.dart';
import 'core/routes/route_manager.dart';
import 'core/routes/route_path.dart';
import 'core/ui_manager/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocalizationBloc>(),
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          if (state is LocalizationLoadedState) {
            return MaterialApp(
              locale: Locale(state.langCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteManager.generateRoute,
              title: "Exam App",
              theme: AppTheme.light,
              initialRoute: RoutePath.forgetPassword,
            );
          }
          return Container();
        },
      ),
    );
  }
}
