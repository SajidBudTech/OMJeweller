import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_images.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_outline_button.dart';

class EmptyWishlist extends StatefulWidget {
  const EmptyWishlist({Key key}) : super(key: key);

  @override
  _EmptyWishlistState createState() => _EmptyWishlistState();
}

class _EmptyWishlistState extends State<EmptyWishlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        textDirection: AppTextDirection.defaultDirection,
        children: <Widget>[
          Image.asset(
            AppImages.emptyWishlist,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
         /* Center(
            child: Text(
              SearchStrings.emptyProductTitle,
              style: AppTextStyle.h4TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              textDirection: AppTextDirection.defaultDirection,
            ),
          ),*/
          SizedBox(
            height: 5,
          ),
          Center(
            child: CustomOutlineButton(
              title: 'Explore',
              width: AppSizes.getScreenWidth(context)*0.4,
              onPressed: (){

              },
            )
          ),
        ],
      ),
    );
  }
}
