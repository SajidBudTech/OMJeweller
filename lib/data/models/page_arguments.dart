import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/subcategory.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';

class PageArguments {

  final Category category;
  final Subcategory subCategory;
  final Collection collection;
  PageArguments({
    this.category,
    this.subCategory,
    this.collection
  });

}