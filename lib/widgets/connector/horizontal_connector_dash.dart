import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HorizontalConnectorLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        DottedLine(
          direction: Axis.horizontal,
          lineLength: 28,
          lineThickness: 0.5,
          dashLength: 2.0,
          dashColor: Color(0xFFD09C68),
          dashGapLength: 3.0,
          dashGapColor: Colors.transparent,
        ),
        SvgPicture.asset('assets/images/ploy_hori.svg'),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: 28,
          lineThickness: 0.5,
          dashLength: 2.0,
          dashColor: Color(0xFFD09C68),
          dashGapLength: 3.0,
          dashGapColor: Colors.transparent,
        ),
      ],
    );
  }
}