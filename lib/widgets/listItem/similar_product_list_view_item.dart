import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/bloc/product.bloc.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:intl/intl.dart';
import 'package:flutter_om_jeweller/data/models/product_arguments.dart';
import 'package:flutter_om_jeweller/data/viewmodels/count.viewmodel.dart';

class SimilarProdcutListViewItem extends StatefulWidget {
  SimilarProdcutListViewItem({
    Key key,
    @required this.product,
    @required this.platinumRate,
  }) : super(key: key);

  final Product product;
  final double platinumRate;
  @override
  _SimilarProdcutListViewItemState createState() =>
      _SimilarProdcutListViewItemState();
}

class _SimilarProdcutListViewItemState extends State<SimilarProdcutListViewItem> {
  ProductBloc _produtBloc=ProductBloc();
  var format = NumberFormat.currency(locale: 'HI',decimalDigits: 0,customPattern: 'INR #,##,###');
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
            widget.product.isWishlist=101;
          });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return
      /*  Hero(
      tag: widget.vendor,
      child: */
      Container(
        width: (AppSizes.getScreenWidth(context)/2)-30,
        margin: EdgeInsets.only(right: 10,bottom: 4),
        child: RaisedButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            //show vendor full info and menu
            Navigator.pushNamed(
                context,
                AppRoutes.productDetailRoute,
                arguments: ProductArguments(
                    product: widget.product,
                    status: false
                )
            );
          },
          // elevation: 3,
          // shape: StadiumBorder(),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: <Widget>[
              Stack(
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                          Stack(
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: Api.ProductdownloadUrlPath + (widget.product.productImage==null?"":widget.product.productImage),
                                  placeholder: (context, url) => Container(
                                    height: 181,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  height: 181,
                                  fit: BoxFit.cover,
                                  width: (AppSizes.getScreenWidth(context)/2)-50,
                                ),
                               /* Align(
                                  alignment: Alignment.topRight,
                                  child:Padding(
                                      padding: EdgeInsets.only(right: 8,top: 8),
                                      child:Icon(
                                        FlutterIcons.close_ant,
                                        size: 18,
                                        color: AppColor.textColor(context),
                                      )),
                                )*/
                              ]),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppPaddings.buttonPaddingSize,
                            ),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              textDirection: AppTextDirection.defaultDirection,
                              children: <Widget>[
                                //vendor name
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                    child:Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(top: 6),
                                        child:Text(
                                          widget.product.productName??"",
                                          style: AppTextStyle.h5TitleTextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.textColor(context),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: AppTextDirection.defaultDirection,
                                        ))),
                                    Expanded(
                                      flex: 2,
                                    child:InkWell(
                                    onTap: (){
                                      if(widget.product.isWishlist==null) {
                                        _produtBloc.addToWishList(
                                            produtcId: widget.product
                                                .productID);
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
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                              widget.product.isWishlist==null?FlutterIcons.favorite_border_mdi:FlutterIcons.favorite_mdi,
                                              size: 16,
                                              color: widget.product.isWishlist==null?AppColor.hintTextColor(context):AppColor.accentColor,
                                            )
                                    ))),


                                  ],
                                ),

                                //product types and minimum order amount
                                Text(
                                  widget.product.collectionName==null?"":(widget.product.collectionName+" Collection"),
                                  style: AppTextStyle.h7TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                    fontWeight: FontWeight.w400
                                  ),
                                  textDirection: AppTextDirection.defaultDirection,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  getProductPrice(),
                                  style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.accentColor,
                                      fontWeight: FontWeight.w500
                                  ),
                                  textDirection: AppTextDirection.defaultDirection,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                //UiSpacer.divider(thickness: 0.5,color: AppColor.hintTextColor(context)),
                              ],
                            ),
                          ),
                        ]),
                  ]),
            ],
          ),
        ),
      );
    // );
  }

  String getProductPrice() {
    double totalAmount=0;

    double calculatedTotalAmount=0;
    double calculatedTotalWieght=0;


    for(Productattributes productattributes in widget.product.productattributes){
      calculatedTotalAmount=calculatedTotalAmount+double.parse(productattributes.diamondamount??"0");
    }
    for(Productattributes productattributes in widget.product.productattributes){
      calculatedTotalWieght=calculatedTotalWieght+double.parse(productattributes.diamondweight??"0");
    }

    if(widget.product.productType==1){
      double makingCharges=double.parse(widget.product.purityPrice??"0")*((widget.product.makingwastage??0)/100);
      double price=((makingCharges+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight)))+double.parse(widget.product.stonecharges??"0");
      double tax=price*((widget.product.taxValue??0)/100);
      totalAmount=price+tax;
    }else if(widget.product.productType==2){

      double price=(((double.parse(widget.product.makingcost??"0")+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight))))+(double.parse(widget.product.stonecharges??"0"))+calculatedTotalAmount;
      double tax=price*((widget.product.taxValue??0)/100);

      totalAmount=price+tax;

    }else if(widget.product.productType==3){
      double platinumAmount=(double.parse(widget.product.platiniummaking??"0")+widget.platinumRate)*(double.parse(widget.product.platiniumweight??"0"));

      double price=((double.parse(widget.product.makingcost??"0")+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight)))+platinumAmount+(double.parse(widget.product.stonecharges??"0"))+calculatedTotalAmount;
      double tax=price*((widget.product.taxValue??0)/100);

      totalAmount=price+tax;

    }else if(widget.product.productType==4){
      double polkiAmount =(double.parse(widget.product.polkiamount??"0"))*(double.parse(widget.product.polkiweight??"0"));

      double price=((double.parse(widget.product.makingcost??"0")+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight)))+polkiAmount+(double.parse(widget.product.stonecharges??"0"))+calculatedTotalAmount;
      double tax=price*((widget.product.taxValue??0)/100);

      totalAmount=price+tax;

    }


    return  format.format(totalAmount.toInt());

  }

}
