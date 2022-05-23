import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/inputs/textinput_edittext_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/bloc/fillDetails.bloc.dart';
import 'package:edge_alert/edge_alert.dart';

class FillDetailsPage extends StatefulWidget {
  FillDetailsPage({Key key}) : super(key: key);

  @override
  _FillDetailsPageState createState() => _FillDetailsPageState();
}

class _FillDetailsPageState extends State<FillDetailsPage> {
  //SearchVendorsBloc instance
  FillDetailsBloc _fillDetailsBloc=FillDetailsBloc();
  @override
  void initState() {
    super.initState();
    _fillDetailsBloc.initBloc();
    _fillDetailsBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _fillDetailsBloc.dialogData.title,
          description: _fillDetailsBloc.dialogData.body,
          backgroundColor: AppColor.accentColor,
          icon: _fillDetailsBloc.dialogData.iconData,
        );
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _fillDetailsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) =>
    AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
    statusBarColor: AppColor.newprimaryColor,
    ),
    child:
            Scaffold(
            body:
            SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                            child: LeadingAppBar(
                              title: "Details",
                              subTitle: "",
                            ),
                          ),
            Expanded(child:Container(
            padding: AppPaddings.defaultPadding(),
            child:CustomScrollView(slivers: [
              SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(children: <Widget>[
                      Text(
                        'Please fill appointment person details',
                        style: AppTextStyle.h4TitleTextStyle(
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
                    stream: _fillDetailsBloc.validName,
                    builder: (context, snapshot) {
                      return  CustomHintLableTextFormField(
                        isFixedHeight: false,
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        labelText:"Name",
                        keyboardType: TextInputType.name,
                        textStyle: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context)
                        ),
                        textInputAction: TextInputAction.next,
                        textEditingController: _fillDetailsBloc.nameTEC,
                        errorText: snapshot.error,
                        onChanged: _fillDetailsBloc.validateName,
                      );
                    },
                  )),
              SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
              SliverToBoxAdapter(
                  child:StreamBuilder<bool>(
                    stream: _fillDetailsBloc.validmobile,
                    builder: (context, snapshot) {
                      return  CustomHintLableTextFormField(
                          isFixedHeight: false,
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          labelText: "Contact Number",
                          keyboardType: TextInputType.phone,
                          textStyle: AppTextStyle.h4TitleTextStyle(
                              color: AppColor.textColor(context)
                          ),
                          textInputAction: TextInputAction.next,
                          textEditingController: _fillDetailsBloc.mobileTEC,
                          errorText: snapshot.error,
                          onChanged: _fillDetailsBloc.validateMobile
                      );
                    },
                  )),
              SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
              SliverToBoxAdapter(
                  child:StreamBuilder<bool>(
                    stream: _fillDetailsBloc.validEmailAddress,
                    builder: (context, snapshot) {
                      return  CustomHintLableTextFormField(
                        isFixedHeight: false,
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        textStyle: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context)
                        ),
                        textInputAction: TextInputAction.next,
                        textEditingController: _fillDetailsBloc.emailAddressTEC,
                        errorText: snapshot.error,
                        onChanged: _fillDetailsBloc.validateEmailAddress,
                       // suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 12,color: Colors.black,),

                      );
                    },
                  )),
              SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
              SliverToBoxAdapter(
                  child:StreamBuilder<bool>(
                    stream: _fillDetailsBloc.validproduct,
                    builder: (context, snapshot) {
                      return  CustomHintLableTextFormField(
                          isFixedHeight: false,
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          labelText: "Product",
                          keyboardType: TextInputType.text,
                          textStyle: AppTextStyle.h4TitleTextStyle(
                              color: AppColor.textColor(context)
                          ),
                          textInputAction: TextInputAction.next,
                          textEditingController: _fillDetailsBloc.productTEC,
                          //errorText: snapshot.error,
                          //onChanged: _fillDetailsBloc.validateMobileNumber
                      );
                    },
                  )),
              SliverToBoxAdapter(child:UiSpacer.verticalSpace(space: 40)),

              SliverToBoxAdapter(
                  child:StreamBuilder<UiState>(
                stream: _fillDetailsBloc.uiState,
                builder: (context, snapshot) {
                  final uiState = snapshot.data;

                  return CustomButton(
                    padding: AppPaddings.mediumButtonPadding(),
                    color: AppColor.accentColor,
                    onPressed: uiState != UiState.loading
                        ?  (){_fillDetailsBloc.processAppointmnetBooking(context: context);}
                        : null,
                    child: uiState != UiState.loading
                        ? Text(
                      "continue",
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

              SliverToBoxAdapter(child:UiSpacer.verticalSpace()),

            ]))),


                  ]))

        ),
        ));
  }
}
