import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/explore/domain/entities/subject_entity.dart';
import 'package:exam_app/features/subject%20details/domain/entities/exam_entity.dart';
import 'package:exam_app/features/subject%20details/domain/usecases/get_exams_on_subjects_use_case.dart';
import 'package:injectable/injectable.dart';

part 'subject_details_event.dart';
part 'subject_details_state.dart';

@lazySingleton
class SubjectDetailsBloc
    extends Bloc<GetExamsOnSubjectEvent, SubjectDetailsState> {
  final GetExamsOnSubjectsUseCase _getExamsOnSubjectsUseCase;
  SubjectDetailsBloc(this._getExamsOnSubjectsUseCase)
    : super(SubjectDetailsState()) {
    on<GetExamsOnSubjectEvent>(getSubjectDetails);
  }

  getSubjectDetails(
    GetExamsOnSubjectEvent event,
    Emitter<SubjectDetailsState> emit,
  ) async {
    emit(state.copywith(isLoading: true));
    final response = await _getExamsOnSubjectsUseCase(
      subjectId: event.subjectEntity.id,
      subjectName: event.subjectEntity.name,
    );
    switch (response) {
      case SuccessResponse<ExamsOnSubjectEntity>():
        log(response.data.exams.length.toString());
        emit(state.copywith(isLoading: false, subjectDetails: response.data));
        break;
      case ErrorResponse<ExamsOnSubjectEntity, Failure>():
        emit(
          state.copywith(
            isLoading: false,
            errorMessage: response.error.message,
          ),
        );
    }
  }
}
