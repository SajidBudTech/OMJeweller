import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/data/models/api_response.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';
import 'package:flutter_om_jeweller/data/models/new_category.dart';
import 'package:flutter_om_jeweller/services/http.service.dart';
import 'package:flutter_om_jeweller/utils/api_response.utils.dart';
import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/data/models/omlive.dart';
import 'package:http/http.dart' as http;


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

  Future<String> getLoyaltyPoints({String mobile}) async {
     String points="0";


     final response = await http.post(Uri.parse('https://app.exclusife.com/api_business_V2'),
       headers: {
         "Content-Type": "application/x-www-form-urlencoded",
       },
       encoding: Encoding.getByName('utf-8'),
       body: {
          "method": "getCustomerLoyalty",
          "data":json.encode({
            "businessId" : "30566998",
            "auth_key":"MHRHNm5sMEN5S1B0dDllN0lEUFFjK2loMEovREtMYlpUSEFGdnM5UmVnaz0=",
            "customerNumber" : mobile,
            "sendOtp" : "N"}),
       },
     );

     if(response.statusCode==200){
       var resp=json.decode(response.body);
       if(resp['status']=="success"){
         points=resp['customerPoint']??"0";
       }
     }


    return points;

  }

  Future<List<NewCategory>> getNewCategories() async {
    List<NewCategory> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.newcategories,{});

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
      categories.add(NewCategory.fromJson(categoryJSONObject));

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

  Future<List<Product>> getNewArrival() async {
    List<Product> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.newArrival,{});

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
      categories.add(Product.fromJson(categoryJSONObject));

    });

    return categories;
  }

  Future<List<OMLive>> getOMLive() async {
    List<OMLive> categories = [];

    //make http call for vendors data
    final apiResult = await post(Api.omLive,{});

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
      categories.add(OMLive.fromJson(categoryJSONObject));

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
