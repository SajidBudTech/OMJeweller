import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/utils/validators.dart';
import 'package:flutter_om_jeweller/constants/validation_messages.dart';
import 'package:flutter_om_jeweller/data/repositories/appointment.repository.dart';
import 'package:flutter_om_jeweller/data/models/dialog_data.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/data/models/appointment.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';


class FillDetailsBloc extends BaseBloc {
  //text editing controller
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController emailAddressTEC = new TextEditingController();
  TextEditingController mobileTEC = new TextEditingController();
  TextEditingController productTEC = new TextEditingController();


  BehaviorSubject<bool> _nameValid = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> _emailValid = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> _mobileValid = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> _productValid = BehaviorSubject<bool>.seeded(true);


  Stream<bool> get validName => _nameValid.stream;
  Stream<bool> get validEmailAddress => _emailValid.stream;
  Stream<bool> get validmobile => _mobileValid.stream;
  Stream<bool> get validproduct => _productValid.stream;



  AppointmentRepository _appointmentRepository=AppointmentRepository();
  @override
  void initBloc() {
    super.initBloc();
    nameTEC.text=AuthBloc.getUserName();
    emailAddressTEC.text=AuthBloc.getUserEmail();
    mobileTEC.text=AuthBloc.getUserMobile();
    productTEC.text=AppStrings.selectedProduct??"";
  }



  void processAppointmnetBooking({BuildContext context}) async {

    final name = nameTEC.text;
    final mobile =mobileTEC.text;
    final email =emailAddressTEC.text;
    final product =productTEC.text;

    //check if the user entered email & password are valid

    if (validateName(name) && validateMobile(mobile) &&validateEmailAddress(email)){
      //update ui state
       final int userId=AuthBloc.getUserID();
      setUiState(UiState.loading);


      Appointment appointment=Appointment();
      appointment.appointmentType=AppStrings.selectedTypeofvisit;
      appointment.appointmentDetail=AppStrings.selectedTypeDetails;
      appointment.appointmentDate=AppStrings.selectedBookDate;
      appointment.appointmentTime=AppStrings.selectedBookTime;
      appointment.name=name;
      appointment.mobileNo=mobile;
      appointment.email=email;
      appointment.product=product;


      final resultDialogData = await _appointmentRepository.bookAppointmnet(
        appointment:appointment,
        userId: userId
      );

      //update ui state after operation
      setUiState(UiState.done);

      //checking if operation was successful before either showing an error or redirect to home page
      if (resultDialogData.dialogType == DialogType.success) {
        // setUiState(UiState.redirect);

        goToConfirmBookingPage(context,appointment);
        //setUiState(UiState.redirect);
      } else {
        //prepare the data model to be used to show the alert on the view
        dialogData.title = resultDialogData.title;
        dialogData.body = resultDialogData.body;
        dialogData.backgroundColor = AppColor.failedColor;
        dialogData.iconData = FlutterIcons.error_mdi;
        //notify listners to show show alert
        setShowAlert(true);
      }
    }
  }


  bool validateName(String value) {
    if (value.isEmpty || value.length < 3) {
      _nameValid.addError(ValidationMessages.invalidName);
      return false;
    } else {
      _nameValid.add(true);
      return true;
    }
  }

  bool validateProduct(String value) {
    if (value.isEmpty || value.length < 3) {
      _productValid.addError(ValidationMessages.invalidProduct);
      return false;
    } else {
      _productValid.add(true);
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

  void goToConfirmBookingPage(BuildContext context,Appointment appointment) {
    Navigator.pushNamed(
      context,
      AppRoutes.confirmedBokkingRoute,
      arguments: appointment
    );
  }



}
