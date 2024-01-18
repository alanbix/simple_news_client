import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_news_client/framework/network/interceptor/auth_interceptor.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio dio(AuthInterceptor authInterceptor) =>
      Dio()..interceptors.add(authInterceptor);
}
