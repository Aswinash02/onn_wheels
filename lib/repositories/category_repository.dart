import 'dart:convert';

import 'package:onnwheels/helpers/api_helpers.dart';
import 'package:onnwheels/models/category_models.dart';
import 'package:onnwheels/models/filter_bikes_model.dart';
import 'package:onnwheels/utils/shared_value.dart';
import '../models/category_product_models.dart';
import '../utils/app_config.dart';

class CategoryRepository {
  Future<List<CategoryResponse>> getCategories() async {
    String url = ("${AppConfig.BASE_URL}/categories");
    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "App-Language": app_language.$!,
        "moduleId": "1",
        "zoneId": '[2]'
      },
    );
    print("get All Category response=======>${response.body}");

    List<dynamic> jsonData = json.decode(response.body);
    List<CategoryResponse> categories =
        jsonData.map((json) => CategoryResponse.fromJson(json)).toList();

    return categories;
  }

  Future<CategoryProductsData> fetchCategoryProducts({
    int? categoryId,
  }) async {
    String url =
        ("${AppConfig.BASE_URL}/categories/items/list?limit=${10}&offset=${0}&category_ids=[$categoryId]");
    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "moduleId": "1",
        "zoneId": '[2]'
      },
    );

    return categoryProductResponseFromJson(response.body);
  }

}
