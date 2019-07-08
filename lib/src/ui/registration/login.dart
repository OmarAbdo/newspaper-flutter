import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(25.0),
            children: <Widget>[
              Center(
                child:  Text('Login Screen'),
              ),
              RaisedButton(
                onPressed: () {},
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
