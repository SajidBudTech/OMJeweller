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
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/about_banner_slider.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/myappointment_slider.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_map_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/company_member_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/sort_page_content/sort_page.dart';
import 'package:flutter_om_jeweller/widgets/fliters/filter_content_page.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/connector/horizontal_connector_dash.dart';
import 'package:flutter_om_jeweller/widgets/connector/vertical_connector_dash.dart';
import 'package:flutter_om_jeweller/widgets/connector/horizontal_right_connector.dart';

class AboutBrandPage extends StatefulWidget {
  AboutBrandPage({Key key}) : super(key: key);

  @override
  _AboutBrandPageState createState() => _AboutBrandPageState();
}

class _AboutBrandPageState extends State<AboutBrandPage> {
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
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => AnnotatedRegion<
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
                          title: "About Us",
                          subTitle: "",
                        ),
                      ),
                      Expanded(
                          child: Container(
                              color: Colors.white,
                              child: CustomScrollView(slivers: [
                                SliverToBoxAdapter(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 19,
                                    ),
                                    child: AboutBannerSlider(
                                        //search base on the category select from the banner
                                        onBannerTapped:
                                            model.openCategorySearchPage),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: UiSpacer.verticalSpace(),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'The Legacy',
                                        style: AppTextStyle.h16TitleTextStyle(
                                            color: AppColor.textColor(context),
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                        textDirection:
                                            AppTextDirection.defaultDirection,
                                      )),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Text(
                                        'OM is more than jewellery… it embodies family values, based on trust & understanding. Our lineage is committed to learning and progressing. We thank our customers, fellow jewellers and hope to grow, while staying true to our roots. Jewels & Family Bonds… Live Forever…Your Family Jeweller',
                                        style: AppTextStyle.h5TitleTextStyle(
                                            color:
                                                AppColor.hintTextColor(context),
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                        textDirection:
                                            AppTextDirection.defaultDirection,
                                      )),
                                ),
                                SliverPadding(
                                    padding: AppPaddings.defaultPadding(),
                                    sliver: model.categoriesLoadingState ==
                                            LoadingState.Loading
                                        //the loadinng shimmer
                                        ? SliverToBoxAdapter(
                                            child: VendorShimmerListViewItem(),
                                          )
                                        // the faild view
                                        : model.categoriesLoadingState ==
                                                LoadingState.Failed
                                            ? SliverToBoxAdapter(
                                                child: LoadingStateDataView(
                                                  stateDataModel:
                                                      StateDataModel(
                                                    showActionButton: true,
                                                    actionButtonStyle:
                                                        AppTextStyle
                                                            .h4TitleTextStyle(
                                                      color: Colors.red,
                                                    ),
                                                    actionFunction: () =>
                                                        model.wishlistList,
                                                  ),
                                                ),
                                              )
                                            // the vendors list
                                            : model.wishlistList.length == 0
                                                ? SliverToBoxAdapter(
                                                    child: Center(
                                                    child: EmptyWishlist(),
                                                  ))
                                                :
                                                //grid listing type
                                                SliverGrid(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 16,
                                                      mainAxisSpacing: 16,
                                                      childAspectRatio: 0.78,
                                                    ),
                                                    delegate:
                                                        SliverChildBuilderDelegate(
                                                      (context, index) {
                                                        return AnimatedMapListViewItem(
                                                          index: index,
                                                          vendor: model
                                                                  .CompanyNameList[
                                                              index],
                                                          listViewItem:
                                                              CompanyListViewItem(
                                                            name: model
                                                                    .CompanyNameList[
                                                                index],
                                                            post: model
                                                                    .CompanyPostList[
                                                                index],
                                                          ),
                                                        );
                                                      },
                                                      childCount: model
                                                          .CompanyNameList
                                                          .length,
                                                    ),
                                                  )),
                                SliverToBoxAdapter(
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Our History',
                                        style: AppTextStyle.h16TitleTextStyle(
                                            color: AppColor.textColor(context),
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                        textDirection:
                                            AppTextDirection.defaultDirection,
                                      )),
                                ),
                                SliverToBoxAdapter(
                                  child: UiSpacer.verticalSpace(space: 14),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: getRowItemWidget(
                                              "1939",
                                              "Foundations",
                                              "Damji Jakhia starts a small jewellery workshop in Gujarat.")),
                                      Container(margin: EdgeInsets.only(top: 36),
                                          child:HorizontalConnectorLine()),
                                      Expanded(
                                          child: getRowItemWidget(
                                              "1969",
                                              "Manufacturing",
                                              "Narendra Jhakia & Mukesh Jhakia established an enterprise in jewellery  manufacturing by the name of NM Jewellers."))
                                    ],
                                  )),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child:Container()),
                                          /*Container(margin: EdgeInsets.only(top: 36),
                                              child:HorizontalConnectorLine()),*/
                                          Expanded(
                                            child:Container(
                                                margin: EdgeInsets.only(left: 30),
                                              child: VerticalConnectorLine()))
                                        ],
                                      )),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: getRowItemWidget(
                                                  "1999",
                                                  "First Retail Store",
                                                  "NM Jewellers enters the retail marktet with it’s first store in Borivali with the name of OM Jewellers.")),
                                          Container(margin: EdgeInsets.only(top: 36),
                                              child:HorizontalRightConnectorLine()),
                                          Expanded(
                                              child: getRowItemWidget(
                                                  "1989",
                                                  "Export",
                                                  "NM Jewellers expands into jewellery wholesale globally and introduces 916 hallmark jewellery in India."))
                                        ],
                                      )),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                      child:Container(
                                      margin: EdgeInsets.only(right: 30),
                                              child:VerticalConnectorLine())),
                                          /*Container(margin: EdgeInsets.only(top: 36),
                                              child:HorizontalConnectorLine()),*/
                                          Expanded(
                                              child: Container())
                                        ],
                                      )),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: getRowItemWidget(
                                                  "2004",
                                                  "Family Jeweller",
                                                  "OM transforms into a jewellery brand of the 21st century by entering the digital space.")),
                                          Container(margin: EdgeInsets.only(top: 36),
                                              child:HorizontalConnectorLine()),
                                          Expanded(
                                              child: getRowItemWidget(
                                                  "2010",
                                                  "OM, The Brand",
                                                  "OM gets its brand identity revamped in response to changing times."))
                                        ],
                                      )),
                                ),

                                SliverToBoxAdapter(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child:Container()),
                                          /*Container(margin: EdgeInsets.only(top: 36),
                                              child:HorizontalConnectorLine()),*/
                                          Expanded(
                                              child: Container(
                                                    margin: EdgeInsets.only(left: 30),
                                                  child:VerticalConnectorLine()))
                                        ],
                                      )),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: getRowItemWidget(
                                                  "2015",
                                                  "Family Jeweller",
                                                  "OM transforms into a jewellery brand of the 21st century by entering the digital space.")),
                                          Container(margin: EdgeInsets.only(top: 36),
                                              child:HorizontalRightConnectorLine()),
                                          Expanded(
                                              child: getRowItemWidget(
                                                  "2011",
                                                  "Second Store",
                                                  "OM Opens its second store in Mulund."))
                                        ],
                                      )),
                                ),

                              ]))),
                    ]))))));

    //);
  }

  Widget getRowItemWidget(String title, String subtitle, String discription) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(bottom: 2),
            child: Text(
              title,
              style: AppTextStyle.h16TitleTextStyle(
                  color: AppColor.textColor(context),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              textDirection: AppTextDirection.defaultDirection,
            )),
        Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              subtitle,
              style: AppTextStyle.h5TitleTextStyle(
                  color: AppColor.textColor(context),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              textDirection: AppTextDirection.defaultDirection,
            )),
        Container(
            alignment: Alignment.topCenter,
            child: Text(
              discription,
              style: AppTextStyle.h7TitleTextStyle(
                  color: AppColor.hintTextColor(context),
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              textDirection: AppTextDirection.defaultDirection,
            )),
      ],
    );
  }
}
