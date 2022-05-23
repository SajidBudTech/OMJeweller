import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
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
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_product_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/wishlist_list_item.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:flutter_om_jeweller/widgets/state/unauthenticated.dart';
import 'package:stacked/stacked.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({Key key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {


  @override
  Widget build(BuildContext context) {
    Widget pageBody;
    if (AuthBloc.authenticated()) {
      pageBody = ViewModelBuilder<ProductPageViewModel>.reactive(
          viewModelBuilder: () => ProductPageViewModel(context),
          onModelReady: (model) => model.getWishListProducts(),
          builder: (context, model, child) =>
              Scaffold(
                  body:
                  Container(
                    color: AppColor.newprimaryColor,
                    /*   decoration: BoxDecoration(
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
                                title: "Wishlist",
                                subTitle: model.productbyWishList.length
                                    .toString() + " Items",
                              ),
                            ),
                            Expanded(child: CustomScrollView(slivers: [
                              SliverPadding(
                                  padding: AppPaddings.defaultPadding(),
                                  sliver: model.productByWishlistLoadingState ==
                                      LoadingState.Loading
                                  //the loadinng shimmer
                                      ? SliverToBoxAdapter(
                                    child: VendorShimmerListViewItem(),
                                  )
                                  // the faild view
                                      : model.productByWishlistLoadingState ==
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
                                            model.getWishListProducts(),
                                      ),
                                    ),
                                  )
                                  // the vendors list
                                      : model.productbyWishList.length == 0
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
                                      childAspectRatio: 1 / 1.6,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                        return AnimatedProdcutListViewItem(
                                          index: index,
                                          product: model
                                              .productbyWishList[index],
                                          listViewItem:
                                          WishlistListViewItem(
                                            product: model.productbyWishList[index],
                                            platinumRate: model.platiniumRate,
                                            productPageViewModel: model,
                                            onPressed: (product) {
                                              setState(() {
                                                model.productbyWishList.remove(product);
                                              });
                                            },
                                          ),
                                        );
                                      },
                                      childCount: model.productbyWishList
                                          .length,
                                    ),
                                  )),


                            ])),
                          ]),
                    ),
                  )));
    }else{
      pageBody=Scaffold(body:UnauthenticatedPage());
    }
    return pageBody;
    //);
  }
}
