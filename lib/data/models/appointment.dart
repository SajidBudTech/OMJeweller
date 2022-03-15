class Appointment{
  int id;
  var userId;
  String appointmentType;
  String appointmentDetail;
  String appointmentDate;
  String appointmentTime;
  String name;
  String mobileNo;
  String email;
  String product;
  String createdAt;
  String updatedAt;

  Appointment(
      { this.id,
        this.userId,
        this.appointmentType,
        this.appointmentDetail,
        this.appointmentDate,
        this.appointmentTime,
        this.name,
        this.mobileNo,
        this.email,
        this.product,
        this.createdAt,
        this.updatedAt,});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    appointmentType = json['appointment_type'];
    appointmentDetail = json['appointment_detail'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    product = json['product'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['appointment_type'] = this.appointmentType;
    data['appointment_detail'] = this.appointmentDetail;
    data['appointment_date'] = this.appointmentDate;
    data['appointment_time'] = this.appointmentTime;
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['product'] = this.product;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }


}