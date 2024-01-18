import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_client/core/domain/source.dart';
import 'package:simple_news_client/di/di.dart';

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
  const _HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                Visibility(
                  visible: state.isLoading,
                  child: const LinearProgressIndicator(),
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
                            context.cubit.getTopHeadlines(source);
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
                    ),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.articles[index].title),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

extension on BuildContext {
  HomeCubit get cubit => read<HomeCubit>();
}
