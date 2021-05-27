class User{
  int customerID;
  String customerName;
  String customerEmail;
  String cutomerMobile;
  String customerPassword;
  String apiKey;
  String createdAt;
  String updatedAt;
  int otp;
  bool loginRegister=false;

  User(
      {this.customerID,
        this.customerName,
        this.customerEmail,
        this.cutomerMobile,
        this.customerPassword,
        this.apiKey,
        this.createdAt,
        this.updatedAt,
        this.otp});

  User.fromJson(Map<String, dynamic> json) {
    customerID = json['customerID'];
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    cutomerMobile = json['cutomerMobile'];
    customerPassword = json['customerPassword'];
    apiKey = json['api_key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerID'] = this.customerID;
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['cutomerMobile'] = this.cutomerMobile;
    data['customerPassword'] = this.customerPassword;
    data['api_key'] = this.apiKey;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}