import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';

class VerifyOTPPage extends StatefulWidget {
  VerifyOTPPage({Key key}) : super(key: key);

  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
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
    _loginBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _loginBloc.dialogData.title,
          description: _loginBloc.dialogData.body,
          backgroundColor: _loginBloc.dialogData.backgroundColor,
          icon: _loginBloc.dialogData.iconData,
        );
      }
    });

    //listen to state of the ui
    _loginBloc.uiState.listen((uiState) async {
      if (uiState == UiState.redirect) {
        // await Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, AppRoutes.homeRoute);
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   AppRoutes.homeRoute,
        //   (route) => false,
        // );
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
    return

  /*    Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),
        child: */
      AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
      ),
    child:Scaffold(
          primary: false,
          bottomSheet: getBottomWidget(),
          appBar: EmptyAppBar(),
          extendBodyBehindAppBar: true,
          backgroundColor: AppColor.appBackground(context),
          body: Stack(
            children: [
              //body
              CustomScrollView(
                slivers: <Widget>[
               /*   SliverPadding(
                      padding: EdgeInsets.only(),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            //page title*/
                            SliverToBoxAdapter(child:UiSpacer.verticalSpace(space:89)),
                            SliverPadding(padding: EdgeInsets.only(left: 32,right: 32),
                            sliver: SliverList(
                            delegate: SliverChildListDelegate([
                            Text(
                              AuthStrings.otpTitle,
                              style: AppTextStyle.h1TitleTextStyle(
                                color: AppColor.textColor(context),
                              ),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            ),
                            UiSpacer.verticalSpace(space: 9),
                            Text(
                              "We have sent and OTP to your mobile number",
                              style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                                fontWeight: FontWeight.w400
                              ),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            )
                            ])))  ,

          SliverPadding(padding: EdgeInsets.only(left: 32,right: 14),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                            UiSpacer.verticalSpace(space: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex:1,
                                    child: StreamBuilder<bool>(
                                      stream: _loginBloc.validMobileNumber,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle: AppTextStyle.h2TitleTextStyle(color: AppColor.hintTextColor(context),fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle: AppTextStyle.h1TitleTextStyle(fontWeight: FontWeight.w300),
                                          textEditingController: _loginBloc.mobileNumberTEC,
                                          errorText: snapshot.error,
                                          onChanged: _loginBloc.validateMobileNumber,
                                        );
                                      },
                                    )),
                                Expanded(
                                    flex:1,
                                    child: StreamBuilder<bool>(
                                      stream: _loginBloc.validMobileNumber,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle: AppTextStyle.h2TitleTextStyle(color: AppColor.hintTextColor(context),fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle: AppTextStyle.h1TitleTextStyle(fontWeight: FontWeight.w300),
                                          textEditingController: _loginBloc.mobileNumberTEC,
                                          errorText: snapshot.error,
                                          onChanged: _loginBloc.validateMobileNumber,
                                        );
                                      },
                                    )),
                                Expanded(
                                    flex:1,
                                    child: StreamBuilder<bool>(
                                      stream: _loginBloc.validMobileNumber,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle: AppTextStyle.h2TitleTextStyle(color: AppColor.hintTextColor(context),fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle: AppTextStyle.h1TitleTextStyle(fontWeight: FontWeight.w300),
                                          textEditingController: _loginBloc.mobileNumberTEC,
                                          errorText: snapshot.error,
                                          onChanged: _loginBloc.validateMobileNumber,
                                        );
                                      },
                                    )),
                                Expanded(
                                    flex:1,
                                    child: StreamBuilder<bool>(
                                      stream: _loginBloc.validMobileNumber,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle: AppTextStyle.h2TitleTextStyle(color: AppColor.hintTextColor(context),fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle: AppTextStyle.h1TitleTextStyle(fontWeight: FontWeight.w300),
                                          textEditingController: _loginBloc.mobileNumberTEC,
                                          errorText: snapshot.error,
                                          onChanged: _loginBloc.validateMobileNumber,
                                        );
                                      },
                                    )),
                              ],
                            ),
                            ]))),
                            //email/phone number textformfield
                            SliverToBoxAdapter(child:UiSpacer.verticalSpace(space: 30)),
                           SliverToBoxAdapter(child:
                           Container(
                             padding: EdgeInsets.only(left: 32,right: 32),
                             alignment: Alignment.bottomLeft,
                            child:Text(
                              "Resend OTP in 00:28",
                              style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                              ),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            ))),
                  SliverToBoxAdapter(child:UiSpacer.verticalSpace(space: 40)),
                            //login button
                            //listen to the uistate to know the appropriated state to put the login button
                  SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.only(left: 32,right: 32),
                          child:StreamBuilder<UiState>(
                              stream: _loginBloc.uiState,
                              builder: (context, snapshot) {
                                final uiState = snapshot.data;

                                return CustomButton(
                                  padding: AppPaddings.mediumButtonPadding(),
                                  color: AppColor.accentColor,
                                  onPressed: uiState != UiState.loading
                                      ? (){Navigator.pushNamed(
                                    context,
                                    AppRoutes.registerRoute,
                                     );}
                                      : null,
                                  child: uiState != UiState.loading
                                      ? Text(
                                    AuthStrings.otpButtonTitle,
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
                            ))
                      ),
                          //])))
                ],
              ),
            ],
          ),
        ));

    //);
  }

   Widget getBottomWidget() {
     TextStyle defaultStyle = AppTextStyle.h5TitleTextStyle(color: AppColor.textColor(context),fontWeight: FontWeight.w400);
     TextStyle linkStyle = AppTextStyle.h5TitleTextStyle(color: AppColor.accentColor,fontWeight: FontWeight.w400,decoration: TextDecoration.underline);
     return Container(
          color: Color(0xFFFFFDFB),
          height: 56,
          alignment: Alignment.center,
         child:RichText(
           textAlign: TextAlign.center,
       text: TextSpan(
         style: defaultStyle,
         children: <TextSpan>[
           TextSpan(text: 'By verifying OTP, you agree to our\n'),
           TextSpan(
               text: 'Terms & Conditions',
               style: linkStyle,
               recognizer: TapGestureRecognizer()
                 ..onTap = () {
                   print('Terms of Service"');
                 }),
           TextSpan(text: ' and '),
           TextSpan(
               text: 'Privacy Policy',
               style: linkStyle,
               recognizer: TapGestureRecognizer()
                 ..onTap = () {
                   print('Privacy Policy"');
                 }),
         ],
       ),
     ));
  }
}
