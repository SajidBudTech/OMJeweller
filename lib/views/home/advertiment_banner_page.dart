import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/subcategory.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/page_arguments.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/data/models/product_arguments.dart';

class AdvertismentSliderPage extends StatefulWidget {
  AdvertismentSliderPage({Key key}) : super(key: key);

  @override
  _AdvertismentSliderPageState createState() => _AdvertismentSliderPageState();
}

class _AdvertismentSliderPageState extends State<AdvertismentSliderPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      onModelReady: (model) => model.fetchAdvertismentBanners(),
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
                      actionFunction: () => model.fetchAdvertismentBanners(),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(bottom: 13, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            onTap: () {
                              if(model.advertismentBanners[0].bannertype=="category"){
                                Category category=Category();
                                category.categoryID=model.advertismentBanners[0].bannerUrl as int;
                                category.categoryName=model.advertismentBanners[0].bannertype;
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.productListPageRoute,
                                    arguments: PageArguments(
                                        category: category,
                                        subCategory: null,
                                        collection: null
                                    )
                                );
                              }else if(model.advertismentBanners[0].bannertype=="subcategory"){
                                Subcategory subategory=Subcategory();
                                subategory.subcategoryID=int.parse(model.advertismentBanners[0].bannerUrl);
                                subategory.subcategoryName=model.advertismentBanners[0].bannertype;
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.productListPageRoute,
                                    arguments: PageArguments(
                                        category: null,
                                        subCategory: subategory,
                                        collection: null
                                    )
                                );
                              }else if(model.advertismentBanners[0].bannertype=="collection"){
                                Collection collection=Collection();
                                collection.collectionID=int.parse(model.advertismentBanners[0].bannerUrl);
                                collection.collectionName=model.advertismentBanners[0].bannertype;
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.productListPageRoute,
                                    arguments: PageArguments(
                                        category: null,
                                        subCategory: null,
                                        collection: collection
                                    )
                                );
                              }else if(model.advertismentBanners[0].bannertype=="product"){
                                Product product=Product();
                                product.productID=int.parse(model.advertismentBanners[0].bannerUrl);
                                product.productName=model.advertismentBanners[0].bannertype;
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
                            highlightColor: Colors.transparent,
                            splashColor:
                                AppColor.newprimaryColor.withOpacity(0.5),
                            child: Card(
                                elevation: 0,
                               // margin: EdgeInsets.only(top: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: Api.downloadUrlPath +
                                        model.advertismentBanners[0].bannerImage,
                                    placeholder: (context, url) => Container(
                                      height: 178,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    height: 178,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                )
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(left:6,right: 6),
                            child:Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      if(model.advertismentBanners[1].bannertype=="category"){
                                        Category category=Category();
                                        category.categoryID=int.parse(model.advertismentBanners[1].bannerUrl);
                                        category.categoryName=model.advertismentBanners[1].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: category,
                                                subCategory: null,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[1].bannertype=="subcategory"){
                                        Subcategory subategory=Subcategory();
                                        subategory.subcategoryID=int.parse(model.advertismentBanners[1].bannerUrl);
                                        subategory.subcategoryName=model.advertismentBanners[1].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: subategory,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[1].bannertype=="collection"){
                                        Collection collection=Collection();
                                        collection.collectionID=int.parse(model.advertismentBanners[1].bannerUrl);
                                        collection.collectionName=model.advertismentBanners[1].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: null,
                                                collection: collection
                                            )
                                        );
                                      }else if(model.advertismentBanners[1].bannertype=="product"){
                                        Product product=Product();
                                        product.productID=int.parse(model.advertismentBanners[1].bannerUrl);
                                        product.productName=model.advertismentBanners[1].bannertype;
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
                                    highlightColor: Colors.transparent,
                                    splashColor: AppColor.newprimaryColor
                                        .withOpacity(0.5),
                                    child: Card(
                                      elevation: 0,
                                      margin: EdgeInsets.only(top: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: Api.downloadUrlPath +
                                                model.advertismentBanners[1]
                                                    .bannerImage,
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 178,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            height: 178,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )),
                                    ))),
                            Container(
                              width: 12,
                            ),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      if(model.advertismentBanners[2].bannertype=="category"){
                                        Category category=Category();
                                        category.categoryID=int.parse(model.advertismentBanners[2].bannerUrl);
                                        category.categoryName=model.advertismentBanners[2].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: category,
                                                subCategory: null,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[2].bannertype=="subcategory"){
                                        Subcategory subategory=Subcategory();
                                        subategory.subcategoryID=int.parse(model.advertismentBanners[2].bannerUrl);
                                        subategory.subcategoryName=model.advertismentBanners[2].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: subategory,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[2].bannertype=="collection"){
                                        Collection collection=Collection();
                                        collection.collectionID=int.parse(model.advertismentBanners[2].bannerUrl);
                                        collection.collectionName=model.advertismentBanners[2].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: null,
                                                collection: collection
                                            )
                                        );
                                      }else if(model.advertismentBanners[2].bannertype=="product"){
                                        Product product=Product();
                                        product.productID=int.parse(model.advertismentBanners[2].bannerUrl);
                                        product.productName=model.advertismentBanners[2].bannertype;
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
                                    highlightColor: Colors.transparent,
                                    splashColor: AppColor.newprimaryColor
                                        .withOpacity(0.5),
                                    child: Card(
                                      elevation: 0,
                                      margin: EdgeInsets.only(top: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: Api.downloadUrlPath +
                                                model.advertismentBanners[2]
                                                    .bannerImage,
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 178,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            height: 178,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )),
                                    )))
                          ],
                        )),
                          Container(
                          margin: EdgeInsets.only(left:6,right: 6),
                         child:Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      if(model.advertismentBanners[3].bannertype=="category"){
                                        Category category=Category();
                                        category.categoryID=int.parse(model.advertismentBanners[3].bannerUrl);
                                        category.categoryName=model.advertismentBanners[3].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: category,
                                                subCategory: null,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[3].bannertype=="subcategory"){
                                        Subcategory subategory=Subcategory();
                                        subategory.subcategoryID=int.parse(model.advertismentBanners[3].bannerUrl);
                                        subategory.subcategoryName=model.advertismentBanners[3].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: subategory,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[3].bannertype=="collection"){
                                        Collection collection=Collection();
                                        collection.collectionID=int.parse(model.advertismentBanners[3].bannerUrl);
                                        collection.collectionName=model.advertismentBanners[3].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: null,
                                                collection: collection
                                            )
                                        );
                                      }else if(model.advertismentBanners[3].bannertype=="product"){
                                        Product product=Product();
                                        product.productID=int.parse(model.advertismentBanners[3].bannerUrl);
                                        product.productName=model.advertismentBanners[3].bannertype;
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
                                    highlightColor: Colors.transparent,
                                    splashColor: AppColor.newprimaryColor
                                        .withOpacity(0.5),
                                    child: Card(
                                        elevation: 0,
                                        margin: EdgeInsets.only(top: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: Api.downloadUrlPath +
                                                model.advertismentBanners[3]
                                                    .bannerImage,
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 178,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            height: 178,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        )))),
                            Container(
                              width: 12,
                            ),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      if(model.advertismentBanners[4].bannertype=="category"){
                                        Category category=Category();
                                        category.categoryID=int.parse(model.advertismentBanners[4].bannerUrl);
                                        category.categoryName=model.advertismentBanners[4].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: category,
                                                subCategory: null,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[4].bannertype=="subcategory"){
                                        Subcategory subategory=Subcategory();
                                        subategory.subcategoryID=int.parse(model.advertismentBanners[4].bannerUrl);
                                        subategory.subcategoryName=model.advertismentBanners[4].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: subategory,
                                                collection: null
                                            )
                                        );
                                      }else if(model.advertismentBanners[4].bannertype=="collection"){
                                        Collection collection=Collection();
                                        collection.collectionID=int.parse(model.advertismentBanners[4].bannerUrl);
                                        collection.collectionName=model.advertismentBanners[4].bannertype;
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes.productListPageRoute,
                                            arguments: PageArguments(
                                                category: null,
                                                subCategory: null,
                                                collection: collection
                                            )
                                        );
                                      }else if(model.advertismentBanners[4].bannertype=="product"){
                                        Product product=Product();
                                        product.productID=int.parse(model.advertismentBanners[4].bannerUrl);
                                        product.productName=model.advertismentBanners[4].bannertype;
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
                                    highlightColor: Colors.transparent,
                                    splashColor: AppColor.newprimaryColor
                                        .withOpacity(0.5),
                                    child: Card(
                                        elevation: 0,
                                        margin: EdgeInsets.only(top: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: Api.downloadUrlPath +
                                                model.advertismentBanners[4]
                                                    .bannerImage,
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 178,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            height: 178,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ))))
                          ],
                        )),
                        InkWell(
                            onTap: () {
                              if(model.advertismentBanners[5].bannertype=="category"){
                                Category category=Category();
                                category.categoryID=int.parse(model.advertismentBanners[5].bannerUrl);
                                category.categoryName=model.advertismentBanners[5].bannertype;
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.productListPageRoute,
                                    arguments: PageArguments(
                                        category: category,
                                        subCategory: null,
                                        collection: null
                                    )
                                );
                              }else if(model.advertismentBanners[5].bannertype=="subcategory"){
                                Subcategory subategory=Subcategory();
                                subategory.subcategoryID=int.parse(model.advertismentBanners[5].bannerUrl);
                                subategory.subcategoryName=model.advertismentBanners[5].bannertype;
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.productListPageRoute,
                                    arguments: PageArguments(
                                        category: null,
                                        subCategory: subategory,
                                        collection: null
                                    )
                                );
                              }else if(model.advertismentBanners[5].bannertype=="collection"){
                                Collection collection=Collection();
                                collection.collectionID=int.parse(model.advertismentBanners[5].bannerUrl);
                                collection.collectionName=model.advertismentBanners[5].bannertype;
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.productListPageRoute,
                                    arguments: PageArguments(
                                        category: null,
                                        subCategory: null,
                                        collection: collection
                                    )
                                );
                              }
                            },
                            highlightColor: Colors.transparent,
                            splashColor:
                            AppColor.newprimaryColor.withOpacity(0.5),
                            child: Card(
                                elevation: 0,
                                margin: EdgeInsets.only(top: 12,left: 6,right: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: Api.downloadUrlPath +
                                        model
                                            .advertismentBanners[5].bannerImage,
                                    placeholder: (context, url) => Container(
                                      height: 178,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    height: 178,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
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
