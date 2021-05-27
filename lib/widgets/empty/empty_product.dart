import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_images.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';

class EmptyProduct extends StatefulWidget {
  const EmptyProduct({Key key}) : super(key: key);

  @override
  _EmptyProductState createState() => _EmptyProductState();
}

class _EmptyProductState extends State<EmptyProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        textDirection: AppTextDirection.defaultDirection,
        children: <Widget>[
          Image.asset(
            AppImages.emptySearch,
            height: MediaQuery.of(context).size.height * 0.3,
            alignment: Alignment.center,
          ),
          Center(
            child: Text(
              SearchStrings.emptyProductTitle,
              style: AppTextStyle.h4TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              textDirection: AppTextDirection.defaultDirection,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              SearchStrings.emptyBody,
              style: AppTextStyle.h5TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              textAlign: TextAlign.center,
              textDirection: AppTextDirection.defaultDirection,
            ),
          ),
        ],
      ),
    );
  }
}
