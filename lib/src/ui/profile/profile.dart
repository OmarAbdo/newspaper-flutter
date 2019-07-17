import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:math';

class Profile extends StatelessWidget {
  // Create storage
  final storage = new FlutterSecureStorage();
  Future<String> readToken() async {
    var token = await storage.read(key: 'token');
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(25.0),
            children: <Widget>[
              Center(
                child: Text('Logged in!'),
              ),
               Center(
                child: Text('Here\'s your data'),
              ),
               Center(
                child: Text('name:'),
              ),
               Center(
                child: Text('email:'),
              ),
               Center(
                child: Text('country:'),
              ),
               Center(
                child: Text('birthday:'),
              ),
              RaisedButton(
                child: Text('Logout'),
                onPressed: () {
                  //remove token from storage
                  //push replacement profile and go to login
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
