import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/data/models/api_response.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';
import 'package:flutter_om_jeweller/services/http.service.dart';
import 'package:flutter_om_jeweller/utils/api_response.utils.dart';
import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';


class HomePageRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.categories,{});

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
      categories.add(Category.fromJson(categoryJSONObject));

    });

    return categories;

  }

  Future<List<Collection>> getCollection() async {
    List<Collection> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.collections,{});

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
      categories.add(Collection.fromJson(categoryJSONObject));

    });

    return categories;
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



}
