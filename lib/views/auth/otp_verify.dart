import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/otp.bloc.dart';
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
import 'package:flutter_om_jeweller/data/models/user_data.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/utils/otp_timer.dart';

class VerifyOTPPage extends StatefulWidget {
  VerifyOTPPage({Key key, this.user}) : super(key: key);

  User user;
  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  //login bloc
  OTPBloc _otpBloc = OTPBloc();
  //email focus node

  final firstFocusNode = new FocusNode();
  //password focus node
  final secondFocusNode = new FocusNode();
  final threeFocusNode = new FocusNode();
  final fourthFocusNode = new FocusNode();
  bool hasTimerStopped=false;

  void callShowOTP() {
    EdgeAlert.show(
      context,
      title:widget.user.otp.toString(),
      description: "OTP Sent Successfully!",
      backgroundColor: AppColor.accentColor,
      icon: FlutterIcons.done_mdi,
    );
    print(widget.user.otp.toString());
  }


  @override
  void initState() {
    super.initState();
    _otpBloc.user=widget.user;
    Future.delayed(Duration.zero, () async {
      callShowOTP();
    });

    //listen to the need to show a dialog alert or a normal snackbar alert type
    _otpBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _otpBloc.dialogData.title,
          description: _otpBloc.dialogData.body,
          backgroundColor: AppColor.accentColor,
          icon: _otpBloc.dialogData.iconData,
        );
      }
    });

    //listen to state of the ui
    _otpBloc.uiState.listen((uiState) async {
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
    _otpBloc.dispose();
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
            child: Scaffold(
              primary: false,
              bottomSheet: getBottomWidget(),
              appBar: EmptyAppBar(),
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
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
                      SliverToBoxAdapter(
                          child: UiSpacer.verticalSpace(space: 89)),
                      SliverPadding(
                          padding: EdgeInsets.only(left: 32, right: 32),
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
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            )
                          ]))),

                      SliverPadding(
                          padding: EdgeInsets.only(left: 32, right: 14),
                          sliver: SliverList(
                              delegate: SliverChildListDelegate([
                            UiSpacer.verticalSpace(space: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: StreamBuilder<bool>(
                                      stream: _otpBloc.validFirst,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle:
                                              AppTextStyle.h2TitleTextStyle(
                                                  color: AppColor.hintTextColor(
                                                      context),
                                                  fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle:
                                              AppTextStyle.h1TitleTextStyle(
                                                  fontWeight: FontWeight.w300),
                                          textEditingController:
                                              _otpBloc.firstDigitTEC,
                                          errorText: snapshot.error,
                                          onChanged: (value) {
                                            if (value.toString().length == 1) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      secondFocusNode);
                                            }
                                          },
                                          focusNode: firstFocusNode,
                                          nextFocusNode: secondFocusNode,
                                        );
                                      },
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: StreamBuilder<bool>(
                                      stream: _otpBloc.validSecond,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle:
                                              AppTextStyle.h2TitleTextStyle(
                                                  color: AppColor.hintTextColor(
                                                      context),
                                                  fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle:
                                              AppTextStyle.h1TitleTextStyle(
                                                  fontWeight: FontWeight.w300),
                                          textEditingController:
                                              _otpBloc.secondDigitTEC,
                                          errorText: snapshot.error,
                                          onChanged: (value) {
                                            if (value.toString().length == 1) {
                                              FocusScope.of(context)
                                                  .requestFocus(threeFocusNode);
                                            }
                                          },
                                          focusNode: secondFocusNode,
                                          nextFocusNode: threeFocusNode,
                                        );
                                      },
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: StreamBuilder<bool>(
                                      stream: _otpBloc.validThree,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle:
                                              AppTextStyle.h2TitleTextStyle(
                                                  color: AppColor.hintTextColor(
                                                      context),
                                                  fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle:
                                              AppTextStyle.h1TitleTextStyle(
                                                  fontWeight: FontWeight.w300),
                                          textEditingController:
                                              _otpBloc.threeDigitTEC,
                                          errorText: snapshot.error,
                                          onChanged: (value) {
                                            if (value.toString().length == 1) {
                                              FocusScope.of(context)
                                                  .requestFocus(fourthFocusNode);
                                            }
                                          },
                                          focusNode: threeFocusNode,
                                          nextFocusNode: fourthFocusNode,
                                        );
                                      },
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: StreamBuilder<bool>(
                                      stream: _otpBloc.validFourth,
                                      builder: (context, snapshot) {
                                        return CustomTextFormField(
                                          left: 0,
                                          right: 18,
                                          top: 0,
                                          bottom: 0,
                                          textAlign: TextAlign.center,
                                          hintText: AuthStrings.otpHint,
                                          hintTextStyle:
                                              AppTextStyle.h2TitleTextStyle(
                                                  color: AppColor.hintTextColor(
                                                      context),
                                                  fontWeight: FontWeight.w100),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          textStyle:
                                              AppTextStyle.h1TitleTextStyle(
                                                  fontWeight: FontWeight.w300),
                                          textEditingController:
                                              _otpBloc.fourthDigitTEC,
                                          errorText: snapshot.error,
                                          onChanged: (value) {
                                            _verifyOtp();
                                          },
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ]))),
                      //email/phone number textformfield
                      SliverToBoxAdapter(
                          child: UiSpacer.verticalSpace(space: 30)),
                      SliverToBoxAdapter(
                          child: Container(
                              padding: EdgeInsets.only(left: 32, right: 32),
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  InkWell(
                                  onTap: (){
                                    if(hasTimerStopped){
                                      setState(() {
                                         hasTimerStopped = !hasTimerStopped;
                                        _otpBloc.processOTP(context: context);
                                      });
                                    }
                                  },
                                  child:Text(
                                    hasTimerStopped?"Resend OTP":"Resend OTP in ",
                                    style: hasTimerStopped? AppTextStyle.h4TitleTextStyle(
                                      color:AppColor.accentColor,
                                    ): AppTextStyle.h5TitleTextStyle(
                                      color:AppColor.hintTextColor(context),
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection:
                                    AppTextDirection.defaultDirection,
                                  )),
                                  Visibility(
                                  visible: !hasTimerStopped,
                                  child:CountDownTimer(
                                    secondsRemaining: 60,
                                    whenTimeExpires: () {
                                      setState(() {
                                        hasTimerStopped = !hasTimerStopped;
                                      });
                                    },
                                    countDownTimerStyle: TextStyle(
                                        color: AppColor.hintTextColor(context),
                                        fontSize: 12.0,
                                        height: 1.2),
                                  )),
                                ],
                              )


                          )
                      ),
                      SliverToBoxAdapter(
                          child: UiSpacer.verticalSpace(space: 40)),
                      //login button
                      //listen to the uistate to know the appropriated state to put the login button
                      SliverToBoxAdapter(
                          child: Container(
                              padding: EdgeInsets.only(left: 32, right: 32),
                              color: Colors.transparent,
                              child: StreamBuilder<UiState>(
                                stream: _otpBloc.uiState,
                                builder: (context, snapshot) {
                                  final uiState = snapshot.data;
                                  return CustomButton(
                                    padding: AppPaddings.mediumButtonPadding(),
                                    color: AppColor.accentColor,
                                    onPressed: uiState != UiState.loading
                                        ? () {
                                      if(widget.user.loginRegister){
                                        _otpBloc.processLogin(
                                            mobile:
                                            widget.user.cutomerMobile,
                                            serverOTP:
                                            _otpBloc.user.otp.toString());
                                      }else{
                                        _otpBloc.processRegister(
                                            mobile:
                                            widget.user.cutomerMobile,
                                            serverOTP:
                                            _otpBloc.user.otp.toString(),
                                        name: widget.user.customerName,
                                        email: widget.user.customerEmail);
                                      }
                                          }
                                        : null,
                                    child: uiState != UiState.loading
                                        ? Text(
                                            AuthStrings.otpButtonTitle,
                                            style:
                                                AppTextStyle.h4TitleTextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                            textAlign: TextAlign.start,
                                            textDirection: AppTextDirection
                                                .defaultDirection,
                                          )
                                        : PlatformCircularProgressIndicator(),
                                  );
                                },
                              ))),
                      //])))
                    ],
                  ),
                ],
              ),
            ));

    //);
  }

  void _verifyOtp() {
    final code = _otpBloc.firstDigitTEC.text +
        _otpBloc.secondDigitTEC.text +
        _otpBloc.threeDigitTEC.text +
        _otpBloc.fourthDigitTEC.text;
    if (code.length == 4) {
        if(widget.user.loginRegister){
          _otpBloc.processLogin(
              mobile:
              widget.user.cutomerMobile,
              serverOTP:
              _otpBloc.user.otp.toString());
        }else{
          _otpBloc.processRegister(
              mobile:
              widget.user.cutomerMobile,
              serverOTP:
              _otpBloc.user.otp.toString(),
              name: widget.user.customerName,
              email: widget.user.customerEmail);
        }
    }
  }

  Widget getBottomWidget() {
    TextStyle defaultStyle = AppTextStyle.h5TitleTextStyle(
        color: AppColor.textColor(context), fontWeight: FontWeight.w400);
    TextStyle linkStyle = AppTextStyle.h5TitleTextStyle(
        color: AppColor.accentColor,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline);
    return Container(
        color: Color(0xFFFFFDFB),
        height: 56,
        alignment: Alignment.center,
        child: RichText(
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
