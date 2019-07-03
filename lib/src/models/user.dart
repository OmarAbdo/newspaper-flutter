class UserModel {

  Map<String, dynamic> _user;
  dynamic _userAsJson;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _user = {
      "userName": parsedJson['name'],
      "userEmail": parsedJson['email'],
      "userPassword": parsedJson['password'],
      "userCountry": parsedJson['country'],
      "userBirthday": parsedJson['birthday'],      
    };
  }

  Map<String, dynamic> get user => _user;
}
