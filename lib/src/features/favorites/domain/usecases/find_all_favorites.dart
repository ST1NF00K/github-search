import 'package:github_search/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

class FindAllFavorites {
  final FavoritesRepository _favoritesRepository;

  FindAllFavorites(this._favoritesRepository);

  Future<List<User>> execute() async {
    return await _favoritesRepository.findAll()!;
  }
}
