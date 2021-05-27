import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';

class DiamondListViewItem extends StatefulWidget {
  DiamondListViewItem({
    Key key,
    @required this.productattributes,
    @required this.index,
  }) : super(key: key);

  final Productattributes productattributes;
  final int index;
  @override
  _DiamondListViewItemState createState() =>
      _DiamondListViewItemState();
}

class _DiamondListViewItemState extends State<DiamondListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0.5,
            color:  Colors.grey[400],
          )
        )
      ),
      child:Row(
        children: [
        Expanded(
        flex: 1,
        child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                      left: AppPaddings.contentPaddingSize,
                      right: AppPaddings.contentPaddingSize,
                      top: 10),
                  child: Text(
                    'Diamond '+(widget.index+1).toString(),
                    style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.textColor(context),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  )),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 6),
                          child: Text(
                            'Shape',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),
                  Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 6),
                          child: Text(
                            'weight',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),

                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize),
                          child: Text(
                            widget.productattributes.diamondshapeName??"",
                            style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),
                  Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize),
                          child: Text(
                            widget.productattributes.diamondweight??"",
                            style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),

                ],
              )


            ],
          ),
        )
    ]));
  }

}


