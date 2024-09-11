import 'dart:convert';

BikeDetailsResponse bikeDetailsResponseFromJson(String str) =>
    BikeDetailsResponse.fromJson(json.decode(str));

class BikeDetailsResponse {
  int? id;
  String? name;
  String? description;
  int? weekendPrice;
  String? discountPrice;
  List<Categories>? categories;
  String? image;
  List<String>? images;
  PriceDetail? hoursPrice;
  PriceDetail? weekPrice;
  PriceDetail? monthPrice;
  PriceDetail? daysPrice;
  List<Stations>? stations;
  String? vehicleNumber;
  String? makeYear;
  String? displacement;
  String? topSpeed;
  String? fullCapacity;
  String? kmsDriven;
  String? kerbWeight;
  String? mileage;
  String? seat;
  int? helmetPrice;

  BikeDetailsResponse({
    this.id,
    this.name,
    this.description,
    this.weekendPrice,
    this.discountPrice,
    this.categories,
    this.image,
    this.images,
    this.hoursPrice,
    this.weekPrice,
    this.monthPrice,
    this.daysPrice,
    this.stations,
    this.vehicleNumber,
    this.makeYear,
    this.displacement,
    this.topSpeed,
    this.fullCapacity,
    this.kmsDriven,
    this.kerbWeight,
    this.mileage,
    this.seat,
    this.helmetPrice
  });

  BikeDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    weekendPrice = double.parse(json['weekend_price']).toInt();
    discountPrice = json['discount_price'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    image = json['image'];
    images = json['images'].cast<String>();
    hoursPrice = PriceDetail.fromJson(jsonDecode(json['hours_price']));
    weekPrice = PriceDetail.fromJson(jsonDecode(json['week_price']));
    monthPrice = PriceDetail.fromJson(jsonDecode(json['month_price']));
    daysPrice = PriceDetail.fromJson(jsonDecode(json['days_price']));
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(new Stations.fromJson(v));
      });
    }
    vehicleNumber = json['vehicle_number'];
    makeYear = json['make_year'];
    displacement = json['displacement'];
    topSpeed = json['top_speed'];
    fullCapacity = json['fuel_capacity'];
    kmsDriven = json['kms_driven'];
    kerbWeight = json['kerb_weight'];
    mileage = json['mileage'];
    seat = json['seats'];
    helmetPrice = json['extra_helmet'];
  }
}

class Categories {
  String? id;
  int? position;
  String? name;

  Categories({this.id, this.position, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    name = json['name'];
  }
}

class Stations {
  int? id;
  String? name;
  String? address;
  int? zoneId;
  String? lat;
  String? lon;
  String? createdAt;
  String? updatedAt;
  int? status;
  Pivot? pivot;

  Stations(
      {this.id,
      this.name,
      this.address,
      this.zoneId,
      this.lat,
      this.lon,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.pivot});

  Stations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    zoneId = json['zone_id'];
    lat = json['lat'];
    lon = json['lon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  int? itemId;
  int? stationId;

  Pivot({this.itemId, this.stationId});

  Pivot.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    stationId = json['station_id'];
  }
}

class PriceDetail {
  String? hour;
  String? price;
  String? kmLimit;
  String? kmCharges;
  String? hourLimit;
  String? hourWeekendLimit;
  String? extraHours;
  String? hourWeekendPrice;

  PriceDetail({
    this.hour,
    this.price,
    this.kmLimit,
    this.kmCharges,
    this.hourLimit,
    this.hourWeekendLimit,
    this.extraHours,
    this.hourWeekendPrice,
  });

  PriceDetail.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    price = json['price'];
    kmLimit = json['km_limit'];
    kmCharges = json['km_charges'];
    hourLimit = json['hour_limit'];
    hourWeekendLimit = json['hour_weekend_limit'];
    extraHours = json['extra_hours'];
    hourWeekendPrice = json['h_weekend_price'];
  }
}
