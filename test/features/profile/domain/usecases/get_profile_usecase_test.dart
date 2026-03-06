import 'package:exam_app/features/profile/domain/entities/user_profile_entity.dart';
import 'package:exam_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:exam_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_profile_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileRepository>()])
void main() {
  late GetProfileUseCase useCase;
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetProfileUseCase(mockRepository);
  });

  test('should get profile from repository', () async {
    final tUserProfileEntity = UserProfileEntity(
      id: '1',
      username: 'testuser',
      firstName: 'Test',
      lastName: 'User',
      email: 'test@example.com',
      phone: '1234567890',
      profilePic: 'https://example.com/pic.jpg',
      isVerified: true,
    );

    when(
      mockRepository.getProfile(),
    ).thenAnswer((_) async => tUserProfileEntity);

    final result = await useCase();

    expect(result, equals(tUserProfileEntity));
    verify(mockRepository.getProfile()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return null when repository returns null', () async {
    when(mockRepository.getProfile()).thenAnswer((_) async => null);

    final result = await useCase();

    expect(result, isNull);
    verify(mockRepository.getProfile()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
