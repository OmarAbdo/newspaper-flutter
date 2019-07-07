import 'package:flutter/material.dart';
import 'package:flutter_newspaper/src/theme.dart';
import 'package:flutter_newspaper/src/routes.dart';
import 'package:flutter_newspaper/src/ui/registration/register.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: newspaperTheme,
      home: Scaffold(
        body: Register(),
      ),
      initialRoute: '/',
      routes: allRoutes,
    );
  }
}
