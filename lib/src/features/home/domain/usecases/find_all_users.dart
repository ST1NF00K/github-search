import 'package:github_search/src/features/home/domain/service/github_service.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

class FindAllUsers {
  final GithubService _githubService;

  FindAllUsers(this._githubService);

  Future<List<User>>? execute(String searchQuery) async {
    return await _githubService.findAll(searchQuery)!;
  }
}
