import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../core/utils/constant.dart';
import '../feature/OTP/data/OTP_provider.dart';
import '../feature/OTP/presentation/view/OTP.dart';


class ApiProvider {
  static const String baseUrl = "https://mutemotion.onrender.com/api/v1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ApiProvider() {
    _initFirebaseMessaging();
    _initializeLocalNotifications();
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showNotification(
            message.notification!.title, message.notification!.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Handle the notification tapped logic here
    });
  }

  Future<void> _showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<String?> getFcmToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Failed to get FCM token: $e");
      return null;
    }
  }

  Future<void> updateFCMToken({required String userId, required String fcmToken}) async {
    try {
      Map<String, dynamic> requestBody = {
        "userId": userId,
        "fcmToken": fcmToken,
      };

      Response response = await Dio().post("$baseUrl/driver/updateFCMToken", data: requestBody);

      if (response.statusCode == 200) {
        print('FCM token updated successfully');
      } else {
        print('Failed to update FCM token: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('Dio error: ${e.response?.data}');
      } else {
        print('Request failed with error: $e');
      }
    }
  }

  Future<void> userLogin({
    required BuildContext context,
    required TextEditingController emailCont,
    required TextEditingController passCont,
  }) async {
    try {
      String? fcmToken = await getFcmToken();
      if (fcmToken == null) {
        throw Exception("FCM token is null");
      }

      Map<String, dynamic> requestBody = {
        "email": emailCont.text,
        "password": passCont.text,
      };

      Response response = await Dio().post("$baseUrl/driver/login", data: requestBody);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print('Response: ${response.data}');
        String token = response.data["token"];
        String userId = response.data["user"]["_id"];
        String fullname = response.data["user"]["fullname"];
        String rating = response.data["user"]["rating"];
        String numberOfReviews = response.data["user"]["numberOfReviews"];
        String profileImg = response.data["user"]["profileImg"];

        double ratingValue = double.parse(rating);
        String roundedRating = ratingValue.toStringAsFixed(1);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setString("userId", userId);
        await prefs.setString("fullname", fullname);
        await prefs.setString("rating", roundedRating);
        await prefs.setString("numberOfReviews", numberOfReviews);
        await prefs.setString("profileImg", profileImg);
        print("Token is: $token");
        print("UserId is: $userId");
        print("Fullname is: $fullname");
        print("Rating is: $rating");
        print("NumberOfReviews is: $numberOfReviews");
        print("ProfileImg is: $profileImg");
        await updateFCMToken(userId: userId, fcmToken: fcmToken);
        
        GoRouter.of(context).push('/navbar');
      } else if (response.statusCode == 401) {
        final error = response.statusMessage;
        _showErrorDialogLogin(context, error!, emailCont, passCont);
      } else {
        print('Request failed with status: ${response.statusCode}');
        _showErrorDialogLogin(context, 'Request failed with status: ${response.statusCode}', emailCont, passCont);
      }
    } catch (e) {
      if (e is DioException) {
        print('Dio error: ${e.response?.data}');
        String errorMessage = e.response?.data["message"] ?? 'Unknown error occurred';
        if (e.response?.statusCode == 404) {
          _showErrorDialogLogin(context, 'Resource not found. Please check the URL or contact support.', emailCont, passCont);
        } else {
          _showErrorDialogLogin(context, 'Request failed with error: $errorMessage', emailCont, passCont);
        }
      } else {
        print('Request failed with error: $e');
        _showErrorDialogLogin(context, 'An unexpected error occurred. Please try again later.', emailCont, passCont);
      }
    }
  }

  Future<void> userRegistration({
    required BuildContext context,
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
      String? fcmToken = await getFcmToken();
      FormData formData = FormData.fromMap({
        "fullname": fullname,
        "email": email,
        "password": password,
        "passwordConfirm": passwordConfirm,
        "phone": phone,
        "age": age,
        "cartype": cartype,
        "color": color,
        "model": model,
        "carnum": carnum,
        "cardescription": cardescription,
        "CardNumber": cardnum,
        "ExpiryDate": exdate,
        "CVV": cvv,
      });

      Response response = await Dio().post("$baseUrl/driver/signup", data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print('Response: ${response.data}');

        String userId = response.data["user"]["_id"];
        String fullname = response.data["user"]["fullname"];
        String rating = response.data["user"]["rating"];
        String numberOfReviews = response.data["user"]["numberOfReviews"];

        double ratingValue = double.parse(rating);
        String roundedRating = ratingValue.toStringAsFixed(1);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userId", userId);
        await prefs.setString("fullname", fullname);
        await prefs.setString("rating", roundedRating);
        await prefs.setString("numberOfReviews", numberOfReviews);
        await prefs.setString("fullname", fullname);
        await updateFCMToken(userId: userId, fcmToken: fcmToken!);
        await OTPprovider().sendcode(email: email);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OTP(),
        ));
      } else {
        _showErrorDialogReg(context, 'Registration failed', 'Unknown error occurred');
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialogReg(context, 'Attention!', '${e.response?.data["errors"]?[0]?["msg"] ?? 'Unknown error'}');
      }
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
          buttonPadding: EdgeInsets.only(right: 20, bottom: 10),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa', color: borderColor),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                elevation: MaterialStatePropertyAll(30.0),
                backgroundColor: MaterialStateProperty.all<Color>(borderColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                emailCont.clear();
                passCont.clear();
              },
              child: Text(
                'Try again',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
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
          buttonPadding: EdgeInsets.only(right: 20, bottom: 10),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold, color: borderColor),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa', color: borderColor),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                elevation: MaterialStatePropertyAll(30.0),
                backgroundColor: MaterialStateProperty.all<Color>(borderColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Try again',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}