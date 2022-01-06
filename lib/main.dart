
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/utils/router.dart' as router;
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //

 /* await Firebase.initializeApp();
  //Initialize App Database
  await AppDatabaseSingleton().prepareDatabase();
  //start notification listening
  AppNotification.setUpFirebaseMessaging();*/

  //initiating tellam
  /*Tellam.initialize(
     // Old https://flutter-projects-5ec90-ba266.firebaseio.com/
    // client firstore===https://console.firebase.google.com/u/3/project/allayurvedic-75fa8/firestore
    databaseUrl: "https://allayurvedic-75fa8-default-rtdb.firebaseio.com",
    uiconfiguration: UIConfiguration(
      accentColor: AppColor.accentColor,
      primaryColor: AppColor.primaryColor,
      primaryDarkColor: AppColor.primaryColorDark,
      buttonColor: AppColor.accentColor,
    ),
  );
*/
  //clear user records if any
  // await AppDatabaseSingleton.database.userDao.deleteAll();
  // await AppDatabaseSingleton.database.productDao.deleteAll();
  // await AppDatabaseSingleton.database.productExtraDao.deleteAll();

  // Set default home.
 // String _startRoute = AppRoutes.welcomeRoute;

  String _startRoute = AppRoutes.homeRoute;

  //check if user has signin before
  await AuthBloc.getPrefs();

  if (AuthBloc.firstTimeOnApp()) {
    AuthBloc.prefs.setBool(AppStrings.firstTimeOnApp, false);
  } else {
    if(AuthBloc.authenticated()){
      _startRoute = AppRoutes.homeRoute;
    }else{
      _startRoute = AppRoutes.homeRoute;
    }
  }

  // Run app!
  runApp(
      MaterialApp(
       // title: 'Title',
       // theme: kThemeData,
        debugShowCheckedModeBanner: false,
        home: MyApp(starter: _startRoute),
      )
 /*   new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: router.generateRoute,
      initialRoute: _startRoute,
      theme: ThemeData(
        accentColor: AppColor.accentColor,
        primaryColor: AppColor.primaryColor,
        primaryColorDark: AppColor.primaryColorDark,
        cursorColor: AppColor.cursorColor,
      ),
    ),*/
  );
}

class MyApp extends StatefulWidget {

  MyApp({Key key ,this.starter});

  final String starter;

  @override
  _MyAppState createState() => new _MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
          seconds: 5,
          navigateAfterSeconds: new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          onGenerateRoute: router.generateRoute,
          initialRoute: widget.starter,
          theme: ThemeData(
            accentColor: AppColor.accentColor,
            primaryColor: AppColor.primaryColor,
            primaryColorDark: AppColor.primaryColorDark,
            cursorColor: AppColor.cursorColor,
          ),
        ),
        //image: new Image.asset("assets/images/splash.gif",fit: BoxFit.cover,width: 1080,height: 1920,),
        //backgroundColor: AppColor.newprimaryColor,
        imageBackground :new AssetImage("assets/images/splash.gif"),
        useLoader: false,
       // styleTextUnderTheLoader: new TextStyle(),
        //photoSize: 100.0,
        //onClick: ()=>print("Flutter"),
        //loaderColor: Colors.red
    );
  }
}
