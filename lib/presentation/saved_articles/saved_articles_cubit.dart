import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:simple_news_client/core/use_cases/get_saved_articles.dart';
import 'package:simple_news_client/core/use_cases/remove_article.dart';

part 'saved_articles_state.dart';
part 'saved_articles_cubit.freezed.dart';

@injectable
class SavedArticlesCubit extends Cubit<SavedArticlesState> {
  final GetSavedArticles _getSavedArticles;
  final RemoveArticle _removeArticle;

  SavedArticlesCubit(
    this._getSavedArticles,
    this._removeArticle,
  ) : super(const SavedArticlesState()) {
    _fetchSavedArticles();
  }

  Future<void> _fetchSavedArticles() async {
    emit(state.copyWith(isLoading: true));
    final savedArticles = await _getSavedArticles();

    emit(state.copyWith(
      articles: savedArticles,
      isLoading: false,
    ));
  }

  Future<void> removeArticle(int index) async {
    emit(state.copyWith(isLoading: true));
    await _removeArticle(state.articles[index].url);
    await _fetchSavedArticles();
  }
}
