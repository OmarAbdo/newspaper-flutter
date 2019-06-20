import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Text('Registration'),
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