import 'package:flutter/material.dart';
import 'package:flutter_newspaper/src/ui/custom/custom.dart';
import 'package:flutter_newspaper/src/bloc/user_bloc_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = UserBlocProvider.of(context);
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(25.0),
            children: <Widget>[
              GradientText(txt: 'Welcome To', fontSize: 48.0),
              ColorText(txt: 'Newspaper', fontSize: 64.0),
              EmailTextField(userBloc),
              PasswordTextField(userBloc),
              SizedBox(
                height: 25,
              ),
              RaisedButton(
                onPressed: () {
                  userBloc.submitLogIn(context);
                },
                child: Text('Sign in'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Create a new account'),
              ),
              RaisedButton(
                onPressed: () {
                  readToken().then((onValue) => print(onValue));
                },
                child: Text('Read token'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create storage
  final storage = new FlutterSecureStorage();
  Future<String> readToken() async {
    return await storage.read(key: 'token');
  }
  // storeSomething() async {
  //   return await storage.write(key: 'something', value: 'something for test');
  // }
  //  Future<String>  readSomeThing() async {
  //   return await storage.read(key: 'something');
  // }
}
