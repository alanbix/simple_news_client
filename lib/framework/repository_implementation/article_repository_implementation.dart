import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/data_sources/local_article_data_source.dart';
import 'package:simple_news_client/core/data/data_sources/remote_article_data_source.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';

@Injectable(as: ArticleRepository)
class ArticleRepositoryImplementation implements ArticleRepository {
  final RemoteArticleDataSource _remoteArticleDataSource;
  final LocalArticleDataSource _localArticleDataSource;

  ArticleRepositoryImplementation(
    this._remoteArticleDataSource,
    this._localArticleDataSource,
  );

  @override
  Future<List<Article>> getTopArticles(String sourceId) =>
      _remoteArticleDataSource.getTopArticles(sourceId);

  @override
  Future<List<Article>> searchArticles(String sourceId, String keyword) =>
      _remoteArticleDataSource.searchArticles(sourceId, keyword);

  @override
  Future<List<Article>> getSavedArticles() =>
      _localArticleDataSource.getSavedArticles();

  @override
  Future<void> removeArticle(String id) =>
      _localArticleDataSource.removeArticle(id);

  @override
  Future<void> saveArticle(Article article) =>
      _localArticleDataSource.saveArticle(article);
}
