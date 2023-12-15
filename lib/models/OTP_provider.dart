import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
class OTPprovider{
  static const String baseUrl = "https://verifications.onrender.com";
  sendcode({required String email})async{
    try{
      Map<String,dynamic>requestBody={
        "email":email
      };
      Response response =
          await Dio().post("$baseUrl/sendVerificationCode",data: requestBody);
      print(response.data);
    }
    catch(ex){
      if(ex is DioException){
        print(ex.response?.data);
      }
    }
  }
  code({required BuildContext context,required String email, required String code,
    required TextEditingController code1,
    required TextEditingController code2,
    required TextEditingController code3,
    required TextEditingController code4,
  })async{
    try {
      Map<String, dynamic> requestBody = {
        "email": email,
        "code": code,
      };
      Response response =
      await Dio().post("$baseUrl/verifyCode", data: requestBody);
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        GoRouter.of(context).push('/navbar');
        print('Response: ${response.data}');
      }else {
        print('Responses: ${response.data}');
        _showErrorDialog(context, 'Request failed! ',code1,code2,code3,code4 );
      }
    } catch (e) {
      if (e is DioException) {
        print('Responsesss:${e.response?.data}');
        _showErrorDialog(context, 'verification code is\'t right! ',code1,code2,code3,code4 );
      }
    }
  }
void _showErrorDialog(
    BuildContext context,
    String message,
    TextEditingController code1,
    TextEditingController code2,
    TextEditingController code3,
    TextEditingController code4,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: borderColor,
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontFamily: 'Comfortaa', color: Colors.white),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the border radius as needed
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                code1.clear();// Close the dialog
                code2.clear();
                code3.clear();
                code4.clear();
              },
              child: Text(
                'Try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Comfortaa',fontWeight: FontWeight.bold, color: borderColor),
              ),
            ),
          ],
        );
      },
    );
  }
}