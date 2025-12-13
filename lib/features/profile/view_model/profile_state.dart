part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final UserProfileEntity? profile;
  final bool isLoading;
  final String? errorMessage;
  final bool isUpdating;
  final bool isChangingPassword;
  final String? successMessage;
  final String? selectedImagePath;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
    this.isUpdating = false,
    this.isChangingPassword = false,
    this.successMessage,
    this.selectedImagePath,
  });

  ProfileState copyWith({
    UserProfileEntity? profile,
    bool? isLoading,
    String? errorMessage,
    bool? isUpdating,
    bool? isChangingPassword,
    String? successMessage,
    String? selectedImagePath,
    bool clearError = false,
    bool clearSuccess = false,
    bool clearImage = false,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isUpdating: isUpdating ?? this.isUpdating,
      isChangingPassword: isChangingPassword ?? this.isChangingPassword,
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
      selectedImagePath: clearImage
          ? null
          : (selectedImagePath ?? this.selectedImagePath),
    );
  }

  @override
  List<Object?> get props => [
    profile,
    isLoading,
    errorMessage,
    isUpdating,
    isChangingPassword,
    successMessage,
    selectedImagePath,
  ];
}
