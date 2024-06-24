import 'dart:convert';
import 'package:get/get.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/models/login_response_model.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/views/auth/otp_field.dart';
import 'package:onnwheels/views/main_page/main_page.dart';
import 'package:toast/toast.dart';
import '../helpers/api_helpers.dart';
import '../models/signup_model.dart';
import '../utils/app_config.dart';
import '../utils/shared_value.dart';

class AuthRepository {
  Future getSignupResponse(
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
    if (response.statusCode == 200) {
      Get.to(
        () => Otp(
          phoneNumber: phone,
        ),
      );
      return signupResponseFromJson(response.body);
    } else if (response.statusCode == 403) {
      ToastComponent.showDialog("Not Applicable",
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }

  Future getLoginResponse(
    String? email,
    String password,
  ) async {
    var post_body = jsonEncode({"email": "$email", "password": "$password"});

    String url = ("${AppConfig.BASE_URL}/auth/login");
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body);
    print("login post response=======>${post_body}");
    print("login response=======>${response.body}");
    if (response.statusCode == 200) {
      print("status 200");
      SharedPreference().setLogin(true);
      Get.offAll(() => MainPage());
      return loginResponseFromJson(response.body);
    } else if (response.statusCode == 401) {
      print("status 401");
      ToastComponent.showDialog('Unauthorized',
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }

  Future getConfirmCodeResponse(String verification_code, String? phone) async {
    var post_body =
        jsonEncode({"phone": "$phone", "otp": "$verification_code"});

    String url = ("${AppConfig.BASE_URL}/auth/verify-phone");
    print(url);
    print("Post Body Confirm Code ${post_body}");
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);
    print("confirm Code RESPONSE bODY============>${response.body}");

    // return confirmCodeResponseFromJson(response.body);
  }

  Future getLoginResponsePhone(
      String? phone,
      ) async {
    var post_body = jsonEncode({"phone": "$phone"});

    String url = ("${AppConfig.BASE_URL}/auth/login");
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body);
    if (response.statusCode == 200) {
      print("status 200");
      print("response body phone otp======>${response.body}");
      // SharedPreference().setLogin(true);
      // Get.offAll(() => MainPage());
      return loginResponseFromJson(response.body);
    } else if (response.statusCode == 401) {
      print("status 401");
      ToastComponent.showDialog('Unauthorized',
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }
}
