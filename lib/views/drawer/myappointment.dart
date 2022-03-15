import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/myappointment_slider.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:flutter_om_jeweller/widgets/state/unauthenticated.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/data/viewmodels/appoinement.viewmodel.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_myappointment.dart';

class MyAppointmentListPage extends StatefulWidget {
  MyAppointmentListPage({Key key}) : super(key: key);

  @override
  _MyAppointmentPageState createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentListPage> {
  //SearchVendorsBloc instance
  @override
  Widget build(BuildContext context) {
    Widget pageBody;
    if (AuthBloc.authenticated()) {
      pageBody = ViewModelBuilder<AppointmentViewModel>.reactive(
          viewModelBuilder: () => AppointmentViewModel(),
          onModelReady: (model) => model.getAllMyAppointment(),
          builder: (context, model, child) =>
              Scaffold(
                  backgroundColor: AppColor.newprimaryColor,
                  body: Container(
                    child: SafeArea(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: LeadingAppBar(
                                title: "My Appointments",
                                subTitle: "",
                              ),
                            ),
                            Expanded(
                                child: CustomScrollView(slivers: [
                                  SliverPadding(
                                    padding: EdgeInsets.only(top: 20),
                                    sliver: model.appointmentLoadingState ==
                                        LoadingState.Loading
                                    //the loadinng shimmer
                                        ? SliverToBoxAdapter(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: VendorShimmerListViewItem()),
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
                                          model.getAllMyAppointment,
                                        ),
                                      ),
                                    )
                                    // the vendors list
                                        : model.appointmentslist.length == 0
                                        ? SliverToBoxAdapter(
                                        child: Center(
                                          child: EmptyAppointment(),
                                        ))
                                        :
                                    //grid listing type
                                    SliverToBoxAdapter(
                                        child: MyAppointmentSlider(
                                          appointments: model.appointmentslist,
                                        )),
                                  ),
                                ])),
                          ]),
                    ),
                  )));
    }else{
      pageBody=Scaffold(body: UnauthenticatedPage());
    }
    return pageBody;
    //);
  }

  /*void showSortBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: SortProductPage());
  }

  void showFilterBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: FilterProductPage());
  }*/
}
