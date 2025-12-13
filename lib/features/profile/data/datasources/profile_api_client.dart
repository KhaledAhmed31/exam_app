import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/config/api/api_const.dart';
import '../../data/models/user_profile_model.dart';

part 'profile_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConsts.baseUrl)
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(ApiConsts.profileDataEndPoint)
  Future<UserProfileModel> getProfile();

  @PUT(ApiConsts.updateProfileEndPoint)
  Future<void> editProfile(@Body() Map<String, dynamic> body);

  @PATCH(ApiConsts.changePasswordEndPoint)
  Future<void> changePassword(@Body() Map<String, dynamic> body);
}
