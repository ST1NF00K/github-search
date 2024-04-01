import 'package:github_search/src/features/home/domain/entity/user.dart';
import 'package:github_search/src/features/home/domain/usecases/find_all_users.dart';
import 'package:github_search/src/features/home/domain/usecases/find_user_by_id.dart';
import 'package:mobx/mobx.dart';

part 'github_store.g.dart';

class GithubStore = _GithubStore with _$GithubStore;

abstract class _GithubStore with Store {
  final FindAllUsers _findAllUsers;
  final FindUserById _findUserById;
  _GithubStore(this._findAllUsers, this._findUserById);

  @observable
  ObservableFuture<List<User>> findAllRequest = ObservableFuture.value([]);

  @observable
  ObservableFuture<User> findByIdRequest = ObservableFuture.value(User(
    id: 0,
    login: '',
    avatarUrl: '',
    email: '',
    bio: '',
    location: '',
  ));

  @action
  void findAll(String searchQuery) {
    findAllRequest = _findAllUsers.execute(searchQuery)!.asObservable();
  }

  @action
  void findById(int id) {
    findByIdRequest = _findUserById.execute(id)!.asObservable();
  }

  @action
  void clearResults() {
    findAllRequest = ObservableFuture.value([]);
  }
}
