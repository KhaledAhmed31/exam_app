part of 'subject_details_bloc.dart';

 class GetExamsOnSubjectEvent extends Equatable {
  final SubjectEntity subjectEntity;
  const GetExamsOnSubjectEvent(this.subjectEntity);

  @override
  List<Object> get props => [subjectEntity];
}
