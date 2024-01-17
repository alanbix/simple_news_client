import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/domain/result.dart';

abstract interface class ArticleDataSource {
  Future<Result<List<Article>>> getTopArticles();
}
