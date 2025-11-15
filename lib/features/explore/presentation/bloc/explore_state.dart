part of 'explore_bloc.dart';

class GetAllSubjectsState extends Equatable {
  final bool isLoading;
  final List<SubjectEntity> subjects;
  final List<SubjectEntity>? filteredSubjects;

  final String errorMessage;
  const GetAllSubjectsState({
    this.isLoading = false,
    this.filteredSubjects ,
    this.subjects = const [],
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [isLoading, subjects, errorMessage, filteredSubjects ?? []];

  GetAllSubjectsState copywith({
    bool? isLoading,
    List<SubjectEntity>? subjects,
    List<SubjectEntity>? filteredSubjects,
    String? errorMessage,
  }) {
    return GetAllSubjectsState(
      isLoading: isLoading ?? this.isLoading,
      subjects: subjects ?? this.subjects,
      errorMessage: errorMessage ?? this.errorMessage,
      filteredSubjects: filteredSubjects,
    );
  }
}
