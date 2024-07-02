import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? token;
  int? isPhoneVerified;
  User? user;
  UserKyc? userKyc;

  LoginResponse({this.token, this.isPhoneVerified, this.user, this.userKyc});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isPhoneVerified = json['is_phone_verified'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    userKyc = json['user_kyc'] != null
        ? new UserKyc.fromJson(json['user_kyc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['is_phone_verified'] = this.isPhoneVerified;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.userKyc != null) {
      data['user_kyc'] = this.userKyc!.toJson();
    }
    return data;
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
  UserKyc? userKyc;

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
    userKyc = json['user_kyc'] != null
        ? new UserKyc.fromJson(json['user_kyc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['status'] = this.status;
    data['order_count'] = this.orderCount;
    data['login_medium'] = this.loginMedium;
    data['social_id'] = this.socialId;
    data['zone_id'] = this.zoneId;
    data['wallet_balance'] = this.walletBalance;
    data['loyalty_point'] = this.loyaltyPoint;
    data['ref_code'] = this.refCode;
    data['current_language_key'] = this.currentLanguageKey;
    data['ref_by'] = this.refBy;
    data['temp_token'] = this.tempToken;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.userKyc != null) {
      data['user_kyc'] = this.userKyc!.toJson();
    }
    return data;
  }
}

class UserKyc {
  int? id;
  int? userId;
  String? aadhar;
  String? pan;
  String? licenseFront;
  String? licenseBack;
  int? isVerified;
  int? isReject;
  String? status;
  String? createdAt;
  String? updatedAt;

  UserKyc(
      {this.id,
        this.userId,
        this.aadhar,
        this.pan,
        this.licenseFront,
        this.licenseBack,
        this.isVerified,
        this.isReject,
        this.status,
        this.createdAt,
        this.updatedAt});

  UserKyc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    aadhar = json['aadhar'];
    pan = json['pan'];
    licenseFront = json['license_front'];
    licenseBack = json['license_back'];
    isVerified = json['is_verified'];
    isReject = json['is_reject'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['aadhar'] = this.aadhar;
    data['pan'] = this.pan;
    data['license_front'] = this.licenseFront;
    data['license_back'] = this.licenseBack;
    data['is_verified'] = this.isVerified;
    data['is_reject'] = this.isReject;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
