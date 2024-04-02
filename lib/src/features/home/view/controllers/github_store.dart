import 'package:mobx/mobx.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';
import 'package:github_search/src/features/home/domain/usecases/find_all_users.dart';
import 'package:github_search/src/features/home/domain/usecases/find_user_by_id.dart';

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

  @observable
  ObservableList<User> usersList = ObservableList<User>();

  @observable
  bool isLoading = false;

  @action
  Future<void> findAll(String searchQuery, {required int page}) async {
    isLoading = true;
    try {
      final List<User> newUsers = await _findAllUsers.execute(searchQuery, page: page);
      if (page == 1) {
        usersList.clear();
      }
      usersList.addAll(newUsers);
    } finally {
      isLoading = false;
    }
  }

  @action
  void findById(int id) {
    findByIdRequest = _findUserById.execute(id)!.asObservable();
  }

  @action
  void clearResults() {
    usersList.clear();
  }
}
