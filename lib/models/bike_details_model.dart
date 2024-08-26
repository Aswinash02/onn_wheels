import 'dart:convert';

BikeDetailsResponse bikeDetailsResponseFromJson(String str) =>
    BikeDetailsResponse.fromJson(json.decode(str));

String bikeDetailsResponseToJson(BikeDetailsResponse data) =>
    json.encode(data.toJson());

class BikeDetailsResponse {
  int? id;

  String? image;
  int? categoryId;
  List<CategoryIds>? categoryIds;
  List<Null>? variations;
  List<Null>? addOns;
  List<Null>? attributes;
  List<Null>? choiceOptions;
  int? price;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? status;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  int? orderCount;
  int? avgRating;
  int? ratingCount;
  int? moduleId;
  int? stock;
  List<String>? images;
  List<Null>? foodVariations;
  String? slug;
  int? recommended;
  int? organic;
  String? engineNumber;
  String? chasisNumber;
  String? imei;
  String? gps;
  String? odoMeter;
  String? insuranceExpiryDate;
  int? isApproved;
  String? hoursPrice;
  String? distancePrice;
  String? monthPrice;
  String? weekPrice;
  String? daysPrice;
  String? vehicleNumber;
  int? bikeId;
  int? blocked;
  String? storeName;
  int? isCampaign;
  String? moduleType;
  int? zoneId;
  List<Stations>? stations;
  Bike? bike;
  Module? module;

  BikeDetailsResponse({
    this.id,
    this.image,
    this.categoryId,
    this.categoryIds,
    this.variations,
    this.addOns,
    this.attributes,
    this.choiceOptions,
    this.price,
    this.tax,
    this.taxType,
    this.discount,
    this.discountType,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.status,
    this.storeId,
    this.createdAt,
    this.updatedAt,
    this.orderCount,
    this.avgRating,
    this.ratingCount,
    this.moduleId,
    this.stock,
    this.images,
    this.foodVariations,
    this.slug,
    this.recommended,
    this.organic,
    this.engineNumber,
    this.chasisNumber,
    this.imei,
    this.gps,
    this.odoMeter,
    this.insuranceExpiryDate,
    this.isApproved,
    this.hoursPrice,
    this.distancePrice,
    this.monthPrice,
    this.weekPrice,
    this.daysPrice,
    this.vehicleNumber,
    this.bikeId,
    this.blocked,
    this.storeName,
    this.isCampaign,
    this.moduleType,
    this.zoneId,
    this.stations,
    this.bike,
    this.module,
  });

  BikeDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    image = json['image'];
    categoryId = json['category_id'];
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(new CategoryIds.fromJson(v));
      });
    }

    price = json['price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    status = json['status'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    moduleId = json['module_id'];
    stock = json['stock'];
    images = json['images'].cast<String>();

    slug = json['slug'];
    recommended = json['recommended'];
    organic = json['organic'];
    engineNumber = json['engine_number'];
    chasisNumber = json['chasis_number'];
    imei = json['imei'];
    gps = json['gps'];
    odoMeter = json['odo_meter'];
    insuranceExpiryDate = json['insurance_expiry_date'];
    isApproved = json['is_approved'];
    hoursPrice = json['hours_price'];
    distancePrice = json['distance_price'];
    monthPrice = json['month_price'];
    weekPrice = json['week_price'];
    daysPrice = json['days_price'];
    vehicleNumber = json['vehicle_number'];
    bikeId = json['bike_id'];
    blocked = json['blocked'];
    storeName = json['store_name'];
    isCampaign = json['is_campaign'];
    moduleType = json['module_type'];
    zoneId = json['zone_id'];
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(new Stations.fromJson(v));
      });
    }
    bike = json['bike'] != null ? new Bike.fromJson(json['bike']) : null;

    module =
        json['module'] != null ? new Module.fromJson(json['module']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    if (this.categoryIds != null) {
      data['category_ids'] = this.categoryIds!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['status'] = this.status;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_count'] = this.orderCount;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['module_id'] = this.moduleId;
    data['stock'] = this.stock;
    data['images'] = this.images;
    data['slug'] = this.slug;
    data['recommended'] = this.recommended;
    data['organic'] = this.organic;
    data['engine_number'] = this.engineNumber;
    data['chasis_number'] = this.chasisNumber;
    data['imei'] = this.imei;
    data['gps'] = this.gps;
    data['odo_meter'] = this.odoMeter;
    data['insurance_expiry_date'] = this.insuranceExpiryDate;
    data['is_approved'] = this.isApproved;
    data['hours_price'] = this.hoursPrice;
    data['distance_price'] = this.distancePrice;
    data['month_price'] = this.monthPrice;
    data['week_price'] = this.weekPrice;
    data['days_price'] = this.daysPrice;
    data['vehicle_number'] = this.vehicleNumber;
    data['bike_id'] = this.bikeId;
    data['blocked'] = this.blocked;
    data['store_name'] = this.storeName;
    data['is_campaign'] = this.isCampaign;
    data['module_type'] = this.moduleType;
    data['zone_id'] = this.zoneId;
    if (this.stations != null) {
      data['stations'] = this.stations!.map((v) => v.toJson()).toList();
    }
    if (this.bike != null) {
      data['bike'] = this.bike!.toJson();
    }
    if (this.module != null) {
      data['module'] = this.module!.toJson();
    }
    return data;
  }
}

