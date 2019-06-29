import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../bloc/user_bloc.dart';
import '../custom/custom.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(25.0),
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                 GradientText(txt:'Welcome To', fontSize:48),
                 ColorText(txt:'Newspaper', fontSize:64),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () { },
              child: Text('Register New User'),
            ),
            RaisedButton(
              onPressed: userBloc.fetchDummyUser,
              child: Text('Fetch Dummy User'),
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
