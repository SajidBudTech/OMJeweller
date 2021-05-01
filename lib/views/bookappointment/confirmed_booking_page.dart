import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
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
import 'package:flutter_om_jeweller/widgets/listItem/animated_product_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/available_slot_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/wishlist_list_item.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/search/search_bar.dart';
import 'package:flutter_om_jeweller/widgets/search/search_groupedlist_view.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';

class ConfirmedBookingPage extends StatefulWidget {
  ConfirmedBookingPage({Key key}) : super(key: key);

  @override
  _ConfirmedBookingPageState createState() => _ConfirmedBookingPageState();
}

class _ConfirmedBookingPageState extends State<ConfirmedBookingPage> {
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


           /* Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),
            child: */

            Scaffold(
                body: Container(
               /*   decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),*/
                  child: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          /*Container(
                            child: LeadingAppBar(
                              title: "Date and Time",
                              subTitle: "",
                            ),
                          ),*/
                          Expanded(child: CustomScrollView(slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                              padding: AppPaddings.defaultPadding(),
                              margin: AppPaddings.defaultPadding(),
                              child:Image.asset('assets/images/confirm_book.png',
                              fit: BoxFit.cover)
                            )),
                            SliverToBoxAdapter(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(bottom: 8,top: AppPaddings.contentPaddingSize,left:AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                                  child:Text(
                                    'Booking Confirmed',
                                    style: AppTextStyle.h16TitleTextStyle(
                                        color: AppColor.textColor(context),
                                        fontWeight: FontWeight.w600
                                    ),
                                    textAlign: TextAlign.start,
                                    textDirection: AppTextDirection.defaultDirection,
                                  )),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: new TextSpan(
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: 'You booked an appointment with\n',
                                            style: AppTextStyle.h4TitleTextStyle(color: AppColor.hintTextColor(context),fontWeight: FontWeight.w400)),
                                        new TextSpan(
                                            text: 'OM Jewellers, Borivali ',
                                            style: AppTextStyle.h4TitleTextStyle(color: AppColor.textColor(context),fontWeight: FontWeight.w500)),
                                        new TextSpan(
                                            text: 'on',
                                            style: AppTextStyle.h4TitleTextStyle(color: AppColor.hintTextColor(context),fontWeight: FontWeight.w400)),
                                        new TextSpan(
                                            text: ' September 31,2021\n',
                                            style: AppTextStyle.h4TitleTextStyle(color: AppColor.textColor(context),fontWeight: FontWeight.w500)),
                                        new TextSpan(
                                            text: 'at 12:00 PM',
                                            style: AppTextStyle.h4TitleTextStyle(color: AppColor.textColor(context),fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  )

                              ),
                            ),


                        ])),

                          Padding(padding: AppPaddings.defaultPadding(),
                              child:StreamBuilder<UiState>(
                                stream: _loginBloc.uiState,
                                builder: (context, snapshot) {
                                  final uiState = snapshot.data;
                                  return  CustomButton(
                                    padding: AppPaddings.mediumButtonPadding(),
                                    color: AppColor.accentColor,
                                    onPressed: uiState != UiState.loading
                                        ?  (){
                                      // showBottomDialog();
                                    }
                                        : null,
                                    child: uiState != UiState.loading
                                        ? Text(
                                      "Go To Home",
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
