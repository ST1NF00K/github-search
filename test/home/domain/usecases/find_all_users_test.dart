import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/features/home/data/models/user_model.dart';
import 'package:github_search/src/features/home/domain/usecases/find_all_users.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/shared_mocks.dart';
import '../../mocks/mock_github_service.dart';

void main() {
  late final FindAllUsers usecase;
  late final MockGithubService mockGithubService;

  setUp(() {
    mockGithubService = MockGithubService();
    usecase = FindAllUsersImpl(mockGithubService);
  });

  test(
    'should get users in the github service',
    () async {
      final data = jsonDecode(mockUserList)["data"] as List;
      final response = data.map((e) => UserModel.fromJson(e)).toList();
      when(mockGithubService.findAll("Lily")).thenAnswer((_) async => response);

      final result = await usecase.execute("Lily");

      expect(result, response);
    },
  );
}
