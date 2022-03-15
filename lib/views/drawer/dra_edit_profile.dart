import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/profile.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/auth.string.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/expandable/expandable_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/inputs/textinput_edittext_textfield.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/state/unauthenticated.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class DrawerEditProfilePage extends StatefulWidget {
  DrawerEditProfilePage({Key key}) : super(key: key);

  @override
  _DrawerEditProfilePageState createState() => _DrawerEditProfilePageState();
}

class _DrawerEditProfilePageState extends State<DrawerEditProfilePage> {
  //SearchVendorsBloc instance
  EditProfileBloc _profileBloc = EditProfileBloc();
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  String SELECTED_GENDER="";

  DateTime _datetimeDOB;
  DateTime _datetimeAnniversary;

  @override
  void initState() {
    super.initState();
    _profileBloc.initBloc();
    final dob=AuthBloc.getUserDOB();
    if(dob!=""){
      _datetimeDOB=DateTime.parse(dob);
    }
    final anniver=AuthBloc.getUserAnniversary();
    if(anniver!=""){
      _datetimeAnniversary=DateTime.parse(anniver);
    }
    final geneder=AuthBloc.getUserGender();
    if(geneder!=""){
      SELECTED_GENDER=geneder;
    }

    _profileBloc.showDialogAlert.listen((show) {
      //when asked to show an alert
      /* if (show) {
          CustomDialog.showAlertDialog(
            context,
            _editProfileBloc.dialogData,
            isDismissible: _editProfileBloc.dialogData.isDismissible,
          );
        } else {
          CustomDialog.dismissDialog(context);
        }*/
      EdgeAlert.show(
        context,
        title: _profileBloc.dialogData.title,
        description: _profileBloc.dialogData.body,
        backgroundColor: AppColor.accentColor,
        icon: FlutterIcons.profile_ant,
      );
    },
    );
  }

