
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/constants/string/prefrence_key.string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends BaseBloc {
  //
  static SharedPreferences prefs;

  static Future<SharedPreferences> getPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    return prefs;
  }

  //
  static bool firstTimeOnApp() {
    return prefs.getBool(AppStrings.firstTimeOnApp) ?? true;
  }

  //
  static bool authenticated() {
    return prefs.getBool(AppStrings.authenticated) ?? false;
  }


  static void UpdateUserData(Map userDetails) {
    // prefs.setString(PreferenceString.UserMobile,userDetails["phone_no"]);
    prefs.setString(PreferenceString.UserMobile,userDetails["cutomerMobile"]);
    prefs.setInt(PreferenceString.USERID,userDetails["customerID"]);
    prefs.setString(PreferenceString.USEREmail,userDetails["customerEmail"] ?? "");
    prefs.setString(PreferenceString.UserName,userDetails["customerName"] ?? "");
    prefs.setString(PreferenceString.USERDOB,userDetails["dob"]??"");
    prefs.setString(PreferenceString.UserAnni,userDetails["anniversary"]??"");
    prefs.setString(PreferenceString.USERGeneder,userDetails["gender"]??"");


  }


  static void saveUserData(Map userDetails) {
    prefs.setString(PreferenceString.UserMobile,userDetails["cutomerMobile"]);
    prefs.setInt(PreferenceString.USERID,userDetails["customerID"]);
    prefs.setString(PreferenceString.USEREmail,userDetails["customerEmail"] ?? "");
    prefs.setString(PreferenceString.UserName,userDetails["customerName"] ?? "");
    prefs.setString(PreferenceString.USERDOB,userDetails["dob"]??"");
    prefs.setString(PreferenceString.UserAnni,userDetails["anniversary"]??"");
    prefs.setString(PreferenceString.USERGeneder,userDetails["gender"]??"");
  }
  static void clearUserData() async{
    await prefs.clear();
  }


  static int getUserID() {
    return prefs.getInt(PreferenceString.USERID) ?? 0;
  }
  static String getUserEmail() {
    return prefs.getString(PreferenceString.USEREmail) ?? "";
  }
  static String getUserMobile() {
    return prefs.getString(PreferenceString.UserMobile) ?? "";
  }
  static String getUserDOB() {
    return prefs.getString(PreferenceString.USERDOB) ?? "";
  }
  static String getUserName() {
    return prefs.getString(PreferenceString.UserName) ?? "";
  }

  static String getUserAnniversary() {
    return prefs.getString(PreferenceString.UserAnni) ?? "";
  }
  static String getUserGender() {
    return prefs.getString(PreferenceString.USERGeneder) ?? "";
  }

}
