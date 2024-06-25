import 'dart:convert';

CheckoutResponse checkoutResponseFromJson(String str) =>
    CheckoutResponse.fromJson(json.decode(str));

String checkoutResponseToJson(CheckoutResponse data) =>
    json.encode(data.toJson());

class CheckoutResponse {
  int? userId;
  String? contactPersonName;
  String? contactPersonNumber;
  String? contactPersonEmail;
  String? address;
  String? lng;
  String? lat;
  int? storeId;
  int? orderAmount;
  String? paymentStatus;
  String? transactionReference;
  int? itemId;
  double? distance;
  String? startDate;
  String? endDate;

  CheckoutResponse(
      {this.userId,
      this.contactPersonName,
      this.contactPersonNumber,
      this.contactPersonEmail,
      this.address,
      this.lng,
      this.lat,
      this.storeId,
      this.orderAmount,
      this.paymentStatus,
      this.transactionReference,
      this.itemId,
      this.distance,
      this.startDate,
      this.endDate});

  CheckoutResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    contactPersonEmail = json['contact_person_email'];
    address = json['address'];
    lng = json['lng'];
    lat = json['lat'];
    storeId = json['store_id'];
    orderAmount = json['order_amount'];
    paymentStatus = json['payment_status'];
    transactionReference = json['transaction_reference'];
    itemId = json['item_id'];
    distance = json['distance'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['contact_person_email'] = this.contactPersonEmail;
    data['address'] = this.address;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['store_id'] = this.storeId;
    data['order_amount'] = this.orderAmount;
    data['payment_status'] = this.paymentStatus;
    data['transaction_reference'] = this.transactionReference;
    data['item_id'] = this.itemId;
    data['distance'] = this.distance;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
