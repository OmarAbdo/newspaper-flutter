import 'package:flutter/material.dart';
import 'package:flutter_newspaper/src/ui/registration/register.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Login Screen'),
            RaisedButton(
              onPressed: () {
               Navigator.pushNamed(context, '/');
              },
              child: Text('Create a new account'),
            )
          ],
        ),
      ),
    );
  }
}
