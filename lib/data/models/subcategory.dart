class Subcategory {
  int subcategoryID;
  int categoryID;
  String subcategoryName;
  String subcategoryImage;
  int subcategoryStatus;
  String createdAt;
  String updatedAt;


  Subcategory(
      {this.subcategoryID,
        this.categoryID,
        this.subcategoryName,
        this.subcategoryImage,
        this.subcategoryStatus,
        this.createdAt,
        this.updatedAt});

  Subcategory.fromJson(Map<String, dynamic> json) {
    subcategoryID = json['subcategoryID'];
    categoryID = json['categoryID'];
    subcategoryName = json['subcategoryName'];
    subcategoryImage = json['subcategoryImage'];
    subcategoryStatus = json['subcategoryStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategoryID'] = this.subcategoryID;
    data['categoryID'] = this.categoryID;
    data['subcategoryName'] = this.subcategoryName;
    data['subcategoryImage'] = this.subcategoryImage;
    data['subcategoryStatus'] = this.subcategoryStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}