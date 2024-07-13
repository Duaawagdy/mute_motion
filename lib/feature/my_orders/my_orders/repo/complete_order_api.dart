import 'dart:convert';
import 'package:dio/dio.dart';
//import 'package:mute_motion/feature/my_orders/model/order.dart';
import 'package:mute_motion/feature/my_orders/my_orders/model/order.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<CompletedOrder>> fetchCompletedOrders() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  final dio = Dio();
  try {
    final response = await dio.get(
      'https://mutemotion.onrender.com/api/v1/driver/completedOrders',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      List jsonResponse = response.data['completedOrders'];
      return jsonResponse
          .map((order) => CompletedOrder.fromJson(order))
          .toList();
    } else if (response.statusCode == 404) {
      throw Exception('Orders not found (404)');
    } else {
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  } catch (error) {
    if (error is DioError && error.response?.statusCode == 404) {
      throw Exception('Orders not found (404)');
    } else {
      throw Exception('Failed to load orders: $error');
    }
  }
}
