import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';

class LeadingAppBar extends PreferredSize {
  const LeadingAppBar({
    Key key,
    this.title,
    this.subTitle,
    this.height = kToolbarHeight,
  });

  final double height;
  final String title;
  final String subTitle;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: AppColor.newprimaryColor,
        padding: EdgeInsets.only(top: 20,bottom: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
                child:Icon(
              Icons.arrow_back,
              color: Colors.grey[600],
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: AppTextStyle.h3TitleTextStyle(
                        color: AppColor.textColor(context),
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  ),
                  Visibility(
                    visible: subTitle!="",
                    child: Text(
                    subTitle,
                    style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.hintTextColor(context),
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  ))

                ],
              ),
            )


          ],
        ),
      )
    );
  }
}
