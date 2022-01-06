import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/data/models/api_response.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/services/http.service.dart';
import 'package:flutter_om_jeweller/utils/api_response.utils.dart';
import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';
import 'package:flutter_om_jeweller/data/models/dialog_data.dart';
import 'package:flutter_om_jeweller/constants/string/auth.string.dart';


class ProductRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<Product>> getProductByCategories({int userID,int categoryId}) async {
    List<Product> products = [];

    //make http call for vendors data
    final apiResult = await post(
      Api.getProductByCategory,
      {
        "user_id": userID,
        "id": categoryId,
      },
    );
    //final apiResult = await get(Api.getProductByCategory+"/"+categoryId.toString());

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data']['get_data'] as List).forEach((categoryJSONObject) {
      //vendor data
      products.add(Product.fromJson(categoryJSONObject));
    });

    return products;

  }

  Future<List<Product>> getProductBySubCategories({int userID,int subCategoryId}) async {
    List<Product> products = [];

    //make http call for vendors data


    final apiResult = await post(
      Api.getProductBySubCategory,
      {
        "user_id": userID,
        "id": subCategoryId,
      },
    );

    //final apiResult = await get(Api.getProductBySubCategory+"/"+subCategoryId.toString());

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data']['get_data'] as List).forEach((categoryJSONObject) {
      //vendor data
      products.add(Product.fromJson(categoryJSONObject));
    });

    return products;

  }

  Future<List<Product>> getProductByCollection({int userID,int collectionId}) async {
    List<Product> products = [];

    //make http call for vendors data

    final apiResult = await post(
      Api.getProductByCollection,
      {
        "user_id": userID,
        "id": collectionId,
      },
    );

   // final apiResult = await get(Api.getProductByCollection+"/"+collectionId.toString());

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data']['get_data'] as List).forEach((categoryJSONObject) {
      //vendor data
      products.add(Product.fromJson(categoryJSONObject));
    });

    return products;

  }

  Future<List<Product>> getSerachProduct({int userID,String keyword}) async {
    List<Product> products = [];

    //make http call for vendors data

    final apiResult = await post(
      Api.getProductBySearch,
      {
        "user_id": userID,
        "search": keyword,
      },
    );

    // final apiResult = await get(Api.getProductByCollection+"/"+collectionId.toString());

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data'] as List).forEach((categoryJSONObject) {
      //vendor data
      products.add(Product.fromJson(categoryJSONObject));
    });

    return products;

  }

  Future<Product> getProductByID({int userID,int productID}) async {
    Product product = Product();

    //make http call for vendors data

    final apiResult = await post(
      Api.getProductByID,
      {
        "user_id": userID,
        "id": productID,
      },
    );

    // final apiResult = await get(Api.getProductByCollection+"/"+collectionId.toString());

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model

    product=Product.fromJson(apiResponse.body['data']);
    /*(apiResponse.body['data']['get_data'] as List).forEach((categoryJSONObject) {
      //vendor data
      products.add(Product.fromJson(categoryJSONObject));
    });
*/
    return product;

  }





  Future<List<AdvertismentBanner>> getScrollingBanner() async {
    List<AdvertismentBanner> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.scrollingbanners,{});

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data'] as List).forEach((categoryJSONObject) {
      //vendor data
      categories.add(AdvertismentBanner.fromJson(categoryJSONObject));

    });

    return categories;
  }

  Future<List<AdvertismentBanner>> getAdevertismentBanner() async {
    List<AdvertismentBanner> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.advertismentbanners,{});

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data'] as List).forEach((categoryJSONObject) {
      //vendor data
      categories.add(AdvertismentBanner.fromJson(categoryJSONObject));

    });

    return categories;
  }


  Future<List<GoldRate>> getGoldRate() async {
    List<GoldRate> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.goldRate,{});

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data'] as List).forEach((categoryJSONObject) {
      //vendor data
      categories.add(GoldRate.fromJson(categoryJSONObject));

    });

    return categories;

  }


  Future<DialogData> addToWishList({int userID,int productID}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.addtowishlist,
      {
        "user_id": userID,
        "productID": productID,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = "Product Added To Wishlist Successfully!";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;


    } else {
      resultDialogData.title = "Failed To Add Product To Wishlist!";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }
  Future<DialogData> removeFromWishList({int userID,int productID}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.removeFromWishList,
      {
        "user_id": userID,
        "productID": productID,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = "Product Removed From Wishlist!";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;


    } else {
      resultDialogData.title = "Failed To Remove Product From Wishlist";
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }


  Future<List<Product>> getWishListProduct({int userID}) async {
    List<Product> products = [];

    //make http call for vendors data
    final apiResult = await post(
      Api.wishlistProduct,
      {
        "user_id": userID,
      },
    );

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body['data'] as List).forEach((categoryJSONObject) {
      //vendor data
      products.add(Product.fromJson(categoryJSONObject));
    });

    return products;

  }




}
