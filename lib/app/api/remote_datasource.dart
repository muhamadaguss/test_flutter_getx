import 'package:test_project/app/api/api_client.dart';
import 'package:test_project/app/api/api_response.dart';
import 'package:test_project/app/api/service_url.dart';
import 'package:test_project/app/data/models/login_model.dart';
import 'package:test_project/app/data/models/register_model.dart';
import 'package:test_project/app/data/models/update_user_model.dart';

import '../data/models/user_model.dart';

class RemoteDataSource {
  final ApiClient apiClient = ApiClient();

  //POST
  Future<ApiResponse<Login>> login(String email, String? password) async {
    final response = await apiClient.post(ServiceUrl.login, data: {
      "email": email,
      "password": password,
    });
    return ApiResponse.fromJson(response, Login.fromJson);
  }

  Future<ApiResponse<Register>> register(String email, String? password) async {
    final response = await apiClient.post(ServiceUrl.signup, data: {
      "email": email,
      "password": password,
    });
    return ApiResponse.fromJson(response, Register.fromJson);
  }

  Future<ApiResponse<User>> createUser(User user) async {
    final response =
        await apiClient.post(ServiceUrl.users, data: user.toJson());
    return ApiResponse.fromJson(response, User.fromJson);
  }

  //GET
  Future<ApiResponse<User>> getUsers(int? page) async {
    final response = await apiClient.get('${ServiceUrl.users}?page=$page');
    return ApiResponse.fromJson(response, User.fromJson);
  }

  Future<ApiResponse<User>> getUser(int id) async {
    final response = await apiClient.get('${ServiceUrl.users}/$id');
    return ApiResponse.fromJson(response, User.fromJson);
  }

  //UPDATE
  Future<ApiResponse<UpdateUser>> updateUser(int id, UpdateUser data) async {
    final response =
        await apiClient.put('${ServiceUrl.users}/$id', data: data.toJson());
    return ApiResponse.fromJson(response, UpdateUser.fromJson);
  }

  //DELETE
  Future<ApiResponse> deleteUser(int id) async {
    final response = await apiClient.delete('${ServiceUrl.users}/$id');
    return ApiResponse.fromJson(response, null);
  }
}
