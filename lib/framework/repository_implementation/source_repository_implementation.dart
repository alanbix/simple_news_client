import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/data_sources/source_data_source.dart';
import 'package:simple_news_client/core/data/repositories/source_repository.dart';
import 'package:simple_news_client/core/domain/source.dart';

@Injectable(as: SourceRepository)
class SourceRepositoryImplementation implements SourceRepository {
  final SourceDataSource _sourceDataSource;

  SourceRepositoryImplementation(this._sourceDataSource);

  @override
  Future<List<Source>> getSources() => _sourceDataSource.getSources();
}
