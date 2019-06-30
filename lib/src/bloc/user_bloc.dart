import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/user.dart';
import '../util/formvalidator.dart';

/// To Do list
/// 1. validate data using mixins and stream transforms ...on it
/// 2. post everything safe and sound to the backend
/// 3. BONUS check R code and do some recatoring in here if needed

class UserBloc extends Object with FormValidation {
  final _repository = Repository();

  final _userFullName       = BehaviorSubject<String>(); // Stream controller
  final _userEmailAddress   = BehaviorSubject<String>();
  final _userPassword       = BehaviorSubject<String>();
  final _userRepeatPassword = BehaviorSubject<String>();
  final _userCountry        = BehaviorSubject<String>();
  final _userBirthDay       = BehaviorSubject<DateTime>();

  Observable<String> get userFullNameStream       => _userFullName.stream; // Stream
  Observable<String> get userEmailAddress         => _userEmailAddress.stream.transform(validateEmail);
  Observable<String> get userPasswordStream       => _userPassword.stream.transform(validatePassword);
  Observable<String> get userRepeatPasswordStream => _userRepeatPassword.stream.transform(validatePassword).doOnData((String c){      
      if (0 != _userPassword.value.compareTo(c)){        
        _userRepeatPassword.addError("Password Does not Match"); // throwing an error if both passwords do not match
      }
    });
  Observable<String> get userCountryStream        => _userCountry.stream;
  Observable<DateTime> get userBirthDay           => _userBirthDay.stream;

  Function get changeUserFullName       => _userFullName.sink.add; // Sink
  Function get changeUserEmailAddress   => _userEmailAddress.sink.add;
  Function get changeUserPassword       => _userPassword.sink.add;
  Function get changeUserRepeatPassword => _userRepeatPassword.sink.add;

  changeUserCountry(String country) {
    _userCountry.sink.add(country);
  }

  changeUserBirthday(DateTime birthday) {
    _userBirthDay.sink.add(birthday);
  }

  submit() {
    print(_userFullName.value);
    print(_userEmailAddress.value);
    print(_userPassword.value);
    print(_userRepeatPassword.value);
    print(_userCountry.value);
    print(_userBirthDay.value);
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

final userBloc = UserBloc();
