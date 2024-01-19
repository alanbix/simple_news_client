import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/data_sources/local_article_data_source.dart';
import 'package:simple_news_client/core/data/data_sources/remote_article_data_source.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/framework/repository_implementation/article_repository_implementation.dart';

@GenerateNiceMocks([
  MockSpec<RemoteArticleDataSource>(),
  MockSpec<LocalArticleDataSource>(),
])
import 'article_repository_implementation_test.mocks.dart';

void main() {
  final mockRemoteArticleDataSource = MockRemoteArticleDataSource();
  final mockLocalArticleDataSource = MockLocalArticleDataSource();
  final ArticleRepositoryImplementation articleRepositoryImplementation =
      ArticleRepositoryImplementation(
    mockRemoteArticleDataSource,
    mockLocalArticleDataSource,
  );

  tearDown(() {
    reset(mockRemoteArticleDataSource);
    reset(mockLocalArticleDataSource);
  });

  const title = 'Breaking news';
  const url = 'https://www.some_ramdon_url.com';
  const publishedAt = '2024-01-19T01:19:21.000';
  const author = 'John Doe';
  const description = 'Some random description';
  const urlToImage = 'https://www.some_ramdon_url.com/image';
  const content = 'Lorem ipsum...';
  const sourceName = 'Test News';
  const sourceId = 'test-news';
  const searchKeyword = 'Some random test';

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

  group('ArticleRepositoryImplementationGetTopArticles', () {
    test('''GIVEN there is a list of top articles,
    WHEN fetching the list
    THEN should successfully return the articles''', () async {
      //GIVEN
      final topArticles = [article1, article2];
      when(mockRemoteArticleDataSource.getTopArticles(sourceId))
          .thenAnswer((_) async => topArticles);

      //WHEN
      final result =
          await articleRepositoryImplementation.getTopArticles(sourceId);

      //THEN
      expect(result, topArticles);
      verify(mockRemoteArticleDataSource.getTopArticles(sourceId)).called(1);
    });

    test('''GIVEN there is a list of top articles,
    WHEN fetching the list
    THEN should return error''', () async {
      //GIVEN
      final topArticles = [article1, article2];

      when(mockRemoteArticleDataSource.getTopArticles(sourceId))
          .thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async =>
            await articleRepositoryImplementation.getTopArticles(sourceId),
        throwsException,
      );
      verify(mockRemoteArticleDataSource.getTopArticles(sourceId)).called(1);
    });
  });

  group('ArticleRepositoryImplementationSearchArticles', () {
    test('''GIVEN there is a list of articles,
    WHEN searching articles by keyword
    THEN should successfully return the articles''', () async {
      //GIVEN
      final topArticles = [article1, article2];
      when(mockRemoteArticleDataSource.searchArticles(sourceId, searchKeyword))
          .thenAnswer((_) async => topArticles);

      //WHEN
      final result = await articleRepositoryImplementation.searchArticles(
          sourceId, searchKeyword);

      //THEN
      expect(result, topArticles);
      verify(mockRemoteArticleDataSource.searchArticles(
              sourceId, searchKeyword))
          .called(1);
    });

    test('''GIVEN there is a list of articles,
    WHEN searching articles by keyword
    THEN should return error''', () async {
      //GIVEN
      final topArticles = [article1, article2];

      when(mockRemoteArticleDataSource.searchArticles(sourceId, searchKeyword))
          .thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await articleRepositoryImplementation.searchArticles(
            sourceId, searchKeyword),
        throwsException,
      );
      verify(mockRemoteArticleDataSource.searchArticles(
              sourceId, searchKeyword))
          .called(1);
    });
  });

  group('ArticleRepositoryImplementationGetSavedArticles', () {
    test('''GIVEN I'm a user with articles saved,
    WHEN retrieving the articles
    THEN should successfully return the articles list''', () async {
      //GIVEN
      final articles = [article1, article2];
      when(mockLocalArticleDataSource.getSavedArticles())
          .thenAnswer((_) async => articles);

      //WHEN
      final result = await articleRepositoryImplementation.getSavedArticles();

      //THEN
      expect(result, articles);
      verify(mockLocalArticleDataSource.getSavedArticles()).called(1);
    });

    test('''GIVEN I'm a user with no articles saved,
    WHEN retrieving the articles
    THEN should successfully return an empty articles list''', () async {
      //GIVEN
      final List<Article> articles = [];
      when(mockLocalArticleDataSource.getSavedArticles())
          .thenAnswer((_) async => articles);

      //WHEN
      final result = await articleRepositoryImplementation.getSavedArticles();

      //THEN
      expect(result, isEmpty);
      verify(mockLocalArticleDataSource.getSavedArticles()).called(1);
    });

    test('''GIVEN I'm a user with articles saved,
    WHEN retrieving the articles
    THEN should throw exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockLocalArticleDataSource.getSavedArticles())
          .thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await articleRepositoryImplementation.getSavedArticles(),
        throwsException,
      );
      verify(mockLocalArticleDataSource.getSavedArticles()).called(1);
    });
  });

  group('ArticleRepositoryImplementationSaveArticle', () {
    test('''GIVEN I have a list of articles,
    WHEN saving an article
    THEN should successfully save the article''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockLocalArticleDataSource.saveArticle(any)).thenAnswer((_) async {
        return;
      });

      //WHEN
      await articleRepositoryImplementation.saveArticle(articles.first);

      //THEN
      verify(mockLocalArticleDataSource.saveArticle(article1)).called(1);
    });

    test('''GIVEN I have a list of articles,
    WHEN saving an article
    THEN should throw exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockLocalArticleDataSource.saveArticle(any)).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await articleRepositoryImplementation.saveArticle(article1),
        throwsException,
      );
      verify(mockLocalArticleDataSource.saveArticle(articles.first)).called(1);
    });
  });

  group('ArticleRepositoryImplementationRemoveArticle', () {
    test('''GIVEN I'm a user with articles saved',
    WHEN removing an article
    THEN should successfully remove the article''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockLocalArticleDataSource.removeArticle(any)).thenAnswer((_) async {
        return;
      });

      //WHEN
      await articleRepositoryImplementation.removeArticle(articles.first.url);

      //THEN
      verify(mockLocalArticleDataSource.removeArticle(article1.url)).called(1);
    });

    test('''GIVEN I'm a user with articles saved',
    WHEN removing an article
    THEN should throw an exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockLocalArticleDataSource.removeArticle(any))
          .thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await articleRepositoryImplementation
            .removeArticle(articles.first.url),
        throwsException,
      );
      verify(mockLocalArticleDataSource.removeArticle(article1.url)).called(1);
    });
  });
}
