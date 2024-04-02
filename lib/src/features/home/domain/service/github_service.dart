import 'package:github_search/src/features/home/domain/entity/user.dart';

abstract class GithubService {
  Future<List<User>> findAll(String searchQuery, {required int page, int perPage = 30});
  Future<User>? findById(int id);
}
