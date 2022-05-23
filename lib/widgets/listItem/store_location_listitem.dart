import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';

class StoreLocationListViewItem extends StatefulWidget {
   StoreLocationListViewItem({
    Key key,
    @required this.notification,
     this.onPressed,
     this.SELECTED_INDEX,
     this.current_index,
  }) : super(key: key);

  // final NotificationModel notification;
  final String notification;
  final Function onPressed;
  final int SELECTED_INDEX;
   final int current_index;

  @override
  _StoreLocationListViewItemState createState() =>
      _StoreLocationListViewItemState();

}
class _StoreLocationListViewItemState extends State<StoreLocationListViewItem> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:widget.onPressed,
      child:Container(
        alignment: Alignment.center,
        width: (AppSizes.getScreenWidth(context)/2)-55,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          border: Border.all(color: widget.SELECTED_INDEX==widget.current_index?AppColor.accentColor:AppColor.hintTextColor(context)),
          borderRadius: BorderRadius.circular(8)
        ),
        child:Text(
          widget.notification,
          style: AppTextStyle.h5TitleTextStyle(
              color: widget.SELECTED_INDEX==widget.current_index?AppColor.accentColor:AppColor.hintTextColor(context),
              fontWeight: FontWeight.w400
          ),
          textAlign: TextAlign.start,
          textDirection: AppTextDirection.defaultDirection,
        )
      )
    );
  }

}
