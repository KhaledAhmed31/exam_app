import 'package:exam_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:exam_app/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileRepository>()])
void main() {
  late EditProfileUseCase useCase;
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = EditProfileUseCase(mockRepository);
  });

  test('should edit profile through repository', () async {
    const tSuccessMessage = 'Profile updated successfully';
    when(
      mockRepository.editProfile(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        phone: anyNamed('phone'),
        username: anyNamed('username'),
      ),
    ).thenAnswer((_) async => tSuccessMessage);

    // Act
    final result = await useCase(
      firstName: 'Updated',
      lastName: 'Name',
      email: 'updated@example.com',
      phone: '9876543210',
      username: 'updateduser',
    );

    expect(result, equals(tSuccessMessage));
    verify(
      mockRepository.editProfile(
        firstName: 'Updated',
        lastName: 'Name',
        email: 'updated@example.com',
        phone: '9876543210',
        username: 'updateduser',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should edit profile with partial data', () async {
    const tSuccessMessage = 'Profile updated successfully';
    when(
      mockRepository.editProfile(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        phone: anyNamed('phone'),
        username: anyNamed('username'),
      ),
    ).thenAnswer((_) async => tSuccessMessage);

    final result = await useCase(firstName: 'Updated');

    expect(result, equals(tSuccessMessage));
    verify(
      mockRepository.editProfile(
        firstName: 'Updated',
        lastName: null,
        email: null,
        phone: null,
        username: null,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
