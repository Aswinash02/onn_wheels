import 'dart:convert';
import 'package:onnwheels/models/bike_details.dart';
import '../helpers/api_helpers.dart';
import '../models/all_bike_response.dart';
import '../utils/app_config.dart';
import '../utils/shared_value.dart';

class ProductRepository {
  Future<AllBikeResponse> getAllProducts({int page = 1}) async {
    String url = ("${AppConfig.BASE_URL}/items/get-all");
    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "App-Language": app_language.$!,
        "moduleId": "1"
      },
    );
    print("get All Bike response=======>${response.body}");

    return allBikeResponseFromJson(response.body);
  }

  Future<BikeDetailsResponse> getProductDetails({int? id}) async {
    String url = ("${AppConfig.BASE_URL}/items/details/$id");
    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "moduleId": "1",
        "zoneId": "2"
      },
    );
    print("get Bike Details response=======>${response.body}");

    return bikeDetailsResponseFromJson(response.body);
  }

  Future<AllBikeResponse> filterProductDateTime(
      {String? startDate,
      String? startTime,
      String? endDate,
      String? endTime}) async {
    String url = ("${AppConfig.BASE_URL}/items/vehicle-availability-search");
    var post_body = jsonEncode({
      // "start_date": "June 27, 2024  9:54 AM",
      // "end_date": "June 27, 2024  10:54 AM"
      "start_date": "$startDate  $startTime",
      "end_date": "$endDate $endTime"
    });
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "moduleId": "1",
          "zoneId": "[1]"
        },
        body: post_body);
    print("get All Filter Data response=======>${response.body}");

    return allBikeResponseFromJson(response.body);
  }
}
