import 'package:github_search/features/home/domain/entity/user.dart';

abstract class FavoritesDatasource {
  Future<List<User>>? findAll();
  Future<void>? save(User user);
  Future<void>? delete(User user);
}
