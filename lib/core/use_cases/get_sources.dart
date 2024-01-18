import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/data/repositories/source_repository.dart';
import 'package:simple_news_client/core/domain/source.dart';

@injectable
class GetSources {
  final SourceRepository _sourceRepository;

  GetSources(this._sourceRepository);

  Future<List<Source>> call() => _sourceRepository.getSources();
}
