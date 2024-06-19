
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
        print('Raw response data: ${response.data}'); // Debug statement

        final pendingOrdersResponse = PendingOrdersResponse.fromJson(response.data);
        print('Parsed PendingOrdersResponse: $pendingOrdersResponse'); // Debug statement
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
}
