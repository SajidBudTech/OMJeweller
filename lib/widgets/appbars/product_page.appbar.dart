import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';

class ProductPageAppBar extends StatelessWidget {
  final ProductPageViewModel model;
  final String productName;
  const ProductPageAppBar({
    this.model,
    this.productName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.transparent,
      title: Text(model.makeAppBarTransparent ? "" : productName,style: AppTextStyle.h3TitleTextStyle()),
      backgroundColor: model.makeAppBarTransparent ? Colors.transparent : AppColor.newprimaryColor,
      elevation: 0,
      leading: FlatButton(
        child: Icon(
          Icons.arrow_back_sharp,
          color: model.makeAppBarTransparent
              ? Color(0xFF7C7C7C)
              : Color(0xFF7C7C7C),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      bottom: model.makeAppBarTransparent
          ? null
          : PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(color: AppColor.newprimaryColor),

      ),

      /*TabBar()
              labelColor: AppColor.textColor(
                context,
                inverse: true,
              ),
              unselectedLabelColor:
                  AppColor.bottomNavigationItemUnselectedColor(context),
              isScrollable: true,
              indicatorWeight: 4.0,
              indicatorPadding: EdgeInsets.all(0),
              indicatorColor: AppColor.accentColor,
              labelStyle: AppTextStyle.h4TitleTextStyle(),
              unselectedLabelStyle: AppTextStyle.h5TitleTextStyle(),
              tabs: model.menus.map(
                (menu) {
                  return Tab(
                    text: menu.name,
                  );
                },
              ).toList(),
            ),*/
    );
  }
}
