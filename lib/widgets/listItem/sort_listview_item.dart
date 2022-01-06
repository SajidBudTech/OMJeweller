import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';

class SortListViewItem extends StatefulWidget {
  const SortListViewItem({
    Key key,
    @required this.notification,
    this.onPressed,
  }) : super(key: key);

  // final NotificationModel notification;
  final String notification;
  final Function onPressed;

  @override
  _SortListViewItemState createState() =>
      _SortListViewItemState();

}
class _SortListViewItemState extends State<SortListViewItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child:Container(
        alignment: Alignment.topLeft,
       // color: Colors.white,
        //width: (AppSizes.getScreenWidth(context)/2)-40,
        margin: EdgeInsets.only(top: 10,bottom: 10),
       // padding: EdgeInsets.only(top: 16,bottom: 16,left: 20,right: 20),
      /*  decoration: BoxDecoration(
            border: Border.all(color: AppColor.hintTextColor(context)),
            borderRadius: BorderRadius.circular(8)
        ),*/
        child:Text(
          widget.notification,
          style: AppTextStyle.h4TitleTextStyle(
              color: AppColor.textColor(context),
              fontWeight: FontWeight.w500
          ),
          textAlign: TextAlign.start,
          textDirection: AppTextDirection.defaultDirection,
        )
    ));
  }

}
