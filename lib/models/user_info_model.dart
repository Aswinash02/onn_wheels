class UserInfo {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phone = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    return data;
  }
}
