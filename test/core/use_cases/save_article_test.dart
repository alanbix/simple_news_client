import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/use_cases/save_article.dart';

@GenerateNiceMocks([MockSpec<ArticleRepository>()])
import 'save_article_test.mocks.dart';

void main() {
  final mockArticleRepository = MockArticleRepository();
  final SaveArticle saveArticle = SaveArticle(mockArticleRepository);

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

  group('SaveArticle', () {
    tearDown(() => reset(mockArticleRepository));

    test('''GIVEN I have a list of articles,
    WHEN saving an article
    THEN should successfully save the article''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockArticleRepository.saveArticle(any)).thenAnswer((_) async {});

      //WHEN
      await saveArticle(articles.first);

      //THEN
      verify(mockArticleRepository.saveArticle(article1)).called(1);
    });

    test('''GIVEN I have a list of articles,
    WHEN saving an article
    THEN should throw exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockArticleRepository.saveArticle(any)).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await saveArticle(article1),
        throwsException,
      );
      verify(mockArticleRepository.saveArticle(articles.first)).called(1);
    });
  });
}
