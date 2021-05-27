import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/data/models/api_response.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/services/http.service.dart';
import 'package:flutter_om_jeweller/utils/api_response.utils.dart';
import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';
import 'package:flutter_om_jeweller/data/models/dialog_data.dart';
import 'package:flutter_om_jeweller/constants/string/auth.string.dart';
import 'package:flutter_om_jeweller/data/models/appointment.dart';


class AppointmentRepository extends HttpService {
  //get vendors from server base on the type

  Future<DialogData> bookAppointmnet({Appointment appointment,int userId}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.addAppointmentBook,
      {
        "user_id": userId,
        "appointment_type": appointment.appointmentType,
        "appointment_detail": appointment.appointmentDetail,
        "appointment_date": appointment.appointmentDate,
        "appointment_time": appointment.appointmentTime,
        "name": appointment.name,
        "mobile_no": appointment.mobileNo,
        "email": appointment.email,
        "product": appointment.product,
      },
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = "Your Appointment Booked Sucessfully!";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;


    } else {

      resultDialogData.title = "Failed To Booked Your Appointment!";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;


    }

    return resultDialogData;
  }

  Future<DialogData> editAppointmnet({Appointment appointment,int userId}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.editAppointmentBook,
      {
         "user_id": userId,
         "id":appointment.id,
         "appointment_type": appointment.appointmentType,
        "appointment_detail": appointment.appointmentDetail,
        "appointment_date": appointment.appointmentDate,
        "appointment_time": appointment.appointmentTime,
        "name": appointment.name,
        "mobile_no": appointment.mobileNo,
        "email": appointment.email,
        "product": appointment.product,
      },
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {

      if(apiResponse.message=="Appointment Updated") {
        resultDialogData.title = "Your Appointment Booked Sucessfully!";
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.success;
      }else{
        resultDialogData.title = "Failed To Booked Your Appointment!";
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.failed;
      }


    } else {

      resultDialogData.title = "Failed To Booked Your Appointment!";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;


    }

    return resultDialogData;
  }

  Future<DialogData> submitFeedBack({int userId,String category,String description}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.submitFeedBack,
      {
        "user_id": userId,
        "category":category,
        "description": description,
      },
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {

      if(apiResponse.message=="Thank you for giving feedback") {
        resultDialogData.title = "Your Appointment Booked Sucessfully!";
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.success;
      }else{
        resultDialogData.title = "Failed To Booked Your Appointment!";
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.failed;
      }


    } else {

      resultDialogData.title = "Failed To Booked Your Appointment!";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;


    }

    return resultDialogData;
  }

  Future<List<Appointment>> getAllMyAppointment({int userID}) async {
    List<Appointment> appointments = [];

    //make http call for vendors data
    final apiResult = await post(
      Api.myAppointmentBooking,
      {
        "user_id": userID,
      },
    );

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data'] as List).forEach((categoryJSONObject) {
      //vendor data
      appointments.add(Appointment.fromJson(categoryJSONObject));

    });

    return appointments;

  }


}




