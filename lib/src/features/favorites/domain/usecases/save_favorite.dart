import 'package:github_search/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

abstract class SaveFavorite {
  Future<void> execute(User user);
}

class SaveFavoriteImpl implements SaveFavorite {
  final FavoritesRepository _favoritesRepository;

  SaveFavoriteImpl(this._favoritesRepository);

  @override
  Future<void> execute(User user) async {
    return await _favoritesRepository.save(user);
  }
}
