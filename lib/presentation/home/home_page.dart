import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/di/di.dart';
import 'package:simple_news_client/presentation/debouncer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_cubit.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: _HomePage(title: title),
    );
  }
}

class _HomePage extends StatelessWidget {
  final String title;
  final _debouncer = Debouncer();

  _HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Source:'),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownMenu(
                            initialSelection: state.sources.firstOrNull,
                            onSelected: (source) {
                              if (source != null) {
                                context.cubit.setSelectedSource(source);
                              }
                            },
                            dropdownMenuEntries: state.sources
                                .map<DropdownMenuEntry<Source>>(
                                    (Source source) {
                              return DropdownMenuEntry<Source>(
                                value: source,
                                label: source.name,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    if (state.articles.isNotEmpty)
                      Text(
                        state.keyword.isEmpty
                            ? 'Top headlines:'
                            : 'Search results:',
                        style: const TextStyle(fontSize: 20),
                      ),
                    Expanded(
                      child: (state.articles.isEmpty &&
                              state.keyword.isNotEmpty)
                          ? const Center(
                              child: Text(
                                'Could not find any news! Try with a different search.',
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
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

extension on BuildContext {
  HomeCubit get cubit => read<HomeCubit>();
}
