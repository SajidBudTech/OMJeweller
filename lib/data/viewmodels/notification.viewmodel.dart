import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
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
import 'package:flutter_om_jeweller/data/viewmodels/count.viewmodel.dart';
class NotificationViewModel extends MyBaseViewModel {

  LoadingState notificationLoadingState = LoadingState.Loading;
  NotificationRepository _notificationRepository=new NotificationRepository();

  List<NotificationData> notificationList=List();
  NotificationViewModel(BuildContext context) {
    this.viewContext = context;
  }

   void getNotifications() async {
    //add null data so listener can show shimmer widget to indicate loading
     CountViewModel countViewModel=CountViewModel(viewContext);
     countViewModel.setNotificationCount();

     notificationLoadingState = LoadingState.Loading;
    notifyListeners();
    final int userId=AuthBloc.getUserID();
    try {
      notificationList = await _notificationRepository.getNotifications(userId);
      notificationList.sort((a,b){
        var adate = DateTime.parse(a.createdAt); //before -> var adate = a.expiry;
        var bdate = DateTime.parse(b.createdAt); //before -> var bdate = b.expiry;
        return bdate.compareTo(adate);
      });
      notificationLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      notificationLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }



}
