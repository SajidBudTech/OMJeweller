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
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_om_jeweller/widgets/dashline/dash_line.dart';
import 'package:flutter_om_jeweller/views/similar_product_page.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/widgets/listItem/diamond_listitem_view.dart';
import 'package:intl/intl.dart';

class ProductDetailsViewItem extends StatefulWidget {
  ProductDetailsViewItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;
  @override
  _ProductDetailsViewItemState createState() => _ProductDetailsViewItemState();
}

class _ProductDetailsViewItemState extends State<ProductDetailsViewItem> {
  var format = NumberFormat.currency(locale: 'HI',decimalDigits: 0,customPattern: 'INR #,##,###');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      physics: BouncingScrollPhysics(),
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
                          widget.product.productName == null
                              ? ""
                              : widget.product.productName,
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
                          (widget.product.productCode == null
                                  ? ""
                                  : widget.product.productCode) +
                              "-" +
                              (widget.product.collectionName == null
                                  ? ""
                                  : widget.product.collectionName),
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
                getProductPrice(),
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
                            widget.product.colourName == null
                                ? ""
                                : widget.product.colourName,
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
                            widget.product.netweight == null
                                ? ""
                                : widget.product.netweight,
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
                            textAlign: TextAlign.right,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                      Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(
                              left: AppPaddings.contentPaddingSize,
                              right: AppPaddings.contentPaddingSize),
                          child: Text(
                            widget.product.purityName == null
                                ? ""
                                : widget.product.purityName,
                            style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                    ],
                  ))
            ],
          ),
          UiSpacer.verticalSpace(space: 24),
          Visibility(
              visible: (widget.product.productType == 3 ||
                  widget.product.productType == 4),
              child: Column(
                children: [
                  UiSpacer.divider(
                      thickness: 10, color: AppColor.newDividerColor),
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
                      ))
                ],
              )),
          Visibility(
              visible: (widget.product.productType == 3 ||
                  widget.product.productType == 4),
              child: Column(
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
                                'Purity',
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
                              ))),
                      Expanded(
                          child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(
                                  left: AppPaddings.contentPaddingSize,
                                  right: AppPaddings.contentPaddingSize,
                                  top: 12),
                              child: Text(
                                 widget.product.productType == 3
                                    ? "950 Platinum"
                                    : widget.product.purityName,
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.textColor(context),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
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
                                widget.product.productType==3?"Platinium Wt":"Polki Wt",
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
                              ))),
                      Expanded(
                          child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(
                                  left: AppPaddings.contentPaddingSize,
                                  right: AppPaddings.contentPaddingSize,
                                  top: 10),
                              child: Text(
                                widget.product.productType==3?(widget.product.platiniumweight??""):(widget.product.polkiweight??""),
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.textColor(context),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
                              ))),
                    ],
                  ),
                  Visibility(
                    visible: widget.product.productType==3,
                  child:Row(
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
                                    "Gross Wt",
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                textDirection:
                                AppTextDirection.defaultDirection,
                              ))),
                      Expanded(
                          child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(
                                  left: AppPaddings.contentPaddingSize,
                                  right: AppPaddings.contentPaddingSize,
                                  top: 10),
                              child: Text(
                                getProductGrossWt(),
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.textColor(context),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                textDirection:
                                AppTextDirection.defaultDirection,
                              ))),
                    ],
                  )),
                 /* Row(
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
                                widget.product.productType==3?"Platinium Rate":"Polki Rate",
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
                              ))),
                      Expanded(
                          child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(
                                  left: AppPaddings.contentPaddingSize,
                                  right: AppPaddings.contentPaddingSize,
                                  top: 10),
                              child: Text(
                                widget.product.productType==3?(widget.product.platiniummaking??""):(widget.product.polkiamount??""),
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.textColor(context),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
                              ))),
                    ],
                  ),*/
                 /* Row(
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
                                "Platinium Amount",
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.hintTextColor(context),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
                              ))),
                      Expanded(
                          child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(
                                  left: AppPaddings.contentPaddingSize,
                                  right: AppPaddings.contentPaddingSize,
                                  top: 10),
                              child: Text(
                                getPlatinumAmount(),
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.textColor(context),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                textDirection:
                                    AppTextDirection.defaultDirection,
                              ))),
                    ],
                  ),*/
                  UiSpacer.verticalSpace(space: 24),
                ],
              )),
          Visibility(
              visible: widget.product.productattributes.length > 0,
              child: Column(
                children: [
                  UiSpacer.divider(
                      thickness: 10, color: AppColor.newDividerColor),
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
                      ))
                ],
              )),
          Visibility(
              visible: widget.product.productattributes.length > 0,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  /*decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: RadialGradient(colors: [
                      Colors.grey[200],
                      Colors.grey[400],
                    ], radius: 0.85, focal: Alignment.center),
                  ),*/
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                    ),
                     /* children: widget.product.productattributes.map((diamond){
                return DiamondListViewItem(
                  productattributes: diamond,
                  index: 0,
                );
              }).toList(),*/
                    itemCount: widget.product.productattributes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DiamondListViewItem(
                        productattributes:
                            widget.product.productattributes[index],
                            index: index,
                      );
                    },
                  ),
                ),
                UiSpacer.verticalSpace(space: 30),
              ])),

          /*   Row(
            children: [
              Expanded(
                flex: 1,
                child: Visibility(
                visible: (widget.product.productattributes.length > 0),
                child:Column(
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
                                      (widget.product.productattributes?.length > 0 ? widget.product.productattributes[0].diamondshapeName : ''),
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
                                  (widget.product.productattributes?.length > 0 ? widget.product.productattributes[0].diamondweight : ''),
                                  //widget.product.productattributes[0].diamondweight==null?"":widget.product.productattributes[0].diamondweight,
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
              )),
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
                child: Visibility(
                 visible: (widget.product.productattributes.length>1),
                child:Column(
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
                                  (widget.product.productattributes?.length > 1 ? widget.product.productattributes[1].diamondshapeName : ''),
                                 // widget.product.productattributes[1].diamondshapeName==null?"":widget.product.productattributes[1].diamondshapeName,
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
                                  (widget.product.productattributes?.length > 1 ? widget.product.productattributes[1].diamondweight : ''),
                                 // widget.product.productattributes[1].diamondweight==null?"":widget.product.productattributes[1].diamondweight,
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
              ))
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
                child: Visibility(
                  visible: widget.product.productattributes.length>2,
                child:Column(
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
                                  (widget.product.productattributes?.length > 2 ? widget.product.productattributes[2].diamondshapeName : ''),
                                 // widget.product.productattributes[2].diamondshapeName==null?"":widget.product.productattributes[2].diamondshapeName,
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
                                  (widget.product.productattributes?.length > 2 ? widget.product.productattributes[2].diamondweight : ''),
                                 // widget.product.productattributes[2].diamondweight==null?"":widget.product.productattributes[2].diamondweight,
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
              )),
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
                child:
                Visibility(
                visible: widget.product.productattributes.length>3,
                child:Column(
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
                                  (widget.product.productattributes?.length > 3 ? widget.product.productattributes[3].diamondshapeName : ''),
                                  //widget.product.productattributes[3].diamondshapeName==null?"":widget.product.productattributes[3].diamondshapeName,
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
                                  (widget.product.productattributes?.length > 3 ? widget.product.productattributes[3].diamondweight : ''),
                                 // widget.product.productattributes[3].diamondweight==null?"":widget.product.productattributes[3].diamondweight,
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
              ))
            ],
          ),*/
          SimilarProductPage(
            categoryId: widget.product.categoryID,
          ),
        ],
      ),
    );
  }

  String getProductPrice() {
    double totalAmount = 0;
    double calculatedTotalAmount = 0;
    double calculatedTotalWieght = 0;

    for (Productattributes productattributes
        in widget.product.productattributes) {
      calculatedTotalAmount = calculatedTotalAmount +
          double.parse(productattributes.diamondamount ?? "0");
    }
    for (Productattributes productattributes
        in widget.product.productattributes) {
      calculatedTotalWieght = calculatedTotalWieght +
          double.parse(productattributes.diamondweight ?? "0");
    }

    if (widget.product.productType == 1) {
      double makingCharges = double.parse(widget.product.purityPrice ?? "0") *
          ((widget.product.makingwastage ?? 0) / 100);
      double price =
          ((makingCharges + double.parse(widget.product.purityPrice ?? "0")) *
                  (double.parse(widget.product.netweight))) +
              double.parse(widget.product.stonecharges ?? "0");
      double tax = price * ((widget.product.taxValue ?? 0) / 100);
      totalAmount = price + tax;
    } else if (widget.product.productType == 2) {
      double price = (((double.parse(widget.product.makingcost ?? "0") +
                  double.parse(widget.product.purityPrice ?? "0")) *
              (double.parse(widget.product.netweight)))) +
          (double.parse(widget.product.stonecharges ?? "0")) +
          calculatedTotalAmount;
      double tax = price * ((widget.product.taxValue ?? 0) / 100);

      totalAmount = price + tax;
    } else if (widget.product.productType == 3) {
      double platinumAmount =
          (double.parse(widget.product.platiniummaking ?? "0") + widget.product.platinumRate) *
              (double.parse(widget.product.platiniumweight ?? "0"));

      double price = ((double.parse(widget.product.makingcost ?? "0") +
                  double.parse(widget.product.purityPrice ?? "0")) *
              (double.parse(widget.product.netweight))) +
          platinumAmount +
          (double.parse(widget.product.stonecharges ?? "0")) +
          calculatedTotalAmount;
      double tax = price * ((widget.product.taxValue ?? 0) / 100);

      totalAmount = price + tax;
    } else if (widget.product.productType == 4) {
      double polkiAmount = (double.parse(widget.product.polkiamount ?? "0")) *
          (double.parse(widget.product.polkiweight ?? "0"));

      double price = ((double.parse(widget.product.makingcost ?? "0") +
                  double.parse(widget.product.purityPrice ?? "0")) *
              (double.parse(widget.product.netweight))) +
          polkiAmount +
          (double.parse(widget.product.stonecharges ?? "0")) +
          calculatedTotalAmount;
      double tax = price * ((widget.product.taxValue ?? 0) / 100);

      totalAmount = price + tax;
    }

    return format.format(totalAmount.toInt());
  }

  String getPlatinumAmount(){
    double platinumAmount=0;
    if (widget.product.productType == 3) {
    platinumAmount = (double.parse(widget.product.platiniummaking ?? "0") + widget.product.platinumRate) * (double.parse(widget.product.platiniumweight ?? "0"));
    } else if (widget.product.productType == 4) {
      platinumAmount = (double.parse(widget.product.polkiamount ?? "0")) * (double.parse(widget.product.polkiweight ?? "0"));
    }

    return platinumAmount.toStringAsFixed(2);
  }
  String getProductGrossWt(){
    double grossWt=0;
    if (widget.product.productType == 3) {
      grossWt = (double.parse(widget.product.platiniumweight ?? "0")) + (double.parse(widget.product.netweight ?? "0"));
    } else if (widget.product.productType == 4) {
      grossWt = (double.parse(widget.product.polkiweight ?? "0"))+ (double.parse(widget.product.netweight ?? "0"));
    }

    return grossWt.toStringAsFixed(3);

  }
}
