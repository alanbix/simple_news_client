import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/framework/network/data_sources_implementation/network_source_data_source.dart';
import 'package:simple_news_client/framework/network/model/response/get_sources_response.dart';
import 'package:simple_news_client/framework/network/news_api.dart';

@GenerateNiceMocks([MockSpec<NewsApi>()])
import 'network_source_data_source_test.mocks.dart';

void main() {
  final mockNewsApi = MockNewsApi();
  final NetworkSourceDataSource networkSourceDataSource =
      NetworkSourceDataSource(mockNewsApi);

  const id = 'test_news';
  const name = 'Test News';
  const description = 'This is a descrpiton';
  const url = 'https://www.some_ramdon_url.com';
  const category = 'Home & Health';
  const language = 'en';
  const country = 'us';

  group('NetworkSourceDataSource', () {
    tearDown(() => reset(mockNewsApi));

    test('''GIVEN there is a list of sources,
    WHEN fetching the list
    THEN should successfully return the list''', () async {
      //GIVEN
      final sources = [
        const Source(
          id: id,
          name: name,
          description: description,
          url: url,
          category: category,
          language: language,
          country: country,
        ),
        const Source(
          id: id,
          name: name,
          description: description,
          url: url,
          category: category,
          language: language,
          country: country,
        ),
      ];
      when(mockNewsApi.getSources()).thenAnswer(
          (_) async => GetSourcesResponse(status: 'ok', sources: sources));

      //WHEN
      final result = await networkSourceDataSource.getSources();

      //THEN
      expect(result, sources);
      verify(mockNewsApi.getSources()).called(1);
    });

    test('''GIVEN there is a list of sources,
    WHEN fetching the list
    THEN should return error''', () async {
      //GIVEN
      final sources = [];

      when(mockNewsApi.getSources()).thenThrow(Exception());

      //WHEN/THEN
      expect(() async => await networkSourceDataSource.getSources(),
          throwsException);
      verify(mockNewsApi.getSources()).called(1);
    });
  });
}
