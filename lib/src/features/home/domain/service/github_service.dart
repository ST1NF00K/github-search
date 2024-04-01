import 'package:github_search/src/features/home/domain/entity/user.dart';

abstract class GithubService {
  Future<List<User>> findAll(String searchQuery, {int page = 1, int perPage = 30});
  Future<User>? findById(int id);
}