  @override
  void dispose() {
    super.dispose();
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
                            title: "Edit Profile",
                            subTitle: "",
                          ),
                        ),
                        Expanded(
                            child: Container(
                                color: Colors.white,
                                padding: AppPaddings.defaultPadding(),
                                child: CustomScrollView(slivers: [

                                  SliverToBoxAdapter(
                                      child: Container(
                                          child: Text(
                                            'Personal Details',
                                            style: AppTextStyle
                                                .h3TitleTextStyle(
                                                color: AppColor.textColor(
                                                    context),
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.start,
                                            textDirection: AppTextDirection
                                                .defaultDirection,
                                          ))),
                                  SliverToBoxAdapter(child: UiSpacer
                                      .verticalSpace()),
                                  SliverToBoxAdapter(
                                      child: StreamBuilder<bool>(
                                        stream: _profileBloc.validmobile,
                                        builder: (context, snapshot) {
                                          return CustomHintLableTextFormField(
                                            isFixedHeight: false,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            labelText: "Phone Number",
                                            labelTextStyle: AppTextStyle.h5TitleTextStyle(
                                                color: AppColor.textColor(context)
                                            ),
                                            isReadOnly: true,
                                            keyboardType: TextInputType.phone,
                                            textStyle: AppTextStyle
                                                .h4TitleTextStyle(
                                                color: AppColor.textColor(
                                                    context)
                                            ),
                                            textInputAction: TextInputAction
                                                .next,
                                            textEditingController: _profileBloc
                                                .mobileTEC,
                                            errorText: snapshot.error,
                                            onChanged: _profileBloc
                                                .validateMobile,
                                          );
                                        },
                                      )),
                                  SliverToBoxAdapter(child: UiSpacer
                                      .verticalSpace()),
                                  SliverToBoxAdapter(
                                      child: StreamBuilder<bool>(
                                        stream: _profileBloc.validName,
                                        builder: (context, snapshot) {
                                          return CustomHintLableTextFormField(
                                              isFixedHeight: false,
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              labelText: "Name",
                                              labelTextStyle: AppTextStyle.h5TitleTextStyle(
                                                  color: AppColor.textColor(context)
                                              ),
                                              keyboardType: TextInputType.name,
                                              textStyle: AppTextStyle
                                                  .h4TitleTextStyle(
                                                  color: AppColor.textColor(
                                                      context)
                                              ),
                                              textInputAction: TextInputAction
                                                  .next,
                                              textEditingController: _profileBloc
                                                  .nameTEC,
                                              errorText: snapshot.error,
                                              onChanged: _profileBloc
                                                  .validateName
                                          );
                                        },
                                      )),
                                  SliverToBoxAdapter(child: UiSpacer
                                      .verticalSpace()),
                                  SliverToBoxAdapter(
                                      child: Column(
                                          children: [
                                            Container(
                                                child: AppExpansionTile(
                                                  key: expansionTile,
                                                  contentPadding: EdgeInsets
                                                      .all(0),
                                                  title: Text(
                                                    SELECTED_GENDER == ""
                                                        ? "Gender"
                                                        : SELECTED_GENDER,
                                                    style: AppTextStyle
                                                        .h4TitleTextStyle(
                                                      fontWeight: SELECTED_GENDER ==
                                                          ""
                                                          ? FontWeight.w300
                                                          : FontWeight.w500,
                                                      color: SELECTED_GENDER ==
                                                          "" ? AppColor
                                                          .hintTextColor(
                                                          context) : AppColor
                                                          .textColor(context),
                                                    ),
                                                    //overflow: TextOverflow.ellipsis,
                                                    textDirection: AppTextDirection
                                                        .defaultDirection,
                                                  ),
                                                  children: [
                                                    new ListTile(
                                                      title: Text(
                                                        'Male',
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
                                                          SELECTED_GENDER =
                                                          "Male";
                                                          expansionTile
                                                              .currentState
                                                              .collapse();
                                                        });
                                                      },
                                                      contentPadding: EdgeInsets
                                                          .all(0),
                                                    ),
                                                    new ListTile(
                                                      title: Text(
                                                        'Female',
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
                                                          SELECTED_GENDER =
                                                          "Female";
                                                          expansionTile
                                                              .currentState
                                                              .collapse();
                                                        });
                                                      },
                                                      contentPadding: EdgeInsets
                                                          .all(0),
                                                    ),
                                                    new ListTile(
                                                      title: Text(
                                                        'TransGender',
                                                        style: AppTextStyle.h5TitleTextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColor.textColor(context),
                                                        ),
                                                        //overflow: TextOverflow.ellipsis,
                                                        textDirection: AppTextDirection.defaultDirection,
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          SELECTED_GENDER = "TransGender";
                                                          expansionTile.currentState.collapse();
                                                        });
                                                      },
                                                      contentPadding: EdgeInsets.all(0),
                                                    ),
                                                    new ListTile(
                                                      title: Text(
                                                        'Rather Not Say',
                                                        style: AppTextStyle.h5TitleTextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColor.textColor(context),
                                                        ),
                                                        //overflow: TextOverflow.ellipsis,
                                                        textDirection: AppTextDirection.defaultDirection,
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          SELECTED_GENDER = "Rather Not Say";
                                                          expansionTile.currentState.collapse();
                                                        });
                                                      },
                                                      contentPadding: EdgeInsets.all(0),
                                                    ),
                                                  ],
                                                  rotateWidget: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Color(0xFF2C2C2C),
                                                    size: 18,
                                                  ),
                                                )),
                                            UiSpacer.divider(thickness: 0.5,
                                                color: AppColor.hintTextColor(
                                                    context))
                                          ])
                                  ),
                                  SliverToBoxAdapter(child: UiSpacer
                                      .verticalSpace()),
                                  SliverToBoxAdapter(
                                      child: StreamBuilder<bool>(
                                        stream: _profileBloc.validEmailAddress,
                                        builder: (context, snapshot) {
                                          return CustomHintLableTextFormField(
                                              isFixedHeight: false,
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              labelText: "Email",
                                              labelTextStyle: AppTextStyle.h5TitleTextStyle(
                                                  color: AppColor.textColor(context)
                                              ),
                                              keyboardType: TextInputType
                                                  .emailAddress,
                                              textStyle: AppTextStyle
                                                  .h4TitleTextStyle(
                                                  color: AppColor.textColor(
                                                      context)
                                              ),
                                              textInputAction: TextInputAction
                                                  .next,
                                              textEditingController: _profileBloc
                                                  .emailAddressTEC,
                                              errorText: snapshot.error,
                                              onChanged: _profileBloc
                                                  .validateEmailAddress
                                          );
                                        },
                                      )),
                                  SliverToBoxAdapter(child: UiSpacer
                                      .verticalSpace()),

                                  SliverToBoxAdapter(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [

                                        Expanded(child: getDOBWidget()
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                            child: getAnniversaryWidget()
                                        )

                                      ],
                                    ),
                                  ),
                                  SliverToBoxAdapter(child: UiSpacer
                                      .verticalSpace(space: 40)),
                                  SliverToBoxAdapter(
                                      child: StreamBuilder<UiState>(
                                        stream: _profileBloc.uiState,
                                        builder: (context, snapshot) {
                                          final uiState = snapshot.data;

                                          return CustomButton(
                                            padding: AppPaddings
                                                .mediumButtonPadding(),
                                            color: AppColor.accentColor,
                                            onPressed: uiState !=
                                                UiState.loading
                                                ? () {
                                              _profileBloc.processAccountUpdate(
                                                  dob: _datetimeDOB == null
                                                      ? null
                                                      : DateFormat('yyyy-MM-dd')
                                                      .format(_datetimeDOB),
                                                  anniver: _datetimeAnniversary ==
                                                      null ? null : DateFormat(
                                                      'yyyy-MM-dd').format(
                                                      _datetimeAnniversary),
                                                  gender: SELECTED_GENDER);
                                            }
                                                : null,
                                            child: uiState != UiState.loading
                                                ? Text(
                                              "Save Details",
                                              style: AppTextStyle
                                                  .h4TitleTextStyle(
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
                                  SliverToBoxAdapter(child: UiSpacer
                                      .verticalSpace()),


                                ]))),
                      ]),
                ),
              )));
    }else{
      pageBody=Scaffold(body: UnauthenticatedPage());
    }
    return pageBody;
    //);
  }


  Widget getDOBWidget() {
    return InkWell(
        onTap: () => showDatePicker(
            context: context,
            initialDate:
            _datetimeDOB == null ? DateTime.now() : _datetimeDOB,
            firstDate: DateTime(1901, 01, 01),
            lastDate: DateTime.now())
            .then((date) {
          if (date != null) {
            setState(() {
              _datetimeDOB = date;
            });
          }
        }),
        child: Column(children: [
          Container(
            height: AppSizes.inputHeight,
            padding: EdgeInsets.fromLTRB(0, 5, 20, 5),
            child: Row(
              children: [
                Expanded(
                    flex: 9,
                    child: Text(
                      _datetimeDOB == null
                          ? AuthStrings.registerDOB
                          : DateFormat('dd/MM/yyyy').format(_datetimeDOB),
                      style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.textColor(context),
                      ),
                      textDirection: AppTextDirection.defaultDirection,
                    )),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF2C2C2C),
                      size: 18,
                    ),
                    onPressed: () => showDatePicker(
                        context: context,
                        initialDate: _datetimeDOB == null
                            ? DateTime.now()
                            : _datetimeDOB,
                        firstDate: DateTime(1901,01,01),
                        lastDate: DateTime.now())
                        .then((date) {
                      if (date != null) {
                        setState(() {
                          _datetimeDOB = date;
                        });
                      }
                    }),
                  ),
                )
              ],
            ),
          ),
          UiSpacer.divider(
              thickness: 0.5, color: AppColor.hintTextColor(context))
        ]));
  }


  Widget getAnniversaryWidget() {
    return InkWell(
        onTap: () => showDatePicker(
            context: context,
            initialDate: _datetimeAnniversary == null
                ? DateTime.now()
                : _datetimeAnniversary,
            firstDate: DateTime(1921,01,01),
            lastDate: DateTime.now())
            .then((date) {
          if (date != null) {
            setState(() {
              _datetimeAnniversary = date;
            });
          }
        }),
        child: Column(children: [
          Container(
            height: AppSizes.inputHeight,
            padding: EdgeInsets.fromLTRB(0, 5, 20, 5),
            child: Row(
              children: [
                Expanded(
                    flex: 9,
                    child: Text(
                      _datetimeAnniversary == null
                          ? AuthStrings.anniversaryDate
                          : DateFormat('dd/MM/yyyy')
                          .format(_datetimeAnniversary),
                      style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.textColor(context),
                      ),
                      textDirection: AppTextDirection.defaultDirection,
                    )),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF2C2C2C),
                      size: 18,
                    ),
                    onPressed: () => showDatePicker(
                        context: context,
                        initialDate: _datetimeAnniversary == null
                            ? DateTime.now()
                            : _datetimeAnniversary,
                        firstDate: DateTime(1921,01,01),
                        lastDate: DateTime.now())
                        .then((date) {
                      if (date != null) {
                        setState(() {
                          _datetimeAnniversary = date;
                        });
                      }
                    }),
                  ),
                )
              ],
            ),
          ),
          UiSpacer.divider(
              thickness: 0.5, color: AppColor.hintTextColor(context))
        ]));
  }
}
