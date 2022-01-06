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
import 'package:flutter_om_jeweller/widgets/expandable/expandable_listview_item.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/svg.dart';

class FAQListViewItem extends StatefulWidget {
  FAQListViewItem({
    Key key,
    @required this.question,
    @required this.answer,
  }) : super(key: key);

  final String question;
  final String answer;
  @override
  _FAQListViewItemState createState() => _FAQListViewItemState();
}

class _FAQListViewItemState extends State<FAQListViewItem> {
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
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
      child:AppExpansionTile(
           key: expansionTile,
           title: Text(widget.question??"",
             style: AppTextStyle.h4TitleTextStyle(
               fontWeight: FontWeight.w500,
               color: AppColor.textColor(context),
             ),
             //overflow: TextOverflow.ellipsis,
             textDirection: AppTextDirection.defaultDirection,
           ),
          children: [
            new ListTile(
              title: Text(widget.answer??"",
                style: AppTextStyle.h5TitleTextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColor.hintTextColor(context),
                ),
                //overflow: TextOverflow.ellipsis,
                textDirection: AppTextDirection.defaultDirection,
              ),
              onTap: () {
                setState(() {
                  expansionTile.currentState.collapse();
                });
              },
            ),
           ],
          /* trailing: Icon(
             Icons.arrow_drop_down_circle_outlined,color: Color(0xFF2C2C2C),size: 19,
           ),*/
          )
        );
  }
}
