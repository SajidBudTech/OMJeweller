import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';
import 'package:flutter_om_jeweller/data/repositories/home.repository.dart';
import 'package:flutter_om_jeweller/data/viewmodels/base.viewmodel.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter/material.dart';
class BannerViewModel extends MyBaseViewModel {
  //BannerRepository instance
  HomePageRepository _bannerRepository = HomePageRepository();

  List<AdvertismentBanner> advertismentBanners=[];

  List<AdvertismentBanner> scrollingBanners=[];

  List<GoldRate> goldRate=[];


  String karate18Price;
  String karate22Price;

  //get all banners
  void fetchScrollingBanners() async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);
    try {
      scrollingBanners = await _bannerRepository.getScrollingBanner();
    } catch (error) {
      setError(error);
      print("Error getting banners ==> $error");
    }
    setBusy(false);
  }


  //get all banners
  void fetchAdvertismentBanners() async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);

    try {
      advertismentBanners = await _bannerRepository.getAdevertismentBanner();
    } catch (error) {
      setError(error);
      print("Error getting banners ==> $error");
    }
    setBusy(false);

  }


  //get all banners
  void fetchGoldRate() async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);

    try {
      goldRate = await _bannerRepository.getGoldRate();
      for(GoldRate goldone in goldRate){
        if(goldone.purityName=="18kt"){
           karate18Price=(double.parse(goldone.purityPrice)*10).toString();
        }else if(goldone.purityName=="22kt"){
          karate22Price=(double.parse(goldone.purityPrice)*10).toString();
        }
      }
    } catch (error) {
      setError(error);
      print("Error getting banners ==> $error");
    }
    setBusy(false);
  }

  //get all banners
  void fetchOMLive() async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);

  /*  try {
      scrollingBanners = await _bannerRepository.getScrollingBanner();
    } catch (error) {
      setError(error);
      print("Error getting banners ==> $error");
    }*/
    setBusy(false);
  }


}
