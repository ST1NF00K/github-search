import 'package:github_search/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/features/home/domain/entity/user.dart';

class SaveFavorite {
  final FavoritesRepository _favoritesRepository;

  SaveFavorite(this._favoritesRepository);

  Future<void> execute(User user) async {
    return await _favoritesRepository.save(user);
  }
}
