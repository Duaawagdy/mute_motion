// import 'package:dio/dio.dart';
// import 'package:mute_motion/feature/profile/profile_mode.dart';

// class UserInfo {
//   static Future<ProfileModel> getUserInfo(String? token) async {
//     final String apiUrl = 'https://mutemotion.onrender.com/api/driverInfo';
//           print(token);
//     try {
//       Response response = await Dio().get(
//         apiUrl,
//         options: Options(headers: {
//           'Authorization':
//               'Bearer $token', // Pass the token in the Authorization header
//         }),
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('Request successful');
//         print(response.data);
//         Map<String, dynamic> userDataMap =
//             Map<String, dynamic>.from(response.data);
//         return ProfileModel.fromJson(userDataMap);
//       } else {
//         throw Exception('Failed to load user data');
//       }
//     } catch (error) {
//       // Handle errors
//       print('Error: $error');
//       throw error; // Rethrow the error to maintain the return type
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'dart:convert';

import '../models/profile_mode.dart'; // For base64 encoding/decoding

 class UserInfo {
  static Future<ProfileModel> getUserInfo(String? token) async {
    final String apiUrl = 'https://mutemotion.onrender.com/api/driverInfo';
    print(token);
    try {
      Response response = await Dio().get(
        apiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print(response.data);
        Map<String, dynamic> userDataMap = Map<String, dynamic>.from(response.data);
        return ProfileModel.fromJson(userDataMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  static Future<void> uploadImage(String token, String base64Image) async {
    final String apiUrl = 'https://mutemotion.onrender.com/driver/profile'; // Replace with your actual API endpoint

    try {
      final Response response = await Dio().post(
        apiUrl,
        data: jsonEncode({
          'profileImgBase64': base64Image,
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Driver profile image updated successfully');
        print(response.data);
      } else {
        print('Failed to update driver profile image: ${response.data}');
      }
    } catch (error) {
      print('Error updating driver profile image: $error');
    }
  }
}

