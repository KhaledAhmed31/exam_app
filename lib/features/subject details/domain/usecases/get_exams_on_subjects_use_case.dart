import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/subject%20details/domain/entities/exam_entity.dart';
import 'package:exam_app/features/subject%20details/domain/repositories/get_exams_on_subject_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetExamsOnSubjectsUseCase {
  final GetExamsOnSubjectRepo getExamsOnSubjectRepo;
  GetExamsOnSubjectsUseCase({required this.getExamsOnSubjectRepo});

  Future<BaseResponse<ExamsOnSubjectEntity>> call({
    required String subjectId,
    required String subjectName,
  }) => getExamsOnSubjectRepo.getExamsOnSubject(
    subjectId: subjectId,
    subjectName: subjectName,
  );
}
