// class CategoriesResponse {
//   int? id;
//   String? name;
//   String? image;
//   int? parentId;
//   int? position;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//   int? priority;
//   int? moduleId;
//   String? slug;
//   int? featured;
//   int? productsCount;
//   int? childesCount;
//   List<Null>? childes;
//   List<Translations>? translations;
//
//   CategoriesResponse(
//       {this.id,
//         this.name,
//         this.image,
//         this.parentId,
//         this.position,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.priority,
//         this.moduleId,
//         this.slug,
//         this.featured,
//         this.productsCount,
//         this.childesCount,
//         this.childes,
//         this.translations});
//
//   CategoriesResponse.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     parentId = json['parent_id'];
//     position = json['position'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     priority = json['priority'];
//     moduleId = json['module_id'];
//     slug = json['slug'];
//     featured = json['featured'];
//     productsCount = json['products_count'];
//     childesCount = json['childes_count'];
//     if (json['childes'] != null) {
//       childes = <Null>[];
//       json['childes'].forEach((v) {
//         childes!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['translations'] != null) {
//       translations = <Translations>[];
//       json['translations'].forEach((v) {
//         translations!.add(new Translations.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['parent_id'] = this.parentId;
//     data['position'] = this.position;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['priority'] = this.priority;
//     data['module_id'] = this.moduleId;
//     data['slug'] = this.slug;
//     data['featured'] = this.featured;
//     data['products_count'] = this.productsCount;
//     data['childes_count'] = this.childesCount;
//     if (this.childes != null) {
//       data['childes'] = this.childes!.map((v) => v.toJson()).toList();
//     }
//     if (this.translations != null) {
//       data['translations'] = this.translations!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Translations {
//   int? id;
//   String? translationableType;
//   int? translationableId;
//   String? locale;
//   String? key;
//   String? value;
//   String? createdAt;
//   String? updatedAt;
//
//   Translations(
//       {this.id,
//         this.translationableType,
//         this.translationableId,
//         this.locale,
//         this.key,
//         this.value,
//         this.createdAt,
//         this.updatedAt});
//
//   Translations.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     translationableType = json['translationable_type'];
//     translationableId = json['translationable_id'];
//     locale = json['locale'];
//     key = json['key'];
//     value = json['value'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['translationable_type'] = this.translationableType;
//     data['translationable_id'] = this.translationableId;
//     data['locale'] = this.locale;
//     data['key'] = this.key;
//     data['value'] = this.value;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
