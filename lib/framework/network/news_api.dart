import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:simple_news_client/framework/network/model/response/get_articles_response.dart';

part 'news_api.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
abstract class NewsApi {
  factory NewsApi(Dio dio, {String baseUrl}) = _NewsApi;

  @GET('/top-headlines')
  Future<GetArticlesResponse> getTopArticles();
}
