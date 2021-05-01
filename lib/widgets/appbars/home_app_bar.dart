import 'package:flutter/material.dart';

class HomeAppBar extends AppBar with PreferredSizeWidget {
  @override
  get preferredSize => Size.fromHeight(0);

  HomeAppBar({
    Key key,
    Color backgroundColor,
    Brightness brightness,
  }) : super(
    key: key,
    backgroundColor: backgroundColor,
    brightness: brightness,
    automaticallyImplyLeading: false, // hides leading widget
    flexibleSpace: SizedBox.shrink(),
    elevation: 3,
  );

  


}
