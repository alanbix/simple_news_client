import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/core/use_cases/get_sources.dart';
import 'package:simple_news_client/core/use_cases/get_top_headlines.dart';
import 'package:simple_news_client/core/use_cases/save_article.dart';
import 'package:simple_news_client/core/use_cases/search_articles.dart';
import 'package:simple_news_client/main.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetTopHeadlines _getTopHeadlines;
  final GetSources _getSources;
  final SearchArticles _searchArticles;
  final SaveArticle _saveArticle;

  HomeCubit(
    this._getTopHeadlines,
    this._getSources,
    this._searchArticles,
    this._saveArticle,
  ) : super(const HomeState()) {
    _fetchSources();
    _refreshArticlesPeriodically();
  }

  void _refreshArticlesPeriodically() {
    Timer.periodic(
      const Duration(minutes: 5),
      (timer) async => await searchArticles(state.keyword),
    );
  }

  void _fetchSources() async {
    final sources = await _getSources();
    emit(state.copyWith(sources: sources));

    schedulePeriodicApiCall(sources.first.id);
    await setSelectedSource(sources.first);
  }

  Future<void> setSelectedSource(Source source) async {
    emit(state.copyWith(selectedSource: source));
    await searchArticles(state.keyword);
  }

  Future<void> searchArticles(String keyword) async {
    emit(state.copyWith(isLoading: true));

    final articles = keyword.isEmpty
        ? await _getTopHeadlines(sourceId: state.selectedSource!.id)
        : await _searchArticles(
            sourceId: state.selectedSource!.id,
            keyword: keyword,
          );

    emit(state.copyWith(
      keyword: keyword,
      articles: articles,
      isLoading: false,
    ));
  }

  void toggleLoading(isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  Future<void> saveArticle(int index) async {
    await _saveArticle(state.articles[index]);
    print('Article saved!');
  }
}
