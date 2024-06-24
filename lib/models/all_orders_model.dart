class AllOrdersModel {
  int? id;
  int? userId;
  int? orderAmount;
  int? couponDiscountAmount;
  String? couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  int? totalTaxAmount;
  String? paymentMethod;
  String? transactionReference;
  int? deliveryAddressId;
  int? deliveryManId;
  String? couponCode;
  String? orderNote;
  String? orderType;
  int? checked;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  int? deliveryCharge;
  String? scheduleAt;
  String? callback;
  String? otp;
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  String? deliveryAddress;
  int? scheduled;
  int? storeDiscountAmount;
  int? originalDeliveryCharge;
  String? failed;
  String? adjusment;
  int? edited;
  String? deliveryTime;
  int? zoneId;
  int? moduleId;
  String? orderAttachment;
  int? parcelCategoryId;
  String? receiverDetails;
  String? chargePayer;
  int? distance;
  int? dmTips;
  String? freeDeliveryBy;
  String? refundRequestCanceled;
  bool? prescriptionOrder;
  String? taxStatus;
  int? dmVehicleId;
  String? cancellationReason;
  String? canceledBy;
  String? couponCreatedBy;
  String? discountOnProductBy;
  String? processingTime;
  String? unavailableItemNote;
  bool? cutlery;
  Null? deliveryInstruction;
  String? taxPercentage;
  int? additionalCharge;
  String? orderProof;
  int? partiallyPaidAmount;
  bool? isGuest;
  int? flashAdminDiscountAmount;
  int? flashStoreDiscountAmount;
  String? storeName;
  String? storeAddress;
  String? storePhone;
  String? storeLat;
  String? storeLng;
  String? storeLogo;
  int? minDeliveryTime;
  int? maxDeliveryTime;
  int? itemCampaign;
  int? detailsCount;
  String? moduleType;
  String? customer;
  Store? store;
  Module? module;

  AllOrdersModel(
      {this.id,
        this.userId,
        this.orderAmount,
        this.couponDiscountAmount,
        this.couponDiscountTitle,
        this.paymentStatus,
        this.orderStatus,
        this.totalTaxAmount,
        this.paymentMethod,
        this.transactionReference,
        this.deliveryAddressId,
        this.deliveryManId,
        this.couponCode,
        this.orderNote,
        this.orderType,
        this.checked,
        this.storeId,
        this.createdAt,
        this.updatedAt,
        this.deliveryCharge,
        this.scheduleAt,
        this.callback,
        this.otp,
        this.pending,
        this.accepted,
        this.confirmed,
        this.processing,
        this.handover,
        this.pickedUp,
        this.delivered,
        this.canceled,
        this.refundRequested,
        this.refunded,
        this.deliveryAddress,
        this.scheduled,
        this.storeDiscountAmount,
        this.originalDeliveryCharge,
        this.failed,
        this.adjusment,
        this.edited,
        this.deliveryTime,
        this.zoneId,
        this.moduleId,
        this.orderAttachment,
        this.parcelCategoryId,
        this.receiverDetails,
        this.chargePayer,
        this.distance,
        this.dmTips,
        this.freeDeliveryBy,
        this.refundRequestCanceled,
        this.prescriptionOrder,
        this.taxStatus,
        this.dmVehicleId,
        this.cancellationReason,
        this.canceledBy,
        this.couponCreatedBy,
        this.discountOnProductBy,
        this.processingTime,
        this.unavailableItemNote,
        this.cutlery,
        this.deliveryInstruction,
        this.taxPercentage,
        this.additionalCharge,
        this.orderProof,
        this.partiallyPaidAmount,
        this.isGuest,
        this.flashAdminDiscountAmount,
        this.flashStoreDiscountAmount,
        this.storeName,
        this.storeAddress,
        this.storePhone,
        this.storeLat,
        this.storeLng,
        this.storeLogo,
        this.minDeliveryTime,
        this.maxDeliveryTime,
        this.itemCampaign,
        this.detailsCount,
        this.moduleType,
        this.customer,
        this.store,
        this.module});

  AllOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'];
    couponDiscountAmount = json['coupon_discount_amount'];
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'];
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    deliveryAddressId = json['delivery_address_id'];
    deliveryManId = json['delivery_man_id'];
    couponCode = json['coupon_code'];
    orderNote = json['order_note'];
    orderType = json['order_type'];
    checked = json['checked'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge'];
    scheduleAt = json['schedule_at'];
    callback = json['callback'];
    otp = json['otp'];
    pending = json['pending'];
    accepted = json['accepted'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    handover = json['handover'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    refundRequested = json['refund_requested'];
    refunded = json['refunded'];
    deliveryAddress = json['delivery_address'];
    scheduled = json['scheduled'];
    storeDiscountAmount = json['store_discount_amount'];
    originalDeliveryCharge = json['original_delivery_charge'];
    failed = json['failed'];
    adjusment = json['adjusment'];
    edited = json['edited'];
    deliveryTime = json['delivery_time'];
    zoneId = json['zone_id'];
    moduleId = json['module_id'];
    orderAttachment = json['order_attachment'];
    parcelCategoryId = json['parcel_category_id'];
    receiverDetails = json['receiver_details'];
    chargePayer = json['charge_payer'];
    distance = json['distance'];
    dmTips = json['dm_tips'];
    freeDeliveryBy = json['free_delivery_by'];
    refundRequestCanceled = json['refund_request_canceled'];
    prescriptionOrder = json['prescription_order'];
    taxStatus = json['tax_status'];
    dmVehicleId = json['dm_vehicle_id'];
    cancellationReason = json['cancellation_reason'];
    canceledBy = json['canceled_by'];
    couponCreatedBy = json['coupon_created_by'];
    discountOnProductBy = json['discount_on_product_by'];
    processingTime = json['processing_time'];
    unavailableItemNote = json['unavailable_item_note'];
    cutlery = json['cutlery'];
    deliveryInstruction = json['delivery_instruction'];
    taxPercentage = json['tax_percentage'];
    additionalCharge = json['additional_charge'];
    orderProof = json['order_proof'];
    partiallyPaidAmount = json['partially_paid_amount'];
    isGuest = json['is_guest'];
    flashAdminDiscountAmount = json['flash_admin_discount_amount'];
    flashStoreDiscountAmount = json['flash_store_discount_amount'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    storePhone = json['store_phone'];
    storeLat = json['store_lat'];
    storeLng = json['store_lng'];
    storeLogo = json['store_logo'];
    minDeliveryTime = json['min_delivery_time'];
    maxDeliveryTime = json['max_delivery_time'];
    itemCampaign = json['item_campaign'];
    detailsCount = json['details_count'];
    moduleType = json['module_type'];
    customer = json['customer'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    module =
    json['module'] != null ? new Module.fromJson(json['module']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_amount'] = this.orderAmount;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['coupon_discount_title'] = this.couponDiscountTitle;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['payment_method'] = this.paymentMethod;
    data['transaction_reference'] = this.transactionReference;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['delivery_man_id'] = this.deliveryManId;
    data['coupon_code'] = this.couponCode;
    data['order_note'] = this.orderNote;
    data['order_type'] = this.orderType;
    data['checked'] = this.checked;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_charge'] = this.deliveryCharge;
    data['schedule_at'] = this.scheduleAt;
    data['callback'] = this.callback;
    data['otp'] = this.otp;
    data['pending'] = this.pending;
    data['accepted'] = this.accepted;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['handover'] = this.handover;
    data['picked_up'] = this.pickedUp;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['refund_requested'] = this.refundRequested;
    data['refunded'] = this.refunded;
    data['delivery_address'] = this.deliveryAddress;
    data['scheduled'] = this.scheduled;
    data['store_discount_amount'] = this.storeDiscountAmount;
    data['original_delivery_charge'] = this.originalDeliveryCharge;
    data['failed'] = this.failed;
    data['adjusment'] = this.adjusment;
    data['edited'] = this.edited;
    data['delivery_time'] = this.deliveryTime;
    data['zone_id'] = this.zoneId;
    data['module_id'] = this.moduleId;
    data['order_attachment'] = this.orderAttachment;
    data['parcel_category_id'] = this.parcelCategoryId;
    data['receiver_details'] = this.receiverDetails;
    data['charge_payer'] = this.chargePayer;
    data['distance'] = this.distance;
    data['dm_tips'] = this.dmTips;
    data['free_delivery_by'] = this.freeDeliveryBy;
    data['refund_request_canceled'] = this.refundRequestCanceled;
    data['prescription_order'] = this.prescriptionOrder;
    data['tax_status'] = this.taxStatus;
    data['dm_vehicle_id'] = this.dmVehicleId;
    data['cancellation_reason'] = this.cancellationReason;
    data['canceled_by'] = this.canceledBy;
    data['coupon_created_by'] = this.couponCreatedBy;
    data['discount_on_product_by'] = this.discountOnProductBy;
    data['processing_time'] = this.processingTime;
    data['unavailable_item_note'] = this.unavailableItemNote;
    data['cutlery'] = this.cutlery;
    data['delivery_instruction'] = this.deliveryInstruction;
    data['tax_percentage'] = this.taxPercentage;
    data['additional_charge'] = this.additionalCharge;
    data['order_proof'] = this.orderProof;
    data['partially_paid_amount'] = this.partiallyPaidAmount;
    data['is_guest'] = this.isGuest;
    data['flash_admin_discount_amount'] = this.flashAdminDiscountAmount;
    data['flash_store_discount_amount'] = this.flashStoreDiscountAmount;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    data['store_phone'] = this.storePhone;
    data['store_lat'] = this.storeLat;
    data['store_lng'] = this.storeLng;
    data['store_logo'] = this.storeLogo;
    data['min_delivery_time'] = this.minDeliveryTime;
    data['max_delivery_time'] = this.maxDeliveryTime;
    data['item_campaign'] = this.itemCampaign;
    data['details_count'] = this.detailsCount;
    data['module_type'] = this.moduleType;
    data['customer'] = this.customer;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.module != null) {
      data['module'] = this.module!.toJson();
    }
    return data;
  }
}

class Store {
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
  int? comission;
  bool? scheduleOrder;
  int? status;
  int? vendorId;
  String? createdAt;
  String? updatedAt;
  bool? freeDelivery;
  List<int>? rating;
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
  String? deliveryTime;
  int? veg;
  int? nonVeg;
  int? orderCount;
  int? totalOrder;
  int? moduleId;
  int? orderPlaceToScheduleInterval;
  int? featured;
  int? perKmShippingCharge;
  bool? prescriptionOrder;
  String? slug;
  int? maximumShippingCharge;
  bool? cutlery;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? announcement;
  String? announcementMessage;
  bool? gstStatus;
  String? gstCode;
  List<Translations>? translations;

  Store(
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
        this.rating,
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
        this.deliveryTime,
        this.veg,
        this.nonVeg,
        this.orderCount,
        this.totalOrder,
        this.moduleId,
        this.orderPlaceToScheduleInterval,
        this.featured,
        this.perKmShippingCharge,
        this.prescriptionOrder,
        this.slug,
        this.maximumShippingCharge,
        this.cutlery,
        this.metaTitle,
        this.metaDescription,
        this.metaImage,
        this.announcement,
        this.announcementMessage,
        this.gstStatus,
        this.gstCode,
        this.translations});

  Store.fromJson(Map<String, dynamic> json) {
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
    rating = json['rating'].cast<int>();
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
    deliveryTime = json['delivery_time'];
    veg = json['veg'];
    nonVeg = json['non_veg'];
    orderCount = json['order_count'];
    totalOrder = json['total_order'];
    moduleId = json['module_id'];
    orderPlaceToScheduleInterval = json['order_place_to_schedule_interval'];
    featured = json['featured'];
    perKmShippingCharge = json['per_km_shipping_charge'];
    prescriptionOrder = json['prescription_order'];
    slug = json['slug'];
    maximumShippingCharge = json['maximum_shipping_charge'];
    cutlery = json['cutlery'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    announcement = json['announcement'];
    announcementMessage = json['announcement_message'];
    gstStatus = json['gst_status'];
    gstCode = json['gst_code'];
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
    data['rating'] = this.rating;
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
    data['delivery_time'] = this.deliveryTime;
    data['veg'] = this.veg;
    data['non_veg'] = this.nonVeg;
    data['order_count'] = this.orderCount;
    data['total_order'] = this.totalOrder;
    data['module_id'] = this.moduleId;
    data['order_place_to_schedule_interval'] =
        this.orderPlaceToScheduleInterval;
    data['featured'] = this.featured;
    data['per_km_shipping_charge'] = this.perKmShippingCharge;
    data['prescription_order'] = this.prescriptionOrder;
    data['slug'] = this.slug;
    data['maximum_shipping_charge'] = this.maximumShippingCharge;
    data['cutlery'] = this.cutlery;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_image'] = this.metaImage;
    data['announcement'] = this.announcement;
    data['announcement_message'] = this.announcementMessage;
    data['gst_status'] = this.gstStatus;
    data['gst_code'] = this.gstCode;
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
