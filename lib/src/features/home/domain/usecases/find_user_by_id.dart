import 'package:github_search/src/features/home/domain/service/github_service.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';

abstract class FindUserById {
  Future<User>? execute(int id);
}

class FindUserByIdImpl implements FindUserById {
  final GithubService _githubService;

  FindUserByIdImpl(this._githubService);

  @override
  Future<User>? execute(int id) async {
    return await _githubService.findById(id)!;
  }
}
