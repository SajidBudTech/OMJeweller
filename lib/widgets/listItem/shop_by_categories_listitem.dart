import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';

class ShopByCategoryListViewItem extends StatelessWidget {
  final String category;
  final Function(String) onPressed;
  const ShopByCategoryListViewItem({
    this.category,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => this.onPressed(this.category),
        highlightColor: Colors.transparent,
        splashColor: AppColor.accentColor.withOpacity(0.5),
        child: Card(
            elevation: 0,
            margin: EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            child:Container(
              width: (AppSizes.getScreenWidth(context)/3)-22,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        category,
                      ),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),

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
        )
    );
    //  ],
    // ),
    // );
  }
}
