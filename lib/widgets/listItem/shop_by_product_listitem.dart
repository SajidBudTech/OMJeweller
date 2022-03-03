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
import 'package:flutter_om_jeweller/data/models/page_arguments.dart';

class ShopByProductListViewItem extends StatefulWidget {
  final Category category;
  const ShopByProductListViewItem({
    this.category,
    Key key,
  }) : super(key: key);

  @override
  _ShopByProductListViewItemState createState() => _ShopByProductListViewItemState();

}

class _ShopByProductListViewItemState extends State<ShopByProductListViewItem> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(
              context,
              AppRoutes.productListPageRoute,
              arguments: PageArguments(
                category: widget.category,
                subCategory: null,
                collection: null
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
                            imageUrl: Api.downloadUrlPath + widget.category.categoryImage,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>Padding(padding: AppPaddings.mediumButtonPadding(),child:Image.asset(AppImages.defaultPlaceHolder,fit: BoxFit.contain,)),
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
                              widget.category.categoryName,
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


