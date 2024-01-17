import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';

class GetTopHeadlines {
  final ArticleRepository _articleRepository;

  GetTopHeadlines(this._articleRepository);

  Future<List<Article>> call() => _articleRepository.getTopArticles();
}
