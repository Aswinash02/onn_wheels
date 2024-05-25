import 'dart:convert';

SignupResponse signupResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());
class SignupResponse {
  String? token;
  int? isPhoneVerified;
  String? phoneVerifyEndUrl;

  SignupResponse({this.token, this.isPhoneVerified, this.phoneVerifyEndUrl});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isPhoneVerified = json['is_phone_verified'];
    phoneVerifyEndUrl = json['phone_verify_end_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['phone_verify_end_url'] = this.phoneVerifyEndUrl;
    return data;
  }
}