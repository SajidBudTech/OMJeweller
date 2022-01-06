import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_om_jeweller/data/models/wishlist_data.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';

class AnimatedProdcutListViewItem extends StatelessWidget {
  final int index;
  final Product product;
  final Widget listViewItem;
  final double platinumRate;
  const AnimatedProdcutListViewItem(
      {this.index, this.product, this.listViewItem,this.platinumRate, Key key})
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
                product: product,
                platinumRate: platinumRate,
              ),
        ),
      ),
    );
  }
}
