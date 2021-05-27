import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/data/repositories/auth.repository.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/constants/validation_messages.dart';
import 'package:flutter_om_jeweller/utils/validators.dart';

class EditProfileBloc extends BaseBloc {
  //auth repository
  AuthRepository _authRepository = AuthRepository();

  //text editing controller
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController emailAddressTEC = new TextEditingController();
  TextEditingController mobileTEC = new TextEditingController();


  BehaviorSubject<bool> _nameValid = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> _emailValid = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> _mobileValid = BehaviorSubject<bool>.seeded(true);


  Stream<bool> get validName => _nameValid.stream;
  Stream<bool> get validEmailAddress => _emailValid.stream;
  Stream<bool> get validmobile => _mobileValid.stream;

  @override
  void initBloc() async {
    super.initBloc();

    nameTEC.text = AuthBloc.getUserName();
    emailAddressTEC.text = AuthBloc.getUserEmail();
    mobileTEC.text = AuthBloc.getUserMobile();

  }


  //as user enters name, we are doing name validation, error if its empty of less than 3 words
  bool validateName(String value) {
    if (value.isEmpty || value.length < 3) {
      _nameValid.addError(ValidationMessages.invalidName);
      return false;
    } else {
      _nameValid.add(true);
      return true;
    }
  }



  //as user enters email, we are doing email validation
  bool validateEmailAddress(String value) {
    if (!Validators.isEmailValid(value)) {
      _emailValid.addError(ValidationMessages.invalidEmail);
      return false;
    } else {
      _emailValid.add(true);
      return true;
    }
  }

  //as user enters email, we are doing email validation
  bool validateMobile(String value) {
    if (!Validators.isPhoneNumberValid(value)) {
      _mobileValid.addError(ValidationMessages.invalidPhoneNumber);
      return false;
    } else {
      _mobileValid.add(true);
      return true;
    }
  }

  //process login when user tap on the login button
  void processAccountUpdate({String dob,String anniver,String gender}) async {
    //get the entered value from the text editing controller
    final name = nameTEC.text;
    final email = emailAddressTEC.text;
    final phone = mobileTEC.text;


    //check if the user entered name & email are valid
    if (validateName(name) &&
        validateEmailAddress(email) &&
        validateMobile(phone)) {
      //update ui state
      setUiState(UiState.loading);

      final userId= await AuthBloc.getUserID();
      //make the request to the server
     // final profilePhotoValue = _profilePhoto.value;
      //final medicalReportValue = _medicalReport.value;
      final resultDialogData = await _authRepository.updateProfile(
        userId: userId,
        name: name,
        email: email,
        mobile: phone,
        gender: gender,
        dob: dob,
        anniversary: anniver
      );
      //update ui state after operation
      setUiState(UiState.done);

      //prepare the data model to be used to show the alert on the view
      dialogData = resultDialogData;
      dialogData.isDismissible = true;
      //notify listners tto show show alert
      setShowDialogAlert(true);

    }
  }

}
