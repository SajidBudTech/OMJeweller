import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/data/models/api_response.dart';
import 'package:flutter_om_jeweller/services/http.service.dart';
import 'package:flutter_om_jeweller/utils/api_response.utils.dart';
import 'package:flutter_om_jeweller/data/models/notification_data.dart';

class NotificationRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<NotificationData>> getNotifications(int userId) async {
    //make http call for vendors data
    List<NotificationData> data = [];
    final apiResult = await post(Api.notification,{
      "user_id":userId
    });
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    (apiResponse.body['data']["notifications"] as List).forEach((categoryJSONObject) {
      //vendor data
      data.add(NotificationData.fromJson(categoryJSONObject));
    });

    return data;
  }

  Future<int> getNotificationsCount(int userId) async {
    //make http call for vendors data
    int count=0;
    final apiResult = await post(Api.notificationCount,{
      "user_id":userId
    });
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    count=apiResponse.body['data']['notificationCount'];

    return count;
  }

  Future<int> getWishlistCount(int userId) async {
    //make http call for vendors data
    final apiResult = await post(Api.wishlistCount,{
      "user_id":userId
    });
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    List data=apiResponse.body['wishlist'] as List;

    return data.length;
  }


}
