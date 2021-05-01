import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/data/models/wishlist_data.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';

class ProductListViewItem extends StatefulWidget {
  ProductListViewItem({
    Key key,
    @required this.vendor,
  }) : super(key: key);

  final Wishlist vendor;
  @override
  _ProductListViewItemState createState() =>
      _ProductListViewItemState();
}

class _ProductListViewItemState extends State<ProductListViewItem> {
  @override
  Widget build(BuildContext context) {
    return
      /*  Hero(
      tag: widget.vendor,
      child: */
      Container(
        width: (AppSizes.getScreenWidth(context)/2)-38,
        margin: EdgeInsets.only(bottom: 4),
        child: RaisedButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            //show vendor full info and menu
            Navigator.pushNamed(
              context,
              AppRoutes.productDetailRoute,
             // arguments: widget.vendor,
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
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 16),
                                  height:AppSizes.getScreenheight(context)/3-70,
                                  width:AppSizes.getScreenWidth(context),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/product_image.png',
                                          ),
                                          fit: BoxFit.fitHeight
                                      )

                                  ),
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
                                            child:Text(
                                              "Antique Kada",
                                              style: AppTextStyle.h4TitleTextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.textColor(context),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: AppTextDirection.defaultDirection,
                                            ))
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child:Container(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              FlutterIcons.favorite_border_mdi,
                                              size: 20,
                                              color: AppColor.hintTextColor(context),
                                            )
                                        )),


                                  ],
                                ),

                                //product types and minimum order amount
                                Text(
                                  "Yugani Collection",
                                  style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                  ),
                                  textDirection: AppTextDirection.defaultDirection,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "5,69,203",
                                  style: AppTextStyle.h4TitleTextStyle(
                                    color: AppColor.accentColor,
                                  ),
                                  textDirection: AppTextDirection.defaultDirection,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                //UiSpacer.divider(thickness: 0.5,color: AppColor.hintTextColor(context)),
                              ],
                            ),
                          ),
                        ]),

                    Positioned(
                        child:widget.vendor.stock?
                        /*Container(
                          color: Colors.grey.withOpacity(0.32),
                          height: 260,
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

                        )*/
                        Container()
                            :Container()
                    )
                  ]),

              /* widget.vendor.stock?
              InkWell(
                onTap: (){

                },
                child:Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.buttonPaddingSize,
                    ),
                    child:Text(
                      "Show Similar",
                      style: AppTextStyle.h4TitleTextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.accentColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textDirection: AppTextDirection.defaultDirection,
                    )
                ),
              )
                  : InkWell(
                onTap: (){

                },
                child:Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.buttonPaddingSize,
                    ),
                    child:Text(
                      "Book Appointment",
                      style: AppTextStyle.h4TitleTextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.accentColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textDirection: AppTextDirection.defaultDirection,
                    )
                ),
              )*/


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

}
