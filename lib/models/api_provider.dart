import 'package:dio/dio.dart';

class ApiProvide {
  static const String baseUrl =
      "https://gradution2024-production.up.railway.app/api/v1";
  UserLogin({required String email, required String password}) async {
    try {
      Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };
      Response response =
          await Dio().post("$baseUrl/driverauth/login", data: requestBody);
      print(response.data);
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
    }
  }

  UserRegisteration(
      {required String fullname,
      required String age,
      required String email,
      required String password,
      required String passwordConfirm,

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
