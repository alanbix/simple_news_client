// Mocks generated by Mockito 5.4.4 from annotations
// in simple_news_client/test/framework/network/data_sources_implementation/network_source_data_source_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:simple_news_client/framework/network/model/response/get_articles_response.dart'
    as _i2;
import 'package:simple_news_client/framework/network/model/response/get_sources_response.dart'
    as _i3;
import 'package:simple_news_client/framework/network/news_api.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetArticlesResponse_0 extends _i1.SmartFake
    implements _i2.GetArticlesResponse {
  _FakeGetArticlesResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetSourcesResponse_1 extends _i1.SmartFake
    implements _i3.GetSourcesResponse {
  _FakeGetSourcesResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NewsApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockNewsApi extends _i1.Mock implements _i4.NewsApi {
  @override
  _i5.Future<_i2.GetArticlesResponse> getTopArticles(String? sourceId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopArticles,
          [sourceId],
        ),
        returnValue: _i5.Future<_i2.GetArticlesResponse>.value(
            _FakeGetArticlesResponse_0(
          this,
          Invocation.method(
            #getTopArticles,
            [sourceId],
          ),
        )),
        returnValueForMissingStub: _i5.Future<_i2.GetArticlesResponse>.value(
            _FakeGetArticlesResponse_0(
          this,
          Invocation.method(
            #getTopArticles,
            [sourceId],
          ),
        )),
      ) as _i5.Future<_i2.GetArticlesResponse>);

  @override
  _i5.Future<_i2.GetArticlesResponse> searchArticles(
    String? sourceId,
    String? keyword,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchArticles,
          [
            sourceId,
            keyword,
          ],
        ),
        returnValue: _i5.Future<_i2.GetArticlesResponse>.value(
            _FakeGetArticlesResponse_0(
          this,
          Invocation.method(
            #searchArticles,
            [
              sourceId,
              keyword,
            ],
          ),
        )),
        returnValueForMissingStub: _i5.Future<_i2.GetArticlesResponse>.value(
            _FakeGetArticlesResponse_0(
          this,
          Invocation.method(
            #searchArticles,
            [
              sourceId,
              keyword,
            ],
          ),
        )),
      ) as _i5.Future<_i2.GetArticlesResponse>);

  @override
  _i5.Future<_i3.GetSourcesResponse> getSources() => (super.noSuchMethod(
        Invocation.method(
          #getSources,
          [],
        ),
        returnValue:
            _i5.Future<_i3.GetSourcesResponse>.value(_FakeGetSourcesResponse_1(
          this,
          Invocation.method(
            #getSources,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.GetSourcesResponse>.value(_FakeGetSourcesResponse_1(
          this,
          Invocation.method(
            #getSources,
            [],
          ),
        )),
      ) as _i5.Future<_i3.GetSourcesResponse>);
}
