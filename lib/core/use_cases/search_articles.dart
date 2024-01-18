import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';

@injectable
class SearchArticles {
  final ArticleRepository _articleRepository;

  SearchArticles(this._articleRepository);

  Future<List<Article>> call({
    required String sourceId,
    required String keyword,
  }) =>
      _articleRepository.searchArticles(sourceId, keyword);
}
