class CategoryBanner {
  int id;
  int category_id;
  String image;
 // Category category;

  CategoryBanner({
    this.id,
  //  this.category,
    this.image,
  });

  factory CategoryBanner.fromJSON(dynamic jsonObject) {
    final banner = CategoryBanner(
        id: jsonObject['id'],
      //  category: Category.fromJSON(jsonObject['category']),
        image: jsonObject['image']);
    return banner;
  }
}
