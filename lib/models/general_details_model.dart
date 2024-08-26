class GeneralDetailsModel {
  String? address;
  String? email;
  int? phone;
  String? openingTime;
  String? closingTime;

  GeneralDetailsModel(
      {this.address,
      this.email,
      this.phone,
      this.openingTime,
      this.closingTime});

  GeneralDetailsModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }
}
