import 'package:simple_news_client/core/domain/article.dart';

abstract interface class ArticleRepository {
  Future<List<Article>> getTopArticles(String sourceId);

  Future<List<Article>> searchArticles(String sourceId, String keyword);
}
