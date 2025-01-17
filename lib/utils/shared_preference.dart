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

  Future<void> setUserToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_token", value);
  }

  Future<String> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_token") ?? "";
  }

  Future<void> setKycVerified(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("kyc_verified", value);
  }

  Future<Object> getKycVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("kyc_verified") ?? "";
  }

  Future<void> setUserData({required loginResponse}) async {
    setLogin(true);
    print(loginResponse.user!.id!.toString());
    print(loginResponse.user!.fName!);
    print(loginResponse.user!.email!);
    print(loginResponse.user!.phone!);
    print(loginResponse.token!);
    setUserId(loginResponse.user!.id!.toString());
    setUserName(loginResponse.user!.fName!);
    setUserEmail(loginResponse.user!.email!);
    setUserPhoneNo(loginResponse.user!.phone!);
    setUserToken(loginResponse.token!);
  }

  Future<void> clearUserData() async {
    await setUserId("");
    await setUserName("");
    await setUserEmail("");
    await setUserPhoneNo("");
    await setUserToken("");
  }

  Future<void> clearUserInfo() async {
    await setLogin(false);
    await saveUserInfo("");
  }

  Future<void> saveUserInfo(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_info", value);
  }

  Future<String> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_info") ?? "";
  }
}
