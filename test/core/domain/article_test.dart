import 'package:flutter_test/flutter_test.dart';
import 'package:simple_news_client/core/domain/article.dart';

void main() {
  group('Article', () {
    const title = 'Breaking news';
    const url = 'https://www.some_ramdon_url.com';
    const publishedAt = '2024-01-19T01:19:21.000';
    const author = 'John Doe';
    const description = 'This is a description';
    const urlToImage = 'https://www.some_ramdon_url.com/image';
    const content = 'Lorem ipsum...';
    const sourceName = 'Test News';
    const sourceId = 'test-news';

    test('''GIVEN we have an article json,
    WHEN converting from json,
    THEN should return a valid model''', () {
      //GIVEN
      final articleJson = {
        'title': title,
        'url': url,
        'publishedAt': publishedAt,
        'source': {
          'name': sourceName,
          'id': sourceId,
        },
        'author': author,
        'description': description,
        'urlToImage': urlToImage,
        'content': content,
      };

      //WHEN
      final result = Article.fromJson(articleJson);

      //THEN
      expect(result, isA<Article>());
      expect(result.title, title);
      expect(result.url, url);
      expect(result.publishedAt, isA<DateTime>());
      expect(result.source.name, sourceName);
      expect(result.source.id, sourceId);
      expect(result.author, author);
      expect(result.description, description);
      expect(result.urlToImage, urlToImage);
      expect(result.content, content);
    });

    test('''GIVEN we have an Article model
    WHEN converting to Json
    THEN should return a valid json map''', () {
      //GIVEN
      final article = Article(
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

      final result = article.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['title'], title);
      expect(result['url'], url);
      expect(result['publishedAt'], publishedAt);
      expect(result['author'], author);
      expect(result['description'], description);
      expect(result['urlToImage'], urlToImage);
      expect(result['content'], content);
    });
  });
}
