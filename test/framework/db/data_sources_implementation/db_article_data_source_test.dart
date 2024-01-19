import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/framework/db/data_sources_implementation/db_article_data_source.dart';
import 'package:simple_news_client/framework/db/news_db.dart';

@GenerateNiceMocks([MockSpec<NewsDB>()])
import 'db_article_data_source_test.mocks.dart';

void main() {
  final mockNewsDB = MockNewsDB();
  final DBArticleDataSource dbArticleDataSource =
      DBArticleDataSource(mockNewsDB);

  tearDown(() => reset(mockNewsDB));

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

  group('DBArticleDataSourceGetSavedArticles', () {
    test('''GIVEN I'm a user with articles saved,
    WHEN retrieving the articles
    THEN should successfully return the articles list''', () async {
      //GIVEN
      final articles = [article1, article2];
      when(mockNewsDB.getArticles()).thenAnswer((_) async => articles);

      //WHEN
      final result = await dbArticleDataSource.getSavedArticles();

      //THEN
      expect(result, articles);
      verify(mockNewsDB.getArticles()).called(1);
    });

    test('''GIVEN I'm a user with no articles saved,
    WHEN retrieving the articles
    THEN should successfully return an empty articles list''', () async {
      //GIVEN
      final List<Article> articles = [];
      when(mockNewsDB.getArticles()).thenAnswer((_) async => articles);

      //WHEN
      final result = await dbArticleDataSource.getSavedArticles();

      //THEN
      expect(result, isEmpty);
      verify(mockNewsDB.getArticles()).called(1);
    });

    test('''GIVEN I'm a user with articles saved,
    WHEN retrieving the articles
    THEN should throw exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockNewsDB.getArticles()).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await dbArticleDataSource.getSavedArticles(),
        throwsException,
      );
      verify(mockNewsDB.getArticles()).called(1);
    });
  });

  group('DBArticleDataSourceSaveArticle', () {
    test('''GIVEN I have a list of articles,
    WHEN saving an article
    THEN should successfully save the article''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockNewsDB.insertArticle(any)).thenAnswer((_) async {
        return;
      });

      //WHEN
      await dbArticleDataSource.saveArticle(articles.first);

      //THEN
      verify(mockNewsDB.insertArticle(article1)).called(1);
    });

    test('''GIVEN I have a list of articles,
    WHEN saving an article
    THEN should throw exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockNewsDB.insertArticle(any)).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await dbArticleDataSource.saveArticle(article1),
        throwsException,
      );
      verify(mockNewsDB.insertArticle(articles.first)).called(1);
    });
  });

  group('DBArticleDataSourceGetSavedArticlesRemoveArticle', () {
    test('''GIVEN I'm a user with articles saved',
    WHEN removing an article
    THEN should successfully remove the article''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockNewsDB.deleteArticle(any)).thenAnswer((_) async {
        return;
      });

      //WHEN
      await dbArticleDataSource.removeArticle(articles.first.url);

      //THEN
      verify(mockNewsDB.deleteArticle(article1.url)).called(1);
    });

    test('''GIVEN I'm a user with articles saved',
    WHEN removing an article
    THEN should throw an exception''', () async {
      //GIVEN
      final articles = [article1, article2];

      when(mockNewsDB.deleteArticle(any)).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await dbArticleDataSource.removeArticle(articles.first.url),
        throwsException,
      );
      verify(mockNewsDB.deleteArticle(article1.url)).called(1);
    });
  });
}
