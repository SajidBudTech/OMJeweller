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
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/bloc/register.bloc.dart';
import 'package:flutter_om_jeweller/data/models/user_data.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key,this.user}) : super(key: key);

  User user;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //login bloc
  RegisterBloc _registerBloc = RegisterBloc();
  //email focus node
  final emailFocusNode = new FocusNode();
  //password focus node
  final passwordFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

    //listen to the need to show a dialog alert or a normal snackbar alert type
    _registerBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _registerBloc.dialogData.title,
          description: _registerBloc.dialogData.body,
          backgroundColor: _registerBloc.dialogData.backgroundColor,
          icon: _registerBloc.dialogData.iconData,
        );
      }
    });

    //listen to state of the ui
    _registerBloc.uiState.listen((uiState) async {
      if (uiState == UiState.redirect) {
        // await Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, AppRoutes.verifyOTPRoute,arguments: _registerBloc.user);
      }
    });
  }

  @override
  void dispose() {
    _registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

   /*   Container(
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
    child:
        Scaffold(
          primary: false,
          appBar: EmptyAppBar(),
          extendBodyBehindAppBar: true,
          backgroundColor: AppColor.appBackground(context),
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
                            UiSpacer.verticalSpace(space:80),
                            Text(
                              AuthStrings.registerTitle,
                              style: AppTextStyle.h1TitleTextStyle(
                                color: AppColor.textColor(context),
                              ),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            ),
                            UiSpacer.verticalSpace(space: 6),
                            Text(
                                AuthStrings.registerSubTitle,
                              style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                                fontWeight: FontWeight.w400
                              ),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            ),
                            UiSpacer.verticalSpace(space: 50),
                            StreamBuilder<bool>(
                              stream: _registerBloc.validName,
                              builder: (context, snapshot) {
                                return CustomTextFormField(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: 0,
                                  textStyle: AppTextStyle.h4TitleTextStyle(fontWeight: FontWeight.w400),
                                  hintTextStyle: AppTextStyle.h4TitleTextStyle(fontWeight: FontWeight.w300),
                                  hintText: AuthStrings.registerName,
                                  labelText: AuthStrings.registerName,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  textEditingController: _registerBloc.nameTEC,
                                  errorText: snapshot.error,
                                  //onChanged: _registerBloc.validLastName,
                                );
                              },
                            ),
                            UiSpacer.verticalSpace(space: 50),
                            StreamBuilder<bool>(
                              stream: _registerBloc.validEmailAddress,
                              builder: (context, snapshot) {
                                return CustomTextFormField(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: 0,
                                  hintText: AuthStrings.registerEmail,
                                  labelText: AuthStrings.registerEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  textEditingController: _registerBloc.emailAddressTEC,
                                  errorText: snapshot.error,
                                  onChanged: _registerBloc.validateEmailAddress,
                                );
                              },
                            ),
                            UiSpacer.verticalSpace(space: 65),
                            //login button
                            //listen to the uistate to know the appropriated state to put the login button
                            StreamBuilder<UiState>(
                              stream: _registerBloc.uiState,
                              builder: (context, snapshot) {
                                final uiState = snapshot.data;

                                return CustomButton(
                                  padding: AppPaddings.mediumButtonPadding(),
                                  color: AppColor.accentColor,
                                  onPressed: uiState != UiState.loading
                                      ?  (){

                                    /*Navigator.pushNamed(
                                           context,
                                          AppRoutes.homeRoute,
                                       );*/
                                    _registerBloc.processSendOTP(mobile: widget.user.cutomerMobile);
                                  }
                                      : null,
                                  child: uiState != UiState.loading
                                      ? Text(
                                    AuthStrings.oregisterButtonTitle,
                                    style: AppTextStyle.h4TitleTextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection:
                                    AppTextDirection.defaultDirection,
                                  )
                                      : PlatformCircularProgressIndicator(),
                                );
                              },
                            ),
                          ])))
                ],
              ),
            ],
          ),
        ));
    //);
  }
}
