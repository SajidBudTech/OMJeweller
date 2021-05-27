class AdvertismentBanner{
  int bannerID;
  String bannertype;
  String bannerUrl;
  String bannerImage;
  int bannerStatus;
  String createdAt;
  String updatedAt;

  AdvertismentBanner(
      {this.bannerID,
        this.bannertype,
        this.bannerUrl,
        this.bannerImage,
        this.bannerStatus,
        this.createdAt,
        this.updatedAt});

  AdvertismentBanner.fromJson(Map<String, dynamic> json) {
    bannerID = json['bannerID'];
    bannertype = json['bannertype'];
    bannerUrl = json['bannerUrl'];
    bannerImage = json['bannerImage'];
    bannerStatus = json['bannerStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerID'] = this.bannerID;
    data['bannertype'] = this.bannertype;
    data['bannerUrl'] = this.bannerUrl;
    data['bannerImage'] = this.bannerImage;
    data['bannerStatus'] = this.bannerStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}