class UserInfo {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? isVerifiedKyc;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.isVerifiedKyc
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    isVerifiedKyc = json['kycVerified'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['kycVerified'] = isVerifiedKyc;
    return data;
  }
}
