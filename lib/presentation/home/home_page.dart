import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/presentation/debouncer.dart';
import 'package:simple_news_client/presentation/news_scroll_bar.dart';

import 'home_cubit.dart';

class HomePage extends StatelessWidget {
  final _debouncer = Debouncer();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            if (state.isLoading) const LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SearchBar(
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    hintText: 'Search for any news',
                    onChanged: (value) {
                      // The search is debounced, but let's give the user
                      // immediate UI feedback:)
                      context.cubit.toggleLoading(true);

                      _debouncer.run(() {
                        context.cubit.searchArticles(value);
                      });
                    },
                    leading: const Icon(Icons.search),
                  ),
                  const SizedBox(height: 20),
                  if (state.sources.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Source:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 16),
                        DropdownMenu(
                          initialSelection: state.sources.firstOrNull,
                          onSelected: (source) {
                            if (source != null) {
                              context.cubit.setSelectedSource(source);
                            }
                          },
                          dropdownMenuEntries: state.sources
                              .map<DropdownMenuEntry<Source>>((Source source) {
                            return DropdownMenuEntry<Source>(
                              value: source,
                              label: source.name,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  if (state.articles.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      state.keyword.isEmpty
                          ? 'Top headlines:'
                          : 'Search results:',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Expanded(
                    child: (state.articles.isEmpty && state.keyword.isNotEmpty)
                        ? const Center(
                            child: Text(
                              'Could not find any news! Try with a different search.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24),
                            ),
                          )
                        : NewsScrollBar(
                            articles: state.articles,
                            onBookmarkPressed: (index) async {
                              await context.cubit.saveArticle(index).then(
                                    (_) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('Article Saved!'),
                                      ),
                                    ),
                                  );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

extension on BuildContext {
  HomeCubit get cubit => read<HomeCubit>();
}
