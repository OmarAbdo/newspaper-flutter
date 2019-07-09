import 'package:flutter_newspaper/src/ui/registration/register.dart';
import 'package:flutter_newspaper/src/ui/registration/login.dart';
import 'package:flutter_newspaper/src/bloc/user_bloc_provider.dart';

dynamic allRoutes = {
  '/login': (context) => UserBlocProvider(
        child: Login(),
      ),
};
