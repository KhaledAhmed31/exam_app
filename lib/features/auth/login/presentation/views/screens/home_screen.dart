import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black20,
      body: Center(child: Text('Home Screen')),
    );
  }
}
