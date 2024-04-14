import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/OTP/presentation/view/OTP.dart';
import 'package:mute_motion/models/OTP_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvide {
  static const String baseUrl =
      "https://mutemotion.onrender.com/api/v1";
  UserLogin(
      {required BuildContext context,
        required TextEditingController emailCont,
        required TextEditingController passCont}) async {
    try {
  Map<String, dynamic> requestBody = {
    "email": emailCont.text,
    "password": passCont.text,
  };
  Response response = await Dio().post("$baseUrl/driver/login", data: requestBody);
  
  // Check if response is successful
  if (response.statusCode == 200) {
    print('Request successful');
    print('Response: ${response.data}');
    
    // Assuming your response data has a 'token' field
    String token = response.data["token"];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    print("Token is: $token");
    // set User Name in side bar
    String fullname = response.data["user"]["fullname"];
    await prefs.setString("fullname", fullname);
    print("fullname is: $fullname");
    setUserName(fullname);
    // Navigate to next screen
    GoRouter.of(context).push('/navbar');
  } else {
    // Handle non-200 status code
    print('Request failed with status: ${response.statusCode}');
    _showErrorDialogLogin(context, 'Request failed with status: ${response.statusCode}', emailCont, passCont);
  }
} catch (e) {
  // Handle Dio exceptions
  print('Request failed with error: $e');
  _showErrorDialogLogin(context, 'Request failed with error: $e', emailCont, passCont);
}

  }

  void _showErrorDialogLogin(
      BuildContext context,
      String message,
      TextEditingController emailCont,
      TextEditingController passCont,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: EdgeInsets.only(right: 20,bottom: 10),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontFamily: 'Comfortaa', color: borderColor),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                elevation:MaterialStatePropertyAll(30.0),
                backgroundColor: MaterialStateProperty.all<Color>(borderColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the border radius as needed
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                emailCont.clear();
                passCont.clear(); // Close the dialog
              },
              child: Text(
                'Try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Comfortaa',fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  UserRegisteration(
      { required BuildContext context,
        required String fullname,
        required String age,
        required String email,
        required String password,
        required String passwordConfirm,
        required String phone,
        required String cartype,
        required String color,
        required String model,
        required String carnum,
        required String cardescription,
        required String cardnum,
        required String exdate,
        required String cvv,
      }) async {
    try {
      FormData formData = FormData.fromMap(
          {
            "fullname": fullname,
            "email": email,
            "password": password,
            "passwordConfirm": passwordConfirm,
            "phone":phone,
            "age": age,
            "cartype": cartype,
            "color": color,
            "model": model,
            "carnum": carnum,
            "cardescription":cardescription,
            "CardNumber": cardnum,
            "ExpiryDate": exdate,
            "CVV": cvv,
          }
      );
      Response response =

      await Dio().post("$baseUrl/driver/signup", data: formData);

      await OTPprovider().sendcode(email: email);
      Navigator.of(context).push(MaterialPageRoute (
        builder: (BuildContext context) =>  OTP(),
      ),);
      print('Request successful');
      print('Response: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        //_showErrorDialogReg(context, 'Attention!','this mail already taken');
        _showErrorDialogReg(context, 'Attention!','${e.response?.data["errors"][0]["msg"]}');
      }
    }
  }


  void _showErrorDialogReg(
      BuildContext context,
      String title,
      String message,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: EdgeInsets.only(right: 20,bottom: 10),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontFamily: 'Comfortaa',fontWeight: FontWeight.bold,color: borderColor),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Comfortaa',color: borderColor),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                elevation:MaterialStatePropertyAll(30.0),
                backgroundColor: MaterialStateProperty.all<Color>(borderColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the border radius as needed
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();// Close the dialog
              },
              child: Text(
                'Try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Comfortaa',fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}