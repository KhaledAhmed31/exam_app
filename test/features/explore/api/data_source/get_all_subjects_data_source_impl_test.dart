import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/explore/api/data_source/get_all_subjects_data_source_impl.dart';
import 'package:exam_app/features/explore/data/models/get_all_subjects_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_subjects_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetAllSubjectsDataSourceImpl>()])
void main() {
  final GetAllSubjectsDataSourceImpl getAllSubjectClient =
      MockGetAllSubjectsDataSourceImpl();
 
 //This is not essential for this case
  setUpAll(() {
    provideDummy<SuccessResponse<GetAllSubjectsResponse>>(SuccessResponse(GetAllSubjectsResponse(message: "this is test")));
  });
  test('get all subjects', () async {
    when(
      getAllSubjectClient.getAllSubjects(),
    ).thenAnswer((_) async => ErrorResponse(
      error:Exception("this is test"),
    ));
   final response = await getAllSubjectClient.getAllSubjects();
    expect(
      response,
      isA<ErrorResponse<GetAllSubjectsResponse, Exception>>(),
    );
  });
}
