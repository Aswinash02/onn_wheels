import 'dart:convert';

CategoryProductsData categoryProductResponseFromJson(String str) =>
    CategoryProductsData.fromJson(json.decode(str));

String categoryProductResponseToJson(CategoryProductsData data) =>
    json.encode(data.toJson());

class CategoryProductsData {
  int? totalSize;
  int? limit;
  int? offset;
  List<Products>? products;

  CategoryProductsData(
      {this.totalSize, this.limit, this.offset, this.products});

  CategoryProductsData.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? model;
  String? vehicleNumber;
  String? engineNumber;
  String? chasisNumber;
  String? imagePath;
  String? description;

  Products(
      {this.id,
      this.name,
      this.model,
      this.vehicleNumber,
      this.engineNumber,
      this.chasisNumber,
      this.imagePath,
      this.description});

  Products.fromJson(Map<String, dynamic> json) {
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
