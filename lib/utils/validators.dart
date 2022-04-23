import 'dart:async';

import 'package:flutter/cupertino.dart';

class Validators {
  static bool isEmailValid(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  static bool isPhoneNumberValid(String phone) {
    if (phone.length == 10) {
      return true;
    } else {
      return false;
    }
  }

  static bool isPasswordValid(String password,
      {bool includeCaps = false, int minLength = 6}) {
    if (password.isEmpty ||
        password.length < minLength ||
        RegExp(r".*[A-Z].*").hasMatch(password) != includeCaps) {
      return false;
    } else {
      return true;
    }
  }

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 6 characters');
    }
  });

  final validatePasswordBool = StreamTransformer<String, bool>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(true);
    } else {
      sink.addError('Password must be at least 6 characters');
    }
  });

  static bool validateDigit (String digit)
     {
        if (digit.length ==1) {
          return true;
        } else {
          return false;
        }
      }
}
