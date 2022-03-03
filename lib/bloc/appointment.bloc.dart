
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/data/repositories/appointment.repository.dart';
import 'package:flutter_om_jeweller/data/models/dialog_data.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/data/models/appointment.dart';
import 'package:rxdart/rxdart.dart';

class AppointmentBloc extends BaseBloc {
  //Auth repository
  AppointmentRepository _appointmentRepository = AppointmentRepository();
  String userName;

  TextEditingController shareFeedbackTEC = new TextEditingController();
  BehaviorSubject<bool> _feedBackValid = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get validFeedBack => _feedBackValid.stream;

  bool feedBackButtonStatus=false;

  List<String> storeaddresses=["Ground Floor, Shangrila Apartments, LT Road, Near Borivali Station, Borivali West, Mumbai, Maharashtra 400092",
                               "Shop No. 1, Shree Siddhi Plaza, RRT Rd, Mulund West, Mumbai, Maharashtra 400080",
                                "36, Turner Rd,Bandra West,Mumbai, Maharashtra 400050",
                                 "Coming soon"];

  List<String> storePhone=["022 6158 7000","022 6158 7001","022 6831 8282","Coming soon"];
  List<String> storeLocation=["OM JEWELLERS, BORIVALI","OM JEWELLERS, MULUND","De Beers Forevermark Boutique","OM JEWELLERS, GHATKOPAR"];
  List<String> CompanyNameList = [];
  List<String> CompanyPostList = [];
  List<String> CompanyPostImage = [];
  @override
  void initBloc() {
    // TODO: implement initBloc
    super.initBloc();
    userName=AuthBloc.getUserName();

    CompanyNameList.add('Narendra Jakhia');
    CompanyNameList.add('Mukesh Jakhia');
    CompanyNameList.add('Bhavin Jakhia');
    CompanyNameList.add('Bhavna Jakhia');
    CompanyNameList.add('Harsha and Mamta Jakhia');
    CompanyNameList.add('Bhavesh Jakhia');


    CompanyPostList.add('Chairman');
    CompanyPostList.add('Managing Director');
    CompanyPostList.add('CEO');
    CompanyPostList.add('Head - Digital Ventures');
    CompanyPostList.add('Brand Ambassadors');
    CompanyPostList.add('CMO');

    CompanyPostImage.add('assets/images/chairman.png');
    CompanyPostImage.add('assets/images/director.png');
    CompanyPostImage.add('assets/images/bhavin_ceo.jpg');
    CompanyPostImage.add('assets/images/head_digital.png');
    CompanyPostImage.add('assets/images/ambassadars.png');
    CompanyPostImage.add('assets/images/cmo.png');

  }

  void editAppointment({Appointment appointment}) async {
    //update ui state
    final int userId=AuthBloc.getUserID();

    setUiState(UiState.loading);
    final resultDialogData = await _appointmentRepository.editAppointmnet(
        userId: userId,
        appointment:appointment
    );

    //update ui state after operation
    setUiState(UiState.done);
    //checking if operation was successful before either showing an error or redirect to home page
    if (resultDialogData.dialogType == DialogType.success) {
      dialogData.title = resultDialogData.title;
      dialogData.body = resultDialogData.body;
      dialogData.backgroundColor = AppColor.successfulColor;
      dialogData.iconData = FlutterIcons.done_mdi;
      setShowAlert(true);
    } else {
      //prepare the data model to be used to show the alert on the view
      dialogData.title = resultDialogData.title;
      dialogData.body = resultDialogData.body;
      dialogData.backgroundColor = AppColor.failedColor;
      dialogData.iconData = FlutterIcons.error_mdi;
      //notify listners to show show alert
      setShowAlert(false);
    }


  }

  bool validateFeedback(String value) {
    if (value.length < 1) {
      _feedBackValid.addError("Enter valid FeedBack");
      return false;
    } else {
      _feedBackValid.add(true);
      return true;
    }
  }

  bool validateForm(String category,String desc) {
    if (category!="" && desc.length >= 1) {
      feedBackButtonStatus=true;
      return true;
    } else {
      feedBackButtonStatus=false;
      return false;
    }
  }

  void submitFeedBack({String category}) async {
    //update ui state
    final int userId=AuthBloc.getUserID();
    final String descrip=shareFeedbackTEC.text;
    if(validateFeedback(descrip)) {
      setUiState(UiState.loading);
      final resultDialogData = await _appointmentRepository.submitFeedBack(
        userId: userId,
        description: descrip,
        category: category
      );

      //update ui state after operation
      setUiState(UiState.done);
      //checking if operation was successful before either showing an error or redirect to home page
      if (resultDialogData.dialogType == DialogType.success) {
        dialogData.title = resultDialogData.title;
        dialogData.body = resultDialogData.body;
        dialogData.backgroundColor = AppColor.successfulColor;
        dialogData.iconData = FlutterIcons.done_mdi;
        setShowAlert(true);
      } else {
        //prepare the data model to be used to show the alert on the view
        dialogData.title = resultDialogData.title;
        dialogData.body = resultDialogData.body;
        dialogData.backgroundColor = AppColor.failedColor;
        dialogData.iconData = FlutterIcons.error_mdi;
        //notify listners to show show alert
        setShowAlert(false);
      }
    }

  }

  /*void addToWishList({int produtcId}) async {
    //update ui state
    final int userId=AuthBloc.getUserID();

    setUiState(UiState.loading);
    final resultDialogData = await _productRepository.addToWishList(
        userID: userId,
        productID: produtcId
    );

    //update ui state after operation
    setUiState(UiState.done);
    //checking if operation was successful before either showing an error or redirect to home page
    if (resultDialogData.dialogType == DialogType.success) {
      dialogData.title = resultDialogData.title;
      dialogData.body = resultDialogData.body;
      dialogData.backgroundColor = AppColor.successfulColor;
      dialogData.iconData = FlutterIcons.done_mdi;
      setShowAlert(true);
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

  void removeFromWishList({int produtcId}) async {
    //update ui state
    final int userId=AuthBloc.getUserID();

    setUiState(UiState.loading);
    final resultDialogData = await _productRepository.removeFromWishList(
        userID: userId,
        productID: produtcId
    );

    //update ui state after operation
    setUiState(UiState.done);
    //checking if operation was successful before either showing an error or redirect to home page
    if (resultDialogData.dialogType == DialogType.success) {
      dialogData.title = resultDialogData.title;
      dialogData.body = resultDialogData.body;
      dialogData.backgroundColor = AppColor.successfulColor;
      dialogData.iconData = FlutterIcons.done_mdi;
      setShowAlert(true);
    } else {
      //prepare the data model to be used to show the alert on the view
      dialogData.title = resultDialogData.title;
      dialogData.body = resultDialogData.body;
      dialogData.backgroundColor = AppColor.failedColor;
      dialogData.iconData = FlutterIcons.error_mdi;
      //notify listners to show show alert
      setShowAlert(false);
    }


  }*/




}




