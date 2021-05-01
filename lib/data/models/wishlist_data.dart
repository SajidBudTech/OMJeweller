class Wishlist {
  int id;
  String image;
  bool stock;
  // Category category;

  Wishlist({
    this.id,
    this. stock,
    this.image,
  });

  factory Wishlist.fromJSON(dynamic jsonObject) {
    final wishlist = Wishlist(
        id: jsonObject['id'],
        stock: jsonObject['stock']??false,
        //  category: Category.fromJSON(jsonObject['category']),
        image: jsonObject['image']);
    return wishlist;
  }
}
