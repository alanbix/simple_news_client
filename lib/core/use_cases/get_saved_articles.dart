import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';

@injectable
class GetSavedArticles {
  final ArticleRepository _articleRepository;

  GetSavedArticles(this._articleRepository);

  Future<List<Article>> call() => _articleRepository.getSavedArticles();
}
