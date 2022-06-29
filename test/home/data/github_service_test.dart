import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:github_search/home/data/models/user_model.dart';
import 'package:github_search/home/data/service/github_service_impl.dart';
import 'package:github_search/home/domain/entity/user.dart';
import 'package:github_search/home/domain/service/github_service.dart';
import '../../shared/shared_mocks.dart';

void main() {
  late final Dio dio;
  late final DioAdapter dioAdapter;
  late final GithubService service;
  const path = 'https://api.github.com/search/users';

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
    service = GithubServiceImpl(dio);
  });

  tearDown(() {
    dio.close();
  });

  group('github - user service tests', () {
    test(
      'should get users if status is 200',
      () async {
        dioAdapter.onGet(
          path,
          (server) => server.reply(
            200,
            mockUserList,
            delay: const Duration(seconds: 1),
          ),
        );

        final response = await dio.get(path);

        final data = json.decode(response.data)["data"] as List;
        final List<User> list = data.map((e) => UserModel.fromJson(e)).toList();

        expect(list.first.email, contains('livia'));
      },
    );

    test(
      'should throw error if status is different from 200',
      () async {
        dioAdapter.onGet(
          path,
          (server) => server.throws(
            500,
            DioError(requestOptions: RequestOptions(path: path)),
            delay: const Duration(seconds: 1),
          ),
        );

        final response = service.findAll('lily');

        await expectLater(response, throwsA((e) => e is DioError));
      },
    );
  });
}
