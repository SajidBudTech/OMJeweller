import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_images.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/data/models/product_arguments.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';

class NewArrivalListViewItem extends StatefulWidget {
  final Product product;
  const NewArrivalListViewItem({
    this.product,
    Key key,
  }) : super(key: key);

  @override
  _NewArrivalListViewItemState createState() => _NewArrivalListViewItemState();

}

class _NewArrivalListViewItemState extends State<NewArrivalListViewItem> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(
              context,
              AppRoutes.productDetailRoute,
              arguments: ProductArguments(
                  product: widget.product,
                  status: false
              )
          );
        },
        highlightColor: Colors.transparent,
        splashColor: AppColor.newprimaryColor.withOpacity(0.5),
        child: Card(
            elevation: 0,
            margin: EdgeInsets.only(right: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
                width: 160,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color(0xFFF8F5F1)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          child:
                          CachedNetworkImage(
                            imageUrl: Api.ProductdownloadUrlPath + widget.product.featureImage??"",
                            errorWidget: (context, url, error) =>Padding(padding: AppPaddings.mediumButtonPadding(),child:Image.asset(AppImages.defaultPlaceHolder,fit: BoxFit.contain,)),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                      ),

                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          // color: AppColor.primaryColorDark,
                            decoration: BoxDecoration(
                                color: Color(0xFFF8F5F1),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0))
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              widget.product.subcategoryName??"",
                              style: AppTextStyle.h5TitleTextStyle(
                                  color: AppColor.textColor(context),
                                  fontWeight: FontWeight.w400
                              ),
                              textAlign: TextAlign.center,
                              textDirection: AppTextDirection.defaultDirection,
                            )))

                  ],
                )
            )
        )
    );
    // );
    //  ],
    // ),
    // );
  }
}


