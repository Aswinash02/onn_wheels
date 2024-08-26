import 'dart:convert';

VerifyPhoneModel verifyPhoneModelFromJson(String str) =>
    VerifyPhoneModel.fromJson(json.decode(str));

class VerifyPhoneModel {
  String? message;
  String? otp;
  String? token;
  bool? isPhoneVerified;
  User? user;

  VerifyPhoneModel(
      {this.message, this.otp, this.token, this.isPhoneVerified, this.user});

  VerifyPhoneModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otp = json['otp'];
    token = json['token'];
    isPhoneVerified = json['is_phone_verified'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  int? isPhoneVerified;
  int? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? cmFirebaseToken;
  int? status;
  int? orderCount;
  String? loginMedium;
  int? socialId;
  int? zoneId;
  int? walletBalance;
  int? loyaltyPoint;
  String? refCode;
  String? currentLanguageKey;
  String? refBy;
  String? tempToken;
  String? latitude;
  String? longitude;
  dynamic userKyc;

  User(
      {this.id,
      this.fName,
      this.lName,
      this.phone,
      this.email,
      this.image,
      this.isPhoneVerified,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.cmFirebaseToken,
      this.status,
      this.orderCount,
      this.loginMedium,
      this.socialId,
      this.zoneId,
      this.walletBalance,
      this.loyaltyPoint,
      this.refCode,
      this.currentLanguageKey,
      this.refBy,
      this.tempToken,
      this.latitude,
      this.longitude,
      this.userKyc});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isPhoneVerified = json['is_phone_verified'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cmFirebaseToken = json['cm_firebase_token'];
    status = json['status'];
    orderCount = json['order_count'];
    loginMedium = json['login_medium'];
    socialId = json['social_id'];
    zoneId = json['zone_id'];
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
    refCode = json['ref_code'];
    currentLanguageKey = json['current_language_key'];
    refBy = json['ref_by'];
    tempToken = json['temp_token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userKyc = json['user_kyc'] == null ? null : json['user_kyc'];
  }
}
