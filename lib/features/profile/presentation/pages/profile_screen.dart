import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/config/di/di.dart';
import '../../../../core/config/validation/app_validation.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../core/shared/presentation/widgets/app_button.dart';
import '../../../../core/shared/presentation/widgets/custom_text_feild.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../view_model/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileScreenBody(),
    );
  }
}

class _ProfileScreenBody extends StatefulWidget {
  const _ProfileScreenBody();

  @override
  State<_ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<_ProfileScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imagePicker = ImagePicker();
  bool _fieldsPopulated = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _populateFields(ProfileState state) {
    if (state.profile != null && !_fieldsPopulated) {
      _usernameController.text = state.profile!.username;
      _firstNameController.text = state.profile!.firstName;
      _lastNameController.text = state.profile!.lastName;
      _emailController.text = state.profile!.email;
      _phoneController.text = state.profile!.phone;
      _fieldsPopulated = true;
    }
  }

  Future<void> _pickImage() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (!mounted) return;
      if (image == null) return;
      context.read<ProfileCubit>().selectImage(image.path);
    } catch (_) {}
  }

  void _handleUpdate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileCubit>().updateProfile(
        username: _usernameController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
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
          'Edit profile',
          style: FontStyleManager.interMedium(
            fontSize: FontSizesManager.s20,
            color: AppColors.blackBase,
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            context.read<ProfileCubit>().clearSuccess();
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<ProfileCubit>().clearError();
          }

          if (state.profile != null && !state.isLoading) {
            _populateFields(state);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.blueBase),
            );
          }

          if (state.profile == null && state.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: FontStyleManager.robotoRegular(
                        fontSize: FontSizesManager.s16,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      title: 'Retry',
                      onPressed: () =>
                          context.read<ProfileCubit>().loadProfile(),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightBlue,
                          ),
                          child: state.selectedImagePath != null
                              ? ClipOval(
                                  child: Image.file(
                                    File(state.selectedImagePath!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : state.profile?.profilePic != null
                              ? ClipOval(
                                  child: Image.network(
                                    state.profile!.profilePic!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const _DefaultAvatar(),
                                  ),
                                )
                              : const _DefaultAvatar(),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: AppColors.blueBase,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Center(
                    child: CustomTextField(
                      label: "User name",
                      hint: "Enter your user name",
                      textFieldController: _usernameController,
                      validator: Validators.nameValidator,
                      width: 343,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: 343,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CustomTextField(
                                label: "First name",
                                hint: "Enter first name",
                                textFieldController: _firstNameController,
                                validator: Validators.nameValidator,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: CustomTextField(
                                label: "Last name",
                                hint: "Enter last name",
                                textFieldController: _lastNameController,
                                validator: Validators.nameValidator,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: CustomTextField(
                      label: "Email",
                      hint: "Enter your email",
                      textFieldController: _emailController,
                      validator: Validators.emailValidator,
                      keyboardType: TextInputType.emailAddress,
                      width: 343,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: _PasswordField(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePath.changePassword);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: CustomTextField(
                      label: "Phone number",
                      hint: "Enter phone number",
                      textFieldController: _phoneController,
                      validator: Validators.phoneValidator,
                      keyboardType: TextInputType.phone,
                      width: 343,
                    ),
                  ),
                  const SizedBox(height: 32),

                  AppButton(
                    title: state.isUpdating ? 'Updating...' : 'Update',
                    isDisabled: state.isUpdating,
                    onPressed: () => _handleUpdate(context),
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

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Image.asset(
          'assets/images/Profile.png',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 60, color: AppColors.grey);
          },
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final VoidCallback onTap;

  const _PasswordField({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: FontSizesManager.s14,
            fontWeight: FontWeight.w400,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          width: 343,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.grey, width: 1),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '★★★★★★',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: FontSizesManager.s16,
                    color: AppColors.blackBase,
                    letterSpacing: 2,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Change',
                  style: FontStyleManager.robotoMedium(
                    fontSize: FontSizesManager.s14,
                    color: AppColors.blueBase,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
