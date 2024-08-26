import 'dart:convert';
import 'package:get/get.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/models/login_response_model.dart';
import 'package:onnwheels/models/verify_phone_model.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/views/auth/otp_field.dart';
import 'package:onnwheels/views/main_page/main_page.dart';
import 'package:toast/toast.dart';
import '../helpers/api_helpers.dart';
import '../models/signup_model.dart';
import '../utils/app_config.dart';
import '../utils/shared_value.dart';

class AuthRepository {
  Future<SignupResponse?> getSignupResponse(
    String name,
    String? email,
    String phone,
    String password,
  ) async {
    var postBody = jsonEncode({
      "f_name": name,
      "l_name": "",
      "email": email,
      "phone": phone,
      "password": password
    });

    String url = "${AppConfig.BASE_URL}/auth/sign-up";

    try {
      final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        body: postBody,
      );

      print("Signup response: ${response.body}");

      if (response.statusCode == 200) {
        Get.to(() => Otp(phoneNumber: phone));
        ToastComponent.showDialog(
          "Signup Successful",
          gravity: Toast.center,
          duration: Toast.lengthLong,
        );
        return signupResponseFromJson(response.body);
      } else {
        SignupResponse res = signupResponseFromJson(response.body);
        ToastComponent.showDialog(
          "${res.message!.first.message}",
          gravity: Toast.center,
          duration: Toast.lengthLong,
        );
        return null;
      }
    } catch (error) {
      print("Error occurred during signup: $error");
      ToastComponent.showDialog(
        "An error occurred. Please try again.",
        gravity: Toast.center,
        duration: Toast.lengthLong,
      );
      return null;
    }
  }

  Future<LoginResponse?> getLoginResponse(
      String? email, String password) async {
    var post_body = jsonEncode({"email": "$email", "password": "$password"});

    String url = ("${AppConfig.BASE_URL}/auth/login");

    try {
      final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body,
      );

      if (response.statusCode == 200) {
        ToastComponent.showDialog('Login Successful',
            gravity: Toast.center, duration: Toast.lengthLong);
        SharedPreference().setLogin(true);
        Get.offAll(() => MainPage());
        return loginResponseFromJson(response.body);
      } else {
        LoginResponse res = loginResponseFromJson(response.body);
        ToastComponent.showDialog(
          "${res.error!.first.message}",
          gravity: Toast.center,
          duration: Toast.lengthLong,
        );
        return null;
      }
    } catch (e) {
      ToastComponent.showDialog('An error occurred. Please try again',
          gravity: Toast.center, duration: Toast.lengthLong);
      return null;
    }
  }

  Future<VerifyPhoneModel?> getConfirmCodeResponse(
      String verification_code, String? phone) async {
    var post_body =
        jsonEncode({"phone": "$phone", "otp": "$verification_code"});

    String url = ("${AppConfig.BASE_URL}/auth/verify-phone");
    print(url);
    print("Post Body Confirm Code ${post_body}");
    try {
      final response = await ApiHelper.post(
          url: url,
          headers: {
            "Content-Type": "application/json",
            "App-Language": app_language.$!,
            "Authorization": "Bearer ${access_token.$}",
          },
          body: post_body);

      if (response.statusCode == 200) {
        ToastComponent.showDialog('Phone number verified successfully',
            gravity: Toast.center, duration: Toast.lengthLong);
        SharedPreference().setLogin(true);
        Get.offAll(() => MainPage());
        return verifyPhoneModelFromJson(response.body);
      } else {
        VerifyPhoneModel res = verifyPhoneModelFromJson(response.body);
        ToastComponent.showDialog(
          "${res.message}",
          gravity: Toast.center,
          duration: Toast.lengthLong,
        );
        return null;
      }
    } catch (e) {
      ToastComponent.showDialog('An error occurred. Please try again',
          gravity: Toast.center, duration: Toast.lengthLong);
      return null;
    }
  }

  Future<LoginResponse?> getLoginResponsePhone(
    String? phone,
  ) async {
    var post_body = jsonEncode({"phone": "$phone"});

    String url = ("${AppConfig.BASE_URL}/auth/login");
    try {
      final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body,
      );

      if (response.statusCode == 200) {
        ToastComponent.showDialog('OTP Send Successful',
            gravity: Toast.center, duration: Toast.lengthLong);
        print('response.body ${response.body}');

        return loginResponseFromJson(response.body);
      } else {
        LoginResponse res = loginResponseFromJson(response.body);
        ToastComponent.showDialog(
          "${res.error!.first.message}",
          gravity: Toast.center,
          duration: Toast.lengthLong,
        );
        return null;
      }
    } catch (e) {
      ToastComponent.showDialog('An error occurred. Please try again',
          gravity: Toast.center, duration: Toast.lengthLong);
      return null;
    }
  }

  Future<int> logOut() async {
    String url = ("${AppConfig.BASE_URL}/auth/logout");
    String token = await SharedPreference().getUserToken();
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({}));
    if (response.statusCode == 200) {
      ToastComponent.showDialog('logout Successful',
          gravity: Toast.center, duration: Toast.lengthLong);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
