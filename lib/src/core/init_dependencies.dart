import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search/src/features/favorites/data/favorites_datasource.dart';
import 'package:github_search/src/features/favorites/data/favorites_datasource_impl.dart';
import 'package:github_search/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:github_search/src/features/favorites/domain/repository/favorites_repository_impl.dart';
import 'package:github_search/src/features/favorites/domain/usecases/delete_favorite.dart';
import 'package:github_search/src/features/favorites/domain/usecases/find_all_favorites.dart';
import 'package:github_search/src/features/favorites/domain/usecases/save_favorite.dart';
import 'package:github_search/src/features/favorites/view/controllers/favorites_controller.dart';
import 'package:github_search/src/features/home/data/service/github_service_impl.dart';
import 'package:github_search/src/features/home/domain/service/github_service.dart';
import 'package:github_search/src/features/home/domain/usecases/find_all_users.dart';
import 'package:github_search/src/features/home/domain/usecases/find_user_by_id.dart';
import 'package:github_search/src/features/home/view/controllers/github_store.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  setupServices();
  setupDatasources();
  setupRepositories();
  setupUsecases();
  setupControllers();
}

void setupServices() {
  getIt.registerSingleton<GithubService>(GithubServiceImpl(Dio()));
}

void setupDatasources() {
  getIt.registerFactory<FavoritesDatasource>(() => FavoritesDatasourceImpl());
}

void setupRepositories() {
  getIt.registerFactory<FavoritesRepository>(() => FavoritesRepositoryImpl(getIt<FavoritesDatasource>()));
}

void setupUsecases() {
  // home
  getIt.registerFactory<FindAllUsers>(() => FindAllUsersImpl(getIt<GithubService>()));
  getIt.registerFactory<FindUserById>(() => FindUserByIdImpl(getIt<GithubService>()));

  //favorites
  getIt.registerFactory<FindAllFavorites>(() => FindAllFavoritesImpl(getIt<FavoritesRepository>()));
  getIt.registerFactory<SaveFavorite>(() => SaveFavoriteImpl(getIt<FavoritesRepository>()));
  getIt.registerFactory<DeleteFavorite>(() => DeleteFavoriteImpl(getIt<FavoritesRepository>()));
}

void setupControllers() {
  getIt.registerFactory<GithubStore>(() => GithubStore(
        getIt<FindAllUsers>(),
        getIt<FindUserById>(),
      ));

  getIt.registerFactory<FavoritesStore>(() => FavoritesStore(
        getIt<FindAllFavorites>(),
        getIt<DeleteFavorite>(),
        getIt<SaveFavorite>(),
      ));
}
