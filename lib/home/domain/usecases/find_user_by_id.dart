import 'package:github_search/home/domain/service/github_service.dart';
import 'package:github_search/home/domain/entity/user.dart';

class FindUserById {
  final GithubService _githubService;

  FindUserById(this._githubService);

  Future<User>? execute(int id) async {
      return await _githubService.findById(id)!;
  }
}
