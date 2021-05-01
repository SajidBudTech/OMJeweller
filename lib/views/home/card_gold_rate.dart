import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/dashline/dash_line.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';

class CardGoldRate extends StatefulWidget {
  CardGoldRate({Key key}) : super(key: key);

  @override
  _CardGoldRateState createState() => _CardGoldRateState();
}

class _CardGoldRateState extends State<CardGoldRate> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      onModelReady: (model) => model.fetchBanners(),
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
            actionFunction: () => model.fetchBanners(),
          ),
        )
            :
        Card(
            margin:AppPaddings.defaultPadding(),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child:Container(
          padding: EdgeInsets.only(top: 12,bottom: 13),
          color: AppColor.goldRateBackColor,
          child: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current Rate',
                style: AppTextStyle.h3TitleTextStyle(
                  color: AppColor.accentColor,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              ),
              /*Text(
                'Today’s Gold Price in Mumbai. At OM showroom',
                style: AppTextStyle.h5TitleTextStyle(
                  color: AppColor.hintTextColor(context),
                ),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              ),*/
              UiSpacer.verticalSpace(space: 12),
              Padding(padding: EdgeInsets.only(left: 20,right: 20),
              child:DashLine(
                color: AppColor.accentColor,
                height: 0.5,
              )),
              UiSpacer.verticalSpace(space: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                      child:Column(
                       children: [
                         Text(
                           '18 Karat Gold Rate',
                           style: AppTextStyle.h7TitleTextStyle(
                             color: AppColor.textColor(context),
                             fontWeight: FontWeight.w400
                           ),
                           textAlign: TextAlign.start,
                           textDirection: AppTextDirection.defaultDirection,
                         ),
                         Text(
                           '₹43,870',
                           style: AppTextStyle.h4TitleTextStyle(
                             color: AppColor.accentColor,
                           ),
                           textAlign: TextAlign.start,
                           textDirection: AppTextDirection.defaultDirection,
                         ),
                       ],

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 8),
                  child:DottedLine(
                    direction: Axis.vertical,
                    lineLength: 48,
                    lineThickness: 0.5,
                    dashLength: 2.0,
                    dashColor: AppColor.accentColor,
                    dashGapLength: 3.0,
                    dashGapColor: Colors.transparent,
                  )),
                  Expanded(
                      flex: 1,
                      child:Column(
                        children: [
                          Text(
                            '22 Karat Gold Rate',
                            style: AppTextStyle.h7TitleTextStyle(
                              color: AppColor.textColor(context),
                                fontWeight: FontWeight.w400
                            ),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ),
                          Text(
                            '₹43,870',
                            style: AppTextStyle.h4TitleTextStyle(
                              color: AppColor.accentColor,
                            ),
                            textAlign: TextAlign.start,
                            textDirection: AppTextDirection.defaultDirection,
                          ),
                        ],
                      )
                  )

                ],
              ),
             /* Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 16,top: 8),
                child: Text(
                  'Updated on 15 March 2021 at 12:00 AM',
                  style: AppTextStyle.h6TitleTextStyle(
                    color: AppColor.hintTextColor(context),
                  ),
                  textAlign: TextAlign.start,
                  textDirection: AppTextDirection.defaultDirection,
                ),
              )*/

              /*CarouselSlider(
                items: _getImageSliders(model.banners),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),*/
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: model.banners.map(
                      (banner) {
                    int index = model.banners.indexOf(banner);
                    return Container(
                      width: 12.0,
                      height: 4.0,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _current == index
                            ? AppColor.primaryColorDark
                            : AppColor.accentColor,
                      ),
                    );
                  },
                ).toList(),
              ),*/
            ],
          ),
        )
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
