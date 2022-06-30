import 'package:github_search/favorites/data/favorites_datasource.dart';
import 'package:github_search/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/home/domain/entity/user.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDatasource _favoritesDatasource;

  FavoritesRepositoryImpl(this._favoritesDatasource);

  @override
  Future<List<User>>? findAll() async {
    try {
      return await _favoritesDatasource.findAll()!;
    } catch (e) {
      throw Exception("Error occured finding all favorites in local db.");
    }
  }

  @override
  Future<void>? save(User user) async {
    try {
      await _favoritesDatasource.save(user);
    } catch (e) {
      throw Exception("Error occured saving favorite in local db.");
    }
  }

  @override
  Future<void>? delete(User user) async {
    try {
      await _favoritesDatasource.delete(user);
    } catch (e) {
      throw Exception("Error occured deleting favorite from local db.");
    }
  }
}
