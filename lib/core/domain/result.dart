import 'package:simple_news_client/core/domain/news_error.dart';

sealed class Result<T> {
  final T? data;
  final NewsError? error;

  Result({this.data, this.error});
}

class Success<T> extends Result<T> {
  Success(T data) : super(data: data);
}

class Failure<T> extends Result<T> {
  Failure(NewsError error) : super(error: error);
}
