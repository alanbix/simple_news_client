import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_news_client/core/data/repositories/source_repository.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/core/use_cases/get_sources.dart';

@GenerateNiceMocks([MockSpec<SourceRepository>()])
import 'get_sources_test.mocks.dart';

void main() {
  final mockSourceRepository = MockSourceRepository();
  final GetSources getSources = GetSources(mockSourceRepository);

  const id = 'test_news';
  const name = 'Test News';
  const description = 'This is a descrpiton';
  const url = 'https://www.some_ramdon_url.com';
  const category = 'Home & Health';
  const language = 'en';
  const country = 'us';

  group('GetSources', () {
    tearDown(() => reset(mockSourceRepository));

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
      when(mockSourceRepository.getSources()).thenAnswer((_) async => sources);

      //WHEN
      final result = await getSources();

      //THEN
      expect(result, sources);
      verify(mockSourceRepository.getSources()).called(1);
    });

    test('''GIVEN there is a list of sources,
    WHEN fetching the list
    THEN should return error''', () async {
      //GIVEN
      final sources = [];

      when(mockSourceRepository.getSources()).thenThrow(Exception());

      //WHEN/THEN
      expect(() async => await getSources(), throwsException);
      verify(mockSourceRepository.getSources()).called(1);
    });
  });
}
