import 'package:simple_news_client/core/domain/source.dart';

abstract interface class SourceRepository {
  Future<List<Source>> getSources();
}
