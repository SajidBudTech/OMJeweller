import 'package:intl/intl.dart';

class NotificationData {
  int id;
  var userId;
  String sendBy;
  String title;
  String notification;
  var status;
  String createdAt;
  String updatedAt;

  NotificationData(
      {this.id,
        this.userId,
        this.sendBy,
        this. title,
        this.notification,
        this.status,
        this.createdAt,
        this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sendBy = json['sent_by'];
    if(json['title']!=null) {
      title = json['title'];
    }
    notification = json['notification'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sent_by'] = this.sendBy;
    data['title'] = this.title;
    data['notification'] = this.notification;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }


  String get formattedTimeStamp {
    final notificationDateTime =
    DateTime.parse(this.createdAt);
    final formmartedDate = DateFormat("EEE dd, MMM yyyy").format(
      notificationDateTime,
    );
    return "$formmartedDate";
  }
}