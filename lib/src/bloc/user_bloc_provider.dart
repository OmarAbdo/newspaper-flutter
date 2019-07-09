import 'package:flutter/material.dart';
import 'package:flutter_newspaper/src/bloc/user_bloc.dart';

/// explain that class in comments for future refrence 
class UserBlocProvider extends InheritedWidget {
  final userBloc = UserBloc();

  UserBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static UserBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UserBlocProvider) as UserBlocProvider).userBloc;
  }
}
