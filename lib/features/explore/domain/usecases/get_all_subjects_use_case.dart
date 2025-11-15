import '../../../../core/config/base_response/base_response.dart';
import '../entities/subject_entity.dart';
import '../repositories/get_all_subjects_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllSubjectsUseCase {
  final GetAllSubjectsRepo _getAllSubjectsRepo;
  GetAllSubjectsUseCase(this._getAllSubjectsRepo);
  Future<BaseResponse<List<SubjectEntity>>> call() async =>
      await _getAllSubjectsRepo.getAllSubjects();
}
