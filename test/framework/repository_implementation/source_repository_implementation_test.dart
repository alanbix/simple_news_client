import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/data_sources/source_data_source.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/framework/repository_implementation/source_repository_implementation.dart';

@GenerateNiceMocks([MockSpec<SourceDataSource>()])
import 'source_repository_implementation_test.mocks.dart';

void main() {
  final mockSourceDataSource = MockSourceDataSource();
  final SourceRepositoryImplementation sourceRepositoryImplementation =
      SourceRepositoryImplementation(mockSourceDataSource);

  const id = 'test_news';
  const name = 'Test News';
  const description = 'This is a descrpiton';
  const url = 'https://www.some_ramdon_url.com';
  const category = 'Home & Health';
  const language = 'en';
  const country = 'us';

  group('SourceRepositoryImplementation', () {
    tearDown(() => reset(mockSourceDataSource));

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
      when(mockSourceDataSource.getSources()).thenAnswer((_) async => sources);

      //WHEN
      final result = await sourceRepositoryImplementation.getSources();

      //THEN
      expect(result, sources);
      verify(mockSourceDataSource.getSources()).called(1);
    });

    test('''GIVEN there is a list of sources,
    WHEN fetching the list
    THEN should return error''', () async {
      //GIVEN
      final sources = [];

      when(mockSourceDataSource.getSources()).thenThrow(Exception());

      //WHEN/THEN
      expect(() async => await sourceRepositoryImplementation.getSources(),
          throwsException);
      verify(mockSourceDataSource.getSources()).called(1);
    });
  });
}
