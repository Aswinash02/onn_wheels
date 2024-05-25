import 'dart:convert';

PanResponse panResponseFromJson(String str) => PanResponse.fromJson(json.decode(str));

String panResponseToJson(PanResponse data) => json.encode(data.toJson());
class PanResponse {
  int? responseStatusId;
  PanData? panData;
  int? responseTypeId;
  String? message;
  int? status;

  PanResponse(
      {this.responseStatusId,
        this.panData,
        this.responseTypeId,
        this.message,
        this.status});

  PanResponse.fromJson(Map<String, dynamic> json) {
    responseStatusId = json['response_status_id'];
    panData = json['data'] != null ? new PanData.fromJson(json['data']) : null;
    responseTypeId = json['response_type_id'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_status_id'] = this.responseStatusId;
    if (this.panData != null) {
      data['data'] = this.panData!.toJson();
    }
    data['response_type_id'] = this.responseTypeId;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class PanData {
  String? panNumber;
  String? aadhaarSeedingStatus;
  String? gender;
  String? panReturnedName;
  String? lastName;
  String? aadhaarSeedingStatusCode;
  String? middleName;
  String? title;
  String? firstName;

  PanData(
      {this.panNumber,
        this.aadhaarSeedingStatus,
        this.gender,
        this.panReturnedName,
        this.lastName,
        this.aadhaarSeedingStatusCode,
        this.middleName,
        this.title,
        this.firstName});

  PanData.fromJson(Map<String, dynamic> json) {
    panNumber = json['pan_number'];
    aadhaarSeedingStatus = json['aadhaar_seeding_status'];
    gender = json['gender'];
    panReturnedName = json['pan_returned_name'];
    lastName = json['last_name'];
    aadhaarSeedingStatusCode = json['aadhaar_seeding_status_code'];
    middleName = json['middle_name'];
    title = json['title'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pan_number'] = this.panNumber;
    data['aadhaar_seeding_status'] = this.aadhaarSeedingStatus;
    data['gender'] = this.gender;
    data['pan_returned_name'] = this.panReturnedName;
    data['last_name'] = this.lastName;
    data['aadhaar_seeding_status_code'] = this.aadhaarSeedingStatusCode;
    data['middle_name'] = this.middleName;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    return data;
  }
}
