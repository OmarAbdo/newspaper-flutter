import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/user.dart';

class UserApi {
  Client client = Client();

  Future<UserModel> fetchUser() async {
    //final response = await client.get("http://localhost:5000/api/v1/authentication/getdummyuser", headers: { 'Content-Type': 'application/json', });
    final response = await client.get("http://10.0.2.2:5000/api/v1/authentication/getdummyuser", headers: { 'Content-Type': 'application/json', });
    if (response.statusCode == 200) {
      // If the call to the server was successful, try to parse the JSON
      return UserModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to find user');
    }
  }

  Future<String> registerUser(dynamic user) async {
    final response = await client.post(
        "http://localhost:5000/api/v1/authentication/signup",
        headers: { 'Content-Type': 'application/json', },
        body: user);
    if (response.statusCode == 200) {
      return 'User Created Successfully';
    } else {
      throw Exception('Faild to create user');
    }
  }
}
