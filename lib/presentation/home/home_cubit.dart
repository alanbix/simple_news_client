import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/use_cases/get_top_headlines.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetTopHeadlines _getTopHeadlines;

  HomeCubit(this._getTopHeadlines) : super(const HomeState()) {
    getTopHeadlines();
  }

  void getTopHeadlines() async {
    final articles = await _getTopHeadlines();

    emit(state.copyWith(
      articles: articles,
      isLoading: false,
    ));
  }
}
