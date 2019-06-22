import 'dart:async';
import 'user_api.dart';
import '../models/user.dart';

class Repository {
  final userApi = UserApi();

  Future<UserModel> fetchUser() => userApi.fetchUser();

  Future<String> registerUser(dynamic user) => userApi.registerUser(user);
}