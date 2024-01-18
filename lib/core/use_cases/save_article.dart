import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';

@injectable
class SaveArticle {
  final ArticleRepository _articleRepository;

  SaveArticle(this._articleRepository);

  Future<void> call(Article article) => _articleRepository.saveArticle(article);
}
