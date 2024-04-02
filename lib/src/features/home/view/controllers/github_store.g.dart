// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GithubStore on _GithubStore, Store {
  late final _$findAllRequestAtom =
      Atom(name: '_GithubStore.findAllRequest', context: context);

  @override
  ObservableFuture<List<User>> get findAllRequest {
    _$findAllRequestAtom.reportRead();
    return super.findAllRequest;
  }

  @override
  set findAllRequest(ObservableFuture<List<User>> value) {
    _$findAllRequestAtom.reportWrite(value, super.findAllRequest, () {
      super.findAllRequest = value;
    });
  }

  late final _$findByIdRequestAtom =
      Atom(name: '_GithubStore.findByIdRequest', context: context);

  @override
  ObservableFuture<User> get findByIdRequest {
    _$findByIdRequestAtom.reportRead();
    return super.findByIdRequest;
  }

  @override
  set findByIdRequest(ObservableFuture<User> value) {
    _$findByIdRequestAtom.reportWrite(value, super.findByIdRequest, () {
      super.findByIdRequest = value;
    });
  }

  late final _$usersListAtom =
      Atom(name: '_GithubStore.usersList', context: context);

  @override
  ObservableList<User> get usersList {
    _$usersListAtom.reportRead();
    return super.usersList;
  }

  @override
  set usersList(ObservableList<User> value) {
    _$usersListAtom.reportWrite(value, super.usersList, () {
      super.usersList = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_GithubStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$findAllAsyncAction =
      AsyncAction('_GithubStore.findAll', context: context);

  @override
  Future<void> findAll(String searchQuery, {required int page}) {
    return _$findAllAsyncAction
        .run(() => super.findAll(searchQuery, page: page));
  }

  late final _$_GithubStoreActionController =
      ActionController(name: '_GithubStore', context: context);

  @override
  void findById(int id) {
    final _$actionInfo = _$_GithubStoreActionController.startAction(
        name: '_GithubStore.findById');
    try {
      return super.findById(id);
    } finally {
      _$_GithubStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearResults() {
    final _$actionInfo = _$_GithubStoreActionController.startAction(
        name: '_GithubStore.clearResults');
    try {
      return super.clearResults();
    } finally {
      _$_GithubStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
findAllRequest: ${findAllRequest},
findByIdRequest: ${findByIdRequest},
usersList: ${usersList},
isLoading: ${isLoading}
    ''';
  }
}
