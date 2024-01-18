import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/data_sources/remote_article_data_source.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';

@Injectable(as: ArticleRepository)
class ArticleRepositoryImplementation implements ArticleRepository {
  final RemoteArticleDataSource _remoteArticleDataSource;

  ArticleRepositoryImplementation(this._remoteArticleDataSource);

  @override
  Future<List<Article>> getTopArticles(String sourceId) =>
      _remoteArticleDataSource.getTopArticles(sourceId);

  @override
  Future<List<Article>> searchArticles(String sourceId, String keyword) =>
      _remoteArticleDataSource.searchArticles(sourceId, keyword);
}
