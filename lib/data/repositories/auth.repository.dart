import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_om_jeweller/services/http.service.dart';
import 'package:flutter_om_jeweller/data/models/dialog_data.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/utils/api_response.utils.dart';
import 'package:flutter_om_jeweller/data/models/api_response.dart';
import 'package:flutter_om_jeweller/constants/string/auth.string.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';


class AuthRepository extends HttpService {
  //process user account login
  Future<DialogData> loginOTP({String mobile}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.loginOTP,
      {
        "mobile": mobile,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      if(apiResponse.message=="OTP sent Successfully"){
        resultDialogData.title=apiResponse.body['get_otp_number'].toString();
      }else {
        resultDialogData.title = AuthStrings.processFailedTitle;
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.failed;
      }

    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  Future<DialogData> forgotPassword({String mobile}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.forgotPassword,
      {
        "mobile": mobile,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      if(apiResponse.message=="OTP sent Successfully"){
        resultDialogData.title=apiResponse.body['get_otp_number'].toString();
        resultDialogData.extraData=apiResponse.body['data'][0];
      }else {
        resultDialogData.title = AuthStrings.processFailedTitle;
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.failed;
      }

    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }
  Future<DialogData> changePassword({int customerID,String password}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.changePassword,
      {
        "customerID": customerID,
        "password": password,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      if(apiResponse.message=="User Password updated"){
        saveuserData(apiResponse.body['data']);
      }else {
        resultDialogData.title = AuthStrings.processFailedTitle;
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.failed;
      }

    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  Future<DialogData> loginWithPassword({String mobile,String password}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.login,
      {
        "mobile": mobile,
        "password": password,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;
      if(apiResponse.body["success"]){
        saveuserData(apiResponse.body["data"],
        );
      }else{
        resultDialogData.title = AuthStrings.processFailedTitle;
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.failed;
      }
    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  Future<DialogData> checkMobileNumber({String mobile}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.checkMobile,
      {
        "mobile": mobile,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      if(apiResponse.message!="This account is not registered with us."){
        resultDialogData.title="go to Login";
      }else{
        resultDialogData.title="go to registration";
      }

    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  Future<DialogData> loginDetails({String mobile}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.loginDetail,
      {
        "mobile": mobile,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      //save the user data to hive box
      saveuserData(
        apiResponse.body["data"][0],
      );
      // AuthBloc.prefs.setBool(AppStrings.authenticated, true);

    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }
  //process user account login
  Future<DialogData> login({String mobile, String password}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.login,
      {
        "mobile": mobile,
        "password": password,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      //save the user data to hive box
      saveuserData(
        apiResponse.body["data"],
      );
     // AuthBloc.prefs.setBool(AppStrings.authenticated, true);

    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //process user account login
  Future<DialogData> sendOTP({String mobile, String password}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.registeSendOTP,
      {
        "mobile": mobile,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      resultDialogData.title=apiResponse.body['get_otp_number'].toString();

    } else {
      resultDialogData.title = AuthStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  Future<DialogData> register({
    String name,
    String email,
    String mobile,
    String password,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();

    final Map<String, dynamic> bodyPayload =
    {
      "name": name,
      "email_id": email,
      "mobile": mobile,
      "password": password,
    };

    final apiResult = await post(
      Api.register,
      bodyPayload
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = AuthStrings.processRegisterCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

     if(apiResponse.message=="Registration Successfully"){
       saveuserData(
         apiResponse.body["data"],
       );
     }else{
       resultDialogData.title = AuthStrings.processRegisterFailedTitle;
       resultDialogData.body = apiResponse.message;
       resultDialogData.dialogType = DialogType.failed;
     }

    } else {
      resultDialogData.title = AuthStrings.processRegisterFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;

  }

  Future<DialogData> updateProfile({
    int userId,
    String name,
    String email,
    String mobile,
    String gender,
    String dob,
    String anniversary,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();

    final Map<String, dynamic> bodyPayload =
    {
      "customerID": userId,
      "customerName": name,
      "customerEmail": email,
      "cutomerMobile": mobile,
      "gender": gender,
      "dob": dob,
      "anniversary": anniversary,

    };

    final apiResult = await post(
        Api.updateProfile,
        bodyPayload
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      if(apiResponse.message=="User updated") {
        resultDialogData.title = AuthStrings.processUpdateCompleteTitle;
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.success;
        saveuserData(
          apiResponse.body["data"],
        );
      }else{
        resultDialogData.title = AuthStrings.processUpdateFailedTitle;
        resultDialogData.body = apiResponse.message;
        resultDialogData.dialogType = DialogType.failed;
      }

    } else {
      resultDialogData.title = AuthStrings.processUpdateFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;

  }

  void saveuserData(dynamic userObject) async {
    //this is variable is inherited from HttpService
    //save to shared pref
    AuthBloc.saveUserData(userObject);
    AuthBloc.prefs.setBool(AppStrings.authenticated, true);

  }

  /*Future<DialogData> loginSocial({
    String name,
    String email,
    String phone,
    String password,
    String serverotp,
    String userotp
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.loginSocial,
      {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "server_otp": serverotp,
        "user_otp": userotp,
      },
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = RegisterStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      //save the user data to hive box
      saveuserData(
        apiResponse.body["user"],
        apiResponse.body["token"],
        apiResponse.body["type"],
      );
    } else {

      resultDialogData.title = RegisterStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;

    }

    return resultDialogData;
  }

  //reset password
  Future<DialogData> resetPassword({
    @required String email,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.forgotPassword,
      {
        "email": email,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = ForgotPasswordStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;
    } else {
      resultDialogData.title = ForgotPasswordStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //update account profile
  Future<DialogData> updateProfile({
    String name,
    String lname,
    String email,
    String phone,
    File photo,
    String dob,
    String address,
    String gst_no,
    String gender,
    String maritalStatus,
    String height,
    String wieght,
    List<String> healthIssue,
    String bloodGroup,
    File medicalReport,
    bool social = false,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();

    final Map<String, dynamic> bodyPayload =
    {
      "name": name,
      "lname": lname,
      "email": email,
      "phone": phone,
      "birthdate": dob,
      "address": address,
      "gst_no": gst_no,
      "gender": gender,
      "marital_status": maritalStatus,
      "height": height,
      "weight": wieght,
      "health_issues": healthIssue,
      "blood_group": bloodGroup,
      "social": social ? "1" : "0"
    };

    //adding photo file to the payload if photo was selected
    if (photo != null) {
      final photoFile = await MultipartFile.fromFile(
        photo.path,
      );

      bodyPayload.addAll({
        "photo": photoFile,
      });

    }

    if (medicalReport != null) {
      final medicalFile = await MultipartFile.fromFile(
        medicalReport.path,
      );

      bodyPayload.addAll({
        "medical_report": medicalFile,
      });
    }


    final apiResult = await postWithFiles(
      Api.updateProfile,
      bodyPayload,
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (apiResponse.allGood) {
      resultDialogData.title = UpdateProfileStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.successThenClosePage;

      //get the local version of user data
      final currentUser = await appDatabase.userDao.findCurrent();
      final mUser = User.formJson(userJSONObject: apiResponse.body["user"]);
      mUser.token = currentUser.token;
      mUser.tokenType = currentUser.tokenType;
      mUser.role = currentUser.role;

      //change the data/info
      // currentUser.name = apiResponse.body["user"]["name"];
      // currentUser.email = apiResponse.body["user"]["email"];
      // currentUser.phone = apiResponse.body["user"]["phone"];
      // currentUser.photo = apiResponse.body["user"]["photo"];

      //update the local version of user data
      await appDatabase.userDao.updateItem(mUser);

    } else {
      //the error message
      var errorMessage = apiResponse.message;

      try {
        errorMessage += "\n" + apiResponse.body["errors"]["name"][0];
      } catch (error) {
        print("Name Validation ===> $error");
      }
      try {
        errorMessage += "\n" + apiResponse.body["errors"]["email"][0];
      } catch (error) {
        print("Email Validation ===> $error");
      }

      resultDialogData.title = UpdateProfileStrings.processFailedTitle;
      resultDialogData.body = errorMessage ?? apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }
    return resultDialogData;
  }

  //update user password
  Future<DialogData> updatePassword({
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.changePassword,
      {
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": confirmNewPassword,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = UpdatePasswordStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.successThenClosePage;
    } else {
      //the error message
      var errorMessage = apiResponse.message;

      try {
        errorMessage +=
            "\n" + apiResponse.body["errors"]["current_password"][0];
      } catch (error) {
        print("Current Password ===> $error");
      }
      try {
        errorMessage += "\n" + apiResponse.body["errors"]["new_password"][0];
      } catch (error) {
        print("New Password ===> $error");
      }

      try {
        errorMessage +=
            "\n" + apiResponse.body["errors"]["new_password_confirmation"][0];
      } catch (error) {
        print("New Password Confirmation ===> $error");
      }

      resultDialogData.title = UpdatePasswordStrings.processFailedTitle;
      resultDialogData.body = errorMessage ?? apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //save user data
  void saveuserData(dynamic userObject, String token, String tokenType) async {
    //this is variable is inherited from HttpService
    final mUser = User.formJson(userJSONObject: userObject);
    mUser.token = token;
    mUser.tokenType = tokenType;
    await appDatabase.userDao.deleteAll();
    await appDatabase.userDao.insertItem(mUser);

    //save to tellam
   *//* TellamUser tellamUser = TellamUser(
      id: mUser.id,
      firstName: mUser.name,
      lastName: mUser.lname,
      emailAddress: mUser.email,
      photo: mUser.photo,
    );

    Tellam.client().register(tellamUser);*//*

    //
    _firebaseMessaging.subscribeToTopic("all");
    _firebaseMessaging.subscribeToTopic(mUser.role);
    _firebaseMessaging.subscribeToTopic(mUser.id.toString());

    //save to shared pref
    AuthBloc.prefs.setBool(AppStrings.authenticated, true);

  }

  //logout
  void logout() async {
    //get current user data
    final currentUser = await appDatabase.userDao.findCurrent();
    //delete current user data from local storage
    await appDatabase.userDao.deleteAll();

    _firebaseMessaging.unsubscribeFromTopic("all");
    try {
      _firebaseMessaging.unsubscribeFromTopic(currentUser.role);
      _firebaseMessaging.unsubscribeFromTopic(currentUser.id.toString());
    } catch (error) {
      print("Error Unsubscribing user");
    }
    //logout of tellam
  //  Tellam.client().logout();
    //save to shared pref
    AuthBloc.prefs.setBool(AppStrings.authenticated, false);
  }

  Future<ApiResponse> generateOTP({
    String phone,
    String appSignature
  }) async {
    //instance of the model to be returned
    final apiResult = await get(
      "${Api.otp}/$phone/$appSignature",
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    //final vendor = Vendor.fromJSON(jsonObject: apiResponse.body);
    //final currencies = await appDatabase.currencyDao.findAllCurrencys();
    //vendor.currency = currencies[0];
    return apiResponse;
  }


  // OTP Related Functions...
  //OTP Related functions
  Future<ApiResponse> verifyPhoneNumber({
    String code,
    String phone,
  }) async {
    final apiResult = await post(
      Api.phoneValidation,
      {
        "code": code,
        "phone": phone,
      },
    );

    //
    return ApiResponseUtils.parseApiResponse(apiResult);
  }

  Future<ApiResponse> otpLogin({
    String token,
    String phone,
  }) async {
    final apiResult = await post(
      Api.otpLogin,
      {
        "token": token,
        "phone": phone,
      },
    );

    //
    final apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if( apiResponse.allGood ){
      saveuserData(
        apiResponse.body["user"],
        apiResponse.body["token"],
        apiResponse.body["type"],
      );
    }
    return apiResponse;
  }*/

}
