import 'package:flutter/material.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScrollBar extends StatelessWidget {
  final List<Article> articles;
  final void Function(int index) onBookmarkPressed;

  const NewsScrollBar({
    super.key,
    required this.articles,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return SizedBox(
            height: 100,
            child: Card(
              child: Center(
                child: ListTile(
                  leading: Image.network(
                    width: 70,
                    height: 100,
                    article.urlToImage ??
                        'https://cdn-icons-png.flaticon.com/512/2965/2965879.png',
                  ),
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(article.url),
                    );
                  },
                  title: Text(
                    article.title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      icon: const Icon(Icons.bookmark),
                      onPressed: () {
                        onBookmarkPressed(index);
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
