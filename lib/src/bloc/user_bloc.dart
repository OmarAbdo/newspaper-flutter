import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_newspaper/src/resources/repository.dart';
import 'package:flutter_newspaper/src/util/formvalidator.dart';

class UserBloc extends Object with FormValidation {
  final _repository = Repository();

  final _userFullName       = BehaviorSubject<String>(); // Stream controller
  final _userEmailAddress   = BehaviorSubject<String>();
  final _userPassword       = BehaviorSubject<String>();
  final _userRepeatPassword = BehaviorSubject<String>();
  final _userCountry        = BehaviorSubject<String>();
  final _userBirthDay       = BehaviorSubject<DateTime>();

  Observable<String> get userFullNameStream       => _userFullName.stream.transform(validateFullName); // Stream
  Observable<String> get userEmailAddress         => _userEmailAddress.stream.transform(validateEmail);
  Observable<String> get userPasswordStream       => _userPassword.stream.transform(validatePassword);
  Observable<String> get userRepeatPasswordStream => _userRepeatPassword.stream.transform(validatePassword).doOnData((String c){      
      if (0 != _userPassword.value.compareTo(c)){
        _userRepeatPassword.addError("Password Does not Match"); // throwing an error if both passwords do not match
      } else {
        return true;
      }
    });
  Observable<String>   get userCountryStream    => _userCountry.stream.transform(validateContrySelected);
  Observable<DateTime> get userBirthDay         => _userBirthDay.stream.transform(validateBirthday);
  Observable<bool>     get validatedSignUp      => Observable.combineLatest6(
                                                                  userFullNameStream, 
                                                                  userEmailAddress,
                                                                  userPasswordStream,
                                                                  userRepeatPasswordStream,
                                                                  userCountryStream,
                                                                   userBirthDay,
                                                                  (a, b, c, d, e ,f) => true);

  Observable<bool> get validatedSignIn          => Observable.combineLatest2(userEmailAddress, userPasswordStream, (a, b) => true);

  Function get changeUserFullName       => _userFullName.sink.add; // Sink
  Function get changeUserEmailAddress   => _userEmailAddress.sink.add;
  Function get changeUserPassword       => _userPassword.sink.add;
  Function get changeUserRepeatPassword => _userRepeatPassword.sink.add;
  Function get changeUserCountry       => _userCountry.sink.add;

  changeUserBirthday(DateTime birthday) {
    _userBirthDay.sink.add(birthday);
  }

  String fixBirthdayFormat(DateTime birthday) {
    print('this is ' + birthday.toString()); //debugging
    var myDay   = birthday.day <= 9 ? "0" + birthday.day.toString() : birthday.day.toString();
    var myMonth = birthday.month <= 9 ? "0" + birthday.month.toString() : birthday.month.toString();
    var myYear  = birthday.year.toString();
    return myDay + '/' + myMonth + '/' + myYear;
  }


  submitSignUp(BuildContext context) async {
    Map<String, dynamic> validatedUserMap = {
      'name'            : _userFullName.value,
      'email'           : _userEmailAddress.value,
      'password'        : _userPassword.value,
      'repeatPassword'  : _userRepeatPassword.value,
      'country'         : _userCountry.value,
      'birthday'        : fixBirthdayFormat(_userBirthDay.value), //find a more proper solution for this later  
      //'birthday'        : '01/11/1997', //find a more proper solution for this later  
    };    

    Map<String, dynamic> postResult = await _repository.registerUser(validatedUserMap); 
    print(postResult);

    //only if status code is 200
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: postResult['token']);

    Navigator.pushReplacementNamed(context, '/profile');

    //debug
    // print({
    //   'name'            : _userFullName.value,
    //   'email'           : _userEmailAddress.value,
    //   'password'        : _userPassword.value,
    //   'repeatPassword'  : _userRepeatPassword.value,
    //   'country'         : _userCountry.value,
    //   'birthday'        : fixBirthdayFormat(_userBirthDay.value), //find a more proper solution for this later  
    // });
  }

   submitLogIn(BuildContext context) async {
    Map<String, dynamic> validatedUserMap = {
      'email'           : _userEmailAddress.value,
      'password'        : _userPassword.value,
    };    

    Map<String, dynamic> postResult = await _repository.logInUser(validatedUserMap); 
    
    print(postResult);

   //only if status code is 200
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: postResult['token']);

    Navigator.pushReplacementNamed(context, '/profile');
    //Debug
    //  print({
    //   'email'           : _userEmailAddress.value,
    //   'password'        : _userPassword.value,
    // });
  }

  loginCheck() {
    /// check if login token exists and is valid
    /// if so, go to profile 
    /// if not go to login page
    /// what if token is no longer valid and we move from a protected screen to another?
  }

  /// just making dart happy
  dispose() {
    _userFullName.close();
    _userEmailAddress.close();
    _userPassword.close();
    _userRepeatPassword.close();
    _userCountry.close();
    _userBirthDay.close();
  }
}

