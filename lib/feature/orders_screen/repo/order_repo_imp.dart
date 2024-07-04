
import 'package:dio/dio.dart';
import 'package:mute_motion/core/errors/failures.dart';
import 'package:mute_motion/feature/orders_screen/view_model/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderRepoImpl {
  void handleError(DioException error) {
    ServerFailure failure = ServerFailure.fromDioError(error);
    print(failure.errMessage);
  }

  Future<PendingOrdersResponse> fetchNewestOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    //print(token);
    final String apiUrl = "https://mutemotion.onrender.com/api/v1/pendingOrders";
    try {
      Response response = await Dio().get(
        apiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        //print('Raw response data: ${response.data}');

        final pendingOrdersResponse = PendingOrdersResponse.fromJson(response.data);
        print('passenger  id${pendingOrdersResponse.pendingOrders[0].passengerid}');
        String? passengerId=pendingOrdersResponse.pendingOrders[0].passengerid;
        String? orderId=pendingOrdersResponse.pendingOrders[0].orderid;
        prefs.setString("orderId",orderId!);
        prefs.setString("passengerId",passengerId!);
        return pendingOrdersResponse;

      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      if (error is DioException) {
        handleError(error);
      } else {
        print('Unexpected error: $error');

      }
      rethrow;
    }

  }
Future<void> onlinetoggle(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final String apiUrl = "https://mutemotion.onrender.com/api/users/toggle"; // Removed the leading space

    try {
      Map<String, dynamic> requestBody = {
        "isOnline": state,
      };
      Response response = await Dio().post(
        apiUrl,
        data: requestBody,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' update state successful');
      } else {
        throw Exception('Failed to update state');
      }
    } catch (error) {
      print(error);
    }
  }


  Future<void> responedToOrder(String orderId,bool state) async {

    final String apiUrl = "https://mutemotion.onrender.com/api/v1/respondToRequest"; // Removed the leading space

    try {
      Map<String, dynamic> requestBody = {
        "orderId":orderId,
        "accept":state
      };
      Response response = await Dio().post(
        apiUrl,
        data: requestBody,

      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('respond successful');
      } else {
        throw Exception('Failed to respond');
      }
    } catch (error) {
      print(error);
    }
  }


}
