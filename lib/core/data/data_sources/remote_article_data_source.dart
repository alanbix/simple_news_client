import 'package:simple_news_client/core/domain/article.dart';

abstract interface class RemoteArticleDataSource {
  Future<List<Article>> getTopArticles();
}
