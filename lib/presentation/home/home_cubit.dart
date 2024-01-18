import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/core/use_cases/get_sources.dart';
import 'package:simple_news_client/core/use_cases/get_top_headlines.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetTopHeadlines _getTopHeadlines;
  final GetSources _getSources;

  HomeCubit(
    this._getTopHeadlines,
    this._getSources,
  ) : super(const HomeState()) {
    _fetchSources();
  }

  void _fetchSources() async {
    final sources = await _getSources();
    emit(state.copyWith(sources: sources));

    if (sources.isNotEmpty) {
      getTopHeadlines(sources.first);
    }
  }

  Future<void> getTopHeadlines(Source source) async {
    emit(state.copyWith(isLoading: true));
    final articles = await _getTopHeadlines(sourceId: source.id);

    emit(state.copyWith(
      articles: articles,
      isLoading: false,
    ));
  }
}
