import 'package:github_search/features/favorites/domain/usecases/delete_favorite.dart';
import 'package:github_search/features/favorites/domain/usecases/find_all_favorites.dart';
import 'package:github_search/features/favorites/domain/usecases/save_favorite.dart';
import 'package:github_search/features/home/domain/entity/user.dart';
import 'package:mobx/mobx.dart';
part 'favorites_controller.g.dart';

class FavoritesStore = _FavoritesStoreBase with _$FavoritesStore;

abstract class _FavoritesStoreBase with Store {
  final FindAllFavorites _findAllFavorites;
  final DeleteFavorite _deleteFavorite;
  final SaveFavorite _saveFavorite;

  _FavoritesStoreBase(
    this._findAllFavorites,
    this._deleteFavorite,
    this._saveFavorite,
  );

  @observable
  ObservableFuture<List<User>> findAllRequest = ObservableFuture.value([]);

  @observable
  ObservableFuture<void> deleteRequest = ObservableFuture.value(null);

  @observable
  ObservableFuture<void> saveRequest = ObservableFuture.value(null);

  @action
  void findAll() {
    findAllRequest = _findAllFavorites.execute().asObservable();
  }

  @action
  void save(User user) {
    saveRequest = _saveFavorite.execute(user).asObservable();
  }

  @action
  void delete(User user) {
    deleteRequest = _deleteFavorite.execute(user).asObservable();
  }
}
