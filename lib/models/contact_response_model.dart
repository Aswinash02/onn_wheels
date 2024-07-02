import 'dart:convert';

ContactResponseData contactResponseDataFromJson(String str) => ContactResponseData.fromJson(json.decode(str));

String contactResponseDataToJson(ContactResponseData data) => json.encode(data.toJson());
class ContactResponseData {
  bool? success;
  String? message;

  ContactResponseData({this.success, this.message});

  ContactResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
