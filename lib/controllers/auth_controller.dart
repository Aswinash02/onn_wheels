import 'dart:convert';

import 'package:get/get.dart';
import 'package:onnwheels/models/user_info_model.dart';
import 'package:onnwheels/utils/shared_preference.dart';

class AuthController extends GetxController {
  Future<void> saveUserInfo(UserInfo userInfo) async {
    String userData = jsonEncode(userInfo.toJson());
    SharedPreference().saveUserInfo(userData);
  }

  Future<UserInfo?> getUserInfo() async {
    UserInfo? userData;
    try {
      userData =
          UserInfo.fromJson(jsonDecode(await SharedPreference().getUserInfo()));
    } catch (_) {}
    return userData;
  }
}
