import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Simple News Client'),
      ),
      body: Stack(
        children: [
          const LinearProgressIndicator(),
          ListView(),
        ],
      ),
    );
  }
}
