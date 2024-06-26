class AllOrdersModel {
  int? id;
  int? orderId;
  String? itemName;
  int? totalAmount;
  String? image;

  AllOrdersModel(
      {this.id, this.orderId, this.itemName, this.totalAmount, this.image});

  AllOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    itemName = json['item_name'];
    totalAmount = json['total_amount'] is double
        ? (json['total_amount'] as double).toInt()
        : json['total_amount'];

    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['item_name'] = this.itemName;
    data['total_amount'] = this.totalAmount;
    data['image'] = this.image;
    return data;
  }
}
