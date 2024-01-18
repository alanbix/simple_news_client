import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/data_sources/remote_article_data_source.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/framework/network/news_api.dart';

@Injectable(as: RemoteArticleDataSource)
class NetworkArticleDataSource implements RemoteArticleDataSource {
  final NewsApi _newsApi;

  NetworkArticleDataSource(this._newsApi);

  @override
  Future<List<Article>> getTopArticles(String sourceId) =>
      _newsApi.getTopArticles(sourceId).then((response) => response.articles);

  @override
  Future<List<Article>> searchArticles(String sourceId, String keyword) =>
      _newsApi
          .searchArticles(sourceId, keyword)
          .then((response) => response.articles);
}
