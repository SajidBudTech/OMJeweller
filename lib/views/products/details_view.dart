import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/data/models/wishlist_data.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_om_jeweller/widgets/dashline/dash_line.dart';
import 'package:flutter_om_jeweller/views/similar_product_page.dart';

class ProductDetailsViewItem extends StatefulWidget {
  ProductDetailsViewItem({
    Key key,
    @required this.vendor,
  }) : super(key: key);

  final String vendor;
  @override
  _ProductDetailsViewItemState createState() => _ProductDetailsViewItemState();
}

class _ProductDetailsViewItemState extends State<ProductDetailsViewItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: AppPaddings.defaultPadding(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: AppPaddings.contentPaddingSize,
                right: AppPaddings.contentPaddingSize,
                top: AppPaddings.contentPaddingSize),
            child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 3),
                        child: Text(
                          'DIamond Pendant',
                          style: AppTextStyle.h3TitleTextStyle(
                              color: AppColor.textColor(context),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                          textDirection: AppTextDirection.defaultDirection,
                        ))),
                Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(bottom: 3),
                        child: Text(
                          'GKD-0001-J',
                          style: AppTextStyle.h7TitleTextStyle(
                              color: AppColor.hintTextColor(context),
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.right,
                          textDirection: AppTextDirection.defaultDirection,
                        ))),
              ],
            ),
          ),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: AppPaddings.contentPaddingSize,
                  right: AppPaddings.contentPaddingSize),
              child: Text(
                '5,69,203',
                style: AppTextStyle.h3TitleTextStyle(
                    color: AppColor.accentColor, fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              )),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: AppPaddings.contentPaddingSize,
                  right: AppPaddings.contentPaddingSize),
              child: Text(
                'Inclusive of all taxes',
                style: AppTextStyle.h7TitleTextStyle(
                    color: AppColor.hintTextColor(context),
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              )),
          UiSpacer.verticalSpace(space: 24),
          UiSpacer.divider(thickness: 10, color: AppColor.newDividerColor),
          UiSpacer.verticalSpace(space: 24),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: AppPaddings.contentPaddingSize,
                  right: AppPaddings.contentPaddingSize),
              child: Text(
                'Gold',
                style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.textColor(context),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              )),
          Row(
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
                              top: 12),
                          child: Text(
                            'Colour',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize),
                          child: Text(
                            'Rose',
                            style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 12),
                          child: Text(
                            'Net Weight',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                      Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize),
                          child: Text(
                            '85 gms',
                            style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 12),
                          child: Text(
                            'Purity',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.hintTextColor(context),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                      Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize),
                          child: Text(
                            '18kt',
                            style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                    ],
                  ))
            ],
          ),
          UiSpacer.verticalSpace(space: 24),
          UiSpacer.divider(thickness: 10, color: AppColor.newDividerColor),
          UiSpacer.verticalSpace(space: 24),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: AppPaddings.contentPaddingSize,
                  right: AppPaddings.contentPaddingSize),
              child: Text(
                'Metal Specification',
                style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.textColor(context),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              )),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 12),
                          child: Text(
                            'Colour',
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
                              top: 12),
                          child: Text(
                            'Yellow',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 10),
                          child: Text(
                            'Purity',
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
                              top: 10),
                          child: Text(
                            '22kt',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 10),
                          child: Text(
                            'Gross weight',
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
                              top: 10),
                          child: Text(
                            '100gms',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize,
                              top: 10),
                          child: Text(
                            'Net weight',
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
                              top: 10),
                          child: Text(
                            '85gms',
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ))),
                ],
              )
            ],
          ),
          UiSpacer.verticalSpace(space: 24),
          UiSpacer.divider(thickness: 10, color: AppColor.newDividerColor),
          UiSpacer.verticalSpace(space: 24),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: AppPaddings.contentPaddingSize,
                  right: AppPaddings.contentPaddingSize,
                  bottom: 12),
              child: Text(
                'Diamond Specification',
                style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.textColor(context),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              )),
          Row(
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
                          'Diamond 1',
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
                                  'Square',
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
                                  '0.5',
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
              ),
              Padding(padding: EdgeInsets.only(left: 12,right: 12,top: 12),
                  child:DottedLine(
                    direction: Axis.vertical,
                    lineLength: 48,
                    lineThickness: 0.5,
                    dashLength: 2.0,
                    dashColor: AppColor.accentColor,
                    dashGapLength: 3.0,
                    dashGapColor: Colors.transparent,
                  )),
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
                          'Diamond 2',
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
                                  'Square',
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
                                  '0.5',
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
            ],
          ),

          Padding(padding: EdgeInsets.only(top: 18,bottom: 18,left: 20,right: 20),
              child:DashLine(
                color: AppColor.accentColor,
                height: 0.5,
              )),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            left: AppPaddings.contentPaddingSize,
                            right: AppPaddings.contentPaddingSize),
                        child: Text(
                          'Diamond 3',
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
                                  'Square',
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
                                  '0.5',
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
              ),
              Padding(padding: EdgeInsets.only(left: 12,right: 12,top: 12),
                  child:DottedLine(
                    direction: Axis.vertical,
                    lineLength: 48,
                    lineThickness: 0.5,
                    dashLength: 2.0,
                    dashColor: AppColor.accentColor,
                    dashGapLength: 3.0,
                    dashGapColor: Colors.transparent,
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            left: AppPaddings.contentPaddingSize,
                            right: AppPaddings.contentPaddingSize),
                        child: Text(
                          'Diamond 4',
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
                                  'Square',
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
                                  '0.5',
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
            ],
          ),
          UiSpacer.verticalSpace(space: 30),
          SimilarProductPage(),
        ],
      ),
    );
  }
}
