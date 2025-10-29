import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/shared/presentation/widgets/custom_text_feild.dart';
import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exam App",
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              CustomTextField(label: "Email"),
              AppButton(title: "Login", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
