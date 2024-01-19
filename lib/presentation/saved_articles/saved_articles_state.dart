part of 'saved_articles_cubit.dart';

@freezed
class SavedArticlesState with _$SavedArticlesState {
  const factory SavedArticlesState({
    @Default(true) bool isLoading,
    @Default([]) List<Article> articles,
  }) = _SavedArticlesState;
}
