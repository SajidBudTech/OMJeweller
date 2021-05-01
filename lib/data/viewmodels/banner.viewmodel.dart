import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/viewmodels/base.viewmodel.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter/material.dart';
class BannerViewModel extends MyBaseViewModel {
  //BannerRepository instance
  //CategoryBannerRepository _bannerRepository = CategoryBannerRepository();

  List<CategoryBanner> banners=[];

  //get all banners
  void fetchBanners() async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);

    try {
      //banners = await _bannerRepository.getBanners();
      for(int i=0;i<3;i++){
        CategoryBanner categoryBanner=new CategoryBanner();
        categoryBanner.image="assets/images/img_slider_1.png";
        banners.add(categoryBanner);
      }
    } catch (error) {
      setError(error);
      print("Error getting banners ==> $error");
    }
    setBusy(false);
  }
}
