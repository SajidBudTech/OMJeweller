import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';

class AvailableSlotListViewItem extends StatefulWidget {
  const AvailableSlotListViewItem({
    Key key,
    @required this.notification,
    this.onPressed,
    this.SELECTED_POSITION,
    this.current_index,
  }) : super(key: key);

  // final NotificationModel notification;
  final String notification;
  final Function onPressed;
  final SELECTED_POSITION;
  final current_index;

  @override
  _AvailableSlotListViewItemState createState() =>
      _AvailableSlotListViewItemState();

}
class _AvailableSlotListViewItemState extends State<AvailableSlotListViewItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child:Container(
        alignment: Alignment.center,
       // margin: EdgeInsets.only(left: 8,right: 8),
        //padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
        decoration: BoxDecoration(
            border: Border.all(color: widget.SELECTED_POSITION==widget.current_index?AppColor.accentColor:AppColor.hintTextColor(context)),
            borderRadius: BorderRadius.circular(8)
        ),
        child:Text(
          widget.notification,
          style: AppTextStyle.h4TitleTextStyle(
              color: widget.SELECTED_POSITION==widget.current_index?AppColor.accentColor:AppColor.textColor(context),
              fontWeight: FontWeight.w400
          ),
          textAlign: TextAlign.start,
          textDirection: AppTextDirection.defaultDirection,
        )
    ));
  }

}
