import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
class FogotPsswordApi{
  static const String baseUrl =
      "https://mutemotion.onrender.com/api/v1";
  ResetPassword(
      {required BuildContext context,
        required TextEditingController emailCont,}) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": emailCont.text,
      };
      print('Response: ${emailCont.text}');
      String jsonBody = jsonEncode(requestBody);
      print(jsonBody);
      Response response =
      await Dio().post("$baseUrl/driver/resetpassword", data: jsonBody);
      GoRouter.of(context).push('/forgotpassword');
      print('Request successful');
      print('Response: ${response.data}');
    } catch (e) {
  if (e is DioError) {
    if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout
        ) {
      // Handle connection timeout, receive timeout, send timeout, or other connection-related errors
      print('Request failed due to connection error: $e');
      // Show an appropriate error message to the user
    } else if (e.type == DioErrorType.badResponse) {
      // Handle errors with the server response (e.g., 404, 500, etc.)
      if (e.response != null) {
        print('Response Status Code: ${e.response!.statusCode}');
        print('Response Data: ${e.response!.data}');
        print('Request failed!\n ${e.response?.data["message"]} ');
        _showErrorDialogResPass(context, '${e.response?.data["message"]}', emailCont);
      }
    } else {
      // Handle other Dio errors
      print('Request failed due to unknown error: $e');
    }
  }
}

  }
  void _showErrorDialogResPass(
  BuildContext context,
  String message,
  TextEditingController emailcont,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: borderColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontFamily: 'Comfortaa', color: kprimaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              emailcont.clear();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Container(
              width: 105,
              height: 45,
              decoration: BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: borderColor),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
  ChangePassword(
      {required BuildContext context,
        required TextEditingController emailCont,
        required TextEditingController passCont,
        required TextEditingController ConfPasscont,
        required TextEditingController code1,
        required TextEditingController code2,
        required TextEditingController code3,
        required TextEditingController code4,
        }) async {
    try {
      print('before');
      Map<String, dynamic> requestBody = {
        "email":emailCont.text,
        "verificationCode":'${code1.text}${code2.text}${code3.text}${code4.text}',
        "newPassword":passCont.text,
        
      };
      Response response = await Dio().post("$baseUrl/driver/changepassword", data: requestBody);
      print('after');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        print('Request successful');
      print('Response: ${response.data}');
      GoRouter.of(context).push('/loginview');
        
      }
    }catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialogChaPass(
            context, "Email or code aren't correct", emailCont,code1,code2,code3,code4,passCont,ConfPasscont);
      
      }
    }
  }
  void _showErrorDialogChaPass(
    BuildContext context,
    String message,
      TextEditingController emailcont,
        TextEditingController code1,
        TextEditingController code2,
        TextEditingController code3,
        TextEditingController code4,
        TextEditingController passcont,
        TextEditingController ConfPasscont,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: borderColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontFamily: 'Comfortaa', color: kprimaryColor),
          
        ),
        actions: [
          TextButton(
            onPressed: () {
              emailcont.clear();
              code1.clear();
              code2.clear();
              code3.clear();
              code4.clear();
              passcont.clear();
              ConfPasscont.clear();
            
          
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Container(
              width: 105,
              height: 45,
              decoration: BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Padding(
                padding:  EdgeInsets.only(top: 4),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'OK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        color: borderColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
  ResentCode(
      {required BuildContext context,
        required TextEditingController emailCont,}) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": emailCont.text,
      };
      Response response =

      await Dio().post("$baseUrl/driver/sendagain", data: requestBody);
      print('Request successful');
      print('Response: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialogResCode(context, 'Email not Found', emailCont);
      }
    }
  }
  void _showErrorDialogResCode(
  BuildContext context,
  String message,
  TextEditingController emailcont,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: borderColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontFamily: 'Comfortaa', color: kprimaryColor),
          
        ),
        actions: [
          TextButton(
            onPressed: () {
              emailcont.clear();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Container(
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Padding(
                padding:  EdgeInsets.only(top: 12),
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: borderColor),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
}
