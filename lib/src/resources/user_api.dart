import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/user.dart';

class UserApi {
  Client client = Client();

  Future<UserModel> fetchUser() async {
    final response = await client.get(
        "http://10.0.2.2:5000/api/v1/authentication/getdummyuser",
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      // If the call to the server was successful, try to parse the JSON
      return UserModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to find user');
    }
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> user) async {
    var jsonUser = json.encode(user);

    final response = await client.post(
      "http://10.0.2.2:5000/api/v1/authentication/signup",
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonUser,
    );
    var responseDate = json.decode(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> successReport = {
        'massage': responseDate['success'],
        'statusCode': response.statusCode,
        'token': responseDate['token'],
      };
      return successReport;
    } else {
      Map<String, dynamic> errorReport = {
        'massage': 'Falid to create user',
        'statusCode': response.statusCode,
        'body': response.body
      };
      return errorReport;
    }
  }

  Future<Map<String, dynamic>> logInUser(Map<String, dynamic> user) async {
    var jsonUser = json.encode(user);

    final response = await client.post(
      "http://10.0.2.2:5000/api/v1/authentication/login",
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonUser,
    );
    var responseDate = json.decode(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> successReport = {
        'massage': responseDate['success'],
        'statusCode': response.statusCode,
        'token': responseDate['token']
      };
      return successReport;
    } else {
      Map<String, dynamic> errorReport = {
        'massage': 'Email / password is wrong',
        'statusCode': response.statusCode,
        'body': response.body
      };
      return errorReport;
    }
  }
}
