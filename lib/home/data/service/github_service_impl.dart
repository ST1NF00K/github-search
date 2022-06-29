import 'package:dio/dio.dart';
import 'package:github_search/home/data/models/user_model.dart';
import 'package:github_search/home/domain/service/github_service.dart';
import 'package:github_search/home/domain/entity/user.dart';

class GithubServiceImpl implements GithubService {
  final String _baseUrl = 'https://api.github.com';
  final Dio _dio;

  GithubServiceImpl(this._dio);

  @override
  Future<List<User>> findAll(String searchQuery) async {
    try {
      final response = await _dio.get('$_baseUrl/search/users',
          queryParameters: {
            'q': searchQuery,
          },
          options: Options(headers: {'User-Agent': 'request'}));

      return List<UserModel>.from(
          response.data["items"].map((x) => UserModel.fromJson(x))).toList();
    } on DioError catch (_) {
      throw DioError(
        requestOptions: RequestOptions(path: '$_baseUrl/search/users'),
      );
    } catch (e) {
      throw Exception("Error occured getting all the users.");
    }
  }

  @override
  Future<User> findById(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/user/$id');
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception("Error occured getting user by id.");
    }
  }
}
