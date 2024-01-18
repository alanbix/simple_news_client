import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:simple_news_client/framework/network/model/response/get_articles_response.dart';
import 'package:simple_news_client/framework/network/model/response/get_sources_response.dart';

part 'news_api.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
@singleton
@injectable
abstract class NewsApi {
  @factoryMethod
  factory NewsApi(Dio dio) = _NewsApi;

  @GET('top-headlines')
  Future<GetArticlesResponse> getTopArticles(
    @Query('sources') String sourceId,
  );

  @GET('everything')
  Future<GetArticlesResponse> searchArticles(
    @Query('sources') String sourceId,
    @Query('q') String keyword,
  );

  @GET('top-headlines/sources')
  Future<GetSourcesResponse> getSources();
}
