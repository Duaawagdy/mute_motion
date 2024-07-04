import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountApi {
  static const String baseUrl = "https://mutemotion.onrender.com/api/v1/driver/deleteAccount";

  Future<void> deleteDriverAccount({
    required BuildContext context,
  }) async {
    try {
      // Retrieve the token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      if (token == null) {
        print("Token is not available.");
        showFeedbackDialog(
          context: context,
          title: 'Error',
          content: 'Authentication token is missing. Please log in again.',
        );
        return;
      }

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.delete(
        baseUrl,
      );

      // Check if response is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Account deletion successful');
        print('Response: ${response.data}');
        
        // Navigate to login screen
        GoRouter.of(context).push('/deletecompleted');
      } else {
        // Handle non-200 status code
        print('Request failed with status: ${response.statusCode}');
        showFeedbackDialog(
          context: context,
          title: 'Error',
          content: 'Failed to delete account. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle Dio exceptions
      print('Request failed with error: $e');
      showFeedbackDialog(
        context: context,
        title: 'Error',
        content: 'An error occurred while deleting the account.',
      );
    }
  }

  void showFeedbackDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(
              color: borderColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(color: borderColor, fontSize: 15),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: borderColor,
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  color: borderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void navigateTo(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }
}
