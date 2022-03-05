import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_map_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
import 'package:flutter_om_jeweller/bloc/appointment.bloc.dart';

class VisitOurStorePage extends StatefulWidget {
  VisitOurStorePage({Key key}) : super(key: key);

  @override
  _VisitOurStorePageState createState() => _VisitOurStorePageState();
}

class _VisitOurStorePageState extends State<VisitOurStorePage> {

  AppointmentBloc _appointmentBloc=AppointmentBloc();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                              title: "Visit Our Stores",
                              subTitle: "",
                            ),
                          ),
                          Expanded(
                              child:
                              CustomScrollView(slivers: [
                                SliverToBoxAdapter(
                                  child: Container(
                                    height: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    return AnimatedMapListViewItem(
                                      index: index,
                                      address: _appointmentBloc.storeaddresses[index],
                                      location: _appointmentBloc.storeLocation[index],
                                      phone: _appointmentBloc.storePhone[index],
                                      latLng: _appointmentBloc.storeLatLong[index],
                                    );
                                  },
                                  childCount: _appointmentBloc.storeaddresses.length,
                                )),
                        ]),
                  ),
                ])))));

    //);
  }

/*void showSortBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: SortProductPage());
  }

  void showFilterBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: FilterProductPage());
  }*/
}
