import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:simple_news_client/core/domain/article.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@singleton
@injectable
class NewsDB {
  static const _tableNameArticles = 'articles';
  static const _columNameId = 'id';
  static const _columNameItem = 'item';

  Future<Database> _getDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'simple_news_database.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $_tableNameArticles ($_columNameId TEXT PRIMARY KEY, $_columNameItem TEXT NOT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertArticle(Article article) async {
    final db = await _getDB();

    await db.insert(
      _tableNameArticles,
      {
        _columNameId: article.url,
        _columNameItem: jsonEncode(article.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Article>> getArticles() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return jsonDecode(maps[i][_columNameItem]) as Article;
    });
  }

  Future<void> deleteArticle(String id) async {
    final db = await _getDB();

    await db.delete(
      _tableNameArticles,
      where: '$_columNameId = ?',
      whereArgs: [id],
    );
  }
}
