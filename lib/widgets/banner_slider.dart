import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/constants/api.dart';

class BannerSlider extends StatefulWidget {
  final Function(AdvertismentBanner) onBannerTapped;
  BannerSlider({@required this.onBannerTapped, Key key}) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      onModelReady: (model) => model.fetchScrollingBanners(),
      builder: (context, model, child) {
        return model.isBusy
            ? Padding(
          padding: AppPaddings.defaultPadding(),
          child: VendorShimmerListViewItem(),
        )
            : model.hasError
            ? LoadingStateDataView(
          stateDataModel: StateDataModel(
            showActionButton: true,
            actionButtonStyle: AppTextStyle.h4TitleTextStyle(
              color: Colors.red,
            ),
            actionFunction: () => model.fetchScrollingBanners(),
          ),
        )
            : Container(
          child: Column(
            children: [
              CarouselSlider(
                items: _getImageSliders(model.scrollingBanners),
                options: CarouselOptions(
                  autoPlay: true,
                  height: 186,
                  enlargeCenterPage: false,
                  //aspectRatio: 2.4,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: model.scrollingBanners.map(
                      (banner) {
                    int index = model.scrollingBanners.indexOf(banner);
                    return Container(
                      width: 7.0,
                      height: 7.0,
                      margin: EdgeInsets.only(top: 12,left: 6,right: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? AppColor.accentColor
                            : Color(0xFFDFDCDC),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  int _current = 0;
  List<Widget> _getImageSliders(List<AdvertismentBanner> banners) {
    return banners
        .map(
          (banner) => Container(
        child: ClipRRect(
          /*borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),*/
          child: InkWell(
            onTap: () => widget.onBannerTapped(banner),
            child: CachedNetworkImage(
              imageUrl: Api.downloadUrlPath+banner.bannerImage,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    )
        .toList();
  }
}
