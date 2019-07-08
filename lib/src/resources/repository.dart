import 'dart:async';
import 'user_api.dart';
import '../models/user.dart';

class Repository {
  final userApi = UserApi();

  Future<UserModel> fetchUser() => userApi.fetchUser();

  Future<Map<String, dynamic>> registerUser(dynamic user) => userApi.registerUser(user);

  Future<Map<String, dynamic>> logInUser(dynamic user) => userApi.logInUser(user);
}