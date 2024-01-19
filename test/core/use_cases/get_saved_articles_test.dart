import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/use_cases/get_saved_articles.dart';

@GenerateNiceMocks([MockSpec<ArticleRepository>()])
import 'get_saved_articles_test.mocks.dart';

void main() {
  final mockArticleRepository = MockArticleRepository();
  final GetSavedArticles getSavedArticles =
      GetSavedArticles(mockArticleRepository);

  const title = 'Breaking news';
  const url = 'https://www.some_ramdon_url.com';
  const publishedAt = '2024-01-19T01:19:21.000';
  const author = 'John Doe';
  const description = 'some random description';
  const urlToImage = 'https://www.some_ramdon_url.com/image';
  const content = 'Lorem ipsum...';
  const sourceName = 'Test News';
  const sourceId = 'test-news';

  group('GetSavedArticles', () {
    tearDown(() => reset(mockArticleRepository));

    test('''GIVEN I'm a user with articles saved,
    WHEN retrieving the articles
    THEN should successfully return the articles list''', () async {
      //GIVEN
      final articles = [
        Article(
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
        ),
        Article(
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
        ),
      ];
      when(mockArticleRepository.getSavedArticles())
          .thenAnswer((_) async => articles);

      //WHEN
      final result = await getSavedArticles();

      //THEN
      expect(result, articles);
      verify(mockArticleRepository.getSavedArticles()).called(1);
    });

    test('''GIVEN I'm a user with no articles saved,
    WHEN retrieving the articles
    THEN should successfully return an empty articles list''', () async {
      //GIVEN
      final List<Article> articles = [];
      when(mockArticleRepository.getSavedArticles())
          .thenAnswer((_) async => articles);

      //WHEN
      final result = await getSavedArticles();

      //THEN
      expect(result, isEmpty);
      verify(mockArticleRepository.getSavedArticles()).called(1);
    });

    test('''GIVEN I'm a user with articles saved,
    WHEN retrieving the articles
    THEN should throw exception''', () async {
      //GIVEN
      final articles = [];

      when(mockArticleRepository.getSavedArticles()).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await getSavedArticles(),
        throwsException,
      );
      verify(mockArticleRepository.getSavedArticles()).called(1);
    });
  });
}
