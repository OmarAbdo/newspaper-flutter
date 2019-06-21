import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../bloc/user_bloc.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xffDA44bb),
      Color(0xff8921aa),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(25.0),
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome to ',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      foreground: Paint()..shader = linearGradient,
                    ),
                  ),
                  Text(
                    'Newspaper',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter some text';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
            RaisedButton(
               onPressed: userBloc.fetchUser,
              child: Text('get user'),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/loginbg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}