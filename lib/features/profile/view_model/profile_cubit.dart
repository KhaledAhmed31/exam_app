import 'package:exam_app/features/profile/domain/entities/user_profile_entity.dart';
import 'package:exam_app/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:exam_app/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:exam_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  ProfileCubit(
    this._getProfileUseCase,
    this._editProfileUseCase,
    this._changePasswordUseCase,
  ) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final profile = await _getProfileUseCase();
      emit(state.copyWith(profile: profile, isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? username,
  }) async {
    emit(
      state.copyWith(isUpdating: true, clearError: true, clearSuccess: true),
    );
    try {
      final message = await _editProfileUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        username: username,
      );

      final updatedProfile = await _getProfileUseCase();

      emit(
        state.copyWith(
          profile: updatedProfile,
          isUpdating: false,
          successMessage: message,
        ),
      );
    } catch (error) {
      emit(state.copyWith(isUpdating: false, errorMessage: error.toString()));
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(
      state.copyWith(
        isChangingPassword: true,
        clearError: true,
        clearSuccess: true,
      ),
    );
    try {
      final message = await _changePasswordUseCase(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      emit(state.copyWith(isChangingPassword: false, successMessage: message));
    } catch (error) {
      emit(
        state.copyWith(
          isChangingPassword: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void selectImage(String imagePath) {
    emit(state.copyWith(selectedImagePath: imagePath));
  }

  void clearError() {
    emit(state.copyWith(clearError: true));
  }

  void clearSuccess() {
    emit(state.copyWith(clearSuccess: true));
  }
}
