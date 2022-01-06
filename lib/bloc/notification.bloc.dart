import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/data/models/notification_data.dart';
import 'package:flutter_om_jeweller/data/repositories/notification.repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';


class NotificationsBloc extends BaseBloc {
  //BehaviorSubject stream getters
  /*Stream<List<NotificationModel>> get notifications =>
      appDatabase.notificationDao.findAllAsStream();
*/

  List<NotificationData> dataList=List();

  BehaviorSubject<List<NotificationData>> _dataList = BehaviorSubject<List<NotificationData>>();

  Stream<List<NotificationData>> get notifications =>_dataList.stream;

  NotificationRepository _notificationRepository=new NotificationRepository();

  @override
  void initBloc() {
    // TODO: implement initBloc
    super.initBloc();
    fetchNotifications();
  }

  void fetchNotifications() async{

    final userId=AuthBloc.getUserID();
    _dataList.add(null);
    try {
      dataList = await _notificationRepository.getNotifications(userId);
      dataList.sort((a,b){
        var adate = DateTime.parse(a.createdAt); //before -> var adate = a.expiry;
        var bdate = DateTime.parse(b.createdAt); //before -> var bdate = b.expiry;
        return bdate.compareTo(adate);
      });
      if (dataList.length > 0) {
        _dataList.add(dataList);
      } else {
        _dataList.addError("Notification Error");
      }
    } catch (error) {
      _dataList.addError(error);
    }
  }

}
