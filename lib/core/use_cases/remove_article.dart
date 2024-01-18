import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';

@injectable
class RemoveArticle {
  final ArticleRepository _articleRepository;

  RemoveArticle(this._articleRepository);

  Future<void> call() => _articleRepository.removeArticle();
}
