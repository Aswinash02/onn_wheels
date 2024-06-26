import 'package:onnwheels/models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<void> setLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", value);
  }

  Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  Future<void> setUserId(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", value);
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_id") ?? "0";
  }

  Future<void> setUserName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_name", value);
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_name") ?? "";
  }

  Future<void> setUserEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_email", value);
  }

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_email") ?? "";
  }

  Future<void> setUserPhoneNo(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_phone", value);
  }

  Future<String> getUserPhoneNo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_phone") ?? "";
  }

  Future<void> setUserData({required LoginResponse loginResponse}) async {
    setLogin(true);
    setUserId(loginResponse.user!.id!.toString());
    setUserName(loginResponse.user!.fName!);
    setUserEmail(loginResponse.user!.email!);
    setUserPhoneNo(loginResponse.user!.phone!);
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await setLogin(false);
    await prefs.remove("user_name");
    await prefs.remove("user_id");
    await prefs.remove("user_email");
    await prefs.remove("user_phone");
  }
}
