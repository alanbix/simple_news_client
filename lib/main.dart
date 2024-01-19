import 'package:flutter/material.dart';
import 'package:simple_news_client/framework/network/news_api.dart';
import 'package:simple_news_client/presentation/simple_news_nav_bar.dart';
import 'package:workmanager/workmanager.dart';

import 'di/di.dart';

const _fetchTopArticleTask = 'fetchTopArticlesTask';
const _sourceIdKey = 'sourceId';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == _fetchTopArticleTask) {
      final newsApi = getIt<NewsApi>();
      final articlesResponse =
          await newsApi.getTopArticles(inputData?[_sourceIdKey]);
      print('Articles updated!\n Total: ${articlesResponse.totalResults}');
    }
    return Future.value(true);
  });
}

void schedulePeriodicApiCall(String sourceId) {
  Workmanager().registerPeriodicTask(
    _fetchTopArticleTask,
    _fetchTopArticleTask,
    inputData: <String, dynamic>{_sourceIdKey: sourceId},
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Workmanager().initialize(callbackDispatcher);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const _title = 'Simple News Client';

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SimpleNewsNavBar(title: _title),
    );
  }
}
