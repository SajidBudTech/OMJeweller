import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';

class ShopByProductListViewItem extends StatelessWidget {
  final String category;
  final Function(String) onPressed;
  const ShopByProductListViewItem({
    this.category,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => this.onPressed(this.category),
        highlightColor: Colors.transparent,
        splashColor: AppColor.newprimaryColor.withOpacity(0.5),
        child: Card(
            elevation: 0,
            margin: EdgeInsets.only(right: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child:Container(
              width: (AppSizes.getScreenWidth(context)/2)-32,
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 8,
                child:ClipRRect(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0), topRight:Radius.circular(10.0)),
                child:Image.asset(category,
                    width: double.infinity,
                    fit: BoxFit.fill)
                )),
                Expanded(
                  flex: 2,
                child:Container(
                   // color: AppColor.primaryColorDark,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFE8D1),
                        borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10.0), bottomRight:Radius.circular(10.0))
                    ),
                    alignment: Alignment.center,
                    child:Text(
                      'EARINGS',
                      style: AppTextStyle.h4TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.center,
                      textDirection: AppTextDirection.defaultDirection,
                    )))

              ],
            ))

         /*   Container(
              alignment: Alignment.bottomCenter,
             // padding: EdgeInsets.only(bottom: 12),
              width: (AppSizes.getScreenWidth(context)/2)-24,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        category,
                      ),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
            child:Container(
              height: 32,
              width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.primaryColorDark,
                    borderRadius: BorderRadius.circular(10)
                ),
            alignment: Alignment.center,
            child:Text(
              'Earings',
              style: AppTextStyle.h4TitleTextStyle(
                color: AppColor.textColor(context),
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
              textDirection: AppTextDirection.defaultDirection,
            ))*/
              //    child:Image.asset(category,
              //     fit:BoxFit.cover,
              // ),
              //
              //UiSpacer.verticalSpace(space: 5),
              /*Text(
            this.category.name,
            style: AppTextStyle.h4TitleTextStyle(
              color: AppColor.textColor(context),
            ),
          )*/
            )
        );
   // );
    //  ],
    // ),
    // );
  }
}
