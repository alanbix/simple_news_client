import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_news_client/core/domain/source.dart';

part 'get_sources_response.freezed.dart';
part 'get_sources_response.g.dart';

@freezed
class GetSourcesResponse with _$GetSourcesResponse {
  const factory GetSourcesResponse({
    required String status,
    required List<Source> sources,
  }) = _GetSourcesResponse;

  factory GetSourcesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSourcesResponseFromJson(json);
}
