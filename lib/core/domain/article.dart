import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  const factory Article({
    required String title,
    required String url,
    required DateTime publishedAt,
    required ArticleSource source,
    String? author,
    String? description,
    String? urlToImage,
    String? content,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}

@freezed
class ArticleSource with _$ArticleSource {
  const factory ArticleSource({
    required String name,
    String? id,
  }) = _ArticleSource;

  factory ArticleSource.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceFromJson(json);
}
