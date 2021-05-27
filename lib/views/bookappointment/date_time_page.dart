import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/table_calender.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_slot_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/available_slot_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/wishlist_list_item.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/search/search_bar.dart';
import 'package:flutter_om_jeweller/widgets/search/search_groupedlist_view.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/data/viewmodels/appoinement.viewmodel.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:intl/intl.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter_om_jeweller/constants/validation_messages.dart';
import 'package:flutter_om_jeweller/data/models/appointment.dart';
import 'package:flutter_om_jeweller/bloc/appointment.bloc.dart';


class SelectDateTimePage extends StatefulWidget {
  SelectDateTimePage({Key key,this.DETAILS_PAGE,this.appointment}) : super(key: key);

  final bool DETAILS_PAGE;
  final Appointment appointment;

  @override
  _SelectDateTimePageState createState() => _SelectDateTimePageState();
}

class _SelectDateTimePageState extends State<SelectDateTimePage> {
  //SearchVendorsBloc instance
  AppointmentBloc _appointmentBloc = AppointmentBloc();

  int SELECTED_POSITION=-1;

  @override
  void initState() {
    super.initState();

    _appointmentBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        Navigator.pushNamed(context, AppRoutes.homeRoute);
      }else{
        EdgeAlert.show(
          context,
          title: _appointmentBloc.dialogData.title,
          description: _appointmentBloc.dialogData.body,
          backgroundColor: AppColor.accentColor,
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
    return ViewModelBuilder<AppointmentViewModel>.reactive(
        viewModelBuilder: () => AppointmentViewModel(),
        onModelReady: (model) => model.fetchAppointmentDetailsDateWise(),
        builder: (context, model, child) =>

           /* Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),
            child:*/
            Scaffold(
                body: Container(
                  color: AppColor.newprimaryColor,
                 /* decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),*/

                  child:SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            //color: AppColor.newprimaryColor,
                            child: LeadingAppBar(
                              title: "Date and Time",
                              subTitle: "",
                            ),
                          ),
                          Expanded(child:Container(
                          color: Colors.white,
                          child:CustomScrollView(slivers: [
                           /* SliverToBoxAdapter(
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: AppPaddings.defaultPadding(),
                                  child:Text(
                                    'Pick Your Date',
                                    style: AppTextStyle.h3TitleTextStyle(
                                        color: AppColor.accentColor,
                                        fontWeight: FontWeight.w600
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection: AppTextDirection.defaultDirection,
                                  )),
                            ),*/
                            SliverToBoxAdapter(
                              child:WeekCalendarPage(
                                endDay: model.endday,
                                onDaySelected: (DateTime selectedDay,List<dynamic> event,List<dynamic> orver){
                                  // if(model.courtLoadingState!=LoadingState.Loading) {
                                  SELECTED_POSITION=-1;
                                  AppStrings.selectedBookTime="";
                                  AppStrings.selectedBookDate = DateFormat("yyyy-MM-dd").format(selectedDay);
                                  model.fetchAppointmentDetailsDateWise();
                                  /* }else{
                                     EdgeAlert.show(
                                       context,
                                       title:"Loading Please wait....",
                                       description: "Data loading for "+model.selectedDate,
                                       backgroundColor: AppColor.failedColor,
                                       icon: FlutterIcons.loading_mco,
                                     );
                                   }*/
                                },
                              )
                            ),
                            /*SliverToBoxAdapter(
                              child: UiSpacer.verticalSpace(space: 15),
                            ),*/
                            SliverToBoxAdapter(
                              child: UiSpacer.verticalSpace(space: 12),
                            ),
                            SliverToBoxAdapter(
                              child: UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
                            ),
                            SliverToBoxAdapter(
                              child: UiSpacer.verticalSpace(space: 4),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: AppPaddings.defaultPadding(),
                                  child:Text(
                                    'Available Slot',
                                    style: AppTextStyle.h16TitleTextStyle(
                                        color: AppColor.accentColor,
                                        fontWeight: FontWeight.w500
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection: AppTextDirection.defaultDirection,
                                  )),
                            ),
                            SliverPadding(
                                padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                                sliver: model.appointmentLoadingState ==
                                    LoadingState.Loading
                                //the loadinng shimmer
                                    ? SliverToBoxAdapter(
                                  child: VendorShimmerListViewItem(),
                                )
                                // the faild view
                                    : model.appointmentLoadingState ==
                                    LoadingState.Failed
                                    ? SliverToBoxAdapter(
                                  child: LoadingStateDataView(
                                    stateDataModel: StateDataModel(
                                      showActionButton: true,
                                      actionButtonStyle:
                                      AppTextStyle.h4TitleTextStyle(
                                        color: Colors.red,
                                      ),
                                      actionFunction: () =>
                                      model.availableslotList,
                                    ),
                                  ),
                                )
                                // the vendors list
                                    : model.availableslotList.length == 0
                                    ? SliverToBoxAdapter(
                                    child: Center(
                                      child: EmptyWishlist(),
                                    ))
                                    :
                                //grid listing type
                                SliverGrid(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                   // mainAxisExtent: 48,
                                    childAspectRatio: 0.5 /0.18,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      return AnimatedSlotListViewItem(
                                        index: index,
                                        vendor: model.availableslotList[index],
                                        listViewItem:
                                        AvailableSlotListViewItem(
                                          notification: model.availableslotList[index],
                                          current_index: index,
                                          SELECTED_POSITION: SELECTED_POSITION,
                                          onPressed: (){
                                           if(!model.availableslotList[index].active){
                                           setState(() {
                                             SELECTED_POSITION=index;
                                             AppStrings.selectedBookTime=model.availableslotList[index].slot;
                                           });
                                           }else{
                                             EdgeAlert.show(
                                               context,
                                               title: "No Available Slot",
                                               description: ValidationMessages.slotNotAvailable,
                                               backgroundColor: AppColor.accentColor,
                                               icon: FlutterIcons.error_mdi,
                                             );
                                           }
                                          },
                                        ),
                                      );
                                    },
                                    childCount: model.availableslotList.length,
                                  ),
                                )),
                          ]))),

                          Container(
                              padding: AppPaddings.defaultPadding(),
                               color: Colors.white,
                            child:StreamBuilder<UiState>(
                                stream: _appointmentBloc.uiState,
                                builder: (context, snapshot) {
                                  final uiState = snapshot.data;
                                  return  CustomButton(
                                        padding: AppPaddings.mediumButtonPadding(),
                                        color: AppColor.accentColor,
                                        onPressed: uiState != UiState.loading
                                            ?  () {
                                          // showBottomDialog();
                                          if (AppStrings.selectedBookTime != "") {
                                            if (widget.DETAILS_PAGE) {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.fillDetailsRoute,
                                                //arguments: category,
                                              );
                                            } else {
                                              /*Navigator.pushNamed(
                                                context,
                                                AppRoutes.confirmedBokkingRoute,
                                                //arguments: category,
                                              );*/
                                              widget.appointment.appointmentDate=AppStrings.selectedBookDate;
                                              widget.appointment.appointmentTime=AppStrings.selectedBookTime;
                                              _appointmentBloc.editAppointment(appointment: widget.appointment);
                                            }
                                          }else{
                                            EdgeAlert.show(
                                              context,
                                              title: "Please select appointment time!",
                                              description: "Select Your appointment time",
                                              backgroundColor: AppColor.accentColor,
                                              icon: FlutterIcons.error_mdi,
                                            );
                                          }
                                        }
                                            : null,
                                        child: uiState != UiState.loading
                                            ? Text(
                                          "continue",
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
                              )),

                        ]),
                  ),
                )));
    //);
  }
}
