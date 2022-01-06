import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/listItem/store_location_listitem.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/listItem/similar_product_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/sort_listview_item.dart';

class SortProductPage extends StatefulWidget {
  SortProductPage({
    Key key,
    this.model
  }) : super(key: key);

  ProductPageViewModel model;

  @override
  _SortProductPageState createState() => _SortProductPageState();


}

class _SortProductPageState extends State<SortProductPage> {

  List<String> sortlist=["Price - Low to High","Price - High to Low"];

  @override
  Widget build(BuildContext viewcontext) {
    return Container(
          color: AppColor.newprimaryColor,
          child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UiSpacer.verticalSpace(),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                    //padding: EdgeInsets.only(),
                    child:Text(
                      'Sort By',
                      style: AppTextStyle.h2TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.start,
                      textDirection: AppTextDirection.defaultDirection,
                    )),
                UiSpacer.verticalSpace(),
                UiSpacer.divider(thickness: 0.3,color: AppColor.hintTextColor(context)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                  child:  ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: sortlist.length,
                    //padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                    separatorBuilder: (context, index) =>
                        UiSpacer.horizontalSpace(space: 0),
                    itemBuilder: (context, index) {
                      return SortListViewItem(
                        notification:sortlist[index],
                        onPressed: (){
                          widget.model.sortProductList(sortlist[index]);
                          Navigator.pop(viewcontext);
                         /* setState(() {
                            widget.model.sortProductList(sortlist[index]);
                          });*/
                        },
                      );
                    },
                  ),

                ),
                UiSpacer.verticalSpace(space: 40)
                /*StreamBuilder<UiState>(
                  stream: _loginBloc.uiState,
                  builder: (context, snapshot) {
                    final uiState = snapshot.data;
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CustomButton(
                          padding: EdgeInsets.only(top: 15,bottom: 15,left: 48,right: 48),
                          color: AppColor.accentColor,
                          onPressed: uiState != UiState.loading
                              ?  (){
                            Navigator.pushNamed(
                              context,
                              AppRoutes.dateTimeRoute,
                              //arguments: category,
                            );
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
                ),*/
              ]),

        );
  }
}
