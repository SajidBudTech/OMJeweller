import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_outline_button.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';

class MyAppointmentSlider extends StatefulWidget {
  final Function(CategoryBanner) onBannerTapped;
  MyAppointmentSlider({@required this.onBannerTapped, Key key}) : super(key: key);

  @override
  _MyAppointmentSliderState createState() => _MyAppointmentSliderState();
}

class _MyAppointmentSliderState extends State<MyAppointmentSlider> {
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
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CarouselSlider(
                items: _getPageSliders(model.banners,context),
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1/1.4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _current = 0;
  List<Widget> _getPageSliders(List<CategoryBanner> banners, BuildContext context) {
    return banners
        .map((banner) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           // Expanded(child:
                Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 3),
                child:Text(
                  "In 3 days",
                  style: AppTextStyle.h4TitleTextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor(context),
                  ),
                  overflow: TextOverflow.ellipsis,
                  textDirection: AppTextDirection.defaultDirection,
                )),
      //),
             //Expanded(child:
             Container(
                alignment: Alignment.topLeft,
                 margin: EdgeInsets.only(bottom: 13),
                child:Text(
                  "In Store Visit appointment at Om Jewellers - Borivali",
                  style: AppTextStyle.h16TitleTextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.textColor(context),
                  ),
                  textDirection: AppTextDirection.defaultDirection,
                )),
    //),
       // Expanded(child:
        Row(
              children: [
                SvgPicture.asset(
                  'assets/images/my_app_cal.svg',
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'January 25',
                      style: AppTextStyle.h5TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                      textDirection: AppTextDirection.defaultDirection,
                    ))
              ],
            ),
            UiSpacer.verticalSpace(space: 13),
        Row(
              children: [
                SvgPicture.asset(
                  'assets/images/my_app_time.svg',
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      '12:30 PM',
                      style: AppTextStyle.h5TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                      textDirection: AppTextDirection.defaultDirection,
                    ))
              ],
            ),
    //),
        /* Expanded(
           child:*/
            UiSpacer.verticalSpace(space: 13),
           Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SvgPicture.asset(
                  'assets/images/dra_visit.svg',
                ),
                Expanded(
                    child:Padding(
                        padding: EdgeInsets.only(left: 8),
                    child:Text(
                      'Ground Floor, Shangrila Apartments, LT Road, Near Borivali Station, Borivali West, Mumbai,Maharashtra 400092',
                      style: AppTextStyle.h5TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                      textDirection: AppTextDirection.defaultDirection,
                    ))
                ),
              ],
            ),
       // ),
            UiSpacer.verticalSpace(space: 3),
            Container(
              padding: EdgeInsets.only(left: 22),
                alignment:Alignment.topLeft,
                child:InkWell(
                  child: Text(
                    'Directions',
                    style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.accentColor,
                        decoration:TextDecoration.underline,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  ),
                  onTap: (){

                  },
                )),
            UiSpacer.verticalSpace(space: 13),
             Row(
              children: [
                SvgPicture.asset(
                  'assets/images/my_app_call.svg',
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      '02261587000',
                      style: AppTextStyle.h5TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                      textDirection: AppTextDirection.defaultDirection,
                    ))
              ],
            ),
            UiSpacer.verticalSpace(space: 24),
            Container(
              alignment: Alignment.topLeft,
              child: CustomOutlineButton(
                padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                width: 143,
                title: "Reschedule",
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    AppRoutes.dateTimeRoute,
                    arguments: false,
                  );
                },
              ),
            )
          ],
        )

    /*    ClipRRect(
          *//*borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),*//*
          child: InkWell(
            onTap: () => widget.onBannerTapped(banner),
            child: Image(
              image: AssetImage(banner.image),
              //imageUrl: banner.image,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),*/
      ),
    )
        .toList();
  }
}
