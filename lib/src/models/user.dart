class UserModel {
  String _userName;
  String _userEmail;
  String _userPassword;
  String _userCountry;
  dynamic _userBirthday;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _userName = parsedJson['name'];
    _userEmail = parsedJson['email'];
    _userPassword = parsedJson['password'];
    _userCountry = parsedJson['country'];
    _userBirthday = parsedJson['birthday'];
  }

  String get userName       => _userName;
  String get userEmail      => _userEmail;
  String get userPassword   => _userPassword;
  String get userCountry    => _userCountry;
  dynamic get userBirthday  => _userBirthday;
}
