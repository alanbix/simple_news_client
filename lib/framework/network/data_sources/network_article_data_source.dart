import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/data_sources/article_data_source.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/framework/network/news_api.dart';

@Injectable(as: ArticleDataSource)
class NetworkArticleDataSource implements ArticleDataSource {
  final NewsApi _newsApi;

  NetworkArticleDataSource(this._newsApi);

  @override
  Future<List<Article>> getTopArticles() =>
      _newsApi.getTopArticles().then((value) => value.articles);
}
