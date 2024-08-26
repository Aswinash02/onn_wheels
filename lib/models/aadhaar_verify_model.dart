class AadhaarVerifyModel {
  int? timestamp;
  String? transactionId;
  AadhaarData? data;
  int? code;

  AadhaarVerifyModel(
      {this.timestamp, this.transactionId, this.data, this.code});

  AadhaarVerifyModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    transactionId = json['transaction_id'];
    data = json['data'] != null ? new AadhaarData.fromJson(json['data']) : null;
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

class AadhaarData {
  String? entity;
  int? referenceId;
  String? message;

  AadhaarData({this.entity, this.referenceId, this.message});

  AadhaarData.fromJson(Map<String, dynamic> json) {
    entity = json['@entity'];
    referenceId = json['reference_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@entity'] = this.entity;
    data['reference_id'] = this.referenceId;
    data['message'] = this.message;
    return data;
  }
}
