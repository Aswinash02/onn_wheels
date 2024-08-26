class AadhaarOTPModel {
  int? timestamp;
  String? transactionId;
  AadhaarOTPData? data;
  int? code;

  AadhaarOTPModel({this.timestamp, this.transactionId, this.data, this.code});

  AadhaarOTPModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    transactionId = json['transaction_id'];
    data = json['data'] != null ? AadhaarOTPData.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['transaction_id'] = this.transactionId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class AadhaarOTPData {
  String? entity;
  String? message;

  AadhaarOTPData({this.entity, this.message});

  AadhaarOTPData.fromJson(Map<String, dynamic> json) {
    entity = json['@entity'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@entity'] = this.entity;
    data['message'] = this.message;
    return data;
  }
}
