import 'package:dio/dio.dart';
import 'package:mute_motion/feature/profile/profile_mode.dart';

class UserInfo {
  static Future<ProfileModel> getUserInfo(String? token) async {
    final String apiUrl = 'https://mutemotion.onrender.com/api/driverInfo';
    try {
      Response response = await Dio().get(
        apiUrl,
        options: Options(headers: {
          'Authorization':
              'Bearer $token', // Pass the token in the Authorization header
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print(response.data);
        Map<String, dynamic> userDataMap =
            Map<String, dynamic>.from(response.data);
        return ProfileModel.fromJson(userDataMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      // Handle errors
      print('Error: $error');
      throw error; // Rethrow the error to maintain the return type
    }
  }
}
