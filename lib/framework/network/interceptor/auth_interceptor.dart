import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['X-Api-Key'] = '8398e073855743fd910bad9b3682d3b3';
    super.onRequest(options, handler);
  }
}
