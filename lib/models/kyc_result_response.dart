import 'dart:convert';

kycResultResponse kycResultFromJson(String str) =>
    kycResultResponse.fromJson(json.decode(str));

String kycResultToJson(kycResultResponse data) => json.encode(data.toJson());

class kycResultResponse {
  bool? success;
  Data? data;

  kycResultResponse({this.success, this.data});

  kycResultResponse.fromJson(Map<String, dynamic> json) {
    print('json ------  ${json['data']}');
    print('success ------  ${json['success']}');
    success = json['success'];

    data = json['data'] != "User KYC details not found"
        ? new Data.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? aadhaar;
  String? pan;
  String? licenseFront;
  String? licenseBack;
  int? isVerified;
  int? isReject;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? userName;

  Data(
      {this.id,
      this.userId,
      this.aadhaar,
      this.pan,
      this.licenseFront,
      this.licenseBack,
      this.isVerified,
      this.isReject,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    aadhaar = json['aadhar'];
    pan = json['pan'];
    licenseFront = json['license_front'];
    licenseBack = json['license_back'];
    isVerified = json['is_verified'];
    isReject = json['is_reject'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['aadhar'] = this.aadhaar;
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
