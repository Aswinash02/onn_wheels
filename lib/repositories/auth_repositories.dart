import 'dart:convert';

import '../helpers/api_helpers.dart';
import '../models/signup_model.dart';
import '../utils/app_config.dart';
import '../utils/shared_value.dart';

class AuthRepository{

  Future<SignupResponse> getSignupResponse(
      String name,
      String? email,
      String phone,
      String password,
      ) async {
    var post_body = jsonEncode({
      "f_name": "$name",
      "l_name": "",
      "email": "$email",
      "phone": "$phone",
      "password": "$password"
    });

    String url = ("${AppConfig.BASE_URL}/auth/sign-up");
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        body: post_body);
    print("signup response=======>${response.body}");

    return signupResponseFromJson(response.body);
  }

  Future getLoginResponse(
      String? email,
      String password,
      ) async {
    var post_body = jsonEncode({
      "email": "$email",
      "password": "$password"
    });

    String url = ("${AppConfig.BASE_URL}/auth/login");
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        body: post_body);
    print("login response=======>${response.body}");

    // return signupResponseFromJson(response.body);
  }

  Future getConfirmCodeResponse(String verification_code,String? phone) async {
    var post_body = jsonEncode({ "phone": "$phone","otp": "$verification_code"});

    String url = ("${AppConfig.BASE_URL}/auth/verify-phone");
    print(url);
    print(post_body);
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);
    print(response.body);

    // return confirmCodeResponseFromJson(response.body);
  }
}