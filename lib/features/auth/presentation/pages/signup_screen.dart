import 'package:exam_app/core/config/validation/app_validation.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/shared/presentation/widgets/custom_text_feild.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/auth/presentation/bloc/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(_onFormChanged);
    _firstNameController.addListener(_onFormChanged);
    _lastNameController.addListener(_onFormChanged);
    _emailController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
    _confirmPasswordController.addListener(_onFormChanged);
    _phoneController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  bool _isFormValid() {
    final usernameValid =
        Validators.usernameValidator(_userNameController.text) == null;
    final firstNameValid =
        Validators.nameValidator(_firstNameController.text) == null;
    final lastNameValid =
        Validators.nameValidator(_lastNameController.text) == null;
    final emailValid = Validators.emailValidator(_emailController.text) == null;
    final passwordValid =
        Validators.passwordValidator(_passwordController.text) == null;
    final confirmValid =
        _confirmPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text == _passwordController.text;
    final phoneValid = Validators.phoneValidator(_phoneController.text) == null;
    return usernameValid &&
        firstNameValid &&
        lastNameValid &&
        emailValid &&
        passwordValid &&
        confirmValid &&
        phoneValid;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSignup(BuildContext context) {
    _submitted = true;
    setState(() {});
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<SignupCubit>().signup(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      rePassword: _confirmPasswordController.text,
      phone: _phoneController.text,
      userName: _userNameController.text.toLowerCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign up'), centerTitle: false),
        body: SafeArea(
          child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupLoading) {
                context.loaderOverlay.show();
              } else if (state is SignupError) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              } else if (state is SignupSuccess) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(AppStrings.signupSuccess),
                    backgroundColor: AppColors.success,
                    duration: Duration(seconds: 2),
                  ),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                });
              }
            },
            builder: (context, state) {
              final isLoading = state is SignupLoading;
              final isFormValid = _isFormValid();
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _submitted
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "User name",
                        hint: "Enter your user name",
                        textFieldController: _userNameController,
                        validator: Validators.usernameValidator,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "First name",
                              hint: "Enter first name",
                              textFieldController: _firstNameController,
                              validator: Validators.nameValidator,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              label: "Last name",
                              hint: "Enter last name",
                              textFieldController: _lastNameController,
                              validator: Validators.nameValidator,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: "Email",
                        hint: "Enter your email",
                        textFieldController: _emailController,
                        validator: Validators.emailValidator,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "Password",
                              hint: "Enter password",
                              textFieldController: _passwordController,
                              validator: Validators.passwordValidator,
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              label: "Confirm password",
                              hint: "Confirm password",
                              textFieldController: _confirmPasswordController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return AppStrings.confirmPasswordRequired;
                                }
                                if (val != _passwordController.text) {
                                  return AppStrings.passwordsDoNotMatch;
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: "Phone number",
                        hint: "Enter phone number",
                        textFieldController: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: Validators.phoneValidator,
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        title: isLoading
                            ? AppStrings.signingUp
                            : AppStrings.signup,
                        isDisabled: isLoading || (_submitted && !isFormValid),
                        onPressed: () => _handleSignup(context),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.alreadyHaveAccount,
                              style: FontStyleManager.interRegular(
                                color: AppColors.blackBase,
                                fontSize: FontSizesManager.s16,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.login,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.blueBase,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizesManager.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
