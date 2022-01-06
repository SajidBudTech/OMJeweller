import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/persistent_header.dart';
import 'package:flutter_om_jeweller/widgets/appbars/product_page.appbar.dart';
import 'package:flutter_om_jeweller/widgets/header/product_page_header.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/general_shimmer_list_view_item.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/views/products/details_view.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/bloc/product.bloc.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter_om_jeweller/widgets/storelocationlist/appoinment_type_content.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/data/viewmodels/count.viewmodel.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({
    Key key,
    this.product,
    this.status
  }) : super(key: key);

  final Product product;
  final bool status;
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductBloc _produtBloc=ProductBloc();
  ProductPageViewModel model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _produtBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _produtBloc.dialogData.title,
          description: _produtBloc.dialogData.body,
          backgroundColor: AppColor.accentColor,
          icon: _produtBloc.dialogData.iconData,
        );
        if(_produtBloc.dialogData.title=="Product Added To Wishlist Successfully!"){
          CountViewModel countViewModel=CountViewModel(context);
          countViewModel.incrementWishlistCount();
          setState(() {
            if(widget.status){
              widget.product.isWishlist=101;
            }else{
              model.product.isWishlist=101;
            }
          });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductPageViewModel>.reactive(
      viewModelBuilder: () => ProductPageViewModel(context),
      onModelReady: (model) => (widget.status?model.initialise():model.getProductsByID(productID: widget.product.productID)),
      builder: (context, model, child) {
        this.model=model;
        return Scaffold(
          backgroundColor: AppColor.appBackground(context),
          appBar: PreferredSize(
            preferredSize: Size(double.infinity,
                model.makeAppBarTransparent ? kToolbarHeight : 56),
            child: ProductPageAppBar(
              model: model,
              productName: widget.status?(widget.product.productName??""):(model.product.productName??""),
            ),
          ),
          //extendBodyBehindAppBar: true,
          body:  model.isBusy
              ? Padding(
            padding: AppPaddings.defaultPadding(),
            child: GeneralShimmerListViewItem(),
          ):

          Stack(
            children: [
              // body
              Container(
                padding: EdgeInsets.all(0),
                // color: AppColor.appBackground(context),
                child: NestedScrollView(
                    controller: model.vendorPageStrollController,
                    headerSliverBuilder: (context, value) {
                      return [
                        //vendor information header
                        ProductPageHeader(
                          product: widget.status?(widget.product):(model.product),
                        ),

                        // vendor menu types appbar with tabs
                        SliverPersistentHeader(
                          pinned: false,
                          floating: false,
                          delegate: PersistentHeader(
                            widget: Container(
                              width: double.infinity,
                              //height: 100,
                               //color: AppColor.newprimaryColor,
                              decoration: BoxDecoration(
                                borderRadius: AppSizes.containerTopBorderRadiusShape(),
                                color: AppColor.appBackground(context),
                              ),
                              child:
                                  model.isBusy || !model.makeAppBarTransparent
                                      ? UiSpacer.horizontalSpace()
                                      : Center(
                                          child: Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                              color: AppColor.accentColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        )),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: model.isBusy
                        ? Padding(
                      padding: AppPaddings.defaultPadding(),
                      child: GeneralShimmerListViewItem(),
                      )
                        : Column(
                      children: [
                        Expanded(
                          child:ProductDetailsViewItem(
                            product: widget.status?(widget.product):(model.product),
                          ),
                        ),
                        Container(
                         color: Colors.white,
                          padding: AppPaddings.defaultPadding(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex:8,
                                child:StreamBuilder<UiState>(
                                stream: _produtBloc.uiState,
                                builder: (context, snapshot) {
                                  final uiState = snapshot.data;

                                  return CustomButton(
                                    padding: AppPaddings.mediumButtonPadding(),
                                    color: AppColor.accentColor,
                                    onPressed: uiState != UiState.loading
                                        ?  (){
                                           AppStrings.selectedProduct=widget.product.productName??"";
                                           showStoreVisitBottomDialog();
                                        }
                                        : null,
                                    child: uiState != UiState.loading
                                        ? Text(
                                      "Book an Appointement",
                                      style: AppTextStyle.h4TitleTextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                      ),
                                      textAlign: TextAlign.start,
                                      textDirection:
                                      AppTextDirection.defaultDirection,
                                    )
                                        : PlatformCircularProgressIndicator(),
                                  );
                                },
                              )),
                              Expanded(
                                flex: 2,
                                child:InkWell(
                                  onTap: (){
                                    if(widget.status?(widget.product.isWishlist==null):(model.product.isWishlist==null)) {
                                      _produtBloc.addToWishList(produtcId: widget.status?(widget.product.productID):(model.product.productID));
                                    }else{
                                      EdgeAlert.show(
                                        context,
                                        title: "Already Added In Wishlist",
                                        description: "Please try with some other product!",
                                        backgroundColor: AppColor.accentColor,
                                        icon: FlutterIcons.error_mdi,
                                      );
                                    }
                                  },
                                child:Container(
                                  margin:EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.only(top: 9,bottom: 9),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: widget.status?(widget.product.isWishlist==null?AppColor.hintTextColor(context):AppColor.accentColor):
                                    (model.product.isWishlist==null?AppColor.hintTextColor(context):AppColor.accentColor),width: 1),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child:Icon(
                                    widget.status?(widget.product.isWishlist==null?FlutterIcons.favorite_border_mdi:FlutterIcons.favorite_mdi):
                                    (model.product.isWishlist==null?FlutterIcons.favorite_border_mdi:FlutterIcons.favorite_mdi),
                                    color: widget.status?(widget.product.isWishlist==null?AppColor.hintTextColor(context):AppColor.accentColor):
                                           (model.product.isWishlist==null?AppColor.hintTextColor(context):AppColor.accentColor),
                                    size: 32,
                                  )
                                ))
                              )
                            ],

                          ),
                        ),

                      ],
                    )
                    ),
              ),

              // floating cart button
              /*Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.20,
                  right: AppPaddings.contentPaddingSize,
                  child: FloatingCartButton(),
                ),*/
            ],
          ),
        );
      },
    );
  }

  void showStoreVisitBottomDialog() {
    CustomDialog.showCustomBottomSheet(
      context,
      content: AppointmentTypeContent(),
    );
  }
}
