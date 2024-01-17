import 'package:simple_news_client/core/domain/article.dart';

abstract interface class ArticleDataSource {
  Future<List<Article>> getTopArticles();
}
