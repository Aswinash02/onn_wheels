import 'dart:convert';

BikeDetailsResponse bikeDetailsResponseFromJson(String str) => BikeDetailsResponse.fromJson(json.decode(str));

String bikeDetailsResponseToJson(BikeDetailsResponse data) => json.encode(data.toJson());

class BikeDetailsResponse {
  int? id;
  String? name;
  String? description;
  String? image;
  int? categoryId;
  List<CategoryIds>? categoryIds;
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
  int? avgRating;
  int? ratingCount;
  int? moduleId;
  int? stock;
  List<String>? images;
  String? slug;
  int? recommended;
  int? organic;
  int? maximumCartQuantity;
  int? isApproved;
  String? hoursPrice;
  String? distancePrice;
  int? whislistsCount;
  String? storeName;
  int? isCampaign;
  String? moduleType;
  int? zoneId;
  int? flashSale;
  int? storeDiscount;
  bool? scheduleOrder;
  int? minDeliveryTime;
  int? maxDeliveryTime;
  int? commonConditionId;
  int? isBasic;
  StoreDetails? storeDetails;
  String? unitType;
  List<Translations>? translations;
  Module? module;
  int? unit;

  BikeDetailsResponse(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.categoryId,
      this.categoryIds,
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
      this.moduleId,
      this.stock,
      this.images,
      this.slug,
      this.recommended,
      this.organic,
      this.maximumCartQuantity,
      this.isApproved,
      this.hoursPrice,
      this.distancePrice,
      this.whislistsCount,
      this.storeName,
      this.isCampaign,
      this.moduleType,
      this.zoneId,
      this.flashSale,
      this.storeDiscount,
      this.scheduleOrder,
      this.minDeliveryTime,
      this.maxDeliveryTime,
      this.commonConditionId,
      this.isBasic,
      this.storeDetails,
      this.unitType,
      this.translations,
      this.module,
      this.unit});

  BikeDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
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
    veg = json['veg'];
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
    maximumCartQuantity = json['maximum_cart_quantity'];
    isApproved = json['is_approved'];
    hoursPrice = json['hours_price'];
    distancePrice = json['distance_price'];
    whislistsCount = json['whislists_count'];
    storeName = json['store_name'];
    isCampaign = json['is_campaign'];
    moduleType = json['module_type'];
    zoneId = json['zone_id'];
    flashSale = json['flash_sale'];
    storeDiscount = json['store_discount'];
    scheduleOrder = json['schedule_order'];
    minDeliveryTime = json['min_delivery_time'];
    maxDeliveryTime = json['max_delivery_time'];
    commonConditionId = json['common_condition_id'];
    isBasic = json['is_basic'];
    storeDetails = json['store_details'] != null
        ? new StoreDetails.fromJson(json['store_details'])
        : null;
    unitType = json['unit_type'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
    module =
        json['module'] != null ? new Module.fromJson(json['module']) : null;
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
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
    data['veg'] = this.veg;
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
    data['maximum_cart_quantity'] = this.maximumCartQuantity;
    data['is_approved'] = this.isApproved;
    data['hours_price'] = this.hoursPrice;
    data['distance_price'] = this.distancePrice;
    data['whislists_count'] = this.whislistsCount;
    data['store_name'] = this.storeName;
    data['is_campaign'] = this.isCampaign;
    data['module_type'] = this.moduleType;
    data['zone_id'] = this.zoneId;
    data['flash_sale'] = this.flashSale;
    data['store_discount'] = this.storeDiscount;
    data['schedule_order'] = this.scheduleOrder;
    data['min_delivery_time'] = this.minDeliveryTime;
    data['max_delivery_time'] = this.maxDeliveryTime;
    data['common_condition_id'] = this.commonConditionId;
    data['is_basic'] = this.isBasic;
    if (this.storeDetails != null) {
      data['store_details'] = this.storeDetails!.toJson();
    }
    data['unit_type'] = this.unitType;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    if (this.module != null) {
      data['module'] = this.module!.toJson();
    }
    data['unit'] = this.unit;
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

class StoreDetails {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? logo;
  String? latitude;
  String? longitude;
  String? address;
  String? footerText;
  int? minimumOrder;
  String? comission;
  bool? scheduleOrder;
  int? status;
  int? vendorId;
  String? createdAt;
  String? updatedAt;
  bool? freeDelivery;
  String? coverPhoto;
  bool? delivery;
  bool? takeAway;
  bool? itemSection;
  int? tax;
  int? zoneId;
  bool? reviewsSection;
  bool? active;
  String? offDay;
  int? selfDeliverySystem;
  bool? posSystem;
  int? minimumShippingCharge;
  int? orderCount;
  int? totalOrder;
  int? moduleId;
  int? orderPlaceToScheduleInterval;
  int? featured;
  int? perKmShippingCharge;
  bool? prescriptionOrder;
  String? slug;
  bool? cutlery;
  int? open;
  double? distance;
  bool? isRecommended;
  int? avgRating;
  int? ratingCount;
  int? positiveRating;
  int? totalItems;
  int? totalCampaigns;
  List<int>? categoryIds;
  List<CategoryDetails>? categoryDetails;
  List<PriceRange>? priceRange;
  bool? gstStatus;
  String? gstCode;
  int? discount;
  List<Translations>? translations;

  StoreDetails(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.logo,
      this.latitude,
      this.longitude,
      this.address,
      this.footerText,
      this.minimumOrder,
      this.comission,
      this.scheduleOrder,
      this.status,
      this.vendorId,
      this.createdAt,
      this.updatedAt,
      this.freeDelivery,
      this.coverPhoto,
      this.delivery,
      this.takeAway,
      this.itemSection,
      this.tax,
      this.zoneId,
      this.reviewsSection,
      this.active,
      this.offDay,
      this.selfDeliverySystem,
      this.posSystem,
      this.minimumShippingCharge,
      this.orderCount,
      this.totalOrder,
      this.moduleId,
      this.orderPlaceToScheduleInterval,
      this.featured,
      this.perKmShippingCharge,
      this.prescriptionOrder,
      this.slug,
      this.cutlery,
      this.open,
      this.distance,
      this.isRecommended,
      this.avgRating,
      this.ratingCount,
      this.positiveRating,
      this.totalItems,
      this.totalCampaigns,
      this.categoryIds,
      this.categoryDetails,
      this.priceRange,
      this.gstStatus,
      this.gstCode,
      this.discount,
      this.translations});

  StoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    logo = json['logo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    footerText = json['footer_text'];
    minimumOrder = json['minimum_order'];
    comission = json['comission'];
    scheduleOrder = json['schedule_order'];
    status = json['status'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    freeDelivery = json['free_delivery'];
    coverPhoto = json['cover_photo'];
    delivery = json['delivery'];
    takeAway = json['take_away'];
    itemSection = json['item_section'];
    tax = json['tax'];
    zoneId = json['zone_id'];
    reviewsSection = json['reviews_section'];
    active = json['active'];
    offDay = json['off_day'];
    selfDeliverySystem = json['self_delivery_system'];
    posSystem = json['pos_system'];
    minimumShippingCharge = json['minimum_shipping_charge'];
    orderCount = json['order_count'];
    totalOrder = json['total_order'];
    moduleId = json['module_id'];
    orderPlaceToScheduleInterval = json['order_place_to_schedule_interval'];
    featured = json['featured'];
    perKmShippingCharge = json['per_km_shipping_charge'];
    prescriptionOrder = json['prescription_order'];
    slug = json['slug'];
    cutlery = json['cutlery'];
    open = json['open'];
    distance = json['distance'];
    isRecommended = json['is_recommended'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    positiveRating = json['positive_rating'];
    totalItems = json['total_items'];
    totalCampaigns = json['total_campaigns'];
    categoryIds = json['category_ids'].cast<int>();
    if (json['category_details'] != null) {
      categoryDetails = <CategoryDetails>[];
      json['category_details'].forEach((v) {
        categoryDetails!.add(new CategoryDetails.fromJson(v));
      });
    }
    if (json['price_range'] != null) {
      priceRange = <PriceRange>[];
      json['price_range'].forEach((v) {
        priceRange!.add(new PriceRange.fromJson(v));
      });
    }
    gstStatus = json['gst_status'];
    gstCode = json['gst_code'];
    discount = json['discount'];
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
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['footer_text'] = this.footerText;
    data['minimum_order'] = this.minimumOrder;
    data['comission'] = this.comission;
    data['schedule_order'] = this.scheduleOrder;
    data['status'] = this.status;
    data['vendor_id'] = this.vendorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['free_delivery'] = this.freeDelivery;
    data['cover_photo'] = this.coverPhoto;
    data['delivery'] = this.delivery;
    data['take_away'] = this.takeAway;
    data['item_section'] = this.itemSection;
    data['tax'] = this.tax;
    data['zone_id'] = this.zoneId;
    data['reviews_section'] = this.reviewsSection;
    data['active'] = this.active;
    data['off_day'] = this.offDay;
    data['self_delivery_system'] = this.selfDeliverySystem;
    data['pos_system'] = this.posSystem;
    data['minimum_shipping_charge'] = this.minimumShippingCharge;
    data['order_count'] = this.orderCount;
    data['total_order'] = this.totalOrder;
    data['module_id'] = this.moduleId;
    data['order_place_to_schedule_interval'] =
        this.orderPlaceToScheduleInterval;
    data['featured'] = this.featured;
    data['per_km_shipping_charge'] = this.perKmShippingCharge;
    data['prescription_order'] = this.prescriptionOrder;
    data['slug'] = this.slug;
    data['cutlery'] = this.cutlery;
    data['open'] = this.open;
    data['distance'] = this.distance;
    data['is_recommended'] = this.isRecommended;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['positive_rating'] = this.positiveRating;
    data['total_items'] = this.totalItems;
    data['total_campaigns'] = this.totalCampaigns;
    data['category_ids'] = this.categoryIds;
    if (this.categoryDetails != null) {
      data['category_details'] =
          this.categoryDetails!.map((v) => v.toJson()).toList();
    }
    if (this.priceRange != null) {
      data['price_range'] = this.priceRange!.map((v) => v.toJson()).toList();
    }
    data['gst_status'] = this.gstStatus;
    data['gst_code'] = this.gstCode;
    data['discount'] = this.discount;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  int? id;
  String? name;
  String? image;
  int? parentId;
  int? position;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? priority;
  int? moduleId;
  String? slug;
  int? featured;
  List<Translations>? translations;

  CategoryDetails(
      {this.id,
      this.name,
      this.image,
      this.parentId,
      this.position,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.priority,
      this.moduleId,
      this.slug,
      this.featured,
      this.translations});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    parentId = json['parent_id'];
    position = json['position'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    priority = json['priority'];
    moduleId = json['module_id'];
    slug = json['slug'];
    featured = json['featured'];
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
    data['name'] = this.name;
    data['image'] = this.image;
    data['parent_id'] = this.parentId;
    data['position'] = this.position;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['priority'] = this.priority;
    data['module_id'] = this.moduleId;
    data['slug'] = this.slug;
    data['featured'] = this.featured;
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
  String? createdAt;
  String? updatedAt;

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

class PriceRange {
  int? minPrice;
  int? maxPrice;
  String? unitType;
  int? unit;

  PriceRange({this.minPrice, this.maxPrice, this.unitType, this.unit});

  PriceRange.fromJson(Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    unitType = json['unit_type'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['unit_type'] = this.unitType;
    data['unit'] = this.unit;
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
