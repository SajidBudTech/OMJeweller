import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_images.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/data/models/wishlist_data.dart';
import 'package:flutter_om_jeweller/widgets/storelocationlist/store_location_content.dart';
import 'package:flutter_om_jeweller/views/similar_product_page.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/bloc/product.bloc.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter_om_jeweller/widgets/storelocationlist/appoinment_type_content.dart';
import 'package:intl/intl.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
import 'package:flutter_om_jeweller/data/viewmodels/count.viewmodel.dart';

class WishlistListViewItem extends StatefulWidget {
  WishlistListViewItem({
    Key key,
    @required this.product,
    @required this.platinumRate,
    @required this.productPageViewModel,
    this.onPressed
  }) : super(key: key);

  final Product product;
  final double platinumRate;
  final ProductPageViewModel productPageViewModel;
  final Function(Product) onPressed;

  @override
  _WishlistListViewItemState createState() =>
      _WishlistListViewItemState();
}

class _WishlistListViewItemState extends State<WishlistListViewItem> {

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
        CountViewModel countViewModel=CountViewModel(context);
        countViewModel.decrementWishlistCount();
        setState(() {
          widget.onPressed(widget.product);
        });
      }else{
        EdgeAlert.show(
          context,
          title: _produtBloc.dialogData.title,
          description: _produtBloc.dialogData.body,
          backgroundColor: AppColor.accentColor,
          icon: _produtBloc.dialogData.iconData,
        );
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
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.all(0),
          onPressed: () {

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
                  imageUrl: Api.ProductdownloadUrlPath + (widget.product.productImage==null?widget.product.featureImage:widget.product.productImage),
                  placeholder: (context, url) => Container(
                    height: ((AppSizes.getScreenWidth(context)/2)-50)+(((AppSizes.getScreenWidth(context)/2)-50)*0.15),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) =>Padding(padding: AppPaddings.mediumButtonPadding(),child:Image.asset(AppImages.defaultPlaceHolder,fit: BoxFit.contain,)),
                  height: ((AppSizes.getScreenWidth(context)/2)-50)+(((AppSizes.getScreenWidth(context)/2)-50)*0.15),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              Align(
                alignment: Alignment.topRight,
                child:InkWell(
                  onTap: (){
                    _produtBloc.removeFromWishList(produtcId: widget.product.productID);
                  },
                child:Padding(
                  padding: EdgeInsets.only(right: 8,top: 8),
                 child:Icon(
                  FlutterIcons.close_ant,
                  size: 18,
                  color: AppColor.textColor(context),
                ))),
              )
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
                    Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 6),
                    child:Text(
                     (widget.product.productName==null?"":(widget.product.productName)),
                      style: AppTextStyle.h5TitleTextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textColor(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                      textDirection: AppTextDirection.defaultDirection,
                    )),
                    //product types and minimum order amount
                    Text(
                      (widget.product.collectionName==null?"":(widget.product.collectionName+" Collection")),
                      style: AppTextStyle.h7TitleTextStyle(
                        color: AppColor.textColor(context),
                        fontWeight: FontWeight.w400,
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
                    UiSpacer.divider(thickness: 0.5,color: AppColor.hintTextColor(context)),
                  ],
                ),
              ),
              ]),
            
             /*Positioned(
               child:widget.vendor.stock?
               Container(
                 color: Colors.grey.withOpacity(0.32),
                 height:AppSizes.getScreenheight(context)/2.75,
                 width: double.infinity,
                 alignment: Alignment.center,
                 child:Text(
                   "Out of Stock",
                   style: AppTextStyle.h3TitleTextStyle(
                     color: AppColor.textColor(context),
                   ),
                   textDirection: AppTextDirection.defaultDirection,
                   overflow: TextOverflow.ellipsis,
                 ),

               ):Container()
             )*/
              ]),

             /*widget.vendor.stock?
              InkWell(
                onTap: (){
                  showBottomDialog();
                },
                child:Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.buttonPaddingSize,
                    ),
                    child:Text(
                      "Show Similar",
                      style: AppTextStyle.h5TitleTextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.accentColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textDirection: AppTextDirection.defaultDirection,
                    )
                ),
              )
                 :*/ InkWell(
               onTap: (){
                 AppStrings.selectedProduct=widget.product.productName??"";
                 showStoreVisitBottomDialog();
               },
               child:Container(
                   alignment: Alignment.topLeft,
                   padding: EdgeInsets.symmetric(
                     horizontal: AppPaddings.buttonPaddingSize,
                   ),
                   child:Text(
                     "Book Appointment",
                     style: AppTextStyle.h5TitleTextStyle(
                       fontWeight: FontWeight.w500,
                       color: AppColor.accentColor,
                     ),
                     overflow: TextOverflow.ellipsis,
                     textDirection: AppTextDirection.defaultDirection,
                   )
               ),
             )


              //delivery info
              //delivery time
              // Positioned(
              //   right: 10,
              //   top: AppSizes.smallVendorImageHeight - 40,
              //   child: DeliveryTimeButton(
              //     deliveryTime: widget.vendor.deliveryTime,
              //   ),
              // ),
            ],
          ),
        ),
      );
   // );
  }

  void showStoreVisitBottomDialog() {
    CustomDialog.showCustomBottomSheet(
      context,
      content: AppointmentTypeContent(),
    );
  }

  /*String getProductPrice() {
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


    return format.format(totalAmount.toInt());

  }*/

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

    if(int.tryParse(widget.product.productType??"0")==1){
      double makingCharges=double.parse(widget.product.purityPrice??"0")*((double.parse(widget.product.makingwastage??"0"))/100);
      double price=((makingCharges+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight)))+double.parse(widget.product.stonecharges??"0");
      //double tax=price*((widget.product.taxValue??0)/100);
      double tax=price*((double.parse(widget.product.taxValue??"0"))/100);
      totalAmount=price+tax;
    }else if(int.tryParse(widget.product.productType??"0")==2){

      double price=(((double.parse(widget.product.makingcost??"0")+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight))))+(double.parse(widget.product.stonecharges??"0"))+calculatedTotalAmount;
      double tax=price*((double.parse(widget.product.taxValue??"0"))/100);

      totalAmount=price+tax;

    }else if(int.tryParse(widget.product.productType??"0")==3){
      double platinumAmount=(double.parse(widget.product.platiniummaking??"0")+widget.platinumRate)*(double.parse(widget.product.platiniumweight??"0"));

      double price=((double.parse(widget.product.makingcost??"0")+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight)))+platinumAmount+(double.parse(widget.product.stonecharges??"0"))+calculatedTotalAmount;
      //double tax=price*((widget.product.taxValue??0)/100);
      double tax=price*((double.parse(widget.product.taxValue??"0"))/100);
      totalAmount=price+tax;

    }else if(int.tryParse(widget.product.productType??"0")==4){
      double polkiAmount =(double.parse(widget.product.polkiamount??"0"))*(double.parse(widget.product.polkiweight??"0"));

      double price=((double.parse(widget.product.makingcost??"0")+double.parse(widget.product.purityPrice??"0"))*(double.parse(widget.product.netweight)))+polkiAmount+(double.parse(widget.product.stonecharges??"0"))+calculatedTotalAmount;
      //double tax=price*((widget.product.taxValue??0)/100);
      double tax=price*((double.parse(widget.product.taxValue??"0"))/100);
      totalAmount=price+tax;

    }

    widget.product.productPrice=totalAmount.toInt();


    return format.format(totalAmount.toInt());

  }

  void showBottomDialog() {

    CustomDialog.showCustomBottomSheet(
      context,
      content: SimilarProductPage(),
    );
  }
}
