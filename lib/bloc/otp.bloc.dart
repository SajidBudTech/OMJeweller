
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/data/models/dialog_data.dart';
import 'package:flutter_om_jeweller/utils/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/data/repositories/auth.repository.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_om_jeweller/constants/validation_messages.dart';


class OTPBloc extends BaseBloc with CodeAutoFill{
    //Auth repository
    AuthRepository _authRepository = new AuthRepository();

    String appSignature;
    String otpCode;
    //text editing controller
    TextEditingController firstDigitTEC = new TextEditingController();
    TextEditingController secondDigitTEC = new TextEditingController();
    TextEditingController threeDigitTEC = new TextEditingController();
    TextEditingController fourthDigitTEC = new TextEditingController();

    //view entered data
    BehaviorSubject<bool> _firstValid = BehaviorSubject<bool>.seeded(false);
    BehaviorSubject<bool> _secondValid = BehaviorSubject<bool>.seeded(false);
    BehaviorSubject<bool> _threeValid = BehaviorSubject<bool>.seeded(false);
    BehaviorSubject<bool> _fourthValid = BehaviorSubject<bool>.seeded(false);

    //entered data variables getter
    Stream<bool> get validFirst => _firstValid.stream;

    Stream<bool> get validSecond => _secondValid.stream;

    Stream<bool> get validThree => _threeValid.stream;

    Stream<bool> get validFourth => _fourthValid.stream;


    @override
    void initBloc() {
      super.initBloc();
      // initApp()
      SmsAutoFill().listenForCode;
     /* SmsAutoFill().getAppSignature.then((signature) {
        appSignature=signature;
      });*/
    }

    @override
    void dispose() {
      SmsAutoFill().unregisterListener();
      super.dispose();
    }


    //process login when user tap on the login button
    void processLogin({String mobile,String serverOTP}) async {

    //check if the user entered email & password are valid
      //update ui state
      setUiState(UiState.loading);

      if(firstDigitTEC.text+secondDigitTEC.text+threeDigitTEC.text+fourthDigitTEC.text==serverOTP) {
        final resultDialogData = await _authRepository.login(
          mobile: mobile,
          password: serverOTP,
        );

        //update ui state after operation
        setUiState(UiState.done);

        //checking if operation was successful before either showing an error or redirect to home page
        if (resultDialogData.dialogType == DialogType.success) {
          setUiState(UiState.redirect);
        } else {
          //prepare the data model to be used to show the alert on the view
          dialogData.title = resultDialogData.title;
          dialogData.body = resultDialogData.body;
          dialogData.backgroundColor = AppColor.failedColor;
          dialogData.iconData = FlutterIcons.error_mdi;
          //notify listners to show show alert
          setShowAlert(true);
        }

      }else{
        setUiState(UiState.done);
        dialogData.title = "OTP Verification Failed!";
        dialogData.body = "OTP Does Not Match!";
        dialogData.backgroundColor = AppColor.failedColor;
        dialogData.iconData = FlutterIcons.error_mdi;
        //notify listners to show show alert
        setShowAlert(true);
      }

  }

    //as user enters email address, we are doing email validation
    bool validateFirstDigit(String value) {
      if (!Validators.validateDigit(value)) {
        _firstValid.addError(ValidationMessages.invalidDigit);
        return false;
      } else {
        _firstValid.add(true);
        return true;
      }
    }

    bool validateSecondDigit(String value) {
      if (!Validators.validateDigit(value)) {
        _secondValid.addError(ValidationMessages.invalidDigit);
        return false;
      } else {
        _secondValid.add(true);
        return true;
      }
    }

    bool validateThirdDigit(String value) {
      if (!Validators.validateDigit(value)) {
        _threeValid.addError(ValidationMessages.invalidDigit);
        return false;
      } else {
        _threeValid.add(true);
        return true;
      }
    }

    bool validateFouthDigit(String value) {
      if (!Validators.validateDigit(value)) {
        _fourthValid.addError(ValidationMessages.invalidDigit);
        return false;
      } else {
        _fourthValid.add(true);
        return true;
      }
    }



  @override
  void codeUpdated() {
      otpCode = code;
      firstDigitTEC.text=otpCode[0];
      secondDigitTEC.text=otpCode[1];
      threeDigitTEC.text=otpCode[2];
      fourthDigitTEC.text=otpCode[3];
   }


    void processRegister({String name,String email,String mobile,String serverOTP}) async {

      //check if the user entered email & password are valid
      //update ui state
      setUiState(UiState.loading);

      if(firstDigitTEC.text+secondDigitTEC.text+threeDigitTEC.text+fourthDigitTEC.text==serverOTP) {
        final resultDialogData = await _authRepository.register(
          mobile: mobile,
          email: email,
          name: name,
          otp: serverOTP
        );

        //update ui state after operation
        setUiState(UiState.done);

        //checking if operation was successful before either showing an error or redirect to home page
        if (resultDialogData.dialogType == DialogType.success) {
          setUiState(UiState.redirect);
        } else {
          //prepare the data model to be used to show the alert on the view
          dialogData.title = resultDialogData.title;
          dialogData.body = resultDialogData.body;
          dialogData.backgroundColor = AppColor.failedColor;
          dialogData.iconData = FlutterIcons.error_mdi;
          //notify listners to show show alert
          setShowAlert(true);
        }

      }else{
        setUiState(UiState.done);
        dialogData.title = "OTP Verification Failed!";
        dialogData.body = "OTP Does Not Match!";
        dialogData.backgroundColor = AppColor.failedColor;
        dialogData.iconData = FlutterIcons.error_mdi;
        //notify listners to show show alert
        setShowAlert(true);
      }

    }

  }





