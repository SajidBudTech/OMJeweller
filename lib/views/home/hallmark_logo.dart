import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';

class HallMarkLogo extends StatelessWidget {
  HallMarkLogo({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
            padding: EdgeInsets.only(),
            margin: EdgeInsets.only(right: 8),
            // decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
            child: Image.asset(
              'assets/images/foreever.png',
              height: 65,
              width: 120,
            )),
        Container(
            padding: EdgeInsets.only(),
            margin: EdgeInsets.only(right: 8),
            // decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
            child: Image.asset(
              'assets/images/gia.png',
              height: 65,
              width: 120,
            )),
        Container(
            padding: EdgeInsets.only(),
            margin: EdgeInsets.only(right: 8),
            // decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
            child: Image.asset(
              'assets/images/coo.png',
              height: 65,
              width: 120,
            )),
        Container(
            padding: EdgeInsets.only(),
            margin: EdgeInsets.only(right: 8),
            // decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
            child: Image.asset(
              'assets/images/bis.png',
              height: 65,
              width: 120,
            )),
        Container(
            padding: EdgeInsets.only(),
            margin: EdgeInsets.only(right: 8),
            // decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
            child: Image.asset(
              'assets/images/platinum_logo.png',
              height: 65,
              width: 120,
            )),
        Container(
            padding: EdgeInsets.only(),
            margin: EdgeInsets.only(right: 8),
            // decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
            child: Image.asset(
              'assets/images/inter_logo.png',
              height: 65,
              width: 120,
            )),
      ],
    );

    /*Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(),
                margin: EdgeInsets.only(right: 8),
               // decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
                child:Image.asset(
                  'assets/images/foreever.png',
                )

              */ /*  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/face_icon.png",
                      fit: BoxFit.fitHeight,
                      height: 24,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Facebook',
                          style: AppTextStyle.h4TitleTextStyle(
                              color: Color(0xFF475993),
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                          textDirection: AppTextDirection.defaultDirection,
                        ))
                  ],
                )*/ /*


            )),
        */ /*  Container(
          color: AppColor.primaryColorDark,
          height: 65,
          width: 2,
        ),*/ /*
        Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(),
                margin: EdgeInsets.only(left: 1),
               // decoration: BoxDecoration(color: Color(0xFFFFEEFA)),
                child: Image.asset(
                  'assets/images/coo.png',
                    height: 65,

                )

              */ /* Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/insta_icon.png",
                      fit: BoxFit.fitHeight,
                      height: 24,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Instagram',
                          style: AppTextStyle.h4TitleTextStyle(
                              color: Color(0xFFC74950),
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                          textDirection: AppTextDirection.defaultDirection,
                        ))
                  ],
                )*/ /*

            )),
        */ /*Container(
          color: AppColor.primaryColorDark,
          height: 65,
          width: 2,
        ),*/ /*
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(),
                margin: EdgeInsets.only(left: 8),
                //decoration: BoxDecoration(color: Color(0xFFFFF2EE)),
                child:Image.asset(
                  'assets/images/coo.png',
                )

*/ /*                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/p_icon.png",
                      fit: BoxFit.fitHeight,
                      height: 24,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Pintrest',
                          style: AppTextStyle.h4TitleTextStyle(
                              color: Color(0xFFCB2027),
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                          textDirection: AppTextDirection.defaultDirection,
                        ))
                  ],
                )*/ /*

            )),
      ],
    );*/
  }
}
