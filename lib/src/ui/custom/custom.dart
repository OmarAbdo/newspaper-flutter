import 'package:flutter/material.dart';
import 'package:flutter_newspaper/src/bloc/user_bloc.dart';

class GradientText extends StatelessWidget {
  final String txt;
  final double fontSize;

  GradientText({this.txt, this.fontSize});
  @override
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xffDA44bb),
      Color(0xff8921aa),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        foreground: Paint()..shader = linearGradient,
      ),
    );
  }
}

class ColorText extends StatelessWidget {
  final txt;
  final fontSize;
  final color;

  ColorText({this.txt, this.fontSize, this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: color,
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: userBloc.userEmailAddress,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          onChanged: userBloc.changeUserEmailAddress,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Please Enter your Email address',
            labelText: 'Email Address',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: userBloc.userPasswordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          obscureText: true,
          onChanged: userBloc.changeUserPassword,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Please Enter your password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }
}