class CategoryIds {
  String? id;
  int? position;
  String? name;

  CategoryIds({this.id, this.position, this.name});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position'] = this.position;
    data['name'] = this.name;
    return data;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['station_id'] = this.stationId;
    return data;
  }
}

class Bike {
  int? id;
  String? name;
  String? model;
  String? createdAt;
  String? updatedAt;
  String? description;
  String? hoursPrice;
  String? monthPrice;
  String? weekPrice;
  String? daysPrice;
  int? price;
  String? discount;

  Bike(
      {this.id,
      this.name,
      this.model,
      this.createdAt,
      this.updatedAt,
      this.description,
      this.hoursPrice,
      this.monthPrice,
      this.weekPrice,
      this.daysPrice,
      this.price,
      this.discount});

  Bike.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];

    hoursPrice = json['hours_price'];
    monthPrice = json['month_price'];
    weekPrice = json['week_price'];
    daysPrice = json['days_price'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;

    data['hours_price'] = this.hoursPrice;
    data['month_price'] = this.monthPrice;
    data['week_price'] = this.weekPrice;
    data['days_price'] = this.daysPrice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    return data;
  }
}

class Module {
  int? id;
  String? moduleName;
  String? moduleType;
  String? thumbnail;
  String? status;
  int? storesCount;
  String? createdAt;
  String? updatedAt;
  String? icon;
  int? themeId;
  String? description;
  int? allZoneService;
  List<Translations>? translations;

  Module(
      {this.id,
      this.moduleName,
      this.moduleType,
      this.thumbnail,
      this.status,
      this.storesCount,
      this.createdAt,
      this.updatedAt,
      this.icon,
      this.themeId,
      this.description,
      this.allZoneService,
      this.translations});

  Module.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleName = json['module_name'];
    moduleType = json['module_type'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    storesCount = json['stores_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'];
    themeId = json['theme_id'];
    description = json['description'];
    allZoneService = json['all_zone_service'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_name'] = this.moduleName;
    data['module_type'] = this.moduleType;
    data['thumbnail'] = this.thumbnail;
    data['status'] = this.status;
    data['stores_count'] = this.storesCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['icon'] = this.icon;
    data['theme_id'] = this.themeId;
    data['description'] = this.description;
    data['all_zone_service'] = this.allZoneService;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? id;
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;
  Null? createdAt;
  Null? updatedAt;

  Translations(
      {this.id,
      this.translationableType,
      this.translationableId,
      this.locale,
      this.key,
      this.value,
      this.createdAt,
      this.updatedAt});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    translationableType = json['translationable_type'];
    translationableId = json['translationable_id'];
    locale = json['locale'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['translationable_type'] = this.translationableType;
    data['translationable_id'] = this.translationableId;
    data['locale'] = this.locale;
    data['key'] = this.key;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
