import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';

@injectable
class GetTopHeadlines {
  final ArticleRepository _articleRepository;

  GetTopHeadlines(this._articleRepository);

  Future<List<Article>> call({
    required String sourceId,
  }) =>
      _articleRepository.getTopArticles(sourceId);
}
