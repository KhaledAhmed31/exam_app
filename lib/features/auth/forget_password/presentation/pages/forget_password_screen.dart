import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/auth/forget_password/presentation/bloc/forget_password_bloc.dart';
import 'package:exam_app/features/auth/forget_password/presentation/pages/send_code_screen.dart';
import 'package:exam_app/features/auth/forget_password/presentation/pages/reset_password_screen.dart';
import 'package:exam_app/features/auth/forget_password/presentation/pages/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordBloc _forgetPasswordBloc;
  late PageController _pageController;
  int _currentIndex = 0;
  late List<Widget> _pages;
  @override
  void initState() {
    _forgetPasswordBloc = getIt<ForgetPasswordBloc>();
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [SendCodeScreen(), VerifyCodeScreen(), ResetPasswordScreen()];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _forgetPasswordBloc,
      child: LoaderOverlay(
        child: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordLoading) {
              context.loaderOverlay.show();
            } else if (state is ForgetPasswordError) {
              context.loaderOverlay.hide();
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: AppColors.blueBase,
                textColor: AppColors.white,
                fontSize: 16.0,
              );
            } else if(state is ResendCodeSuccess){
              context.loaderOverlay.hide();
              Fluttertoast.showToast(
                msg: "Code sent successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: AppColors.blueBase,
                textColor: AppColors.white,
                fontSize: 16.0,
              );
            } else if (state is ForgetPasswordSuccess) {
              context.loaderOverlay.hide();
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            }
           
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                highlightColor: Colors.transparent,
                padding: EdgeInsets.only(left: 16),
                onPressed: () {
                  (_currentIndex == 0)
                      ? Navigator.pop(context)
                      : _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text(
                "Password",
                style: FontStyleManager.interMedium(
                  fontSize: FontSizesManager.s20,
                  color: AppColors.blackBase,
                ),
              ),
            ),
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pages[index],
            ),
          ),
        ),
      ),
    );
  }
}
