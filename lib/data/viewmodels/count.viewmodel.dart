import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/bloc/home.bloc.dart';
import 'package:flutter_om_jeweller/constants/globle_variable.dart';
import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/notification_data.dart';
import 'package:flutter_om_jeweller/data/repositories/home.repository.dart';
import 'package:flutter_om_jeweller/data/repositories/notification.repository.dart';
import 'package:flutter_om_jeweller/data/viewmodels/base.viewmodel.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/views/home_page.dart';
class CountViewModel extends MyBaseViewModel {

  NotificationRepository _notificationRepository=new NotificationRepository();
  CountViewModel(BuildContext context) {
    this.viewContext = context;
  }

  init()async{
    getNotificationCount();
    getWishlistCount();
  }

  void setNotificationCount() async {
    //add null data so listener can show shimmer widget to indicate loading

    GlobleVariable.NOTIFICATION_COUNT=0;
    notifyListeners();

  }
  void setWishListCount() async {
    //add null data so listener can show shimmer widget to indicate loading

    GlobleVariable.WISHLIST_COUNT=0;
    notifyListeners();

  }
   void incrementNotificationCount() async {
    //add null data so listener can show shimmer widget to indicate loading

    GlobleVariable.NOTIFICATION_COUNT++;
    notifyListeners();

  }
  void incrementWishlistCount() async {
    //add null data so listener can show shimmer widget to indicate loading

    GlobleVariable.WISHLIST_COUNT++;
    HomeBloc.currentPageIndex.add(HomePage.currentPageIndex);
    //notifyListeners();

  }

  void decrementWishlistCount() async {
    //add null data so listener can show shimmer widget to indicate loading

    if(GlobleVariable.WISHLIST_COUNT!=0){
      GlobleVariable.WISHLIST_COUNT--;
    }
    notifyListeners();

  }

  void getNotificationCount() async {
    //add null data so listener can show shimmer widget to indicate loading
    final int userId=await AuthBloc.getUserID();
    try {

      GlobleVariable.NOTIFICATION_COUNT = await _notificationRepository.getNotificationsCount(userId);


    } catch (error) {

    }
    notifyListeners();

  }

  void getWishlistCount() async {
    //add null data so listener can show shimmer widget to indicate loading
    final int userId=await AuthBloc.getUserID();
    try {

      GlobleVariable.WISHLIST_COUNT = await _notificationRepository.getWishlistCount(userId);

    } catch (error) {

    }

    notifyListeners();
  }



}
