import 'dart:async';

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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/svg.dart';

class CompanyListViewItem extends StatefulWidget {
  CompanyListViewItem({
    Key key,
    @required this.name,
    @required this.post,
  }) : super(key: key);

  final String name;
  final String post;
  @override
  _CompanyListViewItemState createState() => _CompanyListViewItemState();
}

class _CompanyListViewItemState extends State<CompanyListViewItem> {

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(19.155001,72.849998);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      // margin: EdgeInsets.only(bottom: 4),
      child: Column(children: <Widget>[
        Container(
          // alignment: Alignment.topRight,
          // margin: EdgeInsets.only(top: 16),
          height: 147,
          decoration: BoxDecoration(
            color: Color(0xFFC4C4C4),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            textDirection: AppTextDirection.defaultDirection,
            children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                         widget.name,
                        style: AppTextStyle.h5TitleTextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColor.textColor(context),
                        ),
                        overflow: TextOverflow.ellipsis,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                  Container(
                      alignment: Alignment.center,
                      //margin: EdgeInsets.only(left: 18,bottom: 4),
                      child:Text(
                        widget.post,
                        style: AppTextStyle.h7TitleTextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColor.hintTextColor(context),
                        ),
                      //  overflow: TextOverflow.ellipsis,
                        textDirection: AppTextDirection.defaultDirection,
                      )
                      ),

              //UiSpacer.divider(thickness: 0.5,color: AppColor.hintTextColor(context)),
            ],
          ),
        ),
      ]),
    );
    // );
  }
}
