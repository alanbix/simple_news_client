import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/data_sources/local_article_data_source.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/framework/db/news_db.dart';

@Injectable(as: LocalArticleDataSource)
class DBArticleDataSource implements LocalArticleDataSource {
  final NewsDB _newsDB;

  DBArticleDataSource(this._newsDB);

  @override
  Future<List<Article>> getSavedArticles() => _newsDB.getArticles();

  @override
  Future<void> removeArticle(String id) => _newsDB.deleteArticle(id);

  @override
  Future<void> saveArticle(Article article) => _newsDB.insertArticle(article);
}
