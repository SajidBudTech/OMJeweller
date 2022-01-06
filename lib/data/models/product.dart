class Product{
  int productID;
  String productCode;
  String productName;
  int productType;
  int category;
  int subcategory;
  int collection;
  String material;
  int purity;
  int colour;
  String grossweight;
  String netweight;
  String platiniumweight;
  String platiniummaking;
  int platiniumamount;
  String polkiweight;
  String polkiamount;
  String polkimaking;
  int makingwastage;
  String makingcost;
  String stonecharges;
  int numberofdiamonds;
  int tax;
  int status;
  String createdAt;
  String updatedAt;
  int categoryID;
  String categoryName;
  String categoryImage;
  int categoryStatus;
  int subcategoryID;
  String subcategoryName;
  String subcategoryImage;
  int subcategoryStatus;
  int collectionID;
  String collectionName;
  String collectionImage;
  int collectionStatus;
  int purityID;
  String purityName;
  String purityPrice;
  int purityStatus;
  int colourID;
  String colourName;
  int colourStatus;
  int productimagesID;
  String productImage;
  int taxID;
  String taxName;
  int taxValue;
  int taxStatus;
  int isWishlist;
  List<Productattributes> productattributes=[];
  double platinumRate=0.0;
  int productPrice;


  Product(
      {this.productID,
        this.productCode,
        this.productName,
        this.productType,
        this.category,
        this.subcategory,
        this.collection,
        this.material,
        this.purity,
        this.colour,
        this.grossweight,
        this.netweight,
        this.platiniumweight,
        this.platiniummaking,
        this.platiniumamount,
        this.polkiweight,
        this.polkiamount,
        this.polkimaking,
        this.makingwastage,
        this.makingcost,
        this.stonecharges,
        this.numberofdiamonds,
        this.tax,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.categoryID,
        this.categoryName,
        this.categoryImage,
        this.categoryStatus,
        this.subcategoryID,
        this.subcategoryName,
        this.subcategoryImage,
        this.subcategoryStatus,
        this.collectionID,
        this.collectionName,
        this.collectionImage,
        this.collectionStatus,
        this.purityID,
        this.purityName,
        this.purityPrice,
        this.purityStatus,
        this.colourID,
        this.colourName,
        this.colourStatus,
        this.productimagesID,
        this.productImage,
        this.taxID,
        this.taxName,
        this.taxValue,
        this.taxStatus,
        this.isWishlist,
        this.productattributes});

  Product.fromJson(Map<String, dynamic> json) {
    productID = json['productID'] ?? 0;
    productCode = json['productCode'];
    productName = json['productName'];
    productType = json['productType'];
    category = json['category'];
    subcategory = json['subcategory'];
    collection = json['collection'];
    material = json['material'];
    purity = json['purity'];
    colour = json['colour'];
    grossweight = json['grossweight'];
    netweight = json['netweight'];
    platiniumweight = json['platiniumweight'];
    platiniummaking = json['platiniummaking'];
    platiniumamount = json['platiniumamount'];
    polkiweight = json['polkiweight'];
    polkiamount = json['polkiamount'];
    polkimaking = json['polkimaking'];
    makingwastage = json['makingwastage'];
    makingcost = json['makingcost'];
    stonecharges = json['stonecharges'];
    numberofdiamonds = json['numberofdiamonds'];
    tax = json['tax'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
    categoryStatus = json['categoryStatus'];
    subcategoryID = json['subcategoryID'];
    subcategoryName = json['subcategoryName'];
    subcategoryImage = json['subcategoryImage'];
    subcategoryStatus = json['subcategoryStatus'];
    collectionID = json['collectionID'];
    collectionName = json['collectionName'];
    collectionImage = json['collectionImage'];
    collectionStatus = json['collectionStatus'];
    purityID = json['purityID'];
    purityName = json['purityName'];
    purityPrice = json['purityPrice'];
    purityStatus = json['purityStatus'];
    colourID = json['colourID'];
    colourName = json['colourName'];
    colourStatus = json['colourStatus'];
    productimagesID = json['productimagesID'];
    productImage = json['productImage'];
    taxID = json['taxID'];
    taxName = json['taxName'];
    taxValue = json['taxValue'];
    taxStatus = json['taxStatus'];
    isWishlist = json['is_wishlist'];
    if (json['productattributes'] != null) {
      productattributes = new List<Productattributes>();
      json['productattributes'].forEach((v) {
        productattributes.add(new Productattributes.fromJson(v));
      });
    }else{
      productattributes = new List<Productattributes>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productCode'] = this.productCode;
    data['productName'] = this.productName;
    data['productType'] = this.productType;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['collection'] = this.collection;
    data['material'] = this.material;
    data['purity'] = this.purity;
    data['colour'] = this.colour;
    data['grossweight'] = this.grossweight;
    data['netweight'] = this.netweight;
    data['platiniumweight'] = this.platiniumweight;
    data['platiniummaking'] = this.platiniummaking;
    data['platiniumamount'] = this.platiniumamount;
    data['polkiweight'] = this.polkiweight;
    data['polkimaking'] = this.polkimaking;
    data['makingwastage'] = this.makingwastage;
    data['makingcost'] = this.makingcost;
    data['stonecharges'] = this.stonecharges;
    data['numberofdiamonds'] = this.numberofdiamonds;
    data['tax'] = this.tax;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['categoryID'] = this.categoryID;
    data['categoryName'] = this.categoryName;
    data['categoryImage'] = this.categoryImage;
    data['categoryStatus'] = this.categoryStatus;
    data['subcategoryID'] = this.subcategoryID;
    data['subcategoryName'] = this.subcategoryName;
    data['subcategoryImage'] = this.subcategoryImage;
    data['subcategoryStatus'] = this.subcategoryStatus;
    data['collectionID'] = this.collectionID;
    data['collectionName'] = this.collectionName;
    data['collectionImage'] = this.collectionImage;
    data['collectionStatus'] = this.collectionStatus;
    data['purityID'] = this.purityID;
    data['purityName'] = this.purityName;
    data['purityPrice'] = this.purityPrice;
    data['purityStatus'] = this.purityStatus;
    data['colourID'] = this.colourID;
    data['colourName'] = this.colourName;
    data['colourStatus'] = this.colourStatus;
    data['productimagesID'] = this.productimagesID;
    data['productImage'] = this.productImage;
    data['taxID'] = this.taxID;
    data['taxName'] = this.taxName;
    data['taxValue'] = this.taxValue;
    data['taxStatus'] = this.taxStatus;
    data['is_wishlist'] = this.isWishlist;
    if (this.productattributes != null) {
      data['productattributes'] =
          this.productattributes.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Productattributes {
  int productatrributeID;
  int productID;
  String diamondshapeName;
  String diamondweight;
  String diamondrate;
  String diamondamount;
  String createdAt;
  String updatedAt;

  Productattributes(
      {this.productatrributeID,
        this.productID,
        this.diamondshapeName,
        this.diamondweight,
        this.diamondrate,
        this.diamondamount,
        this.createdAt,
        this.updatedAt});

  Productattributes.fromJson(Map<String, dynamic> json) {
    productatrributeID = json['productatrributeID'];
    productID = json['productID'];
    diamondshapeName = json['diamondshapeName'];
    diamondweight = json['diamondweight'];
    diamondrate = json['diamondrate'];
    diamondamount = json['diamondamount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productatrributeID'] = this.productatrributeID;
    data['productID'] = this.productID;
    data['diamondshapeName'] = this.diamondshapeName;
    data['diamondweight'] = this.diamondweight;
    data['diamondrate'] = this.diamondrate;
    data['diamondamount'] = this.diamondamount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}