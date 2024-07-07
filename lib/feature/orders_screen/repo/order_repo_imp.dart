
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
    final String? token = prefs.getString("token");
    print(token);
    final String apiUrl = "https://mutemotion.onrender.com/api/v1/pendingOrders";

    try {
      final response = await Dio().get(
        apiUrl,
        options: Options(headers: {'Authorization':'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = response.data as Map<String, dynamic>;
        print(jsonData);
        print(1);
        final pendingOrdersData = jsonData['pendingOrders'] as List<dynamic>;
        print(pendingOrdersData);
        print(2);
        return PendingOrdersResponse(
          pendingOrders: pendingOrdersData.map((orderJson) => Order.fromJson(orderJson)).toList(),
        );
      } else {
        throw Exception('API request failed: ${response.statusCode}');
      }
    } on DioException catch (error) {
      handleError(error);
      rethrow;
    } catch (error) {
      print('Unexpected error: $errogit r');
      rethrow;
    }
  }

  Future<void> onlinetoggle(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
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
