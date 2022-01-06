import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/state/unauthenticated.dart';
import 'package:flutter_om_jeweller/widgets/storelocationlist/store_location_content.dart';
import 'package:flutter_om_jeweller/widgets/storelocationlist/store_call_content.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_om_jeweller/bloc/appointment.bloc.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:edge_alert/edge_alert.dart';

class BookAppointmentPage extends StatefulWidget {
  BookAppointmentPage({Key key}) : super(key: key);

  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  //SearchVendorsBloc instance
  final AppointmentBloc _appointmentBloc = AppointmentBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();
  LoginBloc _loginBloc = LoginBloc();

  bool SELECTED_REQUEST_CALL=false;
  bool SELECTED_STORE_VISIT=false;

  @override
  void initState() {
    super.initState();
    _searchBarFocusNode.requestFocus();
    _appointmentBloc.initBloc();
    AppStrings.selectedTypeofvisit="";
    AppStrings.selectedTypeDetails="";
    AppStrings.selectedBookDate="";
    AppStrings.selectedBookTime="";
  }

  @override
  void dispose() {
    super.dispose();
    _appointmentBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget pageBody;

     /*ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.getStoreVisitData(),
        builder: (context, model, child) =>

           *//* Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),
          child:*/
    if (AuthBloc.authenticated()) {
      pageBody = Scaffold(
        body:
        Container(
            padding: AppPaddings.defaultPadding(),
            color: Colors.white,
            /* decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),*/
            child:

            CustomScrollView(slivers: [

              SliverToBoxAdapter(
                child: UiSpacer.verticalSpace(),
              ),
              SliverToBoxAdapter(
                child:
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(bottom: 0),
                    child: Text(
                      'Hi, ' + (_appointmentBloc.userName == null
                          ? ""
                          : _appointmentBloc.userName),
                      style: AppTextStyle.h4TitleTextStyle(
                          color: AppColor.hintTextColor(context),
                          fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.start,
                      textDirection: AppTextDirection.defaultDirection,
                    )),
              ),
              SliverToBoxAdapter(
                child:
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'How would you like to visit?',
                      style: AppTextStyle.h4TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.start,
                      textDirection: AppTextDirection.defaultDirection,
                    )),
              ),
              SliverToBoxAdapter(
                child: UiSpacer.verticalSpace(space: 30),
              ),
              /* SliverToBoxAdapter(
                    child:
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 0),
                        child:Text(
                          'Please select from the below servicies',
                          style: AppTextStyle.h3TitleTextStyle(
                              color: AppColor.hintTextColor(context),
                              fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.start,
                          textDirection: AppTextDirection.defaultDirection,
                        )),
                  ),*/
              SliverToBoxAdapter(
                child: UiSpacer.verticalSpace(),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              SELECTED_STORE_VISIT = true;
                              SELECTED_REQUEST_CALL = false;
                              AppStrings.selectedTypeofvisit = "Store Visit";
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: SELECTED_STORE_VISIT ? AppColor
                                    .accentColor : AppColor.hintTextColor(
                                    context),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [

                                SvgPicture.asset(
                                  'assets/images/store_visit.svg',
                                  width: 34,
                                  height: 34,
                                  color: SELECTED_STORE_VISIT ? AppColor
                                      .accentColor : AppColor.hintTextColor(
                                      context),
                                ),

                                /*  Icon(
                                 FlutterIcons.store_faw5s,
                                 color: SELECTED_STORE?AppColor.accentColor:AppColor.hintTextColor(context),
                                 size: 36,
                               ),*/
                                Padding(padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Store Visit',
                                    style: AppTextStyle.h4TitleTextStyle(
                                        color: SELECTED_STORE_VISIT ? AppColor
                                            .accentColor : AppColor
                                            .hintTextColor(context),
                                        fontWeight: FontWeight.w400
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection: AppTextDirection
                                        .defaultDirection,
                                  ),)
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              SELECTED_STORE_VISIT = false;
                              SELECTED_REQUEST_CALL = true;
                              AppStrings.selectedTypeofvisit = "Request a Call";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: SELECTED_REQUEST_CALL ? AppColor
                                    .accentColor : AppColor.hintTextColor(
                                    context),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/request_call.svg',
                                  width: 34,
                                  height: 34,
                                  color: SELECTED_REQUEST_CALL ? AppColor
                                      .accentColor : AppColor.hintTextColor(
                                      context),
                                ),
                                Padding(padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Request a Call',
                                    style: AppTextStyle.h4TitleTextStyle(
                                        color: SELECTED_REQUEST_CALL ? AppColor
                                            .accentColor : AppColor
                                            .hintTextColor(context),
                                        fontWeight: FontWeight.w400
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection: AppTextDirection
                                        .defaultDirection,
                                  ),)
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SliverToBoxAdapter(child: UiSpacer.verticalSpace(space: 40)),
              SliverToBoxAdapter(child: StreamBuilder<UiState>(
                stream: _appointmentBloc.uiState,
                builder: (context, snapshot) {
                  final uiState = snapshot.data;
                  return Padding(padding: EdgeInsets.only(left: 20, right: 20),

                      child: CustomButton(
                        padding: AppPaddings.mediumButtonPadding(),
                        color: AppColor.accentColor,
                        onPressed: uiState != UiState.loading
                            ? () {
                          if (AppStrings.selectedTypeofvisit != "") {
                            if (SELECTED_STORE_VISIT) {
                              showStoreVisitBottomDialog();
                            } else {
                              showCallBottomDialog();
                            }
                          } else {
                            EdgeAlert.show(
                              context,
                              title: "Please select appointment type!",
                              description: "select one of available appointment option.",
                              backgroundColor: AppColor.accentColor,
                              icon: FlutterIcons.error_mdi,
                            );
                          }
                        }
                            : null,
                        child: uiState != UiState.loading
                            ? Text(
                          "Book an Appointement",
                          style: AppTextStyle.h4TitleTextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                          textDirection:
                          AppTextDirection.defaultDirection,
                        )
                            : PlatformCircularProgressIndicator(),
                      ));
                },
              )),


            ])
        ),
      );
      // );
      //);
    }else{
      pageBody=UnauthenticatedPage();
    }

    return pageBody;
  }

  void showCallBottomDialog() {

    CustomDialog.showCustomBottomSheet(
      context,
      backgroundColor: Colors.white,
      content: StoreCallContent(
        vendor: "",
      ),
    );
  }

  void showStoreVisitBottomDialog() {

    CustomDialog.showCustomBottomSheet(
      context,
      backgroundColor: Colors.white,
      content: StoreLocationContent(
        vendor: "",
      ),
    );
  }
}
