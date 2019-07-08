import 'package:flutter/material.dart';
import 'package:flutter_newspaper/src/ui/custom/custom.dart';
import 'package:flutter_newspaper/src/bloc/user_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              EmailTextField(),
              PasswordTextField(),
              SizedBox(
                height: 25,
              ),
              RaisedButton(
               onPressed: userBloc.submitLogIn,
                child: Text('Sign in'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Create a new account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
