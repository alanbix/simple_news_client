part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(true) bool isLoading,
    @Default([]) List<Article> articles,
    @Default([]) List<Source> sources,
    @Default('') String keyword,
    Source? selectedSource,
  }) = _HomeState;
}
