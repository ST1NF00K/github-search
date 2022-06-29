import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/favorites/data/favorites_datasource.dart';
import 'package:github_search/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/favorites/domain/repository/favorites_repository_impl.dart';
import 'package:github_search/home/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/shared_mocks.dart';

class FavoritesDatasourceMock extends Mock implements FavoritesDatasource {}

void main() {
  late final FavoritesDatasource favoritesDatasource;
  late final FavoritesRepository repository;

  setUp(() {
    favoritesDatasource = FavoritesDatasourceMock();
    repository = FavoritesRepositoryImpl(favoritesDatasource);
  });

  group('favorites repositoy tests', () {
    test('repository should find all favorites in db', () async {
      final data = jsonDecode(mockUserList)["data"] as List;
      final response = data.map((e) => UserModel.fromJson(e)).toList();

      when(favoritesDatasource.findAll()).thenAnswer((_) async => response);

      final result = await repository.findAll();

      expect(result.first.email, contains('livia'));
    });

    test('repository should throw an error if could not find all', () async {
      when(favoritesDatasource.findAll()).thenThrow((_) async => Exception());

      final result = repository.findAll();

      await expectLater(result, throwsException);
    });
  });
}
