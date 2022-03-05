import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
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

import 'package:flutter_om_jeweller/widgets/inputs/custom_comment_text_form.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/expandable/expandable_listview_item.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:flutter_om_jeweller/bloc/appointment.bloc.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter_om_jeweller/widgets/state/unauthenticated.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  //SearchVendorsBloc instance
  AppointmentBloc _appointmentBloc = AppointmentBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();


  String SELECTED_ITEM="";
  @override
  void initState() {
    super.initState();
    SELECTED_ITEM="";

    _appointmentBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _appointmentBloc.dialogData.title,
          description: _appointmentBloc.dialogData.body,
          backgroundColor: _appointmentBloc.dialogData.backgroundColor,
          icon: _appointmentBloc.dialogData.iconData,
        );
        setState(() {
          SELECTED_ITEM="";
          _appointmentBloc.shareFeedbackTEC.text="";
          _activebutton(SELECTED_ITEM,_appointmentBloc.shareFeedbackTEC.text);
        });
      }else{
        EdgeAlert.show(
          context,
          title: _appointmentBloc.dialogData.title,
          description: _appointmentBloc.dialogData.body,
          backgroundColor: _appointmentBloc.dialogData.backgroundColor,
          icon: _appointmentBloc.dialogData.iconData,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _appointmentBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget pageBody;
    if (AuthBloc.authenticated()) {
      pageBody = AnnotatedRegion<
          SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: AppColor.newprimaryColor,
          ),
          child: Scaffold(
            // backgroundColor: AppColor.newprimaryColor,
            //extendBodyBehindAppBar: true,
              backgroundColor: AppColor.newprimaryColor,
              body: Container(
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: LeadingAppBar(
                            title: "Feedback & Suggestions",
                            subTitle: "",
                          ),
                        ),
                        Expanded(
                            child: Container(
                                color: Colors.white,
                                child: CustomScrollView(slivers: [
                                  /* SliverToBoxAdapter(
                                     child: Container(
                                       height: 12,
                                       color: Colors.white,
                                     ),
                                    ),*/
                                  SliverToBoxAdapter(
                                    child: Container(
                                        padding: AppPaddings.defaultPadding(),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Wether it is about our products or our app or you just have some ideas, we would love to hear your feedback and suggestions",
                                          style:
                                          AppTextStyle.h5TitleTextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.textColor(
                                                context),
                                          ),
                                          //overflow: TextOverflow.ellipsis,
                                          textDirection: AppTextDirection
                                              .defaultDirection,
                                        )),
                                  ),
                                  SliverToBoxAdapter(
                                      child: Container(
                                        //padding: EdgeInsets.only(left: 20,right: 20),
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFFD4D4D4),
                                                width: 1),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                          child: AppExpansionTile(
                                            key: expansionTile,
                                            title: Text(
                                              SELECTED_ITEM == ""
                                                  ? "Select a Category"
                                                  : SELECTED_ITEM,
                                              style: AppTextStyle
                                                  .h4TitleTextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: SELECTED_ITEM == ""
                                                    ? AppColor.hintTextColor(
                                                    context)
                                                    : AppColor.textColor(
                                                    context),
                                              ),
                                              //overflow: TextOverflow.ellipsis,
                                              textDirection: AppTextDirection
                                                  .defaultDirection,
                                            ),
                                            children: [
                                              new ListTile(
                                                title: Text(
                                                  'Product & Quality',
                                                  style: AppTextStyle
                                                      .h5TitleTextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor
                                                        .textColor(context),
                                                  ),
                                                  //overflow: TextOverflow.ellipsis,
                                                  textDirection:
                                                  AppTextDirection
                                                      .defaultDirection,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    SELECTED_ITEM =
                                                    "Product & Quality";
                                                    expansionTile.currentState
                                                        .collapse();
                                                    _activebutton(SELECTED_ITEM,
                                                        _appointmentBloc
                                                            .shareFeedbackTEC
                                                            .text);
                                                  });
                                                },
                                              ),
                                              new ListTile(
                                                title: Text(
                                                  'Designs',
                                                  style: AppTextStyle
                                                      .h5TitleTextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: AppColor
                                                        .textColor(
                                                        context),
                                                  ),
                                                  //overflow: TextOverflow.ellipsis,
                                                  textDirection:
                                                  AppTextDirection
                                                      .defaultDirection,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    SELECTED_ITEM = "Designs";
                                                    expansionTile.currentState
                                                        .collapse();
                                                    _activebutton(SELECTED_ITEM,
                                                        _appointmentBloc
                                                            .shareFeedbackTEC
                                                            .text);
                                                  });
                                                },
                                              ),
                                              new ListTile(
                                                title: Text(
                                                  'App & Website',
                                                  style: AppTextStyle
                                                      .h5TitleTextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: AppColor
                                                        .textColor(
                                                        context),
                                                  ),
                                                  //overflow: TextOverflow.ellipsis,
                                                  textDirection:
                                                  AppTextDirection
                                                      .defaultDirection,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    SELECTED_ITEM =
                                                    "App & Website";
                                                    expansionTile.currentState
                                                        .collapse();
                                                    _activebutton(SELECTED_ITEM,
                                                        _appointmentBloc
                                                            .shareFeedbackTEC
                                                            .text);
                                                  });
                                                },
                                              ),
                                              new ListTile(
                                                title: Text(
                                                  'General',
                                                  style: AppTextStyle
                                                      .h5TitleTextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: AppColor
                                                        .textColor(
                                                        context),
                                                  ),
                                                  //overflow: TextOverflow.ellipsis,
                                                  textDirection:
                                                  AppTextDirection
                                                      .defaultDirection,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    SELECTED_ITEM = "General";
                                                    expansionTile.currentState
                                                        .collapse();
                                                    _activebutton(SELECTED_ITEM,
                                                        _appointmentBloc
                                                            .shareFeedbackTEC
                                                            .text);
                                                  });
                                                },
                                              ),
                                            ],
                                            rotateWidget: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xFF2C2C2C),
                                              size: 20,
                                            ),
                                          ))),
                                  SliverToBoxAdapter(
                                    child: UiSpacer.verticalSpace(),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Container(
                                        height: 239,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFFD4D4D4),
                                              width: 1),
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        child: StreamBuilder<bool>(
                                          stream: _appointmentBloc
                                              .validFeedBack,
                                          builder: (context, snapshot) {
                                            return CustomCommentTextFormField(
                                              left: 20,
                                              right: 20,
                                              bottom: 0,
                                              top: 0,
                                              isFixedHeight: false,
                                              textStyle: AppTextStyle
                                                  .h4TitleTextStyle(
                                                  fontWeight: FontWeight.w400),
                                              hintTextStyle: AppTextStyle
                                                  .h4TitleTextStyle(
                                                  color: Color(0xFFA3A3A3),
                                                  fontWeight: FontWeight.w300),
                                              hintText: "Share your feedback here",
                                              keyboardType: TextInputType
                                                  .multiline,
                                              textInputAction: TextInputAction
                                                  .next,
                                              textEditingController: _appointmentBloc
                                                  .shareFeedbackTEC,
                                              errorText: snapshot.error,
                                              onChanged: (value) {
                                                _activebutton(
                                                    SELECTED_ITEM, value);
                                              },
                                            );
                                          },
                                        )),
                                  ),
                                  SliverToBoxAdapter(
                                    child: UiSpacer.verticalSpace(space: 46),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: StreamBuilder<UiState>(
                                          stream: _appointmentBloc.uiState,
                                          builder: (context, snapshot) {
                                            final uiState = snapshot.data;

                                            return CustomButton(
                                              padding: AppPaddings
                                                  .mediumButtonPadding(),
                                              color: AppColor.accentColor,
                                              disabledColor: AppColor
                                                  .disableColor,
                                              onPressed: _appointmentBloc
                                                  .feedBackButtonStatus
                                                  ? () {
                                                if (SELECTED_ITEM != "") {
                                                  _appointmentBloc
                                                      .submitFeedBack(
                                                      category: SELECTED_ITEM);
                                                } else {
                                                  EdgeAlert.show(
                                                    context,
                                                    title: "Please select type of category",
                                                    description: "Select category for which you want to submit your feedback.",
                                                    backgroundColor: AppColor
                                                        .accentColor,
                                                    icon: FlutterIcons
                                                        .error_mdi,
                                                  );
                                                }
                                              }
                                                  : null,
                                              child: uiState != UiState.loading
                                                  ? Text(
                                                "Submit Feedback",
                                                style: AppTextStyle
                                                    .h4TitleTextStyle(
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.start,
                                                textDirection:
                                                AppTextDirection
                                                    .defaultDirection,
                                              )
                                                  : PlatformCircularProgressIndicator(),
                                            );
                                          },
                                        )),
                                  ),
                                  SliverToBoxAdapter(
                                    child: UiSpacer.verticalSpace(space: 18),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "or you can share your feedback on",
                                            style:
                                            AppTextStyle.h5TitleTextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.textColor(
                                                  context),
                                            ),
                                            //overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            textDirection: AppTextDirection
                                                .defaultDirection,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                openEmail();
                                              },
                                              child: Text(
                                                "omjewelllers@gmail.com",
                                                style:
                                                AppTextStyle.h5TitleTextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor
                                                        .accentColor),
                                                //overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                textDirection: AppTextDirection
                                                    .defaultDirection,
                                              ))

                                        ],
                                      ),
                                    ),
                                  )

                                ]))),
                      ]),
                ),
              ))
      );
    }else{
      pageBody=UnauthenticatedPage();
    }
    return pageBody;
  }
  _activebutton(String cat,String desc) async{
    setState(() {
      _appointmentBloc.validateForm(cat,desc);
    });
  }

    openEmail() async{
      const url="mailto:omjewelllers@gmail.com";
      await launch(url);
     /* if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }*/
   }
/*void showSortBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: SortProductPage());
  }

  void showFilterBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: FilterProductPage());
  }*/
}
