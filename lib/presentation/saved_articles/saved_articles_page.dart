import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/presentation/news_scroll_bar.dart';

import 'saved_articles_cubit.dart';

class SavedArticlesPage extends StatelessWidget {
  const SavedArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedArticlesCubit, SavedArticlesState>(
      builder: (context, state) {
        return Stack(
          children: [
            if (state.isLoading) const LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (state.articles.isEmpty)
                  ? const Center(
                      child: Text(
                        'You do not have saved articles yet!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : NewsScrollBar(
                      articles: state.articles,
                      onBookmarkPressed: (index) async {
                        await context.cubit.removeArticle(index).then(
                              (_) => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Article Removed!'),
                                ),
                              ),
                            );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

extension on BuildContext {
  SavedArticlesCubit get cubit => read<SavedArticlesCubit>();
}
