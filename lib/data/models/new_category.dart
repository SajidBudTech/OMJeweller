import 'package:flutter_om_jeweller/data/models/subcategory.dart';

class NewCategory{
  String categoryName;
  String categoryId;
  List<Subcategory> subcategory;

  NewCategory({this.categoryName, this.categoryId, this.subcategory});

  NewCategory.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_Id'];
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_Id'] = this.categoryId;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}