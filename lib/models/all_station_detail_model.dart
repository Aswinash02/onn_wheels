class AllStationDetailModel {
  List<StationData>? data;

  AllStationDetailModel({this.data});

  AllStationDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StationData>[];
      json['data'].forEach((v) {
        data!.add(new StationData.fromJson(v));
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

class StationData {
  int? id;
  String? name;
  String? address;
  int? zoneId;
  String? lat;
  String? lon;
  String? createdAt;
  String? updatedAt;
  int? status;

  StationData(
      {this.id,
      this.name,
      this.address,
      this.zoneId,
      this.lat,
      this.lon,
      this.createdAt,
      this.updatedAt,
      this.status});

  StationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    zoneId = json['zone_id'];
    lat = json['lat'];
    lon = json['lon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['zone_id'] = this.zoneId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
