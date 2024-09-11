class OrderDetailModel {
  String? gst;
  String? sgst;
  int? orderId;

  int? orderAmount;
  String? paymentStatus;
  String? orderStatus;
  String? createdAt;
  List<Items>? items;
  DeliveryAddress? deliveryAddress;

  OrderDetailModel(
      {this.gst,
      this.sgst,
      this.orderId,
      this.orderAmount,
      this.paymentStatus,
      this.orderStatus,
      this.createdAt,
      this.items,
      this.deliveryAddress});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    gst = json['gst'];
    sgst = json['sgst'];
    orderId = json['order_id'];
    orderAmount = json['order_amount'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    createdAt = json['created_at'];

    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gst'] = this.gst;
    data['sgst'] = this.sgst;
    data['order_id'] = this.orderId;
    data['order_amount'] = this.orderAmount;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['created_at'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress!.toJson();
    }
    return data;
  }
}

class Items {
  int? itemId;
  String? itemName;
  int? quantity;
  int? unitPrice;
  int? gstAmount;
  int? sgstAmount;
  int? price;
  int? discount;
  int? helmetPrice;
  int? subtotal;
  int? weekendPrice;
  String? image;
  String? fromDate;
  String? toDate;

  Items(
      {this.itemId,
      this.itemName,
      this.quantity,
      this.unitPrice,
      this.gstAmount,
      this.sgstAmount,
      this.price,
      this.subtotal,
      this.helmetPrice,
      this.discount,
      this.weekendPrice,
      this.fromDate,
      this.toDate,
      this.image});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    gstAmount = json['gst_amount'];
    sgstAmount = json['sgst_amount'];
    price = json['price'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    helmetPrice = json['helmet_amount'];
    weekendPrice = json['weekend_price'];
    image = json['image'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['gst_amount'] = this.gstAmount;
    data['sgst_amount'] = this.sgstAmount;
    data['price'] = this.price;
    data['subtotal'] = this.subtotal;
    data['weekend_price'] = this.weekendPrice;
    data['image'] = this.image;
    return data;
  }
}

class DeliveryAddress {
  String? contactPersonName;
  String? contactPersonNumber;
  String? contactPersonEmail;
  String? addressType;
  String? address;
  String? road;
  String? house;
  String? longitude;
  String? latitude;

  DeliveryAddress(
      {this.contactPersonName,
      this.contactPersonNumber,
      this.contactPersonEmail,
      this.addressType,
      this.address,
      this.road,
      this.house,
      this.longitude,
      this.latitude});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    contactPersonEmail = json['contact_person_email'];
    addressType = json['address_type'];
    address = json['address'];
    road = json['road'];
    house = json['house'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['contact_person_email'] = this.contactPersonEmail;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['road'] = this.road;
    data['house'] = this.house;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
