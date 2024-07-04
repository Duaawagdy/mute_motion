import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> completeOrder(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String orderId = prefs.getString('orderId') ?? '';

    if (orderId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Order ID is empty'),
      ));
      return;
    }

    final url = 'https://mutemotion.onrender.com/api/v1/orders/complete';
    try {
      Map<String, dynamic> dataToSend = {
        'orderId': orderId,
      };

      Response response = await _dio.post(
        url,
        data: dataToSend,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Order completed successfully'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to complete order: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }
}
