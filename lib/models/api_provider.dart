
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';

class ApiProvide {
  static const String baseUrl =
      "https://gradution2024-production.up.railway.app/api/v1";
  UserLogin({required BuildContext context,required TextEditingController emailCont,
  required TextEditingController passCont}) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": emailCont.text,
        "password": passCont.text,
      };
      Response response =
          await Dio().post("$baseUrl/driverauth/login", data: requestBody);
          if (response.statusCode == 200 || response.statusCode == 201 ) {
                GoRouter.of(context).push('/navbar');
                print('Request successful');
                print('Response: ${response.data}');
                }else {
        _showErrorDialog(context, 'Request failed! ',emailCont, passCont);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialog(context, 'Request failed! ', emailCont, passCont);
      }
    }
  }
    void _showErrorDialog(BuildContext context, String message, TextEditingController emailCont,
    TextEditingController passCont,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: borderColor,
          content: Text(message,textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa',color: Colors.white),),
          actions: [
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
        ),
      ),),
              onPressed: () {
                Navigator.of(context).pop();
                emailCont.clear();
                passCont.clear(); // Close the dialog
              },
              child: Text('Try again',textAlign: TextAlign.center,style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa',color: borderColor),),),
          ],
        );
      },
    );
  }
  UserRegisteration(
      {required String fullname,
      required String age,
      required String email,
      required String password,
      required String passwordConfirm,
      required String phone,
      }) async {
    try {
      Map<String, dynamic> requestBody = {
        "fullname": fullname,

        "email": email,
        "password": password,
        "passwordConfirm": passwordConfirm,

      };
      Response response =
          await Dio().post("$baseUrl//drivers", data: requestBody);
      print(response.data);
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
    }
  }
}
