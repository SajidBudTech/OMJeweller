import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_om_jeweller/views/similar_product_page.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';

class ProductPageHeader extends StatelessWidget {
  const ProductPageHeader({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: new SliverChildListDelegate(
        [
          Stack(
            children: <Widget>[
              Container(
                  //margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child:CachedNetworkImage(
                    imageUrl: Api.ProductdownloadUrlPath + (product.productImage==null?"":product.productImage),
                    placeholder: (context, url) => Container(
                      height: (AppSizes.getScreenheight(context)*0.55),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                    height: (AppSizes.getScreenheight(context)*0.55),
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                  ),
                  /*Image.asset(
                  "assets/images/product_image.png",
                  //height: AppSizes.vendorPageImageHeight,
                  height: (AppSizes.getScreenheight(context)*0.55),
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                )*/
              ),
             // ),
              Positioned(
                bottom: 0,
                right: 0,
                child:
                InkWell(
                onTap: (){
                  showBottomDialog(context);
                },
                child:Container(
                  margin: EdgeInsets.only(right: 31,bottom: 18),
                    child:SvgPicture.asset(
                  'assets/images/product_detail_icon.svg',
                ))
                ),
              )
              //curved top
              /*Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:
                 Container(
                  height: AppSizes.vendorPageInfoCurveHeight,
                  decoration: BoxDecoration(
                    borderRadius: AppSizes.containerTopBorderRadiusShape(),
                    color: AppColor.appBackground(context),
                   *//* boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0.1, 0.0), // changes position of shadow
                      ),
                    ],*//*
                  ),
                  child: Center(
                    child:Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color:AppColor.accentColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                  )),
                ),
              ),*/

              //delivery time
             /* Positioned(
                right: 20,
                top: AppSizes.vendorPageInfoTopMargin,
                child: DeliveryTimeButton(
                  deliveryTime: vendor.deliveryTime,
                ),
              ),*/
            ],
          ),

          //Vendor info
         /* Center(
          child:Padding(
            // padding: AppPaddings.vendorPageContentPadding(),
            padding: EdgeInsets.fromLTRB(
              AppPaddings.contentPaddingSize,
              AppPaddings.contentPaddingSize,
              AppPaddings.contentPaddingSize,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: AppTextDirection.defaultDirection,
              children: <Widget>[
                //vendor name text
                Container(
                  decoration: BoxDecoration(
                    color:AppColor.accentColor,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  width: 40,
                  height: 4,
                )
              ],
            ),
          )),*/
        ],
      ),
    );
  }

  void showBottomDialog(BuildContext context) {

    CustomDialog.showCustomBottomSheet(
      context,
      backgroundColor: AppColor.newprimaryColor,
      content: SimilarProductPage(
        categoryId: product.categoryID,
      ),
    );
  }
}
