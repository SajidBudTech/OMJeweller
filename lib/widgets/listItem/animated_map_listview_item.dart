import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/widgets/listItem/visit_store_listview_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_om_jeweller/data/models/wishlist_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AnimatedMapListViewItem extends StatelessWidget {
  final int index;
  final String address;
  final String location;
  final String phone;
  final LatLng latLng;

  final Widget listViewItem;
  const AnimatedMapListViewItem(
      {this.index, this.address,this.location,this.phone,this.latLng, this.listViewItem, Key key})
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
              VisitStoreListViewItem(
                address: address,
                location: location,
                phone: phone,
                latLng: latLng,
              ),
        ),
      ),
    );
  }
}
