import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';

class LocalStorage {
  static Future<void> insertFavorite(ResponseRandomWordModel randomWord) async {
    await (await openDatabase(
      join(await getDatabasesPath(), 'favorites_database.db'),
    ))
        .transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO favorites(word, meaning, pronunciation, example, level) VALUES(?, ?, ?, ?, ?)',
        [
          randomWord.word?.word,
          randomWord.word?.meaning,
          randomWord.word?.pronunciation,
          randomWord.word?.example,
          randomWord.word?.level,
        ],
      );
    });
  }

  static Future<void> createDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), 'favorites_database.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE favorites (id INTEGER PRIMARY KEY, word TEXT, meaning TEXT,pronunciation TEXT, example TEXT, level TEXT)',
        );
      },
    );
  }

  static Future<void> clearFavoriteTable() async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'favorites_database.db'),
    );
    await db.rawQuery('DELETE FROM favorites');
  }

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'favorites_database.db'),
    );
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return maps;
  }

  static Future<void> deleteFavoriteById(int id) async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'favorites_database.db'),
    );
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
