import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../util/formvalidator.dart';

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
      }
    });
  Observable<String> get userCountryStream        => _userCountry.stream.transform(validateContrySelected);
  Observable<DateTime> get userBirthDay           => _userBirthDay.stream.transform(validateBirthday);

  Function get changeUserFullName       => _userFullName.sink.add; // Sink
  Function get changeUserEmailAddress   => _userEmailAddress.sink.add;
  Function get changeUserPassword       => _userPassword.sink.add;
  Function get changeUserRepeatPassword => _userRepeatPassword.sink.add;
  Function get changeUserCountry       => _userCountry.sink.add;

  changeUserBirthday(DateTime birthday) {
    _userBirthDay.sink.add(birthday);
  }

  String fixBirthdayFormat(DateTime birthday) {
    var myDay   = birthday.day <= 9 ? "0" + birthday.day.toString() : birthday.day.toString();
    var myMonth = birthday.month <= 9 ? "0" + birthday.month.toString() : birthday.month.toString();
    var myYear  = birthday.year.toString();
    return myDay + '/' + myMonth + '/' + myYear;
  }

  submitSignUp() async {
    Map<String, dynamic> validatedUserMap = {
      'name'            : _userFullName.value,
      'email'           : _userEmailAddress.value,
      'password'        : _userPassword.value,
      'repeatPassword'  : _userRepeatPassword.value,
      'country'         : _userCountry.value,
      'birthday'        : fixBirthdayFormat(_userBirthDay.value), //find a more proper solution for this later  
    };    

    Map<String, dynamic> postResult = await _repository.registerUser(validatedUserMap); 
    print(postResult);
  }

  submitLogIn() async {
    Map<String, dynamic> validatedUserMap = {
      'email'           : _userEmailAddress.value,
      'password'        : _userPassword.value,
    };    

    Map<String, dynamic> postResult = await _repository.logInUser(validatedUserMap); 
    print(postResult);
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
