import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerticalConnectorLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        DottedLine(
          direction: Axis.vertical,
          lineLength: 24,
          lineThickness: 0.5,
          dashLength: 2.0,
          dashColor: Color(0xFFD09C68),
          dashGapLength: 3.0,
          dashGapColor: Colors.transparent,
        ),
        SvgPicture.asset('assets/images/ploy_verti.svg'),
        DottedLine(
          direction: Axis.vertical,
          lineLength: 24,
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