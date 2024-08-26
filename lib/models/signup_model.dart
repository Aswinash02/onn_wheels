import 'dart:convert';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

class SignupResponse {
  String? token;
  int? isPhoneVerified;
  String? phoneVerifyEndUrl;
  int? otp;
  bool? result;
  List<Message>? message;

  SignupResponse({this.token, this.isPhoneVerified, this.phoneVerifyEndUrl});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isPhoneVerified = json['is_phone_verified'];
    phoneVerifyEndUrl = json['phone_verify_end_url'];
    otp = json['otp'];
    result = json['result'];
    if (json['message'] != null) {
      message = (json['message'] as List)
          .map((item) => Message.fromJson(item))
          .toList();
    }
  }
}

class Message {
  String? code;
  String? message;

  Message({this.code, this.message});

  Message.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
