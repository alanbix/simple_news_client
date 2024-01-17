import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

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
              ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.articles[index].title),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
