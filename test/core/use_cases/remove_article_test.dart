import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/use_cases/remove_article.dart';

@GenerateNiceMocks([MockSpec<ArticleRepository>()])
import 'remove_article_test.mocks.dart';

void main() {
  final mockArticleRepository = MockArticleRepository();
  final RemoveArticle removeArticle = RemoveArticle(mockArticleRepository);

  const title = 'Breaking news';
  const url = 'https://www.some_ramdon_url.com';
  const publishedAt = '2024-01-19T01:19:21.000';
  const author = 'John Doe';
  const description = 'some random description';
  const urlToImage = 'https://www.some_ramdon_url.com/image';
  const content = 'Lorem ipsum...';
  const sourceName = 'Test News';
  const sourceId = 'test-news';

  final article1 = Article(
    title: title,
    url: url,
    publishedAt: DateTime.parse(publishedAt),
    source: const ArticleSource(
      name: sourceName,
      id: sourceId,
    ),
    author: author,
    description: description,
    urlToImage: urlToImage,
    content: content,
  );

  final article2 = Article(
    title: title,
    url: url,
    publishedAt: DateTime.parse(publishedAt),
    source: const ArticleSource(
      name: sourceName,
      id: sourceId,
    ),
    author: author,
    description: description,
    urlToImage: urlToImage,
    content: content,
  );

  group('RemoveArticle', () {
    tearDown(() => reset(mockArticleRepository));

    test('''GIVEN I'm a user with articles saved',
    WHEN removing an article
    THEN should successfully remove the article''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockArticleRepository.removeArticle(any)).thenAnswer((_) async {
        return;
      });

      //WHEN
      await removeArticle(articles.first.url);

      //THEN
      verify(mockArticleRepository.removeArticle(article1.url)).called(1);
    });

    test('''GIVEN I'm a user with articles saved',
    WHEN removing an article
    THEN should throw an exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockArticleRepository.removeArticle(any)).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await removeArticle(articles.first.url),
        throwsException,
      );
      verify(mockArticleRepository.removeArticle(article1.url)).called(1);
    });
  });
}
