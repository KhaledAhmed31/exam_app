import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/di/di.dart';
import '../../../../core/config/validation/app_validation.dart';
import '../../../../core/shared/presentation/widgets/app_button.dart';
import '../../../../core/shared/presentation/widgets/custom_text_feild.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../view_model/profile_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>(),
      child: const _ChangePasswordScreenBody(),
    );
  }
}

class _ChangePasswordScreenBody extends StatefulWidget {
  const _ChangePasswordScreenBody();

  @override
  State<_ChangePasswordScreenBody> createState() =>
      _ChangePasswordScreenBodyState();
}

class _ChangePasswordScreenBodyState extends State<_ChangePasswordScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileCubit>().changePassword(
        oldPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackBase),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Reset password',
          style: FontStyleManager.interMedium(
            fontSize: FontSizesManager.s20,
            color: AppColors.blackBase,
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // Show success and go back
          if (state.successMessage != null && !state.isChangingPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.pop(context);
          }

          // Show error
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<ProfileCubit>().clearError();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Current Password
                  CustomTextField(
                    label: "Current password",
                    hint: "Enter current password",
                    textFieldController: _currentPasswordController,
                    validator: Validators.signInPasswordValidator,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  // New Password
                  CustomTextField(
                    label: "New password",
                    hint: "Enter new password",
                    textFieldController: _newPasswordController,
                    validator: Validators.passwordValidator,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  CustomTextField(
                    label: "Confirm password",
                    hint: "Confirm new password",
                    textFieldController: _confirmPasswordController,
                    validator: (val) => Validators.confirmPasswordValidator(
                      val,
                      _newPasswordController.text,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),

                  // Update Button
                  AppButton(
                    title: state.isChangingPassword ? 'Updating...' : 'Update',
                    isDisabled: state.isChangingPassword,
                    onPressed: () => _handleChangePassword(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
