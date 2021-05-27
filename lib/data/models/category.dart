import 'package:flutter_om_jeweller/data/models/subcategory.dart';
class Category{
  int categoryID;
  String categoryName;
  String categoryImage;
  int categoryStatus;
  String createdAt;
  String updatedAt;
  List<Subcategory> subcategory;


  Category(
      {this.categoryID,
        this.categoryName,
        this.categoryImage,
        this.categoryStatus,
        this.createdAt,
        this.updatedAt,
        this.subcategory});
  Category.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
    categoryStatus = json['categoryStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategory'] != null) {
      subcategory = new List<Subcategory>();
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryID'] = this.categoryID;
    data['categoryName'] = this.categoryName;
    data['categoryImage'] = this.categoryImage;
    data['categoryStatus'] = this.categoryStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}