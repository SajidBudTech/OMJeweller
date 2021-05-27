import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_svg/svg.dart';

class AppointmentTypeListViewItem extends StatefulWidget {
  AppointmentTypeListViewItem({
    Key key,
    @required this.notification,
    @required this.image,
    this.onPressed,
    this.SELECTED_INDEX,
    this.current_index,
  }) : super(key: key);

  // final NotificationModel notification;
  final String notification;
  final String image;
  final Function onPressed;
  final int SELECTED_INDEX;
  final int current_index;

  @override
  _AppointmentTypeListViewItemState createState() =>
      _AppointmentTypeListViewItemState();

}
class _AppointmentTypeListViewItemState extends State<AppointmentTypeListViewItem> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap:widget.onPressed,
        child:Container(
            alignment: Alignment.center,
            width: (AppSizes.getScreenWidth(context)/2)-40,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
                border: Border.all(color: widget.SELECTED_INDEX==widget.current_index?AppColor.accentColor:AppColor.hintTextColor(context)),
                borderRadius: BorderRadius.circular(8)
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.image,
                  width: 34,
                  height: 34,
                  color: widget.SELECTED_INDEX==widget.current_index?AppColor.accentColor:AppColor.hintTextColor(context),
                ),
                Padding(padding: EdgeInsets.only(top: 8),
                  child: Text(
                     widget.notification,
                    style: AppTextStyle.h4TitleTextStyle(
                        color: widget.SELECTED_INDEX==widget.current_index?AppColor.accentColor:AppColor.hintTextColor(context),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  ),)
              ],
            )
        )
    );
  }

}
