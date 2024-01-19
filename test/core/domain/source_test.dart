import 'package:flutter_test/flutter_test.dart';
import 'package:simple_news_client/core/domain/source.dart';

void main() {
  group('Source', () {
    const id = 'test_news';
    const name = 'Test News';
    const description = 'This is a descrpiton';
    const url = 'https://www.some_ramdon_url.com';
    const category = 'Home & Health';
    const language = 'en';
    const country = 'us';

    test('''GIVEN we have a source json,
    WHEN converting from json,
    THEN should return a valid model''', () {
      //GIVEN
      final sourceJson = {
        'id': id,
        'name': name,
        'description': description,
        'url': url,
        'category': category,
        'language': language,
        'country': country,
      };

      //WHEN
      final result = Source.fromJson(sourceJson);

      //THEN
      expect(result, isA<Source>());
      expect(result.id, id);
      expect(result.name, name);
      expect(result.description, description);
      expect(result.url, url);
      expect(result.category, category);
      expect(result.language, language);
      expect(result.country, country);
    });

    test('''GIVEN we have a Source model
    WHEN converting to Json
    THEN should return a valid json map''', () {
      //GIVEN
      const source = Source(
        id: id,
        name: name,
        description: description,
        url: url,
        category: category,
        language: language,
        country: country,
      );

      //WHEN
      final result = source.toJson();

      //THEN
      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], id);
      expect(result['name'], name);
      expect(result['description'], description);
      expect(result['url'], url);
      expect(result['category'], category);
      expect(result['language'], language);
      expect(result['country'], country);
    });
  });
}
