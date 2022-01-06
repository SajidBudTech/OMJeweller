import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
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
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
import 'package:flutter_om_jeweller/data/models/subcategory.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key,this.category,this.subcategory,this.collection}) : super(key: key);

  Category category;
  Subcategory subcategory;
  Collection collection;
  @override
  _ProductPageState createState() => _ProductPageState();

}

class _ProductPageState extends State<ProductPage> {
  //SearchVendorsBloc instance

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductPageViewModel>.reactive(
        viewModelBuilder: () => ProductPageViewModel(context),
        onModelReady: (model) => widget.category==null?(widget.subcategory==null?
        model.getProductsByCollection(collection: widget.collection):model.getProductsBySubCategory(subcategory: widget.subcategory)):
        model.getProductsByCategory(category: widget.category),
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
                          title: widget.category==null?(widget.subcategory==null?widget.collection.collectionName:widget.subcategory.subcategoryName):
                                  widget.category.categoryName,
                          subTitle: model.productByCategoryLoadingState !=
                              LoadingState.Loading?model.productbyCategoryList.length.toString()+" Items":"0 Items",
                        ),
                      ),
                      Expanded(child:
                      CustomScrollView(slivers: [
                        SliverPadding(
                            padding: AppPaddings.defaultPadding(),
                            sliver: model.productByCategoryLoadingState ==
                                LoadingState.Loading
                            //the loadinng shimmer
                                ? SliverToBoxAdapter(
                              child: VendorShimmerListViewItem(),
                            )
                            // the faild view
                                : model.productByCategoryLoadingState ==
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
                                  widget.category==null?(widget.subcategory==null?
                                  model.getProductsByCollection(collection: widget.collection):model.getProductsBySubCategory(subcategory: widget.subcategory)):
                                  model.getProductsByCategory(category: widget.category),
                                ),
                              ),
                            )
                            // the vendors list
                                : model.productbyCategoryList.length == 0
                                ? SliverToBoxAdapter(
                                child: Center(
                                  child: EmptyProduct(),
                                ))
                                :
                            //grid listing type
                            SliverGrid(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1/1.7,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return AnimatedProdcutListViewItem(
                                    index: index,
                                    product: model.productbyCategoryList[index],
                                    platinumRate: model.platiniumRate,
                                   );
                                },
                                childCount: model.productbyCategoryList.length,
                              ),
                            )),

                      ])),

                      Visibility(
                        visible: model.productbyCategoryList.length > 0,
                          child:Container(
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
                                   showSortBottomSheetDialog(model);
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
                                    showFilterBottomSheetDialog(model,model.productbyCategoryList);
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
                      )),
                    ]),
              ),
            )));

    //);
  }

  void showSortBottomSheetDialog(ProductPageViewModel model) {
    CustomDialog.showCustomBottomSheet(
      context,
      backgroundColor: AppColor.newprimaryColor,
      content:SortProductPage(
        model: model,
      )
    );

  }

  void showFilterBottomSheetDialog(ProductPageViewModel model, List<Product> productList) {
    CustomDialog.showCustomBottomSheet(
        context,
        backgroundColor: AppColor.newprimaryColor,
        content:FilterProductPage(
          model: model,
          productList: productList,
        )
    );
  }
}
