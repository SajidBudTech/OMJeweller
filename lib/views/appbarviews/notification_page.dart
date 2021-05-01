import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_notification.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/search/search_bar.dart';
import 'package:flutter_om_jeweller/widgets/search/search_groupedlist_view.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  //SearchVendorsBloc instance
  final ProductSearchBloc _searchVendorsBloc = ProductSearchBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();

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
    return/* Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),
        child:*/

        Scaffold(
          backgroundColor: AppColor.appBackground(context),
          appBar: EmptyAppBar(),
          body: Container(
           /* decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),*/
            child: Stack(
              children: <Widget>[
                //vendors
                Positioned(
                  //if you are using CustomAppbar
                  //use this AppSizes.customAppBarHeight
                  //or this AppSizes.secondCustomAppBarHeight, if you are using the second custom appbar
                  top: AppSizes.secondCustomAppBarHeight,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ListView(
                    //padding: AppPaddings.defaultPadding(),
                    padding: EdgeInsets.fromLTRB(
                      AppPaddings.contentPaddingSize,
                      MediaQuery.of(context).size.height * 0.10,
                      AppPaddings.contentPaddingSize,
                      AppPaddings.contentPaddingSize,
                    ),
                    children: <Widget>[
                      //Resut
                      StreamBuilder<List<String>>(
                        stream: _searchVendorsBloc.searchVendors,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return EmptyNotification();
                          }
                          return SearchGroupedVendorsListView(
                            title: SearchStrings.result,
                            titleTextStyle: AppTextStyle.h3TitleTextStyle(
                              color: AppColor.textColor(context),
                            ),
                            products: snapshot.data,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  //normal
                  child: LeadingAppBar(
                    title: 'Notifications',
                    subTitle: "",
                  ),
                ),
              ],
            ),
          ),
        );
    //);
  }
}
