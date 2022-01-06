import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';

class SearchGroupedVendorsListView extends StatelessWidget {
  const SearchGroupedVendorsListView({
    Key key,
    @required this.title,
    this.products,
    this.platinumRate,
    this.titleTextStyle,
  }) : super(key: key);

  final String title;
  final TextStyle titleTextStyle;
  final List<Product> products;
  final double platinumRate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Text(
          title,
          style: this.titleTextStyle ??
              AppTextStyle.h2TitleTextStyle(
                color: AppColor.textColor(context),
              ),
          textDirection: AppTextDirection.defaultDirection,
        ),
        UiSpacer.verticalSpace(space: 20),
        ..._buildVendorsWidgetList(context),
        UiSpacer.verticalSpace(space: 30),
      ],
    );
  }

  List<Widget> _buildVendorsWidgetList(BuildContext context) {
    List<Widget> vendorsWidget = [];

    //create vendor widget out of the vendors data available
    if (products != null) {
      products.asMap().forEach(
            (index, product) {
          //prepare the vendor widget
       //   final Vendor vendor=Vendor();
         // vendor.id=product.vendorId;
         // vendor.currency=product.currency;
          final vendorWidget = AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ProductListViewItem(
                  product: product,
                  platinumRate: platinumRate,
                ),
              ),
            ),
          );

          //append the new vendor widget to the list
          vendorsWidget.add(vendorWidget);
        },
      );
    } else {
      //add a shimmer widget
      vendorsWidget.add(
        // VendorShimmerListViewItem(),
        Column(
            children: <Widget>[
              Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  child:PlatformCircularProgressIndicator()
              ),
              UiSpacer.verticalSpace(space: 30),
              Text(
                "Loading... Please Wait",
                style: this.titleTextStyle ??
                    AppTextStyle.h6TitleTextStyle(
                      color: AppColor.textColor(context),
                    ),
                textDirection: AppTextDirection.defaultDirection,
              ),

            ]
        ),
      );
    }

    return vendorsWidget;
  }
}
