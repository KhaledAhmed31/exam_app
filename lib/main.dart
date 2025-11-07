
import 'package:exam_app/core/shared/presentation/ui_strings/ui_strings.dart';
// ignore_for_file: avoid_print

import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/routes/route_manager.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_events.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_states.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_view_model.dart';
import 'package:exam_app/features/auth/login/presentation/views/screens/home_screen.dart';
import 'package:exam_app/features/auth/login/presentation/views/screens/login_screen.dart';
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
        BlocProvider(create: (context) => getIt<LocalizationBloc>(),)
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
      builder: (context, state) {
        if (state is LocalizationLoadedState) {
          return MaterialApp(
             locale: Locale(state.langCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            onGenerateRoute: RouteManager.generateRoute,
            home: BlocBuilder<AuthViewModel, AuthStates>(
              builder: (context, state) {
                if (state.loginState?.isLoggedIn == false) {
                  initialRoute = RoutePath.login;
                  print(
                    '<<<<<< ${state.loginState?.isLoggedIn} / initial route in false: $initialRoute',
                  );
                  FlutterNativeSplash.remove();
                } else if (state.loginState?.isLoggedIn == true) {
                  initialRoute = RoutePath.home;
                  print(
                    '<<<<<< ${state.loginState?.isLoggedIn} / initial route in true: $initialRoute',
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
        }
      },
    );
  }
}