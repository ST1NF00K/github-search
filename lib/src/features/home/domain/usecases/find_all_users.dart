import 'package:github_search/src/features/home/domain/service/github_service.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

abstract class FindAllUsers {
  Future<List<User>> execute(String searchQuery, {int page = 1, int perPage = 30});
}

class FindAllUsersImpl implements FindAllUsers {
  final GithubService _githubService;

  FindAllUsersImpl(this._githubService);

  @override
  Future<List<User>> execute(String searchQuery, {int page = 1, int perPage = 30}) async {
    return await _githubService.findAll(searchQuery);
  }
}
