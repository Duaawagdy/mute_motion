import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingApi {
  static const String baseUrl =
      "https://mutemotion.onrender.com/api/v1/passenger/comment";

  Future<void> userFeedBack({
    required BuildContext context,
    required TextEditingController commentText,
  }) async {
    try {
      // Retrieve the driverId from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? passengerId = prefs.getString("passengerId");
      String? token = prefs.getString("token");
      print(passengerId);

      if (passengerId == null) {
        print("Passenger ID is not available.");
        showRatingDialog(
          context: context,
          title: 'Error',
          content: 'Passenger ID is not available. Please try again later.',
        );
        return;
      }
      
      if (token == null) {
        print("Token is not available.");
        showRatingDialog(
          context: context,
          title: 'Error',
          content: 'Authentication token is missing. Please log in again.',
        );
        return;
      }
      Map<String, dynamic> requestBody = {
        "passengerId": passengerId,
        "commentText": commentText.text, // Make sure to send the text content
      };
      print(requestBody);

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.post(baseUrl, data: requestBody);
      print(requestBody);

      // Check if response is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print('Response: ${response.data}');

        // Show success dialog
        showRatingDialog(
          context: context,
          title: 'Success',
          content: 'Feedback submitted successfully.',
        );
      } else {
        // Handle non-200 status code
        print('Request failed with status: ${response.statusCode}');
        showRatingDialog(
          context: context,
          title: 'Error',

          content:
              'Failed to submit rating. Status code: ${response.statusCode}',

        );
      }
    } catch (e) {
      // Handle Dio exceptions
      print('Request failed with error: $e');
      showRatingDialog(
        context: context,
        title: 'Error',
        content: ' An error occurred ',
      );
    }
  }

  // Define the dialog function at the end of userRate
  void showRatingDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
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
                foregroundColor: Colors.white,
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
}
