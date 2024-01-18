import 'package:simple_news_client/core/domain/source.dart';

abstract interface class SourceDataSource {
  Future<List<Source>> getSources();
}
