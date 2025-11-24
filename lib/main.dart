import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/routes/route_manager.dart';
import 'package:exam_app/core/shared/presentation/bloc/localization/localization_bloc.dart';
import 'package:exam_app/core/shared/presentation/bloc/localization/localization_states.dart';
import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:exam_app/features/auth/login/presentation/bloc/auth_view_model.dart';
import 'package:exam_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_events.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_states.dart';
import 'package:exam_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthViewModel>(
          create: (context) => getIt<AuthViewModel>()..add(IsLoggedInEvent()),
        ),
        BlocProvider(create: (context) => getIt<LocalizationBloc>()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, localizationState) {
        Locale currentLocale = AppLocalizations.supportedLocales.first;
        if (localizationState is LocalizationLoadedState) {
          currentLocale = Locale(localizationState.langCode);
        }
        return MaterialApp(
          locale: currentLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          onGenerateRoute: RouteManager.generateRoute,
          home: BlocBuilder<AuthViewModel, AuthStates>(
            buildWhen: (previous, current) =>
                previous.loginState?.isLoggedIn == null &&
                current.loginState?.isLoggedIn != null,
            builder: (context, state) {
              var logger = Logger();
              if (state.loginState?.isLoggedIn == false) {
                logger.d(
                  '<<<<<< ${state.loginState?.isLoggedIn} / initial route in false: login screen',
                );
                FlutterNativeSplash.remove();
                return LoginScreen();
              } else if (state.loginState?.isLoggedIn == true) {
                logger.d(
                  '<<<<<< ${state.loginState?.isLoggedIn} / initial route in true: home screen',
                );
                FlutterNativeSplash.remove();
                return HomeScreen();
              } else {
                return Scaffold();
              }
            },
          ),
        );
      },
    );
  }
}
