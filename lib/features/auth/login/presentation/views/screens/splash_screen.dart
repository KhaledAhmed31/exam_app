import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_events.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_states.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final AuthViewModel authViewModel = getIt<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black20,
      body: BlocProvider<AuthViewModel>(
        create: (context) => authViewModel..add(IsLoggedInEvent()),
        child: BlocListener<AuthViewModel, AuthStates>(
          listener: (context, state) {
            // if (state is IsLoggedInState) {
            //   state.isLoggedIn
            //       ? Navigator.of(context).pushReplacementNamed(RoutePath.home)
            //       : Navigator.of(context).pushReplacementNamed(RoutePath.login);
            // }
            Navigator.of(context).pushReplacementNamed(RoutePath.login);
          },
          child: Center(
            child: CircularProgressIndicator(color: AppColors.blueBase),
          ),
        ),
      ),
    );
  }
}
