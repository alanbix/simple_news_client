import 'package:simple_news_client/core/data/data_sources/article_data_source.dart';
import 'package:simple_news_client/core/domain/article.dart';

class ArticleRepository {
  final ArticleDataSource _articleDataSource;

  ArticleRepository(this._articleDataSource);

  Future<List<Article>> getTopArticles() => _articleDataSource.getTopArticles();
}
