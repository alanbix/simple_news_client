import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
              child: Expanded(
                child: (state.articles.isEmpty)
                    ? const Center(
                        child: Text(
                          'You do not have saved articles yet!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          itemCount: state.articles.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse(state.articles[index].url),
                                );
                              },
                              title: Text(state.articles[index].title),
                            );
                          },
                        ),
                      ),
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
