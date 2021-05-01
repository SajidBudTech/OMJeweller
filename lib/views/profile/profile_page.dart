import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/auth.string.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/inputs/textinput_edittext_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //SearchVendorsBloc instance
  final ProductSearchBloc _searchVendorsBloc = ProductSearchBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();
  LoginBloc _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _searchBarFocusNode.requestFocus();
    _searchVendorsBloc.initBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _searchVendorsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) =>
              Scaffold(
                body: Container(
                    padding: AppPaddings.defaultPadding(),
/*                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),*/
                    child: CustomScrollView(slivers: [
                      SliverToBoxAdapter(
                          child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(children: <Widget>[
                          Text(
                            'Personal Details',
                            style: AppTextStyle.h3TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ),
                          /*Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                FlutterIcons.edit_ant,
                                color: AppColor.accentColor,
                              ))*/
                        ]),
                      )),

                  SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                  SliverToBoxAdapter(
                      child:StreamBuilder<bool>(
                    stream: _loginBloc.validMobileNumber,
                    builder: (context, snapshot) {
                      return  CustomHintLableTextFormField(
                        isFixedHeight: false,
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        labelText:"Phone Number",
                        keyboardType: TextInputType.phone,
                        textStyle: AppTextStyle.h4TitleTextStyle(
                          color: AppColor.textColor(context)
                        ),
                        textInputAction: TextInputAction.next,
                        textEditingController: _loginBloc.mobileNumberTEC,
                        errorText: snapshot.error,
                        onChanged: _loginBloc.validateMobileNumber,
                      );
                    },
                  )),
                      SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                      SliverToBoxAdapter(
                          child:StreamBuilder<bool>(
                            stream: _loginBloc.validMobileNumber,
                            builder: (context, snapshot) {
                              return  CustomHintLableTextFormField(
                                isFixedHeight: false,
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                labelText: "Name",
                                keyboardType: TextInputType.phone,
                                textStyle: AppTextStyle.h4TitleTextStyle(
                                    color: AppColor.textColor(context)
                                ),
                                textInputAction: TextInputAction.next,
                                textEditingController: _loginBloc.mobileNumberTEC,
                                errorText: snapshot.error,
                                onChanged: _loginBloc.validateMobileNumber
                              );
                            },
                          )),
                      SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                      SliverToBoxAdapter(
                          child:StreamBuilder<bool>(
                            stream: _loginBloc.validMobileNumber,
                            builder: (context, snapshot) {
                              return  CustomHintLableTextFormField(
                                isFixedHeight: false,
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                labelText: "Gender",
                                keyboardType: TextInputType.emailAddress,
                                textStyle: AppTextStyle.h4TitleTextStyle(
                                    color: AppColor.textColor(context)
                                ),
                                textInputAction: TextInputAction.next,
                                textEditingController: _loginBloc.passwordTEC,
                                errorText: snapshot.error,
                                onChanged: _loginBloc.validateEmailAddress,
                                suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 12,color: Colors.black,),

                              );
                            },
                          )),
                      SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                      SliverToBoxAdapter(
                          child:StreamBuilder<bool>(
                            stream: _loginBloc.validMobileNumber,
                            builder: (context, snapshot) {
                              return  CustomHintLableTextFormField(
                                  isFixedHeight: false,
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  labelText: "Email",
                                  keyboardType: TextInputType.phone,
                                  textStyle: AppTextStyle.h4TitleTextStyle(
                                      color: AppColor.textColor(context)
                                  ),
                                  textInputAction: TextInputAction.next,
                                  textEditingController: _loginBloc.mobileNumberTEC,
                                  errorText: snapshot.error,
                                  onChanged: _loginBloc.validateMobileNumber
                              );
                            },
                          )),
                      SliverToBoxAdapter(child:UiSpacer.verticalSpace()),

                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [

                        Expanded(child:StreamBuilder<bool>(
                        stream: _loginBloc.validMobileNumber,
                          builder: (context, snapshot) {
                            return  CustomHintLableTextFormField(
                              isFixedHeight: false,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              labelText: "Date Of Birth",
                              keyboardType: TextInputType.emailAddress,
                              textStyle: AppTextStyle.h4TitleTextStyle(
                                  color: AppColor.textColor(context)
                              ),
                              textInputAction: TextInputAction.next,
                              textEditingController: _loginBloc.passwordTEC,
                              errorText: snapshot.error,
                              onChanged: _loginBloc.validateEmailAddress,
                              suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 10,color: Colors.black,),

                            );
                          })),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child:StreamBuilder<bool>(
                                stream: _loginBloc.validMobileNumber,
                                builder: (context, snapshot) {
                                  return  CustomHintLableTextFormField(
                                    isFixedHeight: false,
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    labelText: "Anniversary",
                                    keyboardType: TextInputType.emailAddress,
                                    textStyle: AppTextStyle.h4TitleTextStyle(
                                        color: AppColor.textColor(context)
                                    ),
                                    textInputAction: TextInputAction.next,
                                    textEditingController: _loginBloc.passwordTEC,
                                    errorText: snapshot.error,
                                    onChanged: _loginBloc.validateEmailAddress,
                                    suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 10,color: Colors.black,),

                                  );
                                },
                              )
                            )


                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child:UiSpacer.verticalSpace(space: 40)),
                      SliverToBoxAdapter(
                          child:StreamBuilder<UiState>(
                            stream: _loginBloc.uiState,
                            builder: (context, snapshot) {
                              final uiState = snapshot.data;

                              return CustomButton(
                                padding: AppPaddings.mediumButtonPadding(),
                                color: AppColor.accentColor,
                                onPressed: uiState != UiState.loading
                                    ?  (){

                                    }
                                    : null,
                                child: uiState != UiState.loading
                                    ? Text(
                                  "Save Details",
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
                          )),
                      /*SliverToBoxAdapter(
                          child:StreamBuilder<bool>(
                            stream: _loginBloc.validMobileNumber,
                            builder: (context, snapshot) {
                              return  CustomHintLableTextFormField(
                                isFixedHeight: false,
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                labelText: "Date Of Birth",
                                keyboardType: TextInputType.emailAddress,
                                textStyle: AppTextStyle.h4TitleTextStyle(
                                    color: AppColor.textColor(context)
                                ),
                                textInputAction: TextInputAction.next,
                                textEditingController: _loginBloc.passwordTEC,
                                errorText: snapshot.error,
                                onChanged: _loginBloc.validateEmailAddress,
                                suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 12,color: Colors.black,),

                              );
                            },
                          )),
                      SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                      SliverToBoxAdapter(
                          child:StreamBuilder<bool>(
                            stream: _loginBloc.validMobileNumber,
                            builder: (context, snapshot) {
                              return  CustomHintLableTextFormField(
                                isFixedHeight: false,
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                labelText: "Anniversary",
                                keyboardType: TextInputType.emailAddress,
                                textStyle: AppTextStyle.h4TitleTextStyle(
                                    color: AppColor.textColor(context)
                                ),
                                textInputAction: TextInputAction.next,
                                textEditingController: _loginBloc.passwordTEC,
                                errorText: snapshot.error,
                                onChanged: _loginBloc.validateEmailAddress,
                                suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 12,color: Colors.black,),

                              );
                            },
                          )),*/
                      SliverToBoxAdapter(child:UiSpacer.verticalSpace()),

                    ])),
              ),
            );
    //);
  }
}
