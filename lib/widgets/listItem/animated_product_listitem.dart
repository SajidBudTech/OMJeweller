import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_om_jeweller/data/models/wishlist_data.dart';

class AnimatedProdcutListViewItem extends StatelessWidget {
  final int index;
  final Wishlist vendor;
  final Widget listViewItem;
  const AnimatedProdcutListViewItem(
      {this.index, this.vendor, this.listViewItem, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 100),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: listViewItem ??
              ProductListViewItem(
                vendor: vendor,
              ),
        ),
      ),
    );
  }
}
