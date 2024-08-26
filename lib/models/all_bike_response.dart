import 'dart:convert';

AllBikeResponse allBikeResponseFromJson(String str) =>
    AllBikeResponse.fromJson(json.decode(str));

String allBikeResponseToJson(AllBikeResponse data) =>
    json.encode(data.toJson());

class AllBikeResponse {
  List<BikeData>? data;

  AllBikeResponse({this.data});

  AllBikeResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BikeData>[];
      json['data'].forEach((v) {
        data!.add(new BikeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BikeData {
  int? id;
  String? name;
  String? model;
  String? vehicleNumber;
  String? engineNumber;
  String? chasisNumber;
  String? imagePath;
  String? description;

  BikeData(
      {this.id,
        this.name,
        this.model,
        this.vehicleNumber,
        this.engineNumber,
        this.chasisNumber,
        this.imagePath,
        this.description});

  BikeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    vehicleNumber = json['vehicle_number'];
    engineNumber = json['engine_number'];
    chasisNumber = json['chasis_number'];
    imagePath = json['image_path'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    data['vehicle_number'] = this.vehicleNumber;
    data['engine_number'] = this.engineNumber;
    data['chasis_number'] = this.chasisNumber;
    data['image_path'] = this.imagePath;
    data['description'] = this.description;
    return data;
  }
}
