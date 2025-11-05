import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:exam_app/features/signup/data/repositories/signup_repository_impl.dart';
import 'package:exam_app/features/signup/domain/usecases/signup_usecase.dart';
import 'package:exam_app/features/signup/presentation/screens/signup_screen.dart';
import 'package:dio/dio.dart';
import 'package:exam_app/features/signup/data/datasources/signup_remote_data_source.dart';
import 'package:exam_app/features/signup/view_model/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Login')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) {
                        final dio = Dio();
                        final remoteDataSource = SignupRemoteDataSourceImpl(
                          dio: dio,
                        );
                        final repository = SignupRepositoryImpl(
                          remoteDataSource: remoteDataSource,
                        );
                        final useCase = SignupUseCase(repository: repository);
                        return SignupCubit(useCase);
                      },
                      child: const SignupScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Test Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
