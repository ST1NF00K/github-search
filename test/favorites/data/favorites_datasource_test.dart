import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void sqfliteTestInit() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  sqfliteTestInit();
  late Database db;

  final users = [
    {
      "login": "LilySny",
      "id": 33629714,
      "avatarUrl": "https://avatars.githubusercontent.com/u/33629714?v=4",
      "location": "Campinas, São Paulo - Brazil",
      "email": "liviacastilholi@gmail.com",
      "bio": ""
    },
    {
      "login": "LilySny2",
      "id": 33629715,
      "avatarUrl": "https://avatars.githubusercontent.com/u/33629714?v=4",
      "location": "Campinas, São Paulo - Brazil",
      "email": "liviacastilholi2@gmail.com",
      "bio": ""
    }
  ];

  setUpAll(() async {
    db = await openDatabase(inMemoryDatabasePath);

    await db.execute(
      "CREATE TABLE favorites(id INTEGER PRIMARY KEY, login TEXT, avatarUrl TEXT, location TEXT, email TEXT, bio TEXT)",
    );
  });

  tearDownAll(() async {
    await db.close();
  });

  Future insertUsers() async {
    await db.insert(
      'favorites',
      users[0],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'favorites',
      users[1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  group('test favorites datasource', () {
    test('datasource should add favorite to db', () async {
      await insertUsers();

      var result = await db.query('favorites');
      expect(result, users);
    });

    test('datasource should delete favorite from db', () async {
      insertUsers();

      db.delete(
        'favorites',
        where: 'id = ?',
        whereArgs: [33629715],
      );

      var result = await db.query('favorites');
      expect(result, equals([users[0]]));
    });
  });
}
