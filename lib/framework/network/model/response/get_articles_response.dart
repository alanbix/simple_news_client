import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_news_client/core/domain/article.dart';

part 'get_articles_response.freezed.dart';
part 'get_articles_response.g.dart';

@freezed
class GetArticlesResponse with _$GetArticlesResponse {
  const factory GetArticlesResponse({
    required String status,
    required int totalResults,
    required List<Article> articles,
  }) = _GetArticlesResponse;

  factory GetArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetArticlesResponseFromJson(json);
}
