import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/use_cases/get_saved_articles.dart';

part 'saved_articles_state.dart';
part 'saved_articles_cubit.freezed.dart';

@injectable
class SavedArticlesCubit extends Cubit<SavedArticlesState> {
  final GetSavedArticles _getSavedArticles;

  SavedArticlesCubit(
    this._getSavedArticles,
  ) : super(const SavedArticlesState()) {
    _fetchSavedArticles();
  }

  void _fetchSavedArticles() async {
    emit(state.copyWith(isLoading: true));
    final savedArticles = await _getSavedArticles();

    emit(state.copyWith(
      articles: savedArticles,
      isLoading: false,
    ));
  }
}
