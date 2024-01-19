import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/di/di.dart';
import 'package:simple_news_client/presentation/home/home_page.dart';
import 'package:simple_news_client/presentation/saved_articles/saved_articles_cubit.dart';
import 'package:simple_news_client/presentation/saved_articles/saved_articles_page.dart';

import 'home/home_cubit.dart';

class SimpleNewsNavBar extends StatefulWidget {
  final String title;
  const SimpleNewsNavBar({
    super.key,
    required this.title,
  });

  @override
  State<SimpleNewsNavBar> createState() => _SimpleNewsNavBarState();
}

class _SimpleNewsNavBarState extends State<SimpleNewsNavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
        ],
      ),
      body: <Widget>[
        BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: HomePage(),
        ),
        BlocProvider(
          create: (context) => getIt<SavedArticlesCubit>(),
          child: const SavedArticlesPage(),
        ),
      ][currentPageIndex],
    );
  }
}
