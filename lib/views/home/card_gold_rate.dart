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
      onModelReady: (model) => model.fetchGoldRate(),
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
            actionFunction: () => model.fetchGoldRate(),
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              colors: <Color>[
                Color(0XFFEF9783),
                Color(0XFFD36F50),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current Gold Rate',
                style: AppTextStyle.h3TitleTextStyle(
                  color: Colors.white,
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
                color: Colors.white,
                height: 0.5,
              )),
              UiSpacer.verticalSpace(space: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Expanded(
                    flex: 1,
                      child:Padding(padding: EdgeInsets.only(left: 10,right: 10),
                          child:Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Text(
                           'For 1 Gram of 22KT BIS HALLMARKED JEWELLERY',
                           style: AppTextStyle.h6TitleTextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.w400
                           ),
                           textAlign: TextAlign.center,
                           textDirection: AppTextDirection.defaultDirection,
                         ),
                         Text(
                           'Rs.'+(model.karate22Price??""),
                           style: AppTextStyle.h16TitleTextStyle(
                             color: Colors.white,
                           ),
                           textAlign: TextAlign.center,
                           textDirection: AppTextDirection.defaultDirection,
                         ),
                       ],

                      )
                  )),
                  SizedBox(width: 8,),
                  Padding(padding: EdgeInsets.only(top: 8),
                  child:DottedLine(
                    direction: Axis.vertical,
                    lineLength: 48,
                    lineThickness: 0.5,
                    dashLength: 2.0,
                    dashColor: Colors.white,
                    dashGapLength: 3.0,
                    dashGapColor: Colors.transparent,
                  )),
                  SizedBox(width: 8,),
                  Expanded(
                      flex: 1,
                      child:Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'For 1 Gram of 18KT BIS HALLMARKED JEWELLERY',
                            style: AppTextStyle.h6TitleTextStyle(
                              color: Colors.white,
                                fontWeight: FontWeight.w400
                            ),
                            textAlign: TextAlign.center,
                            textDirection: AppTextDirection.defaultDirection,
                          ),
                          Text(
                            'Rs.'+(model.karate18Price??""),
                            style: AppTextStyle.h16TitleTextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: AppTextDirection.defaultDirection,
                          ),
                        ],
                      )
                  ))

                ],
              ),
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
