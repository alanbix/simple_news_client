import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/framework/network/data_sources_implementation/network_article_data_source.dart';
import 'package:simple_news_client/framework/network/model/response/get_articles_response.dart';
import 'package:simple_news_client/framework/network/news_api.dart';

@GenerateNiceMocks([MockSpec<NewsApi>()])
import 'network_article_data_source_test.mocks.dart';

void main() {
  final mockNewsApi = MockNewsApi();
  final NetworkArticleDataSource networkArticleDataSource =
      NetworkArticleDataSource(mockNewsApi);

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

  group('NetworkArticleDataSource', () {
    tearDown(() => reset(mockNewsApi));

    test('''GIVEN there is a list of top articles,
    WHEN fetching the list
    THEN should successfully return the articles''', () async {
      //GIVEN
      final topArticles = [article1, article2];
      when(mockNewsApi.getTopArticles(sourceId))
          .thenAnswer((_) async => GetArticlesResponse(
                status: 'ok',
                totalResults: topArticles.length,
                articles: topArticles,
              ));

      //WHEN
      final result = await networkArticleDataSource.getTopArticles(sourceId);

      //THEN
      expect(result, topArticles);
      verify(mockNewsApi.getTopArticles(sourceId)).called(1);
    });

    test('''GIVEN there is a list of headlines,
    WHEN fetching the list
    THEN should return error''', () async {
      //GIVEN
      final topArticles = [article1, article2];

      when(mockNewsApi.getTopArticles(sourceId)).thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await networkArticleDataSource.getTopArticles(sourceId),
        throwsException,
      );
      verify(mockNewsApi.getTopArticles(sourceId)).called(1);
    });

    test('''GIVEN there is a list of top articles,
    WHEN searching articles by keyword
    THEN should successfully return the articles''', () async {
      //GIVEN
      final topArticles = [article1, article2];
      when(mockNewsApi.searchArticles(sourceId, searchKeyword))
          .thenAnswer((_) async => GetArticlesResponse(
                status: 'ok',
                totalResults: topArticles.length,
                articles: topArticles,
              ));

      //WHEN
      final result = await networkArticleDataSource.searchArticles(
          sourceId, searchKeyword);

      //THEN
      expect(result, topArticles);
      verify(mockNewsApi.searchArticles(sourceId, searchKeyword)).called(1);
    });

    test('''GIVEN there is a list of top articles,
    WHEN searching articles by keyword
    THEN should return error''', () async {
      //GIVEN
      final topArticles = [article1, article2];

      when(mockNewsApi.searchArticles(sourceId, searchKeyword))
          .thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await networkArticleDataSource.searchArticles(
            sourceId, searchKeyword),
        throwsException,
      );
      verify(mockNewsApi.searchArticles(sourceId, searchKeyword)).called(1);
    });
  });
}
