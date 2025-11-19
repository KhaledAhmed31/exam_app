import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/subject%20details/domain/entities/exam_entity.dart';

abstract class GetExamsOnSubjectRepo {
  Future<BaseResponse<ExamsOnSubjectEntity>> getExamsOnSubject({required String subjectId,required String subjectName});
}