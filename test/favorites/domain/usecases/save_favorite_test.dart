import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/src/features/favorites/domain/usecases/save_favorite.dart';
import 'package:github_search/src/features/home/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/shared_mocks.dart';

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}

void main() {
  late final SaveFavorite usecase;
  late final FavoritesRepository favoritesRepository;

  setUp(() {
    favoritesRepository = FavoritesRepositoryMock();
    usecase = SaveFavorite(favoritesRepository);
  });

  test(
    'should get users in the favorites repository',
    () async {
      final response = UserModel.fromJson(jsonDecode(mockUser));

      usecase.execute(response);
      verify(favoritesRepository.save(response)).called(1);

      expect(response.email, contains('livia'));
    },
  );
}
