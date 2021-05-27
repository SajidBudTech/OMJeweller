import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';

class PlatformCircularProgressIndicator extends StatelessWidget {
  const PlatformCircularProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator()
        : SizedBox(
            child: CircularProgressIndicator(
              backgroundColor: AppColor.disableColor,
            ),
            width: 24,
            height: 24,
          );
  }
}
