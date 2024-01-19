import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/use_cases/search_articles.dart';

@GenerateNiceMocks([MockSpec<ArticleRepository>()])
import 'search_articles_test.mocks.dart';

void main() {
  final mockArticleRepository = MockArticleRepository();
  final SearchArticles searchArticles = SearchArticles(mockArticleRepository);

  const title = 'Breaking news';
  const url = 'https://www.some_ramdon_url.com';
  const publishedAt = '2024-01-19T01:19:21.000';
  const author = 'John Doe';
  const description = 'some random description';
  const urlToImage = 'https://www.some_ramdon_url.com/image';
  const content = 'Lorem ipsum...';
  const sourceName = 'Test News';
  const sourceId = 'test-news';
  const searchKeyword = 'some random test';

  group('SearchArticles', () {
    tearDown(() => reset(mockArticleRepository));

    test('''GIVEN there is a list of articles,
    WHEN searching by keyword
    THEN should successfully return the articles''', () async {
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
      when(mockArticleRepository.searchArticles(sourceId, searchKeyword))
          .thenAnswer((_) async => articles);

      //WHEN
      final result =
          await searchArticles(sourceId: sourceId, keyword: searchKeyword);

      //THEN
      expect(result, articles);
      verify(mockArticleRepository.searchArticles(sourceId, searchKeyword))
          .called(1);
    });

    test('''GIVEN there is a list of articles,
    WHEN searching by keyword
    THEN should return error''', () async {
      //GIVEN
      final articles = [];

      when(mockArticleRepository.searchArticles(sourceId, searchKeyword))
          .thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async =>
            await searchArticles(sourceId: sourceId, keyword: searchKeyword),
        throwsException,
      );
      verify(mockArticleRepository.searchArticles(sourceId, searchKeyword))
          .called(1);
    });
  });
}
