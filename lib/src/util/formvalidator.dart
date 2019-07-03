import 'dart:async';
import 'dart:core';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
const String _kPasswordRule = r"^.*(?=.{8,})((?=.*[!@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$";

class FormValidation {

  final StreamTransformer<String, String> validateFullName = StreamTransformer<String, String>.fromHandlers(handleData: (fullName, sink) {
    if (fullName.length < 4) {
      sink.addError('Name minimum length is 4 characters');
    } else { 
      sink.add(fullName);
    }
  });

  final StreamTransformer<String, String> validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);

    if (!emailExp.hasMatch(email) || email.isEmpty) {
      sink.addError('Entre a valid email');
    } else {
      sink.add(email);
    }
  });

  final StreamTransformer<String, String> validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    final RegExp passwordExp = new RegExp(_kPasswordRule);

    if(!passwordExp.hasMatch(password)) {
      sink.addError('Password must be 8 characters at least containing a capital latter, a small letter, a number, and a special character');
    }
    else if (password.isEmpty) {
      sink.addError('Password can\'t be empty');
    } else {
      sink.add(password);
    }
  });

  final StreamTransformer<String, String> validateContrySelected = StreamTransformer<String, String>.fromHandlers(handleData: (country, sink) {
    if (!country.isEmpty) {
      sink.addError('Please select your country');
    } else { 
      sink.add(country);
    }
  });

  final StreamTransformer<DateTime, DateTime> validateBirthday = StreamTransformer<DateTime, DateTime>.fromHandlers(handleData: (birthday, sink) {
    if (birthday.toString().isEmpty) {
      sink.addError('Please select your birthday');
    } else { 
      sink.add(birthday);
    }
  });
  
}
