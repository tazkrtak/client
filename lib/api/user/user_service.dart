import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../api.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio) = _UserService;

  @POST('/users/register')
  Future<User> register(@Body() RegisterBody registerBody);

  @POST('/users/login')
  Future<User> login(@Body() LoginBody loginBody);

  @GET('users/credit')
  Future<Credit> getCredit();

  @POST('users/recharge')
  Future<Transaction> recharge(@Body() RechargeBody rechargeBody);
}
