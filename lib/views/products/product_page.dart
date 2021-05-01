import 'package:flutter/material.dart';
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
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_product_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/similar_product_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/sort_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/sort_page_content/sort_page.dart';
import 'package:flutter_om_jeweller/widgets/fliters/filter_content_page.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
        builder: (context, model, child) =>

/*            Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),
            child: */

            Scaffold(
                backgroundColor: AppColor.newprimaryColor,
                body: Container(
             /* decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFDBB6), Color(0xFFFFFFFF)])),*/
              child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: LeadingAppBar(
                          title: "Product Name",
                          subTitle: "22 Items",
                        ),
                      ),
                      Expanded(child: CustomScrollView(slivers: [
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
                                stateDataModel: StateDataModel(
                                  showActionButton: true,
                                  actionButtonStyle:
                                  AppTextStyle.h4TitleTextStyle(
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
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1 / 1.67,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return AnimatedProdcutListViewItem(
                                    index: index,
                                    vendor: model.wishlistList[index],
                                    /*listViewItem:
                                    SimilarProdcutListViewItem(
                                      vendor:
                                      model.wishlistList[index],
                                    ),*/
                                  );
                                },
                                childCount: model.wishlistList.length,
                              ),
                            )),



                      ])),
                      Container(
                        margin: EdgeInsets.all(2),
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPaddings.buttonPaddingSize,
                          vertical: AppPaddings.mediumButtonPaddingSize,
                        ),
                      /*  decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.primaryColorDark, width: 1)),*/
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child: InkWell(
                                onTap: (){
                                   showSortBottomSheetDialog();
                                },
                                child:Container(
                                  alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    FlutterIcons.sort_mdi,
                                    size: 16,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        'Sort By',
                                        style: AppTextStyle.h4TitleTextStyle(
                                            color: AppColor.textColor(context),
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.start,
                                        textDirection:
                                            AppTextDirection.defaultDirection,
                                      )),
                                ],
                              ),
                            ))),
                            Container(
                              height: 24,
                              width: 1,
                              color: AppColor.newprimaryColor,
                            ),
                            Expanded(
                              flex: 1,
                                child: InkWell(
                                  onTap: (){
                                    showFilterBottomSheetDialog();
                                  },
                                child:Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        FlutterIcons.filter_ant,
                                        size: 16,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Filter',
                                            style: AppTextStyle.h4TitleTextStyle(
                                                color: AppColor.textColor(context),
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.start,
                                            textDirection:
                                            AppTextDirection.defaultDirection,
                                          )),
                                    ],
                                  ),
                                )))
                          ],
                        ),
                      ),
                    ]),
              ),
            )));

    //);
  }

  void showSortBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(
      context,
      content:SortProductPage()
    );
  }

  void showFilterBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(
        context,
        content:FilterProductPage()
    );

  }
}
