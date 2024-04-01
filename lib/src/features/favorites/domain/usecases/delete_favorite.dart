import 'package:github_search/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

abstract class DeleteFavorite {
  Future<void> execute(User user);
}

class DeleteFavoriteImpl implements DeleteFavorite {
  final FavoritesRepository _favoritesRepository;

  DeleteFavoriteImpl(this._favoritesRepository);

  @override
  Future<void> execute(User user) async {
    return await _favoritesRepository.delete(user);
  }
}
