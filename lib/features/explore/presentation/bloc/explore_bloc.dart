import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/config/base_response/base_response.dart';
import '../../../../core/config/error/error_handler.dart';
import '../../domain/entities/subject_entity.dart';
import '../../domain/usecases/get_all_subjects_use_case.dart';
import 'package:injectable/injectable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

@lazySingleton
class GetallSubjectsBloc extends Bloc<ExploreEvent, GetAllSubjectsState> {
  final GetAllSubjectsUseCase _getAllSubjectsRepo;
  GetallSubjectsBloc(this._getAllSubjectsRepo) : super(GetAllSubjectsState()) {
    on<GetAllSubjectsEvent>(getAllSubjects);
    on<GetSpecificSubjectsEvent>(getSpecificSubjects);
    add(GetAllSubjectsEvent());
  }

  Future<void> getAllSubjects(GetAllSubjectsEvent event, Emitter emit) async {
    emit(state.copywith(isLoading: true));
    final response = await _getAllSubjectsRepo.call();
    switch (response) {
      case SuccessResponse<List<SubjectEntity>>():
        emit(state.copywith(subjects: response.data, isLoading: false));
      case ErrorResponse<List<SubjectEntity>, Failure>():
        emit(
          state.copywith(
            errorMessage: response.error.message,
            isLoading: false,
          ),
        );
    }
  }

  void getSpecificSubjects(GetSpecificSubjectsEvent event, Emitter emit) {
    if (event.query.isEmpty) {
      emit(state.copywith(filteredSubjects: null));
      return;
    }
    List<SubjectEntity> filteredSubjects = state.subjects
        .where(
          (element) => element.name.toLowerCase().contains(
            event.query.toLowerCase().trim(),
          ),
        )
        .toList();

    emit(state.copywith(filteredSubjects: filteredSubjects));
  }
}
