import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/globle_variable.dart';
import 'package:flutter_om_jeweller/data/repositories/notification.repository.dart';
import 'package:rxdart/subjects.dart';

class HomeBloc extends BaseBloc {
  //
  static BehaviorSubject<int> currentPageIndex;
  static NotificationRepository _notificationRepository=new NotificationRepository();
  //switch page to cart
  static void switchPageToCart() {
    currentPageIndex.add(2);
  }

  static void initiBloc() {
    currentPageIndex = BehaviorSubject<int>();
  }

  static void closeListener() {
    currentPageIndex.close();
  }

  static void getNotificationCount() async {
    //add null data so listener can show shimmer widget to indicate loading
    final int userId=await AuthBloc.getUserID();
    try {

      GlobleVariable.NOTIFICATION_COUNT = await _notificationRepository.getNotificationsCount(userId);


    } catch (error) {

    }

    if(!currentPageIndex.isClosed)
     currentPageIndex.add(0);
   // notifyListeners();

  }

  static void getWishlistCount() async {
    //add null data so listener can show shimmer widget to indicate loading
    final int userId=await AuthBloc.getUserID();

    try {

      GlobleVariable.WISHLIST_COUNT = await _notificationRepository.getWishlistCount(userId);

    } catch (error) {

    }
    if(!currentPageIndex.isClosed)
    currentPageIndex.add(0);
    //notifyListeners();
  }
}
