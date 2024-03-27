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

  late final _$_GithubStoreActionController =
      ActionController(name: '_GithubStore', context: context);

  @override
  void findAll(String searchQuery) {
    final _$actionInfo = _$_GithubStoreActionController.startAction(
        name: '_GithubStore.findAll');
    try {
      return super.findAll(searchQuery);
    } finally {
      _$_GithubStoreActionController.endAction(_$actionInfo);
    }
  }

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
  String toString() {
    return '''
findAllRequest: ${findAllRequest},
findByIdRequest: ${findByIdRequest}
    ''';
  }
}
