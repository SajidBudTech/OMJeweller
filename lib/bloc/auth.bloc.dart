
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
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


 /* static bool NotificationBadget() {
    return prefs.getBool(AppStrings.FlutterAppBadgetConstant) ?? false;
  }*/

}
