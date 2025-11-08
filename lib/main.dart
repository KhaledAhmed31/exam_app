// ignore_for_file: avoid_print

import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/shared/presentation/bloc/localization/localization_bloc.dart';
import 'package:exam_app/core/shared/presentation/bloc/localization/localization_states.dart';
import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/routes/route_manager.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:exam_app/features/auth/login/presentation/bloc/auth_events.dart';
import 'package:exam_app/features/auth/login/presentation/bloc/auth_states.dart';
import 'package:exam_app/features/auth/login/presentation/bloc/auth_view_model.dart';
import 'package:exam_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:exam_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
 MainApp({super.key});
 String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, localizationState) {
        Locale currentLocale = AppLocalizations.supportedLocales.first;
        if (localizationState is LocalizationLoadedState) {
          currentLocale = Locale(localizationState.langCode);
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          onGenerateRoute: RouteManager.generateRoute,
          locale: currentLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocBuilder<AuthViewModel, AuthStates>(
            builder: (context, authState) {
              if (authState.loginState?.isLoggedIn == false) {
                initialRoute = RoutePath.login;
                print(
                  '<<<<<< ${authState.loginState?.isLoggedIn} / initial route in false: $initialRoute',
                );
                FlutterNativeSplash.remove();
              } else if (authState.loginState?.isLoggedIn == true) {
                initialRoute = RoutePath.home;
                print(
                  '<<<<<< ${authState.loginState?.isLoggedIn} / initial route in true: $initialRoute',
                );
                FlutterNativeSplash.remove();
              }
              if (initialRoute == '/login') {
                return LoginScreen();
              } else {
                return HomeScreen();
              }
            },
          ),
        );
      },
    );
  }
}
