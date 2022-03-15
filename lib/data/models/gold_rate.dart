class GoldRate{
  int purityID;
  String purityName;
  String purityPrice;
  var purityStatus;
  String createdAt;
  String updatedAt;

  GoldRate(
      {this.purityID,
        this.purityName,
        this.purityPrice,
        this.purityStatus,
        this.createdAt,
        this.updatedAt});

  GoldRate.fromJson(Map<String, dynamic> json) {
    purityID = json['purityID'];
    purityName = json['purityName'];
    purityPrice = json['purityPrice'];
    purityStatus = json['purityStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purityID'] = this.purityID;
    data['purityName'] = this.purityName;
    data['purityPrice'] = this.purityPrice;
    data['purityStatus'] = this.purityStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }


}