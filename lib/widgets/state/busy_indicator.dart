import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';

class BusyIndicator extends StatelessWidget {
  const BusyIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: AppColor.disableColor,
        ),
      ),
    );
  }
}
