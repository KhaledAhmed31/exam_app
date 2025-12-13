import 'package:exam_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:exam_app/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileRepository>()])
void main() {
  late ChangePasswordUseCase useCase;
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = ChangePasswordUseCase(mockRepository);
  });

  test('should change password through repository', () async {
    const tSuccessMessage = 'Password changed successfully';
    when(
      mockRepository.changePassword(
        oldPassword: anyNamed('oldPassword'),
        newPassword: anyNamed('newPassword'),
        confirmPassword: anyNamed('confirmPassword'),
      ),
    ).thenAnswer((_) async => tSuccessMessage);

    final result = await useCase(
      oldPassword: 'oldPass123',
      newPassword: 'newPass123',
      confirmPassword: 'newPass123',
    );

    expect(result, equals(tSuccessMessage));
    verify(
      mockRepository.changePassword(
        oldPassword: 'oldPass123',
        newPassword: 'newPass123',
        confirmPassword: 'newPass123',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
