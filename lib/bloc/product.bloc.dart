
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/data/repositories/product.repository.dart';
import 'package:flutter_om_jeweller/data/models/dialog_data.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';

class ProductBloc extends BaseBloc {
  //Auth repository
  ProductRepository _productRepository = ProductRepository();

  void addToWishList({int produtcId}) async {
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


  }




}




