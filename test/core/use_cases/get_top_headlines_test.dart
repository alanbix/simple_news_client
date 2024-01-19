import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/repositories/article_repository.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/use_cases/get_top_headlines.dart';

@GenerateNiceMocks([MockSpec<ArticleRepository>()])
import 'get_top_headlines_test.mocks.dart';

void main() {
  final mockArticleRepository = MockArticleRepository();
  final GetTopHeadlines getTopHeadlines =
      GetTopHeadlines(mockArticleRepository);

  const title = 'Breaking news';
  const url = 'https://www.some_ramdon_url.com';
  const publishedAt = '2024-01-19T01:19:21.000';
  const author = 'John Doe';
  const description = 'This is a description';
  const urlToImage = 'https://www.some_ramdon_url.com/image';
  const content = 'Lorem ipsum...';
  const sourceName = 'Test News';
  const sourceId = 'test-news';

  group('GetTopHeadlines', () {
    tearDown(() => reset(mockArticleRepository));

    test('''GIVEN there is a list of top headlines,
    WHEN fetching the list
    THEN should successfully return the headlines''', () async {
      //GIVEN
      final headlines = [
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
      when(mockArticleRepository.getTopArticles(sourceId))
          .thenAnswer((_) async => headlines);

      //WHEN
      final result = await getTopHeadlines(sourceId: sourceId);

      //THEN
      expect(result, headlines);
      verify(mockArticleRepository.getTopArticles(sourceId)).called(1);
    });

    test('''GIVEN there is a list of headlines,
    WHEN fetching the list
    THEN should return error''', () async {
      //GIVEN
      final headlines = [];

      when(mockArticleRepository.getTopArticles(sourceId))
          .thenThrow(Exception());

      //WHEN/THEN
      expect(
        () async => await getTopHeadlines(sourceId: sourceId),
        throwsException,
      );
      verify(mockArticleRepository.getTopArticles(sourceId)).called(1);
    });
  });
}
