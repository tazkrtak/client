import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'models/models.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio) = _UserService;

  @POST('/users/register')
  Future<User> register(@Body() Map<String, dynamic> registerInputs);
}
