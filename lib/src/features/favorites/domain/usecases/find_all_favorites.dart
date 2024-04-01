import 'package:github_search/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

abstract class FindAllFavorites {
  Future<List<User>> execute();
}

class FindAllFavoritesImpl implements FindAllFavorites {
  final FavoritesRepository _favoritesRepository;

  FindAllFavoritesImpl(this._favoritesRepository);

  @override
  Future<List<User>> execute() async {
    return await _favoritesRepository.findAll()!;
  }
}
