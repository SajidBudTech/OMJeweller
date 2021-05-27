import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/widgets/listItem/shop_by_subcategory_listitem.dart';

class ShopByCategoryListViewItem extends StatelessWidget {
  final Category category;
  //final Function(String) onPressed;
  const ShopByCategoryListViewItem({
    this.category,
   // this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 12),
        child:Text(
          category.categoryName,
          style: AppTextStyle.h16TitleTextStyle(
              color: AppColor.accentColor,
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.start,
          textDirection: AppTextDirection.defaultDirection,
        )),
      Container(
          width: double.infinity,
          height:195,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: category.subcategory.length,
            padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
            separatorBuilder: (context, index) =>
                UiSpacer.horizontalSpace(space: 0),
            itemBuilder: (context, index) {
              return ShopBySubCategoryListViewItem(
                  subCategory: category.subcategory[index],
              );
            },
          ),
        ),
        UiSpacer.verticalSpace(space: 24),
        UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
        UiSpacer.verticalSpace(space: 18),
       ],
       );
    //  ],
    // ),
    // );
  }
}
