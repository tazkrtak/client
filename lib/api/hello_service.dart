import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'hello_service.g.dart';

@RestApi()
abstract class HelloService {
  factory HelloService(Dio dio, {String baseUrl}) = _HelloService;

  @GET('/')
  Future<String> greet();
}