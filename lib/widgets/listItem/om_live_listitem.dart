import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class OMLiveListItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  OMLiveListItems(
      {@required this.videoPlayerController,
      this.looping,
      this.autoplay,
      Key key})
      : super(key: key);

  @override
  _OMLiveListItemsState createState() => _OMLiveListItemsState();
}

class _OMLiveListItemsState extends State<OMLiveListItems> {
  ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16/9,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: AppTextStyle.h4TitleTextStyle(color: Colors.red),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      onModelReady: (model) => model.fetchOMLive(),
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
                    width: (AppSizes.getScreenWidth(context))-40,
                    margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /*Expanded(
                          flex: 2,
                        child:
                        Container(
                            padding: EdgeInsets.only(top: 16, bottom: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                            child: Text(
                              'DE BEERS GROUP',
                              style: AppTextStyle.h4TitleTextStyle(
                                color: AppColor.textColor(context),
                              ),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            ))),*/
                             Expanded(
                                flex: 8,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16))),
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 0, bottom: 0),
                                          child: Chewie(
                                            controller: _chewieController,
                                            key: widget.key,
                                          )))),
                        Expanded(
                          flex: 2,
                     child:Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColor.newprimaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            child: Text(
                              'There\'s no much change between the photo shown',
                              style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.center,
                              textDirection: AppTextDirection.defaultDirection,
                            ))),
                      ],
                    ),
                  );
      },
    );
  }

/*int _current = 0;
  List<Widget> _getImageSliders(List<CategoryBanner> banners) {
    return banners
        .map(
          (banner) => Container(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
          child: InkWell(
            onTap: () => widget.onBannerTapped(banner),
            child: Image(
              image: AssetImage(banner.image),
              //imageUrl: banner.image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    )
        .toList();
  }*/
}
