import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/data_sources/source_data_source.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/framework/network/news_api.dart';

@Injectable(as: SourceDataSource)
class NetworkSourceDataSource implements SourceDataSource {
  final NewsApi _newsApi;

  NetworkSourceDataSource(this._newsApi);

  @override
  Future<List<Source>> getSources() =>
      _newsApi.getSources().then((response) => response.sources);
}
