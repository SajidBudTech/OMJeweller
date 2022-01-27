import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/views/home/advertiment_banner_page.dart';
import 'package:flutter_om_jeweller/views/home/card_gold_rate.dart';
import 'package:flutter_om_jeweller/views/home/social_views.dart';
import 'package:flutter_om_jeweller/widgets/banner_slider.dart';
import 'package:flutter_om_jeweller/widgets/custome_drawer.dart';
import 'package:flutter_om_jeweller/widgets/listItem/new_arrival_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/om_live_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/shop_by_categories_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/shop_by_collection_bottom_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/shop_by_collections_listitem.dart';
import 'package:flutter_om_jeweller/widgets/listItem/shop_by_product_listitem.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_om_jeweller/views/home/hallmark_logo.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/subcategory.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/page_arguments.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/data/models/product_arguments.dart';
import 'package:flutter_om_jeweller/constants/api.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with AutomaticKeepAliveClientMixin<MainHomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<MainHomeViewModel>.reactive(
      viewModelBuilder: () => MainHomeViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [ //
           /* SliverToBoxAdapter(
              child: UiSpacer.verticalSpace(),
            ),*/
            //banners
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                  top: 19,
                ),
                child: BannerSlider(
                  //search base on the category select from the banner
                  onBannerTapped: (value){
                    if(value.bannertype=="category"){
                      Category category=Category();
                      category.categoryID=value.bannerID;
                      category.categoryName=value.bannertype;
                      Navigator.pushNamed(
                          context,
                          AppRoutes.productListPageRoute,
                          arguments: PageArguments(
                              category: category,
                              subCategory: null,
                              collection: null
                          )
                      );
                    }else if(value.bannertype=="subcategory"){
                      Subcategory subategory=Subcategory();
                      subategory.subcategoryID=value.bannerID;
                      subategory.subcategoryName=value.bannertype;
                      Navigator.pushNamed(
                          context,
                          AppRoutes.productListPageRoute,
                          arguments: PageArguments(
                              category: null,
                              subCategory: subategory,
                              collection: null
                          )
                      );
                    }else if(value.bannertype=="collection"){
                      Collection collection=Collection();
                      collection.collectionID=value.bannerID;
                      collection.collectionName=value.bannertype;
                      Navigator.pushNamed(
                          context,
                          AppRoutes.productListPageRoute,
                          arguments: PageArguments(
                              category: null,
                              subCategory: null,
                              collection: collection
                          )
                      );
                    }else if(value.bannertype=="product"){
                      Product product=Product();
                      product.productID=value.bannerID;
                      product.productName=value.bannertype;
                      Navigator.pushNamed(
                          context,
                          AppRoutes.productDetailRoute,
                          arguments: ProductArguments(
                             product: product,
                             status: false
                          )
                      );
                    }

                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
           /* SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 8),
            ),*/
            SliverToBoxAdapter(
              child:CardGoldRate(),
            ),
          /*  SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),*/
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),
            SliverToBoxAdapter(
              child:
              Container(
                alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 12),
                  child:Text(
                'Shop by Products',
                style: AppTextStyle.h4TitleTextStyle(
                  color: AppColor.accentColor,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.start,
                textDirection: AppTextDirection.defaultDirection,
              )),
            ),
            SliverToBoxAdapter(
                child: AdvertismentSliderPage()
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 12),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),

            /*SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height:160,
                  child: model.categoriesLoadingState == LoadingState.Loading
                  //the loadinng shimmer
                      ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.contentPaddingSize,
                    ),
                    child: VendorShimmerListViewItem(),
                  )
                  // the faild view
                      : model.categoriesLoadingState == LoadingState.Failed
                      ? LoadingStateDataView(
                    stateDataModel: StateDataModel(
                      showActionButton: true,
                      actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                        color: Colors.red,
                      ),
                      actionFunction: model.getCategories,
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.categoriesnewArrival.length,
                    padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                    separatorBuilder: (context, index) =>
                        UiSpacer.horizontalSpace(space: 0),
                    itemBuilder: (context, index) {
                      return NewArrivalListViewItem(
                        category: model.categoriesnewArrival[index],
                        onPressed: model.openCategorySearchPage,
                      );
                    },
                  ),

                )
            ),*/
            SliverToBoxAdapter(
              child:
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 13),
                  child:Text(
                    'New Arrivals',
                    style: AppTextStyle.h4TitleTextStyle(
                      color: AppColor.accentColor,
                        fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  )
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height:195,
                  child: model.newArrivalLoadingState == LoadingState.Loading
                  //the loadinng shimmer
                      ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.contentPaddingSize,
                    ),
                    child: VendorShimmerListViewItem(),
                  )
                  // the faild view
                      : model.newArrivalLoadingState == LoadingState.Failed
                      ? LoadingStateDataView(
                    stateDataModel: StateDataModel(
                      showActionButton: true,
                      actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                        color: Colors.red,
                      ),
                      actionFunction: model.getNewArrival,
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.newArrivalList.length,
                    padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                    separatorBuilder: (context, index) =>
                        UiSpacer.horizontalSpace(space: 0),
                    itemBuilder: (context, index) {
                      return NewArrivalListViewItem(
                         product: model.newArrivalList[index],
                      );
                    },
                  ),

                )
            ),
           /* SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 24),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),*/
            /*SliverToBoxAdapter(
              child:
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 12),
                  child:Text(
                    'Panchang',
                    style: AppTextStyle.h4TitleTextStyle(
                      color: AppColor.accentColor,
                      fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  )),
            ),*/
            /*SliverToBoxAdapter(
              child:
              Container(
                  width: (AppSizes.getScreenWidth(context))-46,
                  height: 160,
                  margin: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/panchang.png",
                          ),
                          fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(10)
                  )
            )),*/
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 24),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),
            SliverToBoxAdapter(
              child:
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 12),
                  child:Text(
                    'Shop by Collections',
                    style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.accentColor,
                        fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  )
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height:196,
                  child: model.collectionLoadingState == LoadingState.Loading
                  //the loadinng shimmer
                      ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.contentPaddingSize,
                    ),
                    child: VendorShimmerListViewItem(),
                  )
                  // the faild view
                      : model.collectionLoadingState == LoadingState.Failed
                      ? LoadingStateDataView(
                    stateDataModel: StateDataModel(
                      showActionButton: true,
                      actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                        color: Colors.red,
                      ),
                      actionFunction: model.getCategories,
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.collections.length,
                    padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                    separatorBuilder: (context, index) =>
                        UiSpacer.horizontalSpace(space: 0),
                    itemBuilder: (context, index) {
                      return ShopByCollectionListViewItem(
                        collection: model.collections[index],
                      );
                    },
                  ),

                )
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 24),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),
            SliverToBoxAdapter(
              child:
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 12),
                  child:Text(
                    'We are on SOCIAL',
                    style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.accentColor,
                        fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  )),
            ),
            SliverToBoxAdapter(
              child:Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
              child:SocialViews()
              ),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 24),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),
           /* SliverToBoxAdapter(
              child:
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 12),
                  child:Text(
                    'Lorem Logo',
                    style: AppTextStyle.h4TitleTextStyle(
                      color: AppColor.accentColor,
                        fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  )),
            ),*/
            SliverToBoxAdapter(
              child:Container(
                   height: 67,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: HallMarkLogo()
              ),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 24),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.divider(thickness: 10,color: AppColor.newDividerColor),
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 18),
            ),

            SliverToBoxAdapter(
              child:
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 12),
                  child:Text(
                    'OM on your Phone LIVE',
                    style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.accentColor,
                        fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                    textDirection: AppTextDirection.defaultDirection,
                  )),
            ),
            SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height:280,
                  child: model.omLiveLoadingState == LoadingState.Loading
                  //the loadinng shimmer
                      ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.contentPaddingSize,
                    ),
                    child: VendorShimmerListViewItem(),
                  )
                  // the faild view
                      : model.omLiveLoadingState == LoadingState.Failed
                      ? LoadingStateDataView(
                    stateDataModel: StateDataModel(
                      showActionButton: true,
                      actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                        color: Colors.red,
                      ),
                      actionFunction: model.getCategories,
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.OMLiveList.length,
                    padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                    separatorBuilder: (context, index) =>
                        UiSpacer.horizontalSpace(space: 0),
                    itemBuilder: (context, index) {
                      var videoUrl=Api.ProductdownloadUrlPath+model.OMLiveList[index].videoUrl;
                      return OMLiveListItems(
                        videoPlayerController: VideoPlayerController.network(videoUrl),
                        autoplay: false,
                        looping: false,
                        title: model.OMLiveList[index].title,
                      );
                    },
                  ),

                )
            ),
            SliverToBoxAdapter(
              child:UiSpacer.verticalSpace(space: 20),
            ),
         ]),
            //
         // ],
      ),
    );
  }

  Widget _getSectionTitle(String title, context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.contentPaddingSize,
        ),
        child: Text(
          title,
          style: AppTextStyle.h3TitleTextStyle(
            color: AppColor.textColor(context),
          ),
        ),
      ),
    );
  }

   void callBanner() async {
     Navigator.pushNamed(
       context,
       AppRoutes.categoryVendorsRoute,
     );
  }
}
