import 'package:flutter/material.dart';
import 'package:flutter_newspaper/src/theme.dart';
import 'package:flutter_newspaper/src/routes.dart';
import 'package:flutter_newspaper/src/ui/registration/register.dart';
import 'package:flutter_newspaper/src/ui/registration/login.dart';
import 'package:flutter_newspaper/src/bloc/user_bloc_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: newspaperTheme,
      home: UserBlocProvider(
        child: Register(),
      ),
      initialRoute: '/',
      routes: allRoutes,
    );
  }
}
