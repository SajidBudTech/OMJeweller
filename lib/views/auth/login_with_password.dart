import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/constants/string/auth.string.dart';
import 'package:flutter_om_jeweller/data/models/user_data.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';

class LoginWithPassword extends StatefulWidget {
  LoginWithPassword({Key key,this.user}) : super(key: key);
  User user;
  @override
  _LoginWithPasswordState createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  //login bloc
  LoginBloc _loginBloc = LoginBloc();
  //email focus node
  final emailFocusNode = new FocusNode();
  //password focus node
  final passwordFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    //listen to the need to show a dialog alert or a normal snackbar alert type
    _loginBloc.mobileNumberTEC.text=widget.user.cutomerMobile;

    _loginBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _loginBloc.dialogData.title,
          description: _loginBloc.dialogData.body,
          backgroundColor: AppColor.accentColor,
          icon: _loginBloc.dialogData.iconData,
        );
      }
    });

    //listen to state of the ui
    _loginBloc.uiState.listen((uiState) async {
      if (uiState == UiState.redirect) {
        // await Navigator.popUntil(context, (route) => false);
        // Navigator.pushNamed(context, AppRoutes.homeRoute);

        if(_loginBloc.OTP_OR_REGISTER){
          Navigator.pushNamed(context, AppRoutes.verifyOTPRoute,arguments: _loginBloc.user);
        }else{
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeRoute,(route) => false,
          );
        }

      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return /*Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),
        child:*/
      AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child:Scaffold(
            primary: false,
            appBar: EmptyAppBar(),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                //body
                CustomScrollView(
                  slivers: <Widget>[
                    SliverPadding(
                        padding: EdgeInsets.only(left: 32,right: 32),
                        sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              //page title
                              UiSpacer.verticalSpace(space: 89),
                              Text(
                                AuthStrings.loginWithTitle,
                                style: AppTextStyle.h1TitleTextStyle(
                                  color: AppColor.textColor(context),
                                ),
                                textAlign: TextAlign.start,
                                textDirection: AppTextDirection.defaultDirection,
                              ),
                              /*UiSpacer.verticalSpace(space: 9),
                              Text(
                                "We will send you confirmation code.",
                                style: AppTextStyle.h4TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                    fontWeight: FontWeight.w400
                                ),
                                textAlign: TextAlign.start,
                                textDirection: AppTextDirection.defaultDirection,
                              ),*/
                              UiSpacer.verticalSpace(space: 47),
                              StreamBuilder<bool>(
                                stream: _loginBloc.validMobileNumber,
                                builder: (context, snapshot) {
                                  return CustomTextFormField(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    isReadOnly: true,
                                    hintText: AuthStrings.registerPhone,
                                    labelText: AuthStrings.registerPhone,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    textEditingController: _loginBloc.mobileNumberTEC,
                                    errorText: snapshot.error,
                                    onChanged: _loginBloc.validateMobileNumber,
                                  );
                                },
                              ),
                              UiSpacer.verticalSpace(space: 20),
                              StreamBuilder<bool>(
                                stream: _loginBloc.validPasswordAddress,
                                builder: (context, snapshot) {
                                  return CustomTextFormField(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    togglePassword: true,
                                    obscureText: true,
                                    hintText: AuthStrings.registerPassword,
                                    labelText: AuthStrings.registerPassword,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    textEditingController: _loginBloc.passwordTEC,
                                    errorText: snapshot.error,
                                    onChanged: _loginBloc.validatePassword,
                                  );
                                },
                              ),
                             /* Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "+91",
                                        style: AppTextStyle.h4TitleTextStyle(
                                            color: AppColor.textColor(context),
                                            fontWeight: FontWeight.w400
                                        ),
                                        textAlign: TextAlign.start,
                                        textDirection: AppTextDirection.defaultDirection,
                                      )),
                                  Container(
                                    width: 1,
                                    height: 16,
                                    margin: EdgeInsets.only(left: 18,right: 18),
                                    color: AppColor.hintTextColor(context),
                                  ),
                                  Expanded(
                                      flex:9,
                                      child: StreamBuilder<bool>(
                                        stream: _loginBloc.validMobileNumber,
                                        builder: (context, snapshot) {
                                          return CustomTextFormField(
                                              textStyle: AppTextStyle.h4TitleTextStyle(fontWeight: FontWeight.w400),
                                              hintTextStyle: AppTextStyle.h4TitleTextStyle(fontWeight: FontWeight.w300),
                                              hintText: AuthStrings.loginHint,
                                              keyboardType: TextInputType.phone,
                                              textInputAction: TextInputAction.next,
                                              textEditingController: _loginBloc.mobileNumberTEC,
                                              errorText: snapshot.error,
                                              onChanged:_activebutton
                                          );
                                        },
                                      )),
                                ],
                              ),*/
                              //email/phone number textformfield

                              Container(
                                margin: EdgeInsets.only(top: 20),
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: (){
                                    //Navigator.pushNamed(context, AppRoutes.verifyOTPRoute,arguments: _loginBloc.user);
                                    _loginBloc.processForgotPassword(context: context);
                                  },
                                  child:Text(
                                  "Forgot Password",
                                  style: AppTextStyle.h4TitleTextStyle(
                                      color: AppColor.accentColor,
                                      fontWeight: FontWeight.w500,
                                      decoration:TextDecoration.underline
                                  ),
                                  textAlign: TextAlign.start,
                                  textDirection: AppTextDirection.defaultDirection,
                                ),
                              )),
                              UiSpacer.verticalSpace(space: 40),
                              //login button
                              //listen to the uistate to know the appropriated state to put the login button

                              StreamBuilder<UiState>(
                                stream: _loginBloc.uiState,
                                builder: (context, snapshot) {
                                  final uiState = snapshot.data;
                                  return CustomButton(
                                    padding: AppPaddings.mediumButtonPadding(),
                                    color: AppColor.accentColor,
                                    disabledColor: AppColor.disableColor,
                                    onPressed: uiState!=UiState.loading
                                        ?  (){
                                         _loginBloc.processLoginWithPassword(context: context);
                                         // Navigator.pushNamed(context, AppRoutes.registerRoute);
                                        }
                                        : null,
                                    child: uiState != UiState.loading
                                        ? Text(
                                      "Login",
                                      style: AppTextStyle.h4TitleTextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500
                                      ),
                                      textAlign: TextAlign.start,
                                      textDirection:
                                      AppTextDirection.defaultDirection,
                                    )
                                        : PlatformCircularProgressIndicator(),
                                  );
                                },
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: (){
                                      _loginBloc.processOTP();
                                    },
                                    child:Text(
                                    "Login with an OTP",
                                    style: AppTextStyle.h4TitleTextStyle(
                                        color: AppColor.accentColor,
                                        fontWeight: FontWeight.w500,
                                        decoration:TextDecoration.underline
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection: AppTextDirection.defaultDirection,
                                  ),
                                  )),
                            ])))
                  ],
                ),
              ],
            ),
          )
      );
    //  );
  }

  _activebutton(String value) async{
    setState(() {
      _loginBloc.validateMobileNumber(value);
    });
  }
}
