import 'package:github_search/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

class DeleteFavorite {
  final FavoritesRepository _favoritesRepository;

  DeleteFavorite(this._favoritesRepository);

  Future<void> execute(User user) async {
    return await _favoritesRepository.delete(user);
  }
}
