part of 'subject_details_bloc.dart';

class SubjectDetailsState extends Equatable {
  final ExamsOnSubjectEntity subjectDetails;
  final bool isLoading;
  final String errorMessage;
  const SubjectDetailsState({
    this.subjectDetails = const ExamsOnSubjectEntity(),
    this.isLoading = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [subjectDetails, isLoading, errorMessage];
  SubjectDetailsState copywith({
    ExamsOnSubjectEntity? subjectDetails,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SubjectDetailsState(
      subjectDetails: subjectDetails ?? this.subjectDetails,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
