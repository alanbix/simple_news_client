import 'package:simple_news_client/core/domain/article.dart';

abstract interface class LocalArticleDataSource {
  Future<List<Article>> getSavedArticles();
  Future<void> saveArticle(Article article);
  Future<void> removeArticle(String id);
}
