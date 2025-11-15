import '../../../../core/config/base_response/base_response.dart';
import '../../../../core/config/error/error_handler.dart';
import '../clients/get_all_subject_client.dart';
import '../../data/datasources/get_all_subjects_data_source.dart';
import '../../data/models/get_all_subjects_response.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: GetAllSubjectsDataSource)
class GetAllSubjectsDataSourceImpl implements GetAllSubjectsDataSource{
  final GetAllSubjectClient _getAllSubjectClient;

  GetAllSubjectsDataSourceImpl(this._getAllSubjectClient);
  @override
  Future<BaseResponse<GetAllSubjectsResponse>> getAllSubjects() async{
   try{
     return SuccessResponse(await _getAllSubjectClient.getAllSubjects());
   }catch(e){
     return ErrorResponse(error: ErrorHandler.handle(e));
   }
  }
}