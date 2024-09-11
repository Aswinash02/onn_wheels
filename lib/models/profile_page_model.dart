class ProfilePageModel {
  int? id;
  String? key;
  String? value;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<TranslationData>? translations;

  ProfilePageModel(
      {this.id,
      this.key,
      this.value,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.translations});

  ProfilePageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['translations'] != null) {
      translations = <TranslationData>[];
      json['translations'].forEach((v) {
        translations!.add(TranslationData.fromJson(v));
      });
    }
  }
}

class TranslationData {
  int? id;
  String? translationAbleType;
  int? translationAbleId;
  String? locale;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  TranslationData(
      {this.id,
      this.key,
      this.value,
      this.translationAbleType,
      this.translationAbleId,
      this.createdAt,
      this.updatedAt,
      this.locale});

  TranslationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    translationAbleType = json['translationable_type'];
    translationAbleId = json['translationable_id'];
    locale = json['locale'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
