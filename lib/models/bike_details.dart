import 'dart:convert';

BikeDetailsResponse bikeDetailsResponseFromJson(String str) =>
    BikeDetailsResponse.fromJson(json.decode(str));

String bikeDetailsResponseToJson(BikeDetailsResponse data) =>
    json.encode(data.toJson());

class BikeDetailsResponse {
  int? id;
  String? name;
  String? description;
  String? image;
  int? categoryId;
  List<CategoryIds>? categoryIds;
  String? variations;
  int? price;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? veg;
  int? status;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  int? orderCount;
  double? avgRating;
  int? ratingCount;
  double? rating;
  int? moduleId;
  int? stock;
  int? unitId;
  List<String>? images;
  String? foodVariations;
  String? slug;
  int? recommended;
  int? organic;
  int? maximumCartQuantity;
  int? isApproved;
  PriceDetail? hoursPrice;
  PriceDetail? distancePrice;
  PriceDetail? monthPrice;
  PriceDetail? weekPrice;
  PriceDetail? daysPrice;
  String? unitType;
  List<Stations>? stations;
  List<Translations>? translations;
  int? unit;

  BikeDetailsResponse({
    this.id,
    this.name,
    this.description,
    this.image,
    this.categoryId,
    this.categoryIds,
    this.variations,
    this.price,
    this.tax,
    this.taxType,
    this.discount,
    this.discountType,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.veg,
    this.status,
    this.storeId,
    this.createdAt,
    this.updatedAt,
    this.orderCount,
    this.avgRating,
    this.ratingCount,
    this.rating,
    this.moduleId,
    this.stock,
    this.unitId,
    this.images,
    this.foodVariations,
    this.slug,
    this.recommended,
    this.organic,
    this.maximumCartQuantity,
    this.isApproved,
    this.hoursPrice,
    this.distancePrice,
    this.monthPrice,
    this.weekPrice,
    this.daysPrice,
    this.unitType,
    this.stations,
    this.translations,
    this.unit,
  });

  BikeDetailsResponse.fromJson(Map<String, dynamic> json) {

    print('=========================== +++++++++= ${json['hours_price']}');
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'];
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    variations = json['variations'];
    price = json['price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    veg = json['veg'];
    status = json['status'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    avgRating =
        (json['avg_rating'] != null) ? json['avg_rating'].toDouble() : null;
    ratingCount = json['rating_count'];
    rating = (json['rating'] != null) ? json['rating'].toDouble() : null;
    moduleId = json['module_id'];
    stock = json['stock'];
    unitId = json['unit_id'];
    images = json['images'].cast<String>();
    foodVariations = json['food_variations'];
    slug = json['slug'];
    recommended = json['recommended'];
    organic = json['organic'];
    maximumCartQuantity = json['maximum_cart_quantity'];
    isApproved = json['is_approved'];
    hoursPrice = json['hours_price'] != null
        ? PriceDetail.fromJson(jsonDecode(json['hours_price']))
        : null;
    distancePrice = json['distance_price'] != null
        ? PriceDetail.fromJson(jsonDecode(json['distance_price']))
        : null;
    monthPrice = json['month_price'] != null
        ? PriceDetail.fromJson(jsonDecode(json['month_price']))
        : null;
    weekPrice = json['week_price'] != null
        ? PriceDetail.fromJson(jsonDecode(json['week_price']))
        : null;
    daysPrice = json['days_price'] != null
        ? PriceDetail.fromJson(jsonDecode(json['days_price']))
        : null;
    unitType = json['unit_type'];
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(Stations.fromJson(v));
      });
    }
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['category_id'] = categoryId;
    if (categoryIds != null) {
      data['category_ids'] = categoryIds!.map((v) => v.toJson()).toList();
    }
    data['variations'] = variations;
    data['price'] = price;
    data['tax'] = tax;
    data['tax_type'] = taxType;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['available_time_starts'] = availableTimeStarts;
    data['available_time_ends'] = availableTimeEnds;
    data['veg'] = veg;
    data['status'] = status;
    data['store_id'] = storeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order_count'] = orderCount;
    data['avg_rating'] = avgRating;
    data['rating_count'] = ratingCount;
    data['rating'] = rating;
    data['module_id'] = moduleId;
    data['stock'] = stock;
    data['unit_id'] = unitId;
    data['images'] = images;
    data['food_variations'] = foodVariations;
    data['slug'] = slug;
    data['recommended'] = recommended;
    data['organic'] = organic;
    data['maximum_cart_quantity'] = maximumCartQuantity;
    data['is_approved'] = isApproved;
    data['hours_price'] =
        hoursPrice != null ? jsonEncode(hoursPrice!.toJson()) : null;
    data['distance_price'] =
        distancePrice != null ? jsonEncode(distancePrice!.toJson()) : null;
    data['month_price'] =
        monthPrice != null ? jsonEncode(monthPrice!.toJson()) : null;
    data['week_price'] =
        weekPrice != null ? jsonEncode(weekPrice!.toJson()) : null;
    data['days_price'] =
        daysPrice != null ? jsonEncode(daysPrice!.toJson()) : null;
    data['unit_type'] = unitType;
    if (stations != null) {
      data['stations'] = stations!.map((v) => v.toJson()).toList();
    }
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    data['unit'] = unit;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    data['name'] = name;
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
  Pivot? pivot;

  Stations({
    this.id,
    this.name,
    this.address,
    this.zoneId,
    this.lat,
    this.lon,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Stations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    zoneId = json['zone_id'];
    lat = json['lat'];
    lon = json['lon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['zone_id'] = zoneId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['station_id'] = stationId;
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
  String? createdAt;
  String? updatedAt;

  Translations({
    this.id,
    this.translationableType,
    this.translationableId,
    this.locale,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['translationable_type'] = translationableType;
    data['translationable_id'] = translationableId;
    data['locale'] = locale;
    data['key'] = key;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PriceDetail {
  String? hour;
  String? price;
  String? kmLimit;
  String? kmCharges;

  PriceDetail({this.hour, this.price, this.kmLimit, this.kmCharges});

  PriceDetail.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    price = json['price'];
    kmLimit = json['km_limit'];
    kmCharges = json['km_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['price'] = this.price;
    data['km_limit'] = this.kmLimit;
    data['km_charges'] = this.kmCharges;
    return data;
  }
}

